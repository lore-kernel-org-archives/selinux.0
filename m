Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6D1nVrT006745
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 21:49:32 -0400 (EDT)
Received: from mail.mvalent.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6D1nADC015508
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 01:49:11 GMT
Subject: vsftpd with SELinux
Date: Mon, 12 Jul 2004 21:49:26 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <E6E16A6D4277CD459BBDE6713766033C92A4FA@exchange.mvalent.local>
From: "James R. Marcus" <jmarcus@mvalent.net>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I just emerged vsftpd on my new Hardened Gentoo system running the
SELinux kernel.  I think I have configured it correctly but keep running
into this issue:

ftp> ope 10.1.5.12
Connected to 10.1.5.12.
220 (vsFTPd 1.2.2)
User (10.1.5.12:(none)): jmarcus
331 Please specify the password.
Password:
230 Login successful.
ftp> ls
500 OOPS: capset
200 PORT command successful. Consider using PASV.
500 OOPS: vsf_sysutil_recv_peek
Connection closed by remote host.
ftp> quit

Here is my vsftpd config:
ftp init.d # cat /etc/vsftpd/vsftpd.conf | grep -v '#'

anonymous_enable=NO
local_enable=YES
write_enable=YES
dirmessage_enable=YES
connect_from_port_20=YES
xferlog_enable=YES
xferlog_file=/var/log/vsftpd/vsftpd.log
nopriv_user=nobody
background=YES
listen=YES

Any help or pointers would be greatly appreciated.


Thanks,
James



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
