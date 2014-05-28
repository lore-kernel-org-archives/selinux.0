Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4SH52R2014633
 for <selinux@tycho.nsa.gov>; Wed, 28 May 2014 13:05:02 -0400
Received: by mail-wi0-f169.google.com with SMTP id hi2so3903133wib.4
 for <selinux@tycho.nsa.gov>; Wed, 28 May 2014 10:04:41 -0700 (PDT)
Received: from siphos.be (ip-83-134-245-227.dsl.scarlet.be. [83.134.245.227])
 by mx.google.com with ESMTPSA id
 m2sm44635290wjf.42.2014.05.28.10.04.40 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
 Wed, 28 May 2014 10:04:40 -0700 (PDT)
Sender: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Date: Wed, 28 May 2014 19:04:11 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: SETools patch for libselinux-2.3
Message-ID: <20140528170411.GA13025@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In libselinux-2.3, the interface of the lsetfilecon_raw function has been
changed:

-extern int lsetfilecon_raw(const char *path, security_context_t con);
+extern int lsetfilecon_raw(const char *path, const char * con);

The call to lsetfilecon_raw in setools' secmds/replcon.cc needs to be
updated accordingly, as it otherwise fails during build:

replcon.cc: In function ‘int replcon_lsetfilecon(const char*, security_context_t)’:
replcon.cc:73:25: warning: NULL used in arithmetic [-Wpointer-arith]
replcon.cc:73:25: error: invalid operands of types ‘<unresolved overloaded function type>’ and ‘long int’ to binary ‘operator!=’

The below patch fixes this (but makes the setools version depend on
libselinux-2.3 now).

With thanks to Arfrever Frehtes Taifersar Arahesis for the patch (I worked
around it first by just calling lsetfilecon_raw directly). Something about
weakly linked functions...


Index: secmds/replcon.cc
===================================================================
--- secmds/replcon.cc	(revision 4973)
+++ secmds/replcon.cc	(working copy)
@@ -60,7 +60,7 @@
 	{NULL, 0, NULL, 0}
 };
 
-extern int lsetfilecon_raw(const char *, security_context_t) __attribute__ ((weak));
+extern int lsetfilecon_raw(const char *, const char *) __attribute__ ((weak));
 
 /**
  * As that setools must work with older libselinux versions that may
