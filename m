Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0PBi7Hb007037
	for <selinux@tycho.nsa.gov>; Mon, 25 Jan 2010 06:44:13 -0500
Received: from hostingsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o0P3a4GI002072
	for <selinux@tycho.nsa.gov>; Mon, 25 Jan 2010 03:36:05 GMT
Message-Id: <201001242029.o0OKTSbY001470@vivaldi39.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: selinux@tycho.nsa.gov
Subject: bzip support in libsemanage and out of memory (userspace ticket 7)
Date: Sun, 24 Jan 2010 21:29:28 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi !

Has anybody had any time to look at this ticket:
http://userspace.selinuxproject.org/trac/ticket/7 ?

I have experienced the same issue and verified that the problem is actually triggered by the bzip support (as pointed out by Stephen Smalley back in August). In fact, if I use bzip-blocksize=0 in semanage.conf then the problem disappears...

Otherwise with a default semanage.conf and bzip enabled, I get:

libsepol.module_package_read_offsets: offset greater than file size (at 4, offset 200478 -> 8192 (No such file or directory).
libsemanage.semanage_load_module: Error while reading from module file /etc/selinux/refpolicy/modules/tmp/base.pp. (No such file or directory).
semodule:  Failed!

I am using libsepol-2.0.41 and libsemanage-2.0.42.

Guido
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
