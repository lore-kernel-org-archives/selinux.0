Date: Sun, 27 Oct 2002 15:23:01 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: kernel warning
Message-ID: <20021027042301.GA18290@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While compiling the kernel, 2.4.19, with the latest lsm-SE Linux
patches from Russell (I am not sure how to double check this; but it is
POLICYDB_VERSION 12), I happened to glance at my screen when this was
displayed:

gcc -D__KERNEL__ -I/home/bam/tmp/woody/selinux/kernel-image/kernel-image-2.4.19-i386-2.4.19/build-k6/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6    -Iinclude  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=hooks  -c -o hooks.o hooks.c
hooks.c:66: warning: #warning "SELinux:  The separate SELinux kernel patch has not been applied.  Using SELinux without this patch is not recommended."

Looking at the code I see:

#ifndef _SELINUX_KERNEL_PATCH_
#warning "SELinux:  The separate SELinux kernel patch has not been applied.  Using SELinux without this patch is not recommended."
#endif

Further down I see:

#ifdef _SELINUX_KERNEL_PATCH_
[...]
#else
       printk(KERN_WARNING "SELinux:  The separate SELinux kernel patch was not applied.  Using SELinux without this patch is not recommended.\n");
[...]
#endif

However, _SELINUX_KERNEL_PATCH_ is only used, and never defined, in this
file.

I have also checked this against Russell's patch, it appears to be the
same.

Have I made a mistake somewhere in patching the kernel, or maybe this
code is obsolete? Or perhaps Russell's patch is not intended to be used
standalone anymore but must be used in conjection with another patch?

What is this "seperate kernel patch"?
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
