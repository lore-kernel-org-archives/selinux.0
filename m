Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LCTWWt025993
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 08:29:32 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9LCTVIE021737
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 12:29:31 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9LCTU1J021734 for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 12:29:31 GMT
Subject: Re: init patch for loading policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200310211052.28494.russell@coker.com.au>
References: <200310200148.15852.russell@coker.com.au>
	 <1066672941.22196.259.camel@moss-spartans.epoch.ncsc.mil>
	 <200310211052.28494.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1066739366.27065.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 21 Oct 2003 08:29:26 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-10-20 at 20:52, Russell Coker wrote:
> Firstly we would need to test that init will actually respond correctly to 
> "telinit u" while it's in that stage.  This is something I am concerned 
> about, particularly regarding race conditions regarding the completion of 
> rc.sysinit (although I guess it's unlikely that rc.sysinit will complete 
> before init restarts).

Note that I subsequently suggested (in a reply to Dan on the list) using
a separate sysinit entry with its own script for performing the initial
policy load and restarting init, followed by the ordinary sysinit entry
(or alternately, a bootwait entry if you can't ensure ordering among
multiple sysinit entries) that executes rc.sysinit.

This might not work, but I thought it would be worth testing, as it
avoids any patching or redirection of /sbin/init, and only involves an
alteration to /etc/inittab and an additional init script.  I agree that
even if it did work experimentally, you would want to examine the init
code to verify that it is safe in general.

> Then there's the issue that rc.sysinit has to get the correct context, so we 
> probably need domain_auto_trans(kernel_t, initrc_exec_t, initrc_t).

Not necessary with the above approach, as the first sysinit entry should
run in kernel_t and the second entry will automatically be placed into
initrc_t because init will have switched into its domain.

> OK.  I'll write a new version of the patch to address these issues.

Again, I don't think you want to directly patch this into /sbin/init.  
You are executing shell commands, mounting filesystems, etc; do it in a
shell script either by redirecting /sbin/init or by patching /sbin/init
to run an initialization script prior to doing anything else.  Think
about maintenance and also about getting this change upstream; there is
a significant difference between a patch that just adds code to execute
a separate script that can be customized vs. a patch that hardcodes this
particular set of logic into init.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
