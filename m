Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4CHvqgA027744
	for <selinux@tycho.nsa.gov>; Thu, 12 May 2005 13:57:53 -0400 (EDT)
Received: from web60413.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j4CHsx5F015740
	for <selinux@tycho.nsa.gov>; Thu, 12 May 2005 17:54:59 GMT
Message-ID: <20050512175506.46422.qmail@web60413.mail.yahoo.com>
Date: Thu, 12 May 2005 10:55:06 -0700 (PDT)
From: Roger Brunell <rog_brunell@yahoo.com>
Subject: policy directory structure - Debian and Tresys tools
To: SELinux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As a follow-on to a prior comment; I am trying to
build the Tresys "SELinux Tools (setools), version
2.0" on a Knoppix 3.8.1 (Debian derived) system. I
already have the selinux running with the default
strict policy. I want to now start exploring what is
in a policy.

It (the Tresys package) appears to have a different
idea of where a policy is located, compiled into one
of the tools; than where the policy actually ends up .
And they are both from the same website.

-------
root@lppda:/p/selinux/nsa/setools-2.0# make
cd libapol; make libapol libapolso
make[1]: Entering directory
`/p/selinux/nsa/setools-2.0/libapol'
cc -Wall -O2 -fPIC   -DLIBSELINUX -DLIBSEFS
-DLIBAPOL_VERSION_STRING='"2.0"'
-DAPOL_INSTALL_DIR='"/usr/share/setools"'
-DLIBAPOL_POLICY_INSTALL_DIR='"/etc/security/selinux"'
-DLIBAPOL_SELINUX_DIR='"/selinux"'
-DLIBAPOL_DEFAULT_POLICY='"/etc/security/selinux/src/policy/policy.conf"'
-I. -o cond.o -c cond.c
cond.c:20:28: sys/capability.h: No such file or
directory
make[1]: *** [cond.o] Error 1
make[1]: Leaving directory
`/p/selinux/nsa/setools-2.0/libapol'
-----
I think that is expecting the default policy path to
be  under '/etc/security/selinux'.

I haven't investigated the missing include yet.


Roger Brunell

Roger Brunell

Infosec Engineer (retired)
"Born 20 years too early"


		
Discover Yahoo! 
Use Yahoo! to plan a weekend, have fun online and more. Check it out! 
http://discover.yahoo.com/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
