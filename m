Date: Tue, 29 Oct 2002 09:53:43 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: kernel warning
Message-ID: <20021028225343.GD18889@snoopy.apana.org.au>
References: <20021027042301.GA18290@snoopy.apana.org.au> <Pine.GSO.4.33.0210280741410.29887-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0210280741410.29887-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Oct 28, 2002 at 07:57:06AM -0500, Stephen Smalley wrote:
> SELinux has always included a separate SELinux-specific kernel patch to be
> applied on top of the LSM patch, although the precise purpose of the patch
> has varied over time.  In the current release, the patch is available in
> the SELinux archive in selinux/module/selinux-2.4.patch or directly from
> http://www.nsa.gov/selinux/patches/selinux-2.4-2002102211.patch.gz.  In
> the latest release, the dependence of the SELinux module on this patch has
> increased due to the elimination of precondition functions.  Some of the
> changes in this patch may find their way back into the mainstream LSM
> patch in a more general form in the future (they have all been discussed
> on the LSM mailing list), but some changes are likely to remain
> SELinux-specific.
> 
> As a side note, please be aware that the lsm-2.4 tree and LSM patch that
> is provided on the NSA SELinux web site is also different from the
> old 2.4.19-lsm1 snapshot patch from WireX.  It is consistent with the head
> of the LSM BitKeeper tree, so it includes many changes that have been
> committed since that snapshot patch.

Russell,

Do you have any plans to include this patch, which currently appears to
be missing into your Debian package kernel-patch-2.4-lsm?

When I next get the chance I will patch my kernel source image available
online my website with this extra patch.
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
