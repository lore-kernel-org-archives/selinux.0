Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1FIv3dj007198
	for <selinux@tycho.nsa.gov>; Thu, 15 Feb 2007 13:57:03 -0500
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1FIwHvK013741
	for <selinux@tycho.nsa.gov>; Thu, 15 Feb 2007 18:58:17 GMT
From: Paul Moore <paul.moore@hp.com>
To: redhat-lspp@redhat.com
Subject: Re: [redhat-lspp] Re: ssh/xinetd/getpeercon???
Date: Thu, 15 Feb 2007 13:58:10 -0500
Cc: Joshua Brindle <jbrindle@tresys.com>, Joy Latten <latten@austin.ibm.com>,
        vyekkirala@TrustedCS.com, selinux@tycho.nsa.gov
References: <1171495601.2603.488.camel@faith.austin.ibm.com> <45D3BBF0.3030901@tresys.com>
In-Reply-To: <45D3BBF0.3030901@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702151358.10230.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, February 14 2007 8:48:32 pm Joshua Brindle wrote:
> Joy Latten wrote:
> > I always wondered if getpeercon() would someday lift its head and bite,
> > I just wish it had not been on Valentine's Day. :-)
> > I am concerned about the mls label being returned.
> >
> > So, my question is, how is this suppose to work?
> > Does CIPSO, when given an mls range, like s3-s9, only pass
> > the effective level through in ip options? If so, is this
> > what labeled ipsec should be doing? Should we be setting only the
> > effective level in the SA? If so, that could potentially create
> > even more SAs. Or should xinetd, when given a range, should only
> > set the effective level for the new process? I kinda like this
> > solution best, that is, xinetd setting single effective level. But
> > I don't know if that is correct resolution?
>
> IMO the entire context should be passed, in CIPSO's case that should be
> the range, if your clearance is s9 on one machine why wouldn't it be on
> another that uses the same levels? I'd hate to see userland interpreting
> ranges like this, it will cause assumptions about the mls policy to be
> made in userspace. While CIPSO is done entirely in the kernel (i think?)
> the decision should still not be made outside the security server which
> is the only part of the system that understands what s2-s9 even means
> (consider a modified mls policy where the second part of the range is
> something other than clearance.
>
> It is (again, IMO) entirely inappropriate for racoon or xinetd or the
> CIPSO code to interpret contexts, this issue keeps coming up and the
> answer should always be that the context is interpreted by the security
> server exclusively.

The CIPSO protocol does not have any concept of a MLS "range", it only allows 
for packets to be labeled with a single sensitivity level and category set.

Currently the NetLabel code only supports a single MLS level.  There are two 
reasons for this:

1. I tend to think packets are objects and as we have seen through numerous 
discussions, "ranged" objects don't make much sense.
2. NetLabel doesn't currently support any protocols which provide a "ranged" 
packet label.

The decision to use the lower/effective/zero-element-in-the-range-array when 
setting the security attributes of a socket using NetLabel is done in the 
SELinux code, not the general NetLabel code and not userspace.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
