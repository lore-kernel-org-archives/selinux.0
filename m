Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1N8UD8Y015747
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2011 03:30:17 -0500
Received: from snt0-omc3-s20.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p1N8UH4S024247
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2011 08:30:17 GMT
Message-ID: <SNT139-w158CDE61B212AC89099502ABDB0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_1d2f9776-1f3c-4df3-8407-72648d754701_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: type_datum changed from define_type() and type_write() ?
Date: Wed, 23 Feb 2011 08:30:16 +0000
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_1d2f9776-1f3c-4df3-8407-72648d754701_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi SELinux experts,

I am trying to add a new rule "typesocket" to checkpolicy which does something like "typesocket syslogd_t syslogd_s_t", where syslogd_t is the domain for the syslog daemon and the syslogd_s_t would be used to label the AF_UNIX socket created by syslog daemon(so that it no longer inherits the creator's sid).

I would like to add two extra members in the binary representation for the syslogd_t's type_datum structure: a u32 "socket_type_len" field before the string of "syslogd_t", and the socket type string of "syslogd_s_t" right after the "syslogd_t" string.

Two new members have been added to the type_datum structure: a char *, "socket_type_str" and a uint32_t, "socket_type_len". The newly added define_typesocket() in policy_define.c is used to handle this new typesocket rule, it will save the string and length of "syslogd_s_t" to syslogd_t's type_datum->socket_type_str and socket_type_len fields. While the type_write() in libsepol write.c will try to save type_datum->socket_type_str right after the key of the current type_datum if type_datum->socket_type_len is not zero.

It seems easy, however, I've run into a strange problem, that the type_datum structure used in define_typesocket() during parsing seems to be different from the one used by type_write() when writing into binary representations. I put some printfs in these two functions, the results are:

/usr/bin/checkpolicy:  loading policy configuration from policy.conf
define_typesocket, syslogd_t.s.value: b09
define_typesocket, syslogd_t.socket_type_len: b
define_typesocket, syslogd_t.socket_type_str: syslogd_s_t
define_typesocket, syslogd_s_t.s.value: b07
/usr/bin/checkpolicy:  policy configuration loaded
/usr/bin/checkpolicy:  writing binary representation (version 24) to policy.24
type_write, key:syslogd_s_t
s.value: 22d
type_write, key:syslogd_t
s.value: ce7
socket_type_len: 0
socket_type_str: (null)

Where we can see that when "typesocket syslogd_t syslogd_s_t" is parsed, the s.value for the syslogd_t and syslogd_s_t are b09 and b07 respectively, and the reference to "syslogd_s_t" has been properly setup in syslogd_t's type_datum. However, when writing binary representations their s.value have been changed to ce7 and 22d, and the reference to "syslogd_s_t" in syslogd_t's type_datum has been zeroed.

Any clues??

Thanks a lot!

Cheers,
Harry 		 	   		  
--_1d2f9776-1f3c-4df3-8407-72648d754701_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Î¢ÈíÑÅºÚ
}
--></style>
</head>
<body class='hmmessage'>
Hi SELinux experts,<br><br>I am trying to add a new rule "typesocket" to checkpolicy which does something like "typesocket syslogd_t syslogd_s_t", where syslogd_t is the domain for the syslog daemon and the syslogd_s_t would be used to label the AF_UNIX socket created by syslog daemon(so that it no longer inherits the creator's sid).<br><br>I would like to add two extra members in the binary representation for the syslogd_t's type_datum structure: a u32 "socket_type_len" field before the string of "syslogd_t", and the socket type string of "syslogd_s_t" right after the "syslogd_t" string.<br><br>Two new members have been added to the type_datum structure: a char *, "socket_type_str" and a uint32_t, "socket_type_len". The newly added define_typesocket() in policy_define.c is used to handle this new typesocket rule, it will save the string and length of "syslogd_s_t" to syslogd_t's type_datum-&gt;socket_type_str and socket_type_len fields. While the type_write() in libsepol wr!
 ite.c will try to save type_datum-&gt;socket_type_str right after the key of the current type_datum if type_datum-&gt;socket_type_len is not zero.<br><br>It seems easy, however, I've run into a strange problem, that the type_datum structure used in define_typesocket() during parsing seems to be different from the one used by type_write() when writing into binary representations. I put some printfs in these two functions, the results are:<br><br>/usr/bin/checkpolicy:&nbsp; loading policy configuration from policy.conf<br>define_typesocket, syslogd_t.s.value: b09<br>define_typesocket, syslogd_t.socket_type_len: b<br>define_typesocket, syslogd_t.socket_type_str: syslogd_s_t<br>define_typesocket, syslogd_s_t.s.value: b07<br>/usr/bin/checkpolicy:&nbsp; policy configuration loaded<br>/usr/bin/checkpolicy:&nbsp; writing binary representation (version 24) to policy.24<br>type_write, key:syslogd_s_t<br>s.value: 22d<br>type_write, key:syslogd_t<br>s.value: ce7<br>socket_type_len: 0<b!
 r>socket_type_str: (null)<br><br>Where we can see that when "typesocke
t syslogd_t syslogd_s_t" is parsed, the s.value for the syslogd_t and syslogd_s_t are b09 and b07 respectively, and the reference to "syslogd_s_t" has been properly setup in syslogd_t's type_datum. However, when writing binary representations their s.value have been changed to ce7 and 22d, and the reference to "syslogd_s_t" in syslogd_t's type_datum has been zeroed.<br><br>Any clues??<br><br>Thanks a lot!<br><br>Cheers,<br>Harry 		 	   		  </body>
</html>
--_1d2f9776-1f3c-4df3-8407-72648d754701_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
