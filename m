Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0KEliIi005083
	for <selinux@tycho.nsa.gov>; Thu, 20 Jan 2005 09:47:44 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0KEllCf015562
	for <selinux@tycho.nsa.gov>; Thu, 20 Jan 2005 14:47:47 GMT
Subject: Re: run_init and interactive scripts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <87acr4u57h.fsf@glaurung.internal.golden-gryphon.com>
References: <87acr4u57h.fsf@glaurung.internal.golden-gryphon.com>
Content-Type: text/plain
Message-Id: <1106230120.26753.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 20 Jan 2005 09:08:40 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-19 at 22:53, Manoj Srivastava wrote:
>         run_init, as distributed, can run init scripts in the initrc
>  domain. However, if the forked process is an interactive one, it
>  inherits the controlling tty, which is would mean that the
>  controlling tty is the controlling tty of a sysadm_t process -- and
>  this can be a problem, since a process  that has a pty can insert
>  characters and potentially take over a sysadm_t session. (If the
>  process invokes a daemon that does not close file handles, then if
>  exploited can be used to take over administrative sessions). (This
>  also inhibits denials due to an initrc_exec_t process trying to write
>  to a sysadm_devpts_t object).

Just to clarify, the current SELinux security module rechecks access to
the controlling tty and to any open file descriptors upon a
context-changing exec, and will automatically revoke access if denied by
policy.  Hence, without any change, it should already be the case that
unless the daemon is explicitly granted permissions to the pty, all
access should be revoked upon the transition into the daemon's domain. 
If you have a daemon running in initrc_t, you have other problems.  I'm
not opposed to this patch (we did merge a version of open_init_pty from
Russell a long time ago, but reverted it due to some problems with its
implementation/dependency on expect), but wanted to clarify this
point...
> 
> ______________________________________________________________________
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
