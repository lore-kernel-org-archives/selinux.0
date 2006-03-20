Subject: Re: semodule dumps core
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux-dev@tresys.com, Ivan Gyurdiev <ivg2@cornell.edu>,
        SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20060318000255.GB8168@thorium.jmh.mhn.de>
References: <20060316224834.GA8552@thorium.jmh.mhn.de>
	 <20060318000255.GB8168@thorium.jmh.mhn.de>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 12:02:32 -0500
Message-Id: <1142874152.16487.88.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-03-18 at 01:02 +0100, Thomas Bleher wrote:
> * Thomas Bleher <bleher@informatik.uni-muenchen.de> [2006-03-16 23:56]:
> > Seems like semodule doesn't like me. I just recompiled my policy with
> > the new versions of the tools and now semodule dumps core when I do a 
> > "semodule -b base.pp".
> 
> Stephen gave me many good suggestions, among them to compile without
> -O2. I tried this and the problem went away! Tracking this down further
> I narrowed it down to libsepol being miscompiled with -O2, it works fine
> with -O0 or -O1. So this looks like a compiler bug in gcc (as shipped in
> current Ubuntu Dapper). Unfortunately I won't have time to track down
> this problem but if anyone wants to look into this I can provide the
> sources I used.

Ok, I reproduced this on Fedora by building libsepol with just -O2 by
hand, e.g. make CFLAGS+="-O2" clean install.  Looking at what an rpm
build of the libsepol package does, it does build with -O2 but also adds
several other flags during the build.  Trying these flags individually
with -O2, it appears that the -fstack-protector option makes the
difference:  adding it yields a working libsepol while removing it
leaves a broken libsepol.  As -fstack-protector adds guard variables and
checking code, it seemed likely that it was covering up some bug that
would otherwise occur.  Looking at sepol_module_package_write() again,
since the seg fault occurred immediately after it completed, I noticed
that buf[] is too small if you include all optional sections (i.e.
users_extra and seusers as well as file_contexts).  Patch below.

Index: libsepol/src/module.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/module.c,v
retrieving revision 1.19
diff -u -p -r1.19 module.c
--- libsepol/src/module.c	7 Feb 2006 14:04:43 -0000	1.19
+++ libsepol/src/module.c	20 Mar 2006 16:37:45 -0000
@@ -661,7 +661,7 @@ int sepol_module_package_write(sepol_mod
 {
 	struct policy_file *file = &spf->pf;
 	policy_file_t polfile;
-	uint32_t buf[3], offsets[5], len, nsec = 0;
+	uint32_t buf[5], offsets[5], len, nsec = 0;
 	int i;
 
 	if (p->policy) {


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
