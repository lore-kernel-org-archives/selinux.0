Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3HI9rI4007333
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2003 14:09:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3HI9pVf019171
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2003 18:09:51 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h3HI9p4D019168
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2003 18:09:51 GMT
Subject: Re: logging messages
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <3E9EB10C.8010409@redhat.com>
References: <200303132210.40371.russell@coker.com.au>
	 <3E9EB10C.8010409@redhat.com>
Content-Type: text/plain
Message-Id: <1050545410.1076.9.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 16 Apr 2003 22:10:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-04-17 at 09:50, Daniel J Walsh wrote:
> How do I get the kernel to log a message again.  Seems like the SELinux 
> kernel on
> logs a denial message a single time after a reboot.  When I change the 
> policy and
> rerun the offending command I would like to see a new error message in 
> /var/log/messages.
> 
> Is there a way to turn this on?

When in permissive mode, SELinux logs each denial once and then adds the
corresponding permission to the cache so that you don't end up with a
flood of identical messages.  The denial won't show up again until the
cache entry is reclaimed.  You can reset the cache by reloading your
policy (e.g. running 'make reload' in the policy directory) or by
switching into enforcing mode (and then optionally back into permissive
mode) by using 'avc_toggle' (assuming that you are in a domain that can
do this).

When in enforcing mode, SELinux applies a rate limit to audit messages
to avoid flooding attacks.  This is necessary even with benign
applications, because many applications don't bother checking error
codes on certain calls so they will generate a huge stream of repeat
denials.  Long term, we would like to see the SELinux audit data handled
by a separate kernel auditing subsystem rather than the existing logging
facility.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
