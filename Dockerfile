FROM ubuntu:latest
MAINTAINER Paimpozhil "paimpozhil@gmail.com"

RUN sudo apt-get update 	# Done
RUN apt-get install -y openssh-server	# DONE
RUN apt-get install -y xubuntu-desktop 	# DONE

ENV DEBIAN_FRONTEND noninteractive	# Skip interactive installs or things

RUN add-apt-repository ppa:x2go/stable	# DONE

RUN apt-get update			# DONE

RUN apt-get install x2goserver x2goserver-xsession pwgen -y	# DONE



RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config			# DONE

RUN sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config		# DONE
RUN sed -i "s/#PasswordAuthentication/PasswordAuthentication/g" /etc/ssh/sshd_config	# DONE

RUN mkdir -p /tmp/.X11-unix && chmod 1777 /tmp/.X11-unix				# DONE

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 22

CMD ["/run.sh"]
