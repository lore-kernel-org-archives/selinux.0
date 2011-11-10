Subject: Re: SELinux on Android
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bhargava Shastry <bshas3@gmail.com>
Cc: SELinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        James Morris
 <jmorris@namei.org>
In-Reply-To: <CAGGozWSziAmmDb-eO3AjVL=eRgeCHzGb6vo-uNpLy_2sxog2tQ@mail.gmail.com>
References: 
	 <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com>
	 <1320409924.1015.7.camel@moss-pluto>
	 <CAGGozWR6yGyQaxgSED+NdAyLYGzkjDhdWmMxnB=B0qEBAEOtLA@mail.gmail.com>
	 <1320425998.1015.31.camel@moss-pluto>
	 <CAGGozWSziAmmDb-eO3AjVL=eRgeCHzGb6vo-uNpLy_2sxog2tQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Nov 2011 08:12:30 -0500
Message-ID: <1320930750.13691.5.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-11-10 at 11:33 +0100, Bhargava Shastry wrote:
> Hello,
> 
> After some tweaks to load_policy, I was able to compile it against
> Android's bionic C lib. However, I have a problem with loading a
> sample policy compiled on my desktop Ubuntu PC (policydb version 24)
> on the Android phone. Specifically, dmesg on the phone's kernel throws
> up the following error:
> SELinux:  policydb version 24 does not match my version range 15-19
> 
> I see two quick solutions: (1) Re-compile Android kernel with policydb
> version setting changed to 24. Unfortunately, the max version number
> currently supported in Android's 2.6.32 msm kernel is 23. (2)
> Downgrade to policy version 19 on the PC. Any thoughts on alternate
> solutions.

Linux 2.6.32 supported policy.24, unless you forced it to an older
version via CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE (which
you shouldn't set in your kernel config at all; it only exists to
address a backward compatibility problem for Fedora Core 3/4).  Maybe we
should get rid of that option altogether.

I've been using policy.24 policies for Android on the emulator (2.6.29)
and on the Nexus S phones (2.6.35).

> As regards Mr.Russell's comment, I'm afraid I won't be able to make
> the binaries public at the moment. However, in order to get SELinux
> enabled on the Android kernel one could simply do a menuconfig and
> enable NSA SELinux support. Personally, I referred to this:
> http://www.linuxtopia.org/online_books/linux_kernel/kernel_configuration/ch09s06.html . As for the Xattr patch for Android's yaffs FS, it is available publicly here: http://www.enck.org/tools/yaffs_xattr.patch

You don't need an xattr patch anymore; upstream yaffs2 has xattr
support.  You might need to back port newer upstream yaffs2 into your
Android kernel if your Android kernel's yaffs2 lacks such support.  You
also need a patch that I posted to the yaffs2 mailing list to ensure
labeling of new files at creation time, as that isn't provided by
default by the xattr support.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
