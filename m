Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3DDYDRb015990
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 09:34:13 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3DDWAUZ006406
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 13:32:10 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i3DDW9mT006403
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 13:32:09 GMT
Subject: Re: Policy backward compatibility
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>,
   Daniel J Walsh <dwalsh@redhat.com>, selinux-dev@tresys.com
In-Reply-To: <1081862565.21530.56.camel@moss-spartans.epoch.ncsc.mil>
References: <1081430495.6379.89.camel@moss-spartans.epoch.ncsc.mil>
	 <200404121834.03658.russell@coker.com.au>
	 <1081862054.21530.51.camel@moss-spartans.epoch.ncsc.mil>
	 <1081862565.21530.56.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1081863227.21530.69.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 13 Apr 2004 09:33:47 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-04-13 at 09:22, Stephen Smalley wrote:
> And, yes, this will require separate policy.conf files for the different
> versions, but that is going to be necessary anyway for significant
> changes to the policy.  Even for the netlink class partitioning, you
> don't want to compile a newer policy.conf that has the fine-grained
> netlink classes with an older checkpolicy, as the best it could do would
> be to map them all to the old netlink class, possibly opening up
> unintended access.

And likewise for any significant use of booleans, since the
compatibility code just discards the conditional statements entirely
rather than generating statements based on the initial boolean value...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
