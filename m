Date: Mon, 28 Oct 2002 07:57:06 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Brian May <bam@snoopy.apana.org.au>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: kernel warning
In-Reply-To: <20021027042301.GA18290@snoopy.apana.org.au>
Message-ID: <Pine.GSO.4.33.0210280741410.29887-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 27 Oct 2002, Brian May wrote:

> While compiling the kernel, 2.4.19, with the latest lsm-SE Linux
> patches from Russell (I am not sure how to double check this; but it is
> POLICYDB_VERSION 12), I happened to glance at my screen when this was
> displayed:
>
> gcc -D__KERNEL__ -I/home/bam/tmp/woody/selinux/kernel-image/kernel-image-2.4.19-i386-2.4.19/build-k6/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6    -Iinclude  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=hooks  -c -o hooks.o hooks.c
> hooks.c:66: warning: #warning "SELinux:  The separate SELinux kernel patch has not been applied.  Using SELinux without this patch is not recommended."
<snip>
> Have I made a mistake somewhere in patching the kernel, or maybe this
> code is obsolete? Or perhaps Russell's patch is not intended to be used
> standalone anymore but must be used in conjection with another patch?
>
> What is this "seperate kernel patch"?

SELinux has always included a separate SELinux-specific kernel patch to be
applied on top of the LSM patch, although the precise purpose of the patch
has varied over time.  In the current release, the patch is available in
the SELinux archive in selinux/module/selinux-2.4.patch or directly from
http://www.nsa.gov/selinux/patches/selinux-2.4-2002102211.patch.gz.  In
the latest release, the dependence of the SELinux module on this patch has
increased due to the elimination of precondition functions.  Some of the
changes in this patch may find their way back into the mainstream LSM
patch in a more general form in the future (they have all been discussed
on the LSM mailing list), but some changes are likely to remain
SELinux-specific.

As a side note, please be aware that the lsm-2.4 tree and LSM patch that
is provided on the NSA SELinux web site is also different from the
old 2.4.19-lsm1 snapshot patch from WireX.  It is consistent with the head
of the LSM BitKeeper tree, so it includes many changes that have been
committed since that snapshot patch.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
