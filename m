Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s06FpbAY003865
 for <selinux@tycho.nsa.gov>; Mon, 6 Jan 2014 10:51:37 -0500
Received: by mail-la0-f48.google.com with SMTP id n7so9788176lam.7
 for <selinux@tycho.nsa.gov>; Mon, 06 Jan 2014 07:51:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140105114502.4a9fd0ff@fornost.bigon.be>
References: <20140105114502.4a9fd0ff@fornost.bigon.be>
Date: Mon, 6 Jan 2014 10:51:34 -0500
Message-ID: <CACLa4puQMxTz=qtoCNPA3mAk==Vrf=5ZxTjE0Jz43iSxziW4TA@mail.gmail.com>
Subject: Re: Mounting selinuxfs as read-only inside chroot
From: Eric Paris <eparis@parisplace.org>
To: Laurent Bigonville <bigon@debian.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

As I recall, and it's been a while.  We first check if selinuxfs
exists in /proc/filesystems.  If so, we know that selinux is enabled
(don't know permissive/enforcing, but we know enabled).  We then look
in /proc/mounts to find where it is mounted.  And then use that mount
point to determine enforcing/permissive.  I believe the way things
work we believe that selinuxfs existing, but not mounted at all,
counts as permissive.  Some higher level tools then failed.  (like
loading policy during an rpm updating inside a chroot)

So we decided that mounting selinuxfs r/o meant that things inside the
chroot could not make changes to the state of the system and we made
the libraries believe that r/o meant 'disabled'

Would have been nicer if there was a way to hide selinuxfs in
/proc/filesystems inside a chroot, but it was easier to do the r/o
means disabled....

On Sun, Jan 5, 2014 at 5:45 AM, Laurent Bigonville <bigon@debian.org> wrote:
> Hi,
>
> I'm maybe missing something, but was wondering, what is the benefit of
> mounting the selinuxfs in a chroot as read-only vs not mounting it at
> all as the user space will anyway report selinux as disabled.
>
> For example, it seems that mock is doing that (looking at the ML
> archive it's the primary reasons this has been implemented).
>
> I'm asking this because several tools in debian that are using chroot
> to build/test (pbuilder, piuparts,...) .deb are mounting the selinuxfs
> r/w and this is causing issues with dpkg if the policy is not installed
> in the chroot.
>
> I'm planing to propose to mount the selinuxfs as r/o in the chroot they
> are using, but I would like to understand this a bit more first.
>
> Cheers,
>
> Laurent Bigonville
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
