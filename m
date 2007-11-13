Subject: Re: Boot Errors
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Lisa Raykowski <lisaraykow@cox.net>
Cc: SELinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
        Manoj Srivastava <manoj.srivastava@stdc.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <20071110192441.8GH97.287922.root@fed1wml01.mgt.cox.net>
References: <20071110192441.8GH97.287922.root@fed1wml01.mgt.cox.net>
Content-Type: text/plain
Date: Tue, 13 Nov 2007 12:33:28 -0500
Message-Id: <1194975208.22155.71.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2007-11-10 at 19:24 -0500, Lisa Raykowski wrote:
> Hello.
> . /etc/selinux/config shows nothing.

It wasn't supposed to display output - the purpose of sourcing it was to
pull in the definition of SELINUXTYPE before the subsequent grep command
that used it.

> 
> These are the actual file contents with a cat:
> selinux:~# cat /etc/selinux/config
> # This file controls the state of SELinux on the system.
> # SELINUX= can take one of these three values:
> # enforcing - SELinux security policy is enforced.
> # permissive - SELinux prints warnings instead of enforcing.
> # disabled - No SELinux policy is loaded.
> SELINUX=permissive
> # SELINUXTYPE= can take one of these two values:
> # refpolicy-targeted - Only targeted network daemons are protected.
> # refpolicy-strict   - Full SELinux protection.
> # refpolicy-src      - Custom policy built from source
> #SELINUXTYPE=refpolicy-targeted
> SELINUXTYPE=refpolicy-targeted
> 
> # SETLOCALDEFS= Check local definition changes
> SETLOCALDEFS=0
> 
> The grep shows:
> 
>  grep /media /etc/selinux/$SELINUXTYPE/contexts/files/file_contexts
> /media(/[^/]*)  -l      system_u:object_r:mnt_t:s0
> /media(/[^/]*)? -d      system_u:object_r:mnt_t:s0
> /media/[^/]*/.* <<none>>

Ok, current upstream policy also has:
/media/\.hal-.*         --      system_u:object_r:mnt_t:s0

Although I'd have typically put that into a derived type myself.

> 
> 
> 
> 
> ---- Stephen Smalley <sds@tycho.nsa.gov> wrote: 
> 
> =============
> On Thu, 2007-11-08 at 22:03 -0500, Lisa R. wrote:
> > Thank you.  The restorecon did not work.  
> > 
> > I am on Debian Etch system with linux-image-2.6.18-5-686.  I probably should have mentioned that.  Targeted policy version 20.
> 
> (added Debian selinux folks to the cc line)
> 
> What does the following show?
> . /etc/selinux/config
> grep /media /etc/selinux/$SELINUXTYPE/contexts/files/file_contexts
> 
> > ---- Stephen Smalley <sds@tycho.nsa.gov> wrote: 
> > > On Wed, 2007-11-07 at 19:39 -0800, Lisa R. wrote:
> > > > Hello.
> > > >  
> > > > I have new to this, have a new system and I have fixed most of the denial errors on boot.  However, I am stuck on three.
> > > > 
> > > > Can anyone help?
> > > > 
> > > > Nov  6 22:00:27 selinux kernel: audit(1194404427.969:3): avc:  denied  { search } for  pid=2814 comm="dmidecode" name="/\
> > > >   " dev=sysfs ino=1 scontext=system_u:system_r:dmidecode_t:s0 tcontext=system_u:object_r:sysfs_t:s0 tclass=dir
> > > > Nov  6 22:00:28 selinux kernel: audit(1194404428.085:4): avc:  denied  { read write } for  pid=2816 comm="hal-storage-cle" name=".hal-mtab-lock" dev=hda1 ino=2359302 scontext=system_u:system_r:hald_t:s0 tcontext=system_u:object_r:default_t:s0 tclass=file
> > > >  Nov  6 22:00:28 selinux kernel: audit(1194404428.089:5): avc:  denied  { lock } for  pid=2816 comm="hal-storage-cle" name=".hal-mtab-lock" dev=hda1 ino=2359302 scontext=system_u:system_r:hald_t:s0 tcontext=system_u:object_r:default_t:s0 tclass=file
> > > 
> > > The name= field in the first message is a bit puzzling, but allowing
> > > dmidecode to search /sys is likely harmless.
> > > 
> > > The other two would seem to be a lack of proper typing
> > > on /media/.hal-mtab-lock.  What happens if you restorecon
> > > -v /media/.hal-mtab-lock?
> > > 
> > > -- 
> > > Stephen Smalley
> > > National Security Agency
> > > 
> > > 
> > > --
> > > This message was distributed to subscribers of the selinux mailing list.
> > > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > > the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
