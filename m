Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n37LsMHU010582
	for <selinux@tycho.nsa.gov>; Tue, 7 Apr 2009 17:54:22 -0400
Received: from g1t0027.austin.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n37LsMPE009999
	for <selinux@tycho.nsa.gov>; Tue, 7 Apr 2009 21:54:22 GMT
Received: from g4t0018.houston.hp.com (g4t0018.houston.hp.com [16.234.32.27])
	by g1t0027.austin.hp.com (Postfix) with ESMTP id E16F2385DE
	for <selinux@tycho.nsa.gov>; Tue,  7 Apr 2009 21:54:21 +0000 (UTC)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by g4t0018.houston.hp.com (Postfix) with ESMTP id C6EAA10019
	for <selinux@tycho.nsa.gov>; Tue,  7 Apr 2009 21:54:21 +0000 (UTC)
From: Paul Moore <paul.moore@hp.com>
To: Jarrett Lu <Jarrett.Lu@sun.com>
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft posted to IETF website
Date: Tue, 7 Apr 2009 17:30:53 -0400
Cc: labeled-nfs@linux-nfs.org, nfs-discuss@opensolaris.org,
        selinux@tycho.nsa.gov, nfsv4@ietf.org
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil> <200904011246.33436.paul.moore@hp.com> <49D56484.50401@sun.com>
In-Reply-To: <49D56484.50401@sun.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200904071730.54112.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 02 April 2009 09:21:08 pm Jarrett Lu wrote:
> On 04/01/09 09:46, Paul Moore wrote:
> > On Wednesday 01 April 2009 03:46:58 am Jarrett Lu wrote:
> >> ... and probably outside the scope of labeled NFSv4 enhancement.
> >
> > Perhaps.  Keep in mind I'm trying to think a bit more generically; if
> > that isn't the goal I'll be happy to go back to my corner and sit quietly
> > :)
> >
> >> So realistically, I think the DOI + opaque label is useful between very
> >> compatible systems.
> >
> > Of course.  I agree there are a lot of things you can do with a DOI +
> > opaque label, especially if you are only concerned about end-to-end
> > security issues which I believe is the case for labeled NFS.
> >
> >> Given that limitation, may be the "package" is small enough and can be
> >> passed in RPC layer during authentication so that MLS can share files
> >> with like MLS systems, and same is true for DTE, fmac, smack, ....
> >
> > Well, I think all that the opaque label buys you is the ability to limit
> > who you share the security policy/translation "package" with, as those
> > systems that participate in the labeled communication (be it NFS, generic
> > IP or some other random service) still need to worry about label
> > translation and security policy differences if they want to enforce
> > policy locally.
>
> I am still trying to understand what is needed to make safe sharing
> possible. BTW, are you implying that it's always necessary to do one
> label translation, e.g. from on-the-wire format to a native label format?

[Sorry for the delayed response.]

As I said earlier I think the easiest way forward is to design systems that 
can interoperate with established DOI definitions and not worry about what 
other peer systems are using for a security mechanism.  In some cases that 
will require translations from a native label format to a wire format and back 
to a label format; in some cases it may result in no translations at all.  It 
all depends on the individual systems and the DOI.

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
