# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aperin <aperin@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/25 09:50:49 by aperin            #+#    #+#              #
#    Updated: 2023/02/07 07:47:46 by aperin           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		= minishell

SRC_FILE	= main.c \
				input_loop/read_input.c \
				lexer/lexer.c \
				lexer/lexer_utils.c \
				lexer/prelexer.c \
				lexer/postlexer.c \
				parser/parser.c \
				parser/parser_utils.c \
				expander/expander.c \
				expander/expander_utils.c \
				executor/executor.c \
				builtins/ft_pwd.c \
				utils/display_header.c \
				error/error.c
				
SRCS_DIR	= srcs
OBJSDIR		= objs
INCDIR		= includes ${LIBFT_DIR}

SRCS		= $(addprefix ${SRCS_DIR}/, ${SRC_FILE})
OBJS		= $(addprefix ${OBJSDIR}/, $(addsuffix .o, $(basename ${SRC_FILE})))
OBJS_DIR	= $(sort $(dir $(OBJS)))

CC			= gcc
CFLAGS		= -Wall -Wextra -Werror -fsanitize=address -g
INCS		= $(foreach d, $(INCDIR), -I$d)

# libft
LIBFT_DIR	= libft
LIBFT		= ${LIBFT_DIR}/libft.a

${OBJSDIR}/%.o: ${SRCS_DIR}/%.c
			@mkdir -p ${OBJSDIR} ${OBJS_DIR}
			${CC} ${CFLAGS} ${INCS} -c -o $@ $<

all:		${NAME}

${NAME}:	${OBJS}
			make -C ${LIBFT_DIR}
			${CC} ${CFLAGS} ${OBJS} ${LIBFT} -lreadline -o ${NAME}

clean:
			make clean -C ${LIBFT_DIR}
			rm -rf ${OBJSDIR}

fclean:		clean
			make fclean -C ${LIBFT_DIR}
			rm -f ${NAME}

re:			fclean all

.PHONY:		all clean fclean re