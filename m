Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8JLTsrT013879
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 17:29:54 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8JLSs2w000217
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 21:28:55 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joshua Brindle <method@gentoo.org>
Subject: Re: [RFC] Upstream policy handling
Date: Mon, 20 Sep 2004 07:29:50 +1000
Cc: selinux <selinux@tycho.nsa.gov>,
   "pebe >> Chris PeBenito" <pebenito@gentoo.org>
References: <414DA0A7.1000708@gentoo.org> <200409200646.51865.russell@coker.com.au> <414DF5F2.9030700@gentoo.org>
In-Reply-To: <414DF5F2.9030700@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409200729.50087.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 20 Sep 2004 07:11, Joshua Brindle <method@gentoo.org> wrote:
> goal is to make the system secure, and if need be break legacy
> behaviour. These are radical differences.

In Red Hat we are breaking legacy behaviour when necessary.  For example by 
moving away from FAM.

> The Current CVS policy is heavily biased toward Redhat (and their
> SELinux goals). This leaves no room for others (such is why I'm
> suggesting this)

I was writing SE Linux policy for Debian long before anyone who was employed 
by Red Hat was doing any SE Linux work.  Now I work for Red Hat writing SE 
Linux policy and write Debian policy in my spare time.

I don't think that distributions other than Red Hat are being squeezed out.

The Debian goals are closer to Gentoo goals than that of Fedora.  For example 
there is no targeted policy in Debian.

> >OK, try maintaining a separate Gentoo policy patch for another year or so
> > and see if you still think that distribution specific tunables are a bad
> > idea.  ;)
>
> PeBenito has maintained our policy for longer than that.  Distro
> tunables (and indeed many many of the current tunables) are
> fundamentally flawed.
> Think about the difficulty of analyzing policy with X number of
> tunables. To do it properly you'd have to analyze X! permutations. Then
> take into account conditionals, and optional modules.

To be pedantic it would be 2^X not X!.

But you don't need to analyse those combinations.  The people who make the 
distribution need to analyse the default options and the recommended 
configurations (of which there should be a small number), and anyone who 
wants to customise their policy has to analyse it themself.

> >The problem is that vendors will introduce bad patches.  Without the
> >requirement to get the policy checked off by Steve the quality will drop
> >while the number of unmerged patches steadily increases.
>
> eh? vendors would introduce bad patches to their own policy. Obviously
> this can already be done, I'm not sure what you are getting at here.

If the difference between the vendor policy and the NSA policy is small then 
there is less scope for error.

> If vendors are concerned about their patches they'd still be able to
> post them to the list (also the changesets would be available at a
> specific central place for everyone so it would be far easier to see
> what people are doing to the policies, and the differences, etc)

How big are the patches between the Gentoo policy and the NSA policy?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
