Message-ID: <1342010812.29461.24.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Adding support for ro.build.selinux to Android.os.SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, rpcraig <rpcraig@tycho.ncsc.mil>
Date: Wed, 11 Jul 2012 08:46:52 -0400
In-Reply-To: <CAFftDdo=pXiZQjTNi=EpqqrEd6i4U0Gf3G8kw57wmBmYjT+HdA@mail.gmail.com>
References: 
	<CAFftDdo=pXiZQjTNi=EpqqrEd6i4U0Gf3G8kw57wmBmYjT+HdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-07-10 at 16:49 -0700, William Roberts wrote:
> Wasn't sure if we wanted to move away from going through a JNI binding
> since we now have access to ro.build.selinux.
> 
> 
> This is some rough draft code, didn't know if we wanted to replace
> SELinux.isSELinuxEnabled() or augment another function for it.
> 
> 
> Please advise.

isSELinuxEnabled() is more general; it will return false if:
- SELinux was disabled in the build,
- SELinux was enabled in the build but not in the kernel,
- SELinux was enabled in the build and the kernel but no policy was
loaded.

In any of those cases, you just want to disable the userspace SELinux
processing, so a simple check of isSELinuxEnabled() is what you want.  I
don't see a need to check the build property from userspace aside from
the special case in the Settings app.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
