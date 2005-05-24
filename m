Subject: Re: Moving target -- kernel version.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Roger Brunell <rog_brunell@yahoo.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050524123502.74451.qmail@web60424.mail.yahoo.com>
References: <20050524123502.74451.qmail@web60424.mail.yahoo.com>
Content-Type: text/plain
Date: Tue, 24 May 2005 09:20:47 -0400
Message-Id: <1116940847.27904.46.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-05-24 at 05:35 -0700, Roger Brunell wrote:
> I am starting to feel a rising wave of frustration with producing a
> reproducible script for installing selinux.
> 
> To do the install the kernel must be patched and rebuild.
> To patch and build the source must be present
> But which source???
>   ? apt-get kernel-source-2.6.11     (version = 2.6.11-3)
>   ? Distro version is not documented
>      ? Kernel.org patches applied not documented
>      ? Distro patches applied -- not documented

First, you can use a vanilla kernel.org kernel or your favorite distro
kernel unchanged, as long it is a 2.6 kernel and SELinux support was
enabled in the kernel configuration, since SELinux is in the mainline
kernel.  For some distro kernels like Debian or SuSE, this means you
need to boot with selinux=1 on the kernel commandline because they
compiled in SELinux support but set the default to disable at boot time.
You only need to patch and build your own kernel if you want the latest
SELinux changes and they aren't already included in your kernel.  Note
that a superset of the SELinux changes from the patch on nsa.gov are
included in 2.6.12-rc4, so that is actually more up-to-date with the
latest SELinux changes than the 2.6.11-based patch on nsa.gov.

Second, http://www.nsa.gov/selinux/code/download5.cfm clearly states
that the SELinux kernel patch available there is relative to the 2.6.11
sources from The Linux Kernel Archives aka kernel.org.  It applies
cleanly to that kernel.

>   ? /nsa/linux-2.6/    is what? Virgin kernel.org sourec ??
>          nope, it changed since last CVS download a week ago (changes = 2168)

Did you read the nsa/README file?  The vendor branch of that tree tracks
the official nsa.gov SELinux releases, and interim updates between
releases are committed on the head.  Hence, it is presently 2.6.11 with
the 2.6.11-selinux1.patch applied plus some subsequent updates to
reflect changes made since the release.  I don't believe that it has
changed recently; looks like the last update was April 28th.

> Right now I am diffing the /nsa/linux-2.6 and the apt-get kernel source.

Bad idea.  That will end up reverting all the patches applied to the
Debian kernel, since nsa/linux-2.6 is just vanilla 2.6.11 plus SELinux
changes.  Either just use the Debian kernel as is (boot with selinux=1)
or try applying the 2.6.11-selinux1.patch to it if you truly need those
changes.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
