Subject: Re: Been looking at further shrinkage of the SELinux footprint on
 Linux.
From: Colin Walters <walters@verbum.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle
 <jbrindle@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <52715E75.5000005@redhat.com>
References: <52715E75.5000005@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 30 Oct 2013 18:01:59 -0400
Message-ID: <1383170519.23834.34.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2013-10-30 at 15:31 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> We are trying to shrink out cloud image as small as possible.  One idea was to
> shrink SELinux Policy footprint by adding compression to it.
> 
> Here is a patch I have been fooling around with which would read a policy.29
> file if it was compressed with xz.

Given that security_load_policy() just copies the data from userspace,
rather than taking advantage of mmap in any way, it makes total sense to
me to ship it compressed.

xz is usually a better choice for new compression deployments since very
often you want its asymmetric tradeoff of good but expensive compression
and fast decompression, unlike the more symmetric gzip.

Since policy is only loaded occasionally, xz also makes sense to me.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
