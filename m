Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6D4OTrT007253
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 00:24:29 -0400 (EDT)
Received: from mail.mvalent.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6D4OSSK004169
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 04:24:28 GMT
Subject: RE: vsftpd with SELinux
Date: Tue, 13 Jul 2004 00:24:28 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <E6E16A6D4277CD459BBDE6713766033C92A51E@exchange.mvalent.local>
From: "James R. Marcus" <jmarcus@mvalent.net>
To: <russell@coker.com.au>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I feel kind of silly now but here are a bunch of AVC messages.

Thanks,
James
Jul  6 15:40:19 ftp rc-scripts: /etc/vsftpd/vsftpd.conf must contain
background=YES and listen=YES
Jul  6 15:40:19 ftp rc-scripts: in order to start vsftpd from
/etc/init.d/vsftpd
Jul  6 15:58:42 ftp xinetd[21671]: Reading included configuration file:
/etc/xinetd.d/vsftpd [file=/etc/xinetd.d/vsftpd] [line=14]
Jul  6 15:58:42 ftp avc:  denied  { execute } for  pid=21671
exe=/usr/sbin/xinetd name=vsftpd dev=hda3 ino=438973
scontext=system_u:system_r:inetd_t tcontext=system_u:object_r:sbin_t
tclass=file
Jul  6 15:58:42 ftp avc:  denied  { getattr } for  pid=21671
exe=/usr/sbin/xinetd path=/usr/sbin/vsftpd dev=hda3 ino=438973
scontext=system_u:system_r:inetd_t tcontext=system_u:object_r:sbin_t
tclass=file
Jul  6 16:03:18 ftp xinetd[26388]: Reading included configuration file:
/etc/xinetd.d/vsftpd [file=/etc/xinetd.d/vsftpd] [line=14]
Jul  6 16:06:34 ftp avc:  denied  { execute } for  pid=5544
exe=/usr/sbin/vsftpd name=unix_chkpwd dev=hda3 ino=501941
scontext=system_u:system_r:initrc_t
tcontext=system_u:object_r:chkpwd_exec_t tclass=file
Jul  6 16:06:34 ftp avc:  denied  { execute_no_trans } for  pid=5544
exe=/usr/sbin/vsftpd path=/sbin/unix_chkpwd dev=hda3 ino=501941
scontext=system_u:system_r:initrc_t
tcontext=system_u:object_r:chkpwd_exec_t tclass=file
Jul  6 16:06:34 ftp avc:  denied  { read } for  pid=5544
exe=/usr/sbin/vsftpd path=/sbin/unix_chkpwd dev=hda3 ino=501941
scontext=system_u:system_r:initrc_t
tcontext=system_u:object_r:chkpwd_exec_t tclass=file
Jul  6 16:06:34 ftp avc:  denied  { ioctl } for  pid=27592
exe=/usr/sbin/vsftpd path=socket:[70844] dev= ino=70844
scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t
tclass=tcp_socket
Jul  6 16:06:34 ftp vsftpd(pam_unix)[27592]: authentication failure;
logname= uid=0 euid=0 tty= ruser= rhost=172.16.1.117
Jul  7 15:00:14 ftp avc:  denied  { read } for  pid=27338 exe=/bin/ls
name=vsftpd dev=hda3 ino=485153 scontext=root:staff_r:staff_t
tcontext=root:object_r:var_log_t tclass=dir
Jul  7 15:00:27 ftp avc:  denied  { read } for  pid=1561
exe=/usr/bin/tail name=vsftpd.log dev=hda3 ino=485176
scontext=root:staff_r:staff_t tcontext=system_u:object_r:var_log_ksyms_t
tclass=file
Jul  8 06:07:01 ftp avc:  denied  { net_bind_service } for  pid=7965
exe=/usr/sbin/vsftpd capability=10 scontext=root:staff_r:staff_t
tcontext=root:staff_r:staff_t tclass=capability
Jul  8 06:30:19 ftp avc:  denied  { append } for  pid=1500
exe=/usr/sbin/vsftpd name=vsftpd.log dev=hda3 ino=485176
scontext=root:staff_r:staff_t tcontext=system_u:object_r:var_log_ksyms_t
tclass=file
Jul  8 06:30:19 ftp avc:  denied  { sys_chroot } for  pid=6664
exe=/usr/sbin/vsftpd capability=18 scontext=root:staff_r:staff_t
tcontext=root:staff_r:staff_t tclass=capability
Jul  8 06:30:19 ftp avc:  denied  { setuid } for  pid=6664
exe=/usr/sbin/vsftpd capability=7 scontext=root:staff_r:staff_t
tcontext=root:staff_r:staff_t tclass=capability
Jul  8 06:30:19 ftp avc:  denied  { lock } for  pid=6664
exe=/usr/sbin/vsftpd path=/var/log/vsftpd/vsftpd.log dev=hda3 ino=485176
scontext=root:staff_r:staff_t tcontext=system_u:object_r:var_log_ksyms_t
tclass=file

-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au] 
Sent: Monday, July 12, 2004 11:42 PM
To: James R. Marcus
Cc: selinux@tycho.nsa.gov
Subject: Re: vsftpd with SELinux

On Tue, 13 Jul 2004 11:49, "James R. Marcus" <jmarcus@mvalent.net>
wrote:
> I just emerged vsftpd on my new Hardened Gentoo system running the
> SELinux kernel.  I think I have configured it correctly but keep
running
> into this issue:

What AVC messages do you get in the kernel message log?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux
packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
