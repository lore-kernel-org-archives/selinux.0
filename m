Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j06Ei3Ii008954
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2005 09:44:03 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j06EgAww007825
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2005 14:42:10 GMT
Subject: Re: passwd using getprevcon() for enforcement
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <method@gentoo.org>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1105021782.972.9.camel@twoface>
References: <1105021782.972.9.camel@twoface>
Content-Type: text/plain
Message-Id: <1105022304.24438.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 06 Jan 2005 09:38:24 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-01-06 at 09:29, Joshua Brindle wrote:
> I was wondering why Fedora's passwd is patched to use getprevcon()? It
> seems to me that enforcing policy on a types previous context is very
> broken behavior. Shouldn't the patch enforce on the current context and
> have different passwd types for privileged users (i seem to remember
> that there was a passwd_t and sysadm_passwd_t but that might have been
> old-api).

It is performing a check of the caller's permissions, so it wants the
domain of the caller (the previous context), not its own context.  It is
asking the question "Can the caller perform a privileged passwd
operation?", not the question "Can I perform a privileged passwd
operation?".   Parallel:  When the kernel performs a permission check,
it uses the credentials of the current process, not the kernel's own
credentials.  s/kernel/passwd program/

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
