Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8KEcXsJ003066
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 10:38:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8KEcW2R020421
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 14:38:32 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h8KEcV1A020418 for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 14:38:31 GMT
Date: Sat, 20 Sep 2003 15:38:24 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Boot time avc messages
Message-ID: <20030920143824.GI12158@vnl.com>
References: <20030915214153.GE8988@vnl.com> <200309201632.59282.russell@coker.com.au> <20030920131340.GH12158@vnl.com> <200309202335.09944.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309202335.09944.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Sep 20, 2003 at 11:35:09PM +1000, Russell Coker wrote:
> It should work.  I already have a couple of 2.6 machines running with my 
> policy tree.  If it doesn't work then let me know and I'll fix my policy.

cat flask/security_classes flask/initial_sids flask/access_vectors tmp/te-rbac.m4 users tmp/constraints-contexts.m4 > policy.conf
/usr/bin/checkpolicy -o policy.15 policy.conf
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
ERROR 'syntax error' at token 'fs_use_task' on line 29587:
# type as the creating task.  
fs_use_task pipefs system_u:object_r:fs_t;
/usr/bin/checkpolicy:  error(s) encountered while parsing configuration
make: *** [policy.15] Error 1

I had to modify the makefile to match Colin's setup with
FLASKDIR=flask/ since the directory you pointed to doesn't exist.

I'll keep digging, but thought I'd pass that right along to you.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
