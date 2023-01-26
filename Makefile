# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aperin <aperin@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/25 09:50:49 by aperin            #+#    #+#              #
#    Updated: 2023/01/26 10:41:24 by aperin           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		= minishell

SRC_FILE	= main.c \
				builtins/ft_pwd.c
				
SRCS_DIR	= srcs
OBJSDIR		= objs
INCDIR		= includes ${LIBFT_DIR}

SRCS		= $(addprefix ${SRCS_DIR}/, ${SRC_FILE})
OBJS		= $(addprefix ${OBJSDIR}/, $(addsuffix .o, $(basename ${SRC_FILE})))
OBJS_DIR	= $(sort $(dir $(OBJS)))

CC			= gcc
CFLAGS		= -Wall -Wextra -Werror
INCS		= $(foreach d, $(INCDIR), -I$d)

# libft
LIBFT_DIR	= srcs/libft
LIBFT		= ${LIBFT_DIR}/libft.a

${OBJSDIR}/%.o: ${SRCS_DIR}/%.c
			@mkdir -p ${OBJSDIR} ${OBJS_DIR}
			${CC} ${CFLAGS} ${INCS} -c -o $@ $<

all:		${NAME}

${NAME}:	${OBJS}
			make -C ${LIBFT_DIR}
			${CC} ${OBJS} ${LIBFT} -lreadline -o ${NAME}

clean:
			make clean -C ${LIBFT_DIR}
			rm -rf ${OBJSDIR}

fclean:		clean
			make fclean -C ${LIBFT_DIR}
			rm -f ${NAME}

re:			fclean all

.PHONY:		all clean fclean re NAME