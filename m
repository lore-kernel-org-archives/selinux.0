Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3DDV7Rb015965
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 09:31:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3DDV6mw007981
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 13:31:06 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id i3DDV350007970 for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 13:31:05 GMT
Date: Tue, 13 Apr 2004 09:30:56 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Russell Coker <russell@coker.com.au>, <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>, <selinux-dev@tresys.com>
Subject: Re: Policy backward compatibility
In-Reply-To: <1081862054.21530.51.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.44.0404130930440.14102-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 13 Apr 2004, Stephen Smalley wrote:

> On Mon, 2004-04-12 at 04:34, Russell Coker wrote:
> > I recall that James originally suggested encoding policy version in the value 
> > that is used for uname -r not the other way around.  Apart from the issue of 
> > changing the version numbering scheme used for kernels this should be OK.
> 
> I don't think this is what James suggested, but he can clarify.  It
> makes more sense to me to encode the kernel release in the policy
> pathname, not the policy version in the kernel release.  The analogy is
> kernel modules and /lib/modules/`uname -r`.

Yes, this is what I meant.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
