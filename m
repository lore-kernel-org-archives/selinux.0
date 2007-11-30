Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAUMmCcc024439
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 17:48:12 -0500
Received: from g1t0026.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAUMmApw019253
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 22:48:11 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Todd C. Miller" <tmiller@tresys.com>
Subject: Re: PATCH: peersid capability support
Date: Fri, 30 Nov 2007 17:48:05 -0500
Cc: selinux@tycho.nsa.gov
References: <200711301734.lAUHYKFJ031076@cadmus.columbia.tresys.com> <200711301406.10774.paul.moore@hp.com>
In-Reply-To: <200711301406.10774.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711301748.05733.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 30 November 2007 2:06:10 pm Paul Moore wrote:
> On Friday 30 November 2007 12:34:20 pm Todd C. Miller wrote:
> > I see what happened.  When generating the patch I did an svn revert not
> > realizing that of course it wouldn't revert a new file it knew nothing
> > about.  So effectively the new files were duplicated--one copy in the
> > patch and one on the filesystem.
> >
> > Here's a fixed diff that applies to a fresh checkout.
>
> Thanks, that applied without problem.

Probably user error on my end but I'm running into problems trying to make use 
of the new code.  Here is what I did, please point out if I'm missing 
something ...

1. Compiled the new bits
2. Replaced checkmodule, checkpolicy, load_policy, libsepol and libsemanage 
with the patched versions (wasn't really sure what needed to be replaced, do 
I need any others?)
3. Created a simple policy module (did I get the syntax for the policycap 
right? ... it's been a while since I looked at lex/yacc code):
 policy_module(peer_test,0.0.1)
 policycap network_peer_controls;
 type peer_test_t;
4. Compiled the new module using the unmodified policy Makefile from Rawhide
 Compiling targeted peer_test module
 /usr/bin/checkmodule:  loading policy configuration from tmp/peer_test.tmp
 /usr/bin/checkmodule:  policy configuration loaded
 /usr/bin/checkmodule:  writing binary representation (version 7) to 
                        tmp/peer_test.mod
 Creating targeted peer_test.pp policy package
5. Tried installing the module
/usr/sbin/load_policy:  Can't load policy:  Invalid argument
libsemanage.semanage_reload_policy: load_policy returned error code 2.
semodule:  Failed!

Help/Ideas?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
