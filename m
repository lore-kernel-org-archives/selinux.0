Message-ID: <52723F44.5070908@tycho.nsa.gov>
Date: Thu, 31 Oct 2013 07:30:12 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>
CC: Daniel J Walsh <dwalsh@redhat.com>, Joshua Brindle <jbrindle@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: Been looking at further shrinkage of the SELinux footprint on
 Linux.
References: <52715E75.5000005@redhat.com> <1383170519.23834.34.camel@localhost>
In-Reply-To: <1383170519.23834.34.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/30/2013 06:01 PM, Colin Walters wrote:
> On Wed, 2013-10-30 at 15:31 -0400, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> We are trying to shrink out cloud image as small as possible.  One idea was to
>> shrink SELinux Policy footprint by adding compression to it.
>>
>> Here is a patch I have been fooling around with which would read a policy.29
>> file if it was compressed with xz.
> 
> Given that security_load_policy() just copies the data from userspace,
> rather than taking advantage of mmap in any way, it makes total sense to
> me to ship it compressed.

Maybe I misunderstood you, but the callers of security_load_policy()
(e.g. selinux_mkload_policy, selinux_init_load_policy) work by mmap'ing
the policy file and then passing that region to security_load_policy().
 They only currently have to copy it if they need to modify the policy
at load time (e.g. if the userspace policy version is newer than that
supported by the kernel and it needs to downgrade to the kernel version).

> 
> xz is usually a better choice for new compression deployments since very
> often you want its asymmetric tradeoff of good but expensive compression
> and fast decompression, unlike the more symmetric gzip.
> 
> Since policy is only loaded occasionally, xz also makes sense to me.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
