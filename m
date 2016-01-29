Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u0TJ2JoL021611
 for <selinux@tycho.nsa.gov>; Fri, 29 Jan 2016 14:02:19 -0500
From: Thomas Downing <tdowning@bomgar.com>
To: <selinux@tycho.nsa.gov>
Subject: Re: Newbie question on fixfiles
Date: Fri, 29 Jan 2016 13:03:56 -0600
Message-ID: <3353242.f7fzmEr840@juss>
In-Reply-To: <56ABA942.9020701@tycho.nsa.gov>
References: <1464190.SZXTM0cE5o@juss> <56ABA942.9020701@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, January 29, 2016 13:02:42 Stephen Smalley wrote:
> On 01/29/2016 12:25 PM, Thomas Downing wrote:
> > Hi,
> > 
> > I need to get SELinux running on an appliance we are building, not based
> > on a distro that already supports SELinux.
> > 
> > I've got all the userspace stuff built, (including setools3) without any
> > warnings or errors. I followed instructions for installing and loading
> > refpolicy, no warnings or errors.  (Except the python tools, which all
> > import selinux.py, which does not seem to be included in the source
> > tree.)
> > 
> > I'm booting with kernel options "security=selinux selinux=1", and dmesg
> > shows SELinux initializing, and no errors or warnings.
> > 
> > sestatus output:
> > 
> > SELinux status:				enabled
> > SELinuxfs mount:			/sys/fs/selinux
> > SELinux root directory:		/etc/selinux
> > Loaded policy name:		refpolicy
> > Current mode:				permissive
> > Mode from config file:		permissive
> > Policy MLS status:			disabled
> > Policy deny_unknown status:	denied
> > Max kernel policy version:		30
> > 
> > Problem is: fixfiles does not actually label anything, and the underlying
> > reason is that none of the mounted disk filesystems (all ext4) have
> > option 'seclabel'.
> > 
> > Any pointers?
> > 
> > Also, given the absence of the seclabel option, I question if the kernel
> > part of SELinux is in fact really happy...and if it isn't, I'm dead in
> > the water anyway.
> 
> This implies that you haven't loaded a policy into the kernel. Normally
> this is done by init; both sysvinit and systemd should already include
> the necessary bits but you may have to enable them in your configure.

Okay, my bad, I thought I had done "make load" in 
/etc/selinux/refpolicy/src/policy, but I guess I missed that.  So now 
"seclabel" shows up on all ext4 file systems in /proc/mounts, so that is good.

Now running "fixfiles -F -f -v -l fixfiles.log relabel" does not complain.

But now I've got two other problems:

1. Looking at the log file produced, only a few files are said to be labeled, 
outside of /run/udev, /dev etc.  What happened to everything else in 
file_contexts?

2. None of the files that the log file claims were relabeled, are in fact 
labeled, according to 'ls -Z'.

There is no sysvinit script for selinux stuff for this distro, I need to create 
all that.  Looking at Fedora 22 that is current SELinux enabled, I can't find 
the systemd unit file that does the load, or I would use that as a reference.

On the other hand, I seems I should be able to use what "make load" does as a 
reference as well.  Is that a valid assuption?

Thanks

Thomas Downing
