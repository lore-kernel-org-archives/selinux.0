Subject: Re: [refpolicy] lnk_file:write
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: russell@coker.com.au, refpolicy@oss1.tresys.com,
        SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1267719909.23761.173.camel@moss-pluto.epoch.ncsc.mil>
References: <201003041221.21671.russell@coker.com.au>
	 <1267719909.23761.173.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 04 Mar 2010 11:29:55 -0500
Message-ID: <1267720195.11679.43.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-03-04 at 11:25 -0500, Stephen Smalley wrote:
> On Thu, 2010-03-04 at 12:21 +1100, Russell Coker wrote:
> > [   12.814762] type=1400 audit(1267664699.904:8): avc:  denied  { write } for  
> > pid=726 comm="udevd" name="4:66" dev=tmpfs ino=1767 
> > scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 
> > tcontext=system_u:object_r:device_t:s0 tclass=lnk_file
> > [   12.814802] type=1300 audit(1267664699.904:8): arch=c000003e syscall=280 
> > success=no exit=-13 a0=ffffffffffffff9c a1=1e69110 a2=0 a3=100 items=0 
> > ppid=689 pid=726 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 
> > sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="udevd" exe="/sbin/udevd" 
> > subj=system_u:system_r:udev_t:s0-s0:c0.c1023 key=(null)
> > 
> > I'm seeing messages like the above in my kernel message log when running the 
> > latest Debian/Testing (2.6.32 kernel and udev 151-2).
> > 
> >         { 4,    TD|TF,  sys_utimensat,          "utimensat"     }, /* 280 */
> > 
> > According to the above from the strace source it seems that on AMD64 syscall 
> > 280 is utimensat().
> > 
> > Should we update manage_lnk_file_perms to include write access?
> 
> Sounds legitimate.  In mainline, SELinux has always checked file write
> permission for the utimes(NULL) case rather than setattr permission.
> Likely people didn't think it was necessary because you never truly
> "write" to a symlink.

I've committed this change.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
