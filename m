Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u0TJda8I024667
 for <selinux@tycho.nsa.gov>; Fri, 29 Jan 2016 14:39:36 -0500
From: Thomas Downing <tdowning@bomgar.com>
To: <selinux@tycho.nsa.gov>
Subject: Re: Newbie question on fixfiles
Date: Fri, 29 Jan 2016 13:41:03 -0600
Message-ID: <1879048.qkpSbo0Lir@juss>
In-Reply-To: <56ABBCB7.4070704@tycho.nsa.gov>
References: <1464190.SZXTM0cE5o@juss> <3353242.f7fzmEr840@juss>
 <56ABBCB7.4070704@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, January 29, 2016 14:25:43 Stephen Smalley wrote:
[snip]
> >> This implies that you haven't loaded a policy into the kernel. Normally
> >> this is done by init; both sysvinit and systemd should already include
> >> the necessary bits but you may have to enable them in your configure.
> > 
> > Okay, my bad, I thought I had done "make load" in
> > /etc/selinux/refpolicy/src/policy, but I guess I missed that.  So now
> > "seclabel" shows up on all ext4 file systems in /proc/mounts, so that is
> > good.
> > 
> > Now running "fixfiles -F -f -v -l fixfiles.log relabel" does not complain.
> > 
> > But now I've got two other problems:
> > 
> > 1. Looking at the log file produced, only a few files are said to be
> > labeled, outside of /run/udev, /dev etc.  What happened to everything
> > else in file_contexts?
> > 
> > 2. None of the files that the log file claims were relabeled, are in fact
> > labeled, according to 'ls -Z'.
> > 
> > There is no sysvinit script for selinux stuff for this distro, I need to
> > create all that.  Looking at Fedora 22 that is current SELinux enabled, I
> > can't find the systemd unit file that does the load, or I would use that
> > as a reference.
> > 
> > On the other hand, I seems I should be able to use what "make load" does
> > as a reference as well.  Is that a valid assuption?
> 
> SELinux initialization is normally done directly from init code, not
> from a script file or unit file, because we need init to load policy and
> then re-exec itself or dynamically switch contexts to get init into its
> own security context (otherwise it will be left in the kernel's domain).
>   sysvinit and systemd source code already include that support (as does
> Android init); if using them, you might just need to rebuild with the
> appropriate configure flags.
> 
> Alternatively, you could invoke "load_policy -i" from an initramfs
> script after switching to the real root and before executing init.
> 
> If you run restorecon -v /path/to/file for one of these files that
> wasn't labeled, what does it say?  What does ls -Z show for the file
> before and after?

About init, duh, just not thinking.  I will indeed need to rebuild init.

restorecon -v /home/tdowning/.viminfo:

restorecon reset /home/tdowning/.viminfo context 
system_u:object_r:user_home_dir_t->system_u:object_r:user_home_t

But ls -aZ:

? .viminfo

(~/.viminfo is the only file under /home that fixfiles even tried to relabel).

It occurs to me that maybe all of fileutils, coreutils,sysutils, libnss*, pam* 
and such like might need to be rebuilt?  Maybe ls is just not build right.  I 
note that 'id -Z' complains "works only on an SELinux-enabled kernel", 
indicating the need to rebuild all that stuff.

thanks

td
