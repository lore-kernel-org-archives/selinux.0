Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v92MOuUP017835
 for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2017 18:24:56 -0400
Received: by mail-it0-f47.google.com with SMTP id c195so9345984itb.4
 for <selinux@tycho.nsa.gov>; Mon, 02 Oct 2017 15:24:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+RmS-8tfA9fkvY3AWviFdCrrYu8=FhtB=J9__rz_DMcGosoQw@mail.gmail.com>
References: <CA+RmS-8tfA9fkvY3AWviFdCrrYu8=FhtB=J9__rz_DMcGosoQw@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 2 Oct 2017 15:24:49 -0700
Message-ID: <CAFftDdpKJ6GRnF1QhB=Sgp8Szrw_ONODatD+92qY+-eGhBGjSg@mail.gmail.com>
To: David Graziano <david.graziano@rockwellcollins.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: Labeling sysfs files
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Oct 2, 2017 at 2:54 PM, David Graziano
<david.graziano@rockwellcollins.com> wrote:
> I'm trying to find a way of labeling specific files/directories in
> sysfs that do not exist at boot time. I'm running an embedded SELinux
> enabled system (4.1 series kernel) where at boot there is an init
> script performing a restorecon on /sys.  Sometime later a usb cellular
> modem is powered on and enumerated at which point the it's sysfs
> sub-directory structure is added.
>
> This directory path is correctly getting my custom label via
> restorecon during boot
> /sys/devices/platform/xxxx/yyyy/fsl-ehci.0/usb1/
>
> After the cellular modem is powered on the following directory
> structure is created.
> /sys/devices/platform/xxxx/yyyy/fsl-ehci.0/usb1/1-1/1-1:1.10/net/wwan1/qmi
> Everything "1-1" and lower that is getting the "default" sysfs_t label.
>
> Is there a method of labeling that newly added sub-directory structure
> other than running restorecond or restorecon again? I specifically
> need to control access to the "qmi" file. I've tried adding a genfscon
> to the policy but it doesn't seem to work although I don't know if
> it's suppose to.
>
> Any advice would be appreciated.
>

Because of sysfs's dynamic nature, labeling is hard, as you found out.
We have these
issues on Android as well. The best solution for us was to use/add
genfscon support:
http://permalink.gmane.org/gmane.linux.kernel.commits.head/535516

But that patch looks like it won't apply to 4.1 as none of the
SB_GENFS infrastructure
is there.

You'd have to call the restorecon in a part where the file exists but
before any clients
start using it. Perhaps you could register something via inotify (I
don't know offhand
if that works on sysfs).

If it's a service, maybe you could have the service run/trigger the
restorecon on starup,
perhaps vis init/systemd scripts.

Or perhaps you can get on a newer kernel, looks like 4.4 has it:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/security/selinux/hooks.c?h=v4.4.89#n742
