Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3OKLbI4010660
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 16:21:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3OKLVVf003333
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 20:21:31 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h3OKLV4D003330
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 20:21:31 GMT
Subject: Re: broad domains
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Robert Bihlmeyer <robbe@orcus.priv.at>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <87n0ilej7x.fsf@orcus.priv.at>
References: <87n0ilej7x.fsf@orcus.priv.at>
Content-Type: text/plain
Message-Id: <1051215495.20300.129.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 24 Apr 2003 16:18:15 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-04-20 at 03:11, Robert Bihlmeyer wrote:
> On the other hand, having a domain for every teensy toy out there
> seems a bit excessive.

There isn't any point in defining a separate domain unless you need to
control/protect the program differently.  You need to decide what your
security goals are, identify what resources need to be protected, and
what processes need to be separated.

> BTW, can't setfiles assume some default user & role if none is given?
> Repeating system_u:object_r: a million times is superflous.

This has come up previously on the list; we prefer that the applications
not assume anything about the internal structure of a security context,
so that they will continue to work if you add or remove security models
to/from the policy engine.  SELinux was designed to provide policy
flexibility and minimize the need for policy-specific code outside of
the policy engine.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
