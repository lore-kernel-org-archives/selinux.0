Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i738RDrT019088
	for <selinux@tycho.nsa.gov>; Tue, 3 Aug 2004 04:27:13 -0400 (EDT)
Received: from snowstorm.hosts.ndo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i738Qd6o003625
	for <selinux@tycho.nsa.gov>; Tue, 3 Aug 2004 08:26:40 GMT
Date: Tue, 3 Aug 2004 09:35:48 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: "Marco d'Itri" <md@Linux.IT>, 263079@bugs.debian.org,
   linux-hotplug-devel@lists.sourceforge.net, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Bug#263079: udev: missing mknod on ppp
Message-ID: <20040803083548.GB3504@lkcl.net>
References: <E1Brl5k-0006Jd-1F@lkcl.net> <20040802224118.GA18849@wonderland.linux.it> <20040802231534.GB16238@lkcl.net> <20040802231148.GA19178@wonderland.linux.it> <410EEFD9.2020902@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <410EEFD9.2020902@ums.usu.ru>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 03, 2004 at 07:52:25AM +0600, Alexander E. Patrakov wrote:
> Marco d'Itri wrote:
> 
> > On Aug 03, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> >
> >> thank you for pointing me at the README.Debian because it makes
> >> clear that for SE/Linux there are certain /dev entries that may not
> >> get fired up by udev, and consequently won't have se/linux
> >> permissions set!
> >
> > On debian, *all* devices are supposed to be created by udev if udev
> > is installed (because /dev is a tmpfs). I don't know why /dev/ppp is
> > not being created on your system.
> >
> Bedause the ppp-generic module is not autoloaded (put it into 
> /etc/modules or see below).
> 
> The same problem exists for all "non-hardware" modules. It can be solved 
> by explicitly loading all these non-hardware modules at system startup. 
> The following bootscriptlet loads all modules that potentially create 
> devices and don't need hardware (i.e. exactly those drivers that are 
> autoloaded on demand due to "char-major" aliases without udev):
> 
>    KVERSION=`uname -r`
>    for module in `egrep '^alias (char|block)-major' \
>        /lib/modules/$KVERSION/modules.alias /etc/modprobe.conf | \
>        grep -v 1394 | awk '{print $3;}'`
>    do
>        modprobe $module
>    done
> 

 okay.

 in addition to calling modprobe, it is necessary to set selinux
 permissions.

 now, modprobe  has a pretty name, but the command to call up the module
 contains no information about what node is going to be created in /dev.

 therefore, we have a problem.

 without the name of the inode, the only way to set the selinux file
 permissions is to either guess or to just... endeavour to set the
 whole lot with this:
 
	 setfiles /etc/selinux/.../file_contexts/file_contexts /dev

 this is totally yuk, but is a last resort measure.

 anyone got any better ideas?

 does anyone know whether doing the modprobe above will result in a
 hotplug event from the "non-hardware" devices, such that udev will
 be triggered, and a restorecon or createcon performed correctly?

 marco kindly mentioned to me that some devices haven't been hooked into
 the pci-hotplug stuff yet.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
