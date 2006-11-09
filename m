Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA9Jkwhm031249
	for <selinux@tycho.nsa.gov>; Thu, 9 Nov 2006 14:46:58 -0500
Received: from gateway-1237.mvista.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA9JjLew014087
	for <selinux@tycho.nsa.gov>; Thu, 9 Nov 2006 19:45:21 GMT
Received: from kelownaxp (asshur.mvista.com [10.0.0.11])
	by hermes.mvista.com (Postfix) with ESMTP id 1E4801C358
	for <selinux@tycho.nsa.gov>; Thu,  9 Nov 2006 11:47:06 -0800 (PST)
Reply-To: <cstone@mvista.com>
From: "Chris Stone" <cstone@mvista.com>
To: "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: I would like to propose that we add compression tohandleallpolicy files on disk.
Date: Thu, 9 Nov 2006 14:47:26 -0500
Message-ID: <001101c70437$e2a401a0$b60a10ac@kelownaxp>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1163099472.32083.55.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For embedded devices, size is an issue. We have just started looking at
this, because it is an issue we need to solve for our customers. I am an
SELinux newbie, but, I wanted to add my two cents to the discussion. Please
forgive me if my comments are not relevant.

I would think that tools (such as setools) used for policy analysis or
debugging would be host based. In other words, only the binary policy files
are loaded on the target, and any other files needed to support analysis
would be loaded on the host. Tools would connect to the device remotely and
use the local files to interpret the devices policy, just like gdb loads
symbols on a host to debug a binary running on a remote device. This is
because policy analysis would only ever get done in the lab. Once a device
is deployed, policy analysis would no longer be required. Nobody is going to
deploy setools on an embedded device. If a problem occurs in the field, it
would have to be reproduced in the lab, and then a new corrected binary
policy deployed. I know that the tools don't currently work this way, but,
they are going to have to be modified to support it.

As far as storing the binary policy in the embedded devices file system,
that can be solved by using a compressed file system such as sqaushfs,
cramfs, or jffs2/3. It is certainly true that policies customized for
embedded devices will have to be developed so that they are smaller. It
seems to me that current policies are designed to handle the generic PC
environment, which is not the same as an embedded environment at all.

Finally, and this where I am really past my knowledge, but, it may be
possible to use memory mapped files to reduce the amount of the binary
policy that is actually loaded into memory.

I think the bottom line is that it may be too soon to consider compressing
the policy. We need to define the problem better, and consider the solution
space, before we jump to a solution. MV is doing that and we hope to
contribute in this area.

Cheers,
   Chris.

----------------------------------------
Christopher Stone
Senior Software Engineer
MontaVista Software,Inc. 
2929 Patrick Henry Drive
Santa Clara, CA. 95054-1831 
Web: www.mvista.com
613-831-1892
> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Karl MacMillan
> Sent: November 9, 2006 2:11 PM
> To: Joshua Brindle
> Cc: Stephen Smalley; Daniel J Walsh; SE Linux
> Subject: RE: I would like to propose that we add compression
> tohandleallpolicy files on disk.
> 
> On Thu, 2006-11-09 at 13:50 -0500, Joshua Brindle wrote:
> > > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com]
> > >
> > > On Thu, 2006-11-09 at 12:00 -0500, Joshua Brindle wrote:
> > > > > From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> > > > >
> > > > > On Thu, 2006-11-09 at 10:13 -0500, Stephen Smalley wrote:
> > > > > > On Thu, 2006-11-09 at 09:34 -0500, Joshua Brindle wrote:
> > > >
> > > > Karl suggested that we can compress the policy packages but not the
> > > > kernel policy. As long as this isn't a policy package format change
> > > > (eg., the policy packages in /usr/share/selinux are the
> > > same they've
> > > > always been) and it is only libsemanage manipulating the
> > > files in the
> > > > store I'm fine with that. The module store is a private resource of
> > > > libsemanage so nothing else should be affected in any way by this.
> > > >
> > >
> > > Making semodule recognize bzipped files should be pretty
> > > simple as well
> > > - why wouldn't we do that to save space in /usr/share/selinux?
> > >
> >
> > What about everything else that will read modules (including setools in
> > the future)?
> 
> It's a small amount of logic to detect.
> 
> >  They need to be stored in their native format and I don't
> > think that libsepol should link against a compression library to make
> > that happen.
> 
> What's wrong with letting libsepol dlopen libbz2.so?
> 
> Karl
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
