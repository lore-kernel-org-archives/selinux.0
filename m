Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h97Dq6Wt011452
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 09:52:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h97Dq40p028820
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 13:52:04 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h97Dq3r7028817
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 13:52:03 GMT
Subject: Re: login messages
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: "James R. Kratzer" <JamesK@xetron.com>, selinux@tycho.nsa.gov
In-Reply-To: <200310071533.00017.russell@coker.com.au>
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A45@s3cin>
	 <1065457196.3919.37.camel@moss-spartans.epoch.ncsc.mil>
	 <200310071533.00017.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1065534718.3919.211.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 07 Oct 2003 09:51:58 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-07 at 01:32, Russell Coker wrote:
> It did not give any audit messages because by Unix permissions the capability 
> was denied so it didn't even reach SE Linux.  

Right, this is because we perform a full capable(CAP_SYS_TTY_CONFIG)
call in selinux_file_ioctl rather than only performing the SELinux
capability permission check via task_has_capability.  We could change
this so that you only need the SELinux permission and not the Linux
capability.  That avoids changing the Linux permissions model.

> It seems that in Red Hat 
> loadkeys is run from /bin/unicode_start in the context of the user (from
> /etc/profile.d/lang.*).  So I wrote a little SUID root helper program (to 
> regain CAP_SYS_TTY_CONFIG) which I copied to /bin/unicode_start (the original 
> file was renamed to /bin/unicode_start.orig).  I made /bin/unicode_start be a 
> SUID program to gain the Unix permissions and also labeled it as type 
> loadkeys_exec_t which causes a transition to user_loadkeys_t, user_loadkeys_t 
> has SETUID and SYS_TTY_CONFIG capabilities.  I also added 
> "loadkeys_domain($1)" to macros/user_macros.te .

I don't think that this helps, unless you are carefully limiting the
types that can be read by user_loadkeys_t, since the user can still
specify a font and umap as arguments to unicode_start and thus specify
an arbitrary map.  Even if you use the policy to limit it to certain
system types, it isn't clear that it is safe to allow the user to select
any system-installed mapping.  The safest approach would be to have
getty or login perform the loading, and to load authorized mappings that
aren't subject to configuration by ordinary users.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
