Message-ID: <20071108220300.L69GB.266243.root@fed1wml01.mgt.cox.net>
Date: Thu, 8 Nov 2007 22:03:00 -0500
From: "Lisa R." <lisaraykow@cox.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Boot Errors
Cc: SELinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1194544787.3198.16.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you.  The restorecon did not work.  

I am on Debian Etch system with linux-image-2.6.18-5-686.  I probably should have mentioned that.  Targeted policy version 20.



---- Stephen Smalley <sds@tycho.nsa.gov> wrote: 
> On Wed, 2007-11-07 at 19:39 -0800, Lisa R. wrote:
> > Hello.
> >  
> > I have new to this, have a new system and I have fixed most of the denial errors on boot.  However, I am stuck on three.
> > 
> > Can anyone help?
> > 
> > Nov  6 22:00:27 selinux kernel: audit(1194404427.969:3): avc:  denied  { search } for  pid=2814 comm="dmidecode" name="/\
> >   " dev=sysfs ino=1 scontext=system_u:system_r:dmidecode_t:s0 tcontext=system_u:object_r:sysfs_t:s0 tclass=dir
> > Nov  6 22:00:28 selinux kernel: audit(1194404428.085:4): avc:  denied  { read write } for  pid=2816 comm="hal-storage-cle" name=".hal-mtab-lock" dev=hda1 ino=2359302 scontext=system_u:system_r:hald_t:s0 tcontext=system_u:object_r:default_t:s0 tclass=file
> >  Nov  6 22:00:28 selinux kernel: audit(1194404428.089:5): avc:  denied  { lock } for  pid=2816 comm="hal-storage-cle" name=".hal-mtab-lock" dev=hda1 ino=2359302 scontext=system_u:system_r:hald_t:s0 tcontext=system_u:object_r:default_t:s0 tclass=file
> 
> The name= field in the first message is a bit puzzling, but allowing
> dmidecode to search /sys is likely harmless.
> 
> The other two would seem to be a lack of proper typing
> on /media/.hal-mtab-lock.  What happens if you restorecon
> -v /media/.hal-mtab-lock?
> 
> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
