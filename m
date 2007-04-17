Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3HFeD7e009287
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 11:40:13 -0400
Received: from mail.nagafix.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3HFeB6q027417
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 15:40:11 GMT
Received: from [192.168.0.6] (82-45-252-239.cable.ubr02.camd.blueyonder.co.uk [82.45.252.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: antoine@nagafix.co.uk)
	by mail.nagafix.co.uk (Postfix) with ESMTP id 313E8B1AD0
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 16:34:56 +0100 (BST)
Message-ID: <4624E91F.1080807@nagafix.co.uk>
Date: Tue, 17 Apr 2007 16:34:55 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: modular policy: local module issues
Content-Type: text/plain; charset=ISO-8859-15
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

I am moving some of my old policies to the modular policy - using this
page as a base:
http://sepolicy-server.sourceforge.net/index.php?page=module-overview
and I am having a few problems:

* Trying to use tmp_domain():
logcheck.te:18:ERROR 'syntax error' at token 'tmp_domain' on line 77716:
tmp_domain(logcheck)

* Removed this line, then:
# make load
Loading strict modules: logcheck
libsepol.permission_copy_callback: Module local depends on permission
dccp_recv in class node, not satisfied
libsemanage.semanage_link_sandbox: Link packages failed

Any ideas?

Thanks
Antoine

# uname -r
kernel 2.6.15-skas3-v8.2

# sestatus
SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   permissive
Mode from config file:          permissive
Policy version:                 20
Policy from config file:        strict

sys-libs/libselinux 1.34.0
sys-libs/libsemanage 1.10.0
sys-libs/libsepol 1.16.2

Gentoo profile:
/usr/portage/profiles/selinux/x86/2006.1

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
