Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3C8ZWRb007106
	for <selinux@tycho.nsa.gov>; Mon, 12 Apr 2004 04:35:32 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3C8XUUZ012764
	for <selinux@tycho.nsa.gov>; Mon, 12 Apr 2004 08:33:30 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i3C8XTmT012685
	for <selinux@tycho.nsa.gov>; Mon, 12 Apr 2004 08:33:29 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Policy backward compatibility
Date: Mon, 12 Apr 2004 18:34:03 +1000
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>,
   Daniel J Walsh <dwalsh@redhat.com>, selinux-dev@tresys.com
References: <1081430495.6379.89.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1081430495.6379.89.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404121834.03658.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 8 Apr 2004 23:21, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> dropping the backward compatibility support, and requiring that every
> installed kernel have a suitable binary policy installed, possibly
> encoding the associated kernel release (e.g. output of uname -r) in the
> binary policy pathname (and possibly doing likewise for the checkpolicy
> program?).

I recall that James originally suggested encoding policy version in the value 
that is used for uname -r not the other way around.  Apart from the issue of 
changing the version numbering scheme used for kernels this should be OK.

Having multiple checkpolicy programs will probably be painful.  We want all 
the checkpolicy programs to understand the newest syntax (unless we have a 
policy.conf for each policy version).  This means that the old checkpolicy 
will need to be updated any time there is a syntax change.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
