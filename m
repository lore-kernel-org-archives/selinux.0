Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7EDpg0S013028
	for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2007 09:51:42 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7EDpe76019407
	for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2007 13:51:41 GMT
Received: by an-out-0708.google.com with SMTP id c38so366495ana
        for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2007 06:51:40 -0700 (PDT)
Message-ID: <4c4ba1530708140651u70a907a0s198b744ea96cb44c@mail.gmail.com>
Date: Tue, 14 Aug 2007 06:51:38 -0700
From: "Tom London" <selinux@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: Strange behavior with skype
Cc: "Daniel J Walsh" <dwalsh@redhat.com>,
        "Karl MacMillan" <kmacmill@redhat.com>,
        "SE Linux" <selinux@tycho.nsa.gov>, "James Morris" <jmorris@namei.org>,
        "Eric Paris" <eparis@parisplace.org>
In-Reply-To: <1187092078.26008.103.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <46BE75D1.5030503@redhat.com>
	 <1187010842.26008.32.camel@moss-spartans.epoch.ncsc.mil>
	 <4c4ba1530708131313n350f4036o7a2d513770a65c90@mail.gmail.com>
	 <1187092078.26008.103.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 8/14/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2007-08-13 at 13:13 -0700, Tom London wrote:
> > On 8/13/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > On Sat, 2007-08-11 at 22:52 -0400, Daniel J Walsh wrote:
> > > > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=246762
> > > >
> > > > I downloaded skype from this site
> > > >
> > > > http://www.skype.com/download/skype/linux/
> > > >
> > > > Installed it and did a
> > > >
> > > > chcon -t unconfined_execmem_exec_t /usr/bin/skype
> > > >
> > > > # ls -lZ /usr/bin/skype
> > > > -rwxr-xr-x  root root system_u:object_r:unconfined_execmem_exec_t /usr/bin/skype
> > > >
> > > >
> > > > But when I run it, I still get
> > > >
> > > > time->Sat Aug 11 22:46:20 2007
> > > > type=PATH msg=audit(1186886780.191:3467): item=1 name=(null) inode=8060946 dev=fd:00 mode=0100755 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:ld_so_t:s0
> > > > type=PATH msg=audit(1186886780.191:3467): item=0 name="/usr/bin/skype" inode=10345414 dev=fd:00 mode=0100755 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:unconfined_execmem_exec_t:s0
> > > > type=CWD msg=audit(1186886780.191:3467):  cwd=2F686F6D652F646576656C2F6477616C73682F4D7920446F776E6C6F616473
> > > > type=EXECVE msg=audit(1186886780.191:3467): a0="skype"
> > > > type=SYSCALL msg=audit(1186886780.191:3467): arch=40000003 syscall=11 success=no exit=-13 a0=9eb8958 a1=9eb8b58 a2=9e95c30 a3=0 items=2 ppid=4077 pid=5789 auid=3267 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts3 comm="skype" subj=system_u:system_r:unconfined_t:s0 key=(null)
> > > > type=AVC msg=audit(1186886780.191:3467): avc:  denied  { execmem } for  pid=5789 comm="skype" scontext=system_u:system_r:unconfined_t:s0 tcontext=system_u:system_r:unconfined_t:s0 tclass=process
> > > >
> > > > When I run a unconfined_execmem_exec_t shell script with id -Z I get the proper transition.
> > > >
> > > > system_u:system_r:unconfined_execmem_t
> > >
> > > IIUC, in this case, the attempt to create the mapping is happening from
> > > the kernel elf loader while mapping in the new executable _before_ the
> > > domain transition takes effect.  So it shows up as a check on the caller
> > > domain rather than the new domain.
> > >
> >
> > That pretty much describes what I am seeing....
> >
> > I believe this behavior started just a bit before I filed the BZ, as
> > my recollection  is this 'used to work'.  That possible?
>
> I don't think the kernel behavior has changed here - domain transitions
> have always taken effect after the kernel has mapped the executable (we
> do the domain transition at the same point where the setuid/setgid
> transition happens, upon compute_creds).  Labeling a program with
> unconfined_execmem_exec_t can only help when it is userspace (ld.so or
> the application) that tries to make a writable mapping executable, not
> the initial mapping of the executable by the kernel.
>
> I suppose we could explore moving up where domain transitions happen,
> but that would require a new hook earlier in the code separate from the
> normal compute_creds and could have side effects.
>
OK.  My memory is certainly not what it used to be ;)

I do remember changes to mmap/mprotect; perhaps I 'combined' 2 issues...

So, should something like "runcon -t unconfined_execmem_t
/usr/bin/skype" pass muster?  The transition should occur before the
kernel maps the executable, right?

However, it still fails with:

type=AVC msg=audit(1187099382.922:33): avc:  denied  { execmem } for
pid=4989 comm="skype" scontext=system_u:system_r:unconfined_t:s0
tcontext=system_u:system_r:unconfined_t:s0 tclass=process
type=SYSCALL msg=audit(1187099382.922:33): arch=40000003 syscall=11
success=no exit=-13 a0=bfd7f984 a1=bfd7eda0 a2=bfd7eda8 a3=8fb4d58
items=0 ppid=3395 pid=4989 auid=500 uid=500 gid=500 euid=500 suid=500
fsuid=500 egid=500 sgid=500 fsgid=500 tty=pts1 comm="skype"
subj=system_u:system_r:unconfined_t:s0 key=(null)


tom
-- 
Tom London

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
