Message-ID: <7B2A7784F4B7F0409947481F3F3FEF8304ACC35A@eammlnt051.lmc.ericsson.se>
From: "Eric Gingras (LMC)" <Eric.Gingras@ericsson.ca>
To: "SELinux Mailing list (E-mail)" <SELinux@tycho.nsa.gov>,
        "LSM Mailing List (E-mail)" <linux-security-module@wirex.com>
Date: Thu, 29 Aug 2002 11:48:40 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C24F73.8C0275C0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C24F73.8C0275C0
Content-Type: text/plain;
	charset="iso-8859-1"

Hi,
I'm quite a newbie to SELinux. Up to now, I've install the system and I've
look at the configuration files. As a first test, I've try to configure an
application called HTTPServer using it's own type(domain) and it's own file
type.

The application is called HTTPServer (compiled from serv.c which is joined
to this message). This application is located in /bin.  A type for the file
of the executable as been created (HTTPServer.fc located in
policy/file_contexts/program/ and joined to this message).  A type (domain)
for the process as also been created (HTTPServer.te located in
policy/domains/program also joined to this message).
 	
When using the sysadm_r role, starting HTTPServer, and checking the process
with ps --context, the domain of the process is "HTTPServer_t".  So
everything looks normal.  But when using the user_r role, starting
HTTPServer, and checking the process with ps --context, the domain of the
process is "user_t".  
 
The goal was to allow the execution of HTTPServer to the sysadm_r and not to
user_r.  A couple of things (e.g. commenting transition rules) to block the
transition from HTTPServer_t to user_t, were tried without success.

Would you have any helpful recommandation or ressource ?


Thank you and regards,


Eric Gingras

Eric.Gingras@ericsson.ca


------_=_NextPart_000_01C24F73.8C0275C0
Content-Type: application/octet-stream;
	name="serv.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="serv.c"

#include <stdio.h>=0A=
#include <sys/types.h>=0A=
#include <sys/socket.h>=0A=
#include <netinet/in.h>=0A=
#include <arpa/inet.h>=0A=
#include <string.h>=0A=
=0A=
int main()=0A=
{=0A=
	int sock;=0A=
	int err;=0A=
	struct sockaddr_in ad;=0A=
	char buff[20];=0A=
=0A=
	printf("Listen side\n");=0A=
	sock =3D socket(PF_INET, SOCK_DGRAM,0);=0A=
	printf("listen socket =3D %d\n",sock);=0A=
=0A=
	memset(&ad,0,sizeof(ad));=0A=
	ad.sin_family =3D AF_INET;=0A=
	ad.sin_port =3D htons(8000);=0A=
	ad.sin_addr.s_addr =3D inet_addr("127.0.0.1");=0A=
	//ad.sin_addr.s_addr =3D inet_addr("142.133.113.67");=0A=
=0A=
	err =3D bind(sock,(struct sockaddr *)&ad,sizeof(ad));=0A=
	printf("bind =3D %d\n",err);=0A=
=0A=
	while(1)=0A=
	{=0A=
		err =3D recv(sock,buff,12,MSG_WAITALL);=0A=
		if(err <=3D 0)=0A=
			break;=0A=
=0A=
		buff[12] =3D 0;=0A=
		printf("%s\n",buff);=0A=
	}=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
=0A=

------_=_NextPart_000_01C24F73.8C0275C0
Content-Type: application/octet-stream;
	name="HTTPServer.fc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="HTTPServer.fc"

# HTTPServer=0A=
/home/telorb/eric/user/server/HTTPServer =
system_u:object_r:HTTPServer_exec_t=0A=
/bin/HTTPServer 			 system_u:object_r:HTTPServer_exec_t=0A=
=0A=

------_=_NextPart_000_01C24F73.8C0275C0
Content-Type: application/octet-stream;
	name="HTTPServer.te"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="HTTPServer.te"

#=0A=
# Author:  Eric Gingras <eric.gingras@ericsson.ca>=0A=
#=0A=
=0A=
#################################=0A=
#=0A=
# Rules for the HTTPServer_t domain.=0A=
#=0A=
# HTTPServer_t is the domain for the HTTPServer program.=0A=
# HTTPServer_exec_t is the type of the corresponding program.=0A=
#=0A=
type HTTPServer_t, domain, privlog;=0A=
role sysadm_r types HTTPServer_t;=0A=
=0A=
#role system_r types HTTPServer_t;=0A=
=0A=
every_domain(HTTPServer_t)=0A=
=0A=
type HTTPServer_exec_t, file_type, sysadmfile, exec_type;=0A=
=0A=
=0A=
# Transition into this domain when you run this program.=0A=
domain_auto_trans(sysadm_t, HTTPServer_exec_t, HTTPServer_t)=0A=
#domain_auto_trans(initrc_t, HTTPServer_exec_t, HTTPServer_t)=0A=
=0A=
# Let ping create raw ICMP packets.=0A=
#allow ping_t self:rawip_socket { create bind setopt getopt write read =
};=0A=
#allow ping_t any_socket_t:rawip_socket sendto;=0A=
=0A=
# Let ping receive ICMP replies.=0A=
#allow ping_t icmp_socket_t:rawip_socket recvfrom;=0A=
=0A=
# Use capabilities.=0A=
#allow ping_t ping_t:capability { net_raw setuid };=0A=
=0A=
# Access the terminal.=0A=
#allow ping_t sysadm_tty_device_t:chr_file rw_file_perms;=0A=
#allow ping_t sysadm_devpts_t:chr_file rw_file_perms;=0A=
#ifdef(`gnome-pty-helper.te', `allow ping_t sysadm_gph_t:fd use;')=0A=
=0A=

------_=_NextPart_000_01C24F73.8C0275C0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
