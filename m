Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1P9O7Rb028809
	for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 04:24:07 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1P9MWlK004870
	for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 09:22:32 GMT
Received: from internode.on.net (bep1.adl2.internode.on.net [203.16.214.212])
	by jazzswing.ncsc.mil  with ESMTP id i1P9MUOX004867
	for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 09:22:31 GMT
Received: from internode.on.net (unverified [203.16.214.212])
	by internode.on.net (SurgeMail 1.6e10) with ESMTP id 20060325
	for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 19:53:16 +1030 (CDT)
From: "keen@internode.on.net" <keen@internode.on.net>
Reply-to: keen@internode.on.net
To: SE Linux <selinux@tycho.nsa.gov>
Subject: I/O Redirect?
Date: Wed, 25 Feb 2004 20:23:16 +1100
Message-id: <403c6984.108.36cc.1234700170@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I am experimenting with SELinux, while doing so, I have
edited the ping.te to include

domain_auto_trans(user_t, ping_exec_t, ping_t)
type user_ping_t, file_type, sysadmfile;
file_type_auto_trans(ping_t, tmp_t, user_ping_t)

however, files which were created in /tmp using commands
such as:
ping 127.0.0.5 -c 4 > pingfile

do not result in a user_ping_t context file being saved,
instead the result was a user_tmp_t . Is using redirection
the cause of it? or is there anyway to produce the file with
the desired context with I/O redirection?

Any input is appreciated.

Regards,
Keen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
