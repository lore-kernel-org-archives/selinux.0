Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB39NQRb020201
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 04:23:26 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB39Mfp5008860
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 09:22:41 GMT
Received: from node11.ravantivirus.com (node11.ravantivirus.com [213.233.121.11])
	by jazzswing.ncsc.mil  with ESMTP id hB39Met0008857
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 09:22:40 GMT
Date: Wed, 3 Dec 2003 11:22:59 +0200
From: Petre Rodan <petre.rodan@ravantivirus.com>
To: Russell Coker <russell@coker.com.au>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: latest djb policies
Message-ID: <20031203092259.GA13454@peter.rav.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Good morning,

The following DJBernstein policies have been finished: daemontools, ucspi-tcp and publicfile.
Thank you Russell for your help in creating them.

net_contexts should also contain:

ifdef(`publicfile.te', `portcon tcp 80  system_u:object_r:utcpserver_port_t'
portcon tcp 21  system_u:object_r:utcpserver_port_t')
ifdef(`qmail.te', `portcon tcp 25  system_u:object_r:utcpserver_port_t')

I would also like this in the ssh.te policy:

ifdef(`daemontools.te', `
allow sshd_t self:capability { kill };
allow sshd_t self:process { signal };
')

because this is the only way I can upgrade remote ssh servers.
(daemontools will spawn automatically a new sshd after I kill the old one)

and this in qmail.fc (or mta.fc):

/usr/sbin/sendmail              system_u:object_r:sendmail_exec_t
/var/qmail/bin/sendmail         system_u:object_r:sendmail_exec_t
/var/qmail/alias				system_u:object_r:sysadm_home_t

/usr/sbin/sendmail is a symlink to /var/qmail/bin/sendmail on my system.

bye,
peter

--/04w6evG8XlLl3ft
Content-Type: application/x-tar-gz
Content-Disposition: attachment; filename="policy.tar.gz"
Content-Transfer-Encoding: base64

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
6icAUAAA

--/04w6evG8XlLl3ft--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
