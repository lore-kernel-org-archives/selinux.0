Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GDEBL9015256
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 08:14:11 -0500 (EST)
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050215213455.GF26294@lkcl.net>
References: <20050215213455.GF26294@lkcl.net>
Content-Type: text/plain
Message-Id: <1108559153.19756.49.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 16 Feb 2005 08:05:53 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-15 at 16:34, Luke Kenneth Casson Leighton wrote:
> i assume it _is_ necessary to perform dynamic auto transitions?
> 
> such that i can track to alternative contexts, yes?

No.  Dynamic transitions are always explicitly requested by
applications, just like setuid(2) calls.  Since you must modify the
application anyway to introduce the dynamic context transition (unlike
an automatic transition upon an existing execve call), there is no such
thing as an automatic dynamic transition.  Now, the issue of how to get
the right new domain is another matter.  For user contexts, we want
something akin to get_default_context().  But in this case, you are
again dealing with two fixed domains that are not associated with a
user, IIUC, so you might as well just create new appconfig files (under
policy/appconfig) that are installed to
/etc/selinux/$SELINUXTYPE/contexts and read by sshd upon startup to
obtain the desired context for the monitor and unprivileged child.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
