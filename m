Message-Id: <200404141718.i3EHIpJx016309@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <russell@coker.com.au>
Cc: "'Tom Mitchell'" <mitch48@sbcglobal.net>,
   "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Selinux Dev'" <selinux-dev@tresys.com>
Subject: RE: Now that SELinux supports booleans should we replace tunables with booleans?
Date: Wed, 14 Apr 2004 13:19:15 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200404150219.27857.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Russell Coker [mailto:russell@coker.com.au]
> I think that the issue with performance is kernel memory use.  Currently
> for
> FC2T2 we have 7M policydb files which roughly equates to 7M of kernel
> memory
> reserved, which has a huge impact on older hardware!  Most of this is due
> to
> compiling in support for every .te file.
> 
> For a typical machine compiling only the .te files that we need should get
> this down to around 2M.  So obviously for space the correct selection of
> .te
> files is a much more significant issue than booleans.  However such
> selection
> of .te files requires a full environment for building policy on each
> machine
> (which removes one of the advantages you stated for using booleans instead
> of
> tunables).  As configuration of policy features in ways other than removal
> of
> unwanted .te files becomes more popular, the volume of policy (and
> therefore
> size of policydb) will depend much more on such things.  I expect that in
> the
> not too distant future we will have a factor of 2-3 in policydb size
> determined by tunables.  If this is all done in booleans then there will
> be
> some significant amounts of wasted space.
> 

This definitely is a problem, especially since this kernel memory is not
swappable. If this amount of policy is controlled by the tunables (much more
than I thought) then I agree that it is best left as tunables for now.

Karl


Karl MacMillan
Tresys Technology
http://www.tresys.com
(410)290-1411 ext 134

> --
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
