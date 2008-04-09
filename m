From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: dpkg bug related to SE Linux
Date: Wed, 9 Apr 2008 17:11:47 +1100
Cc: SE-Linux <selinux@tycho.nsa.gov>,
        Manoj Srivastava <manoj.srivastava@stdc.com>, 474339@bugs.debian.org
References: <200804051347.55320.russell@coker.com.au> <200804080930.13447.russell@coker.com.au> <1207657403.21223.232.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1207657403.21223.232.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200804091611.55435.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patch fixes the problem.

scontext is allocated by matchpathcon(3) and needs to be freed by the caller.  
If it's not set to NULL before the attempted allocation then it'll keep the 
previous value (which had been freed) and then you get a double-free.

--- dpkg-1.14.16.6.orig/src/archives.c
+++ dpkg-1.14.16.6/src/archives.c
@@ -629,6 +629,7 @@
      * or if it has no context; in which case the default
      * context shall be applied.
      */
+    scontext = NULL;
     if( ! ((matchpathcon(fnamevb.buf,
                          (nifd->namenode->statoverride ?
                           nifd->namenode->statoverride->mode : ti->Mode)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
