Subject: Re: [PATCH -v3] SELinux: Add get, set, and cloning of superblock
	security information
From: Eric Paris <eparis@redhat.com>
To: casey@schaufler-ca.com
Cc: selinux@tycho.nsa.gov, LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <213551.91867.qm@web36615.mail.mud.yahoo.com>
References: <213551.91867.qm@web36615.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Sat, 10 Nov 2007 01:41:34 -0500
Message-Id: <1194676894.4627.61.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2007-11-09 at 14:46 -0800, Casey Schaufler wrote:
> --- Eric Paris <eparis@redhat.com> wrote:
> 
> > Adds security_get_sb_mnt_opts, security_set_sb_mnt_opts, and
> > security_clont_sb_mnt_opts to the LSM and to SELinux.  This will allow
> > filesystems to directly own and control all of their mount options if
> > they so choose.
> 
> I understand why you would want get_sb_mnt_opts(), but what
> is the value for set_sb_mnt_opts() and what is the purpose of
> clone_sb_mnt_opts()?

set is really the most important one.  NFS knows when it creates a
superblock (using SELinux as an example) that it wants to set
context=blah.  Thus it calls into set_sb_mnt_opts with the flag for
"context=" and "blah."   get_sb_mnt_opts will likely get used in the
future for /proc/mounts to be able to report the security options.
clone is really just to make it easy for the FS.  If they know "i want
the new one to look like this old one" they can just call into clone_
and don't have to worry about dealing freeing memory or anything like
that...
> 
> > This interface deals only with option identifiers and
> > strings so it should generic enough for any LSM which may come in the
> > future.  Filesystems which pass text mount data around in the kernel
> > (almost all of them) need not currently make use of this interface for
> > SELinux sake since it will still parse those strings as it always has.
> 
> If SELinux is still dealing with strings on it's own what is
> the point of these hooks?

The point is that not all filesystems use strings.  NFS is the real in
kernel kicker.  See things like fs/nfs/namespace.c:nfs_do_clone_mount()
where they pass a binary blob into the vfs which arrives to the LSM as a
binary blob which it cannot parse. (note NFS also uses
nfs_parsed_mount_data and nfs_mount_data)

Since the LSM can't (ok, "isn't allowed" according to previous
discussions with vfs/fs people) deal with those binary blobs to get its
options some method must be created for those filesystems to pass that
data in a usable way.
> 
> > An LSM would need to implement these functions only if they had mount
> > time options, such as selinux has context= or fscontext=.  If the LSM
> > has no mount time options they could simply not implement and let the
> > dummy ops take care of things.  
> 
> Smack and SELinux currently deal with options in sb_kern_mount(), with
> help from sb_copy_data(). Why change the implementation?

I don't plan to change anything for any FS that passes text options, but
we aren't allowed to parse binary blobs (nor can we actually even know
for sure what blobs we are dealing with currently in the LSM even if we
were 'allowed' to parse them and get the needed data directly)

> > A LSM other than SELinux would need to define new option numbers in
> > security.h
> 
> I don't think it is a good idea to require that LSM specific
> information be stored outside the scope of the LSM.

Its either that or FS specific knowledge inside the LSM.  See
security/selinux/hooks.c:try_context_mount() for an example of NFS
specific knowledge inside an LSM.  This current implementation has bugs
since we don't know if *data is any of the 3 above named structs.  This
patch doesn't fix those issues, but lays the groundwork for a fix...

> > (or could reuse if they have the same basic meaning I guess)
> > and any FS which decides to own there own security options would need to
> > be patched to use this new interface for every possible LSM.  This is
> > because it was stated to me very clearly that LSM's should not attempt
> > to understand FS mount data and the burdon to understand security should
> > be in the FS which owns the options.
> 
> Perhaps a mount option prefix then. "Smack.root", "SELinux.context",
> that sort of thing. An LSM writer shouldn't have to patch security.h
> every time she wants to add a mount option.

I did originally namespace these things such as SELINUX__CONTEXT_MNT but
later wondered what the point was.  If another LSM decided to somehow
make use of the same infrastructure in FS that have binary mount data
and they used context= they should be able to use a generic CONTEXT_MNT
rather than pretend that flag has some special meaning.  It actually
works nicely for other LSMs since once I get finished with NFS it should
support 3 mount options which although maybe not named nicely for non
SELinux LSMs will be usable without any FS changes...

And while I don't think its a great thing that every LSM is going to be
adding things to the generic security.h if they want things to work,
they are going to have to add things to the generic structures used by
filesystems which use binary mount data.

We have this tight coupling of information.  3 options.

1) make the LSM very FS knowledgeable (what SELinux currently does for
NFS and is maybe not a great idea and has already been strongly pooped
on on list before)
2) make the FS know what LSM is running and what options it is allowed
to send (obviously a terrible unscalable mess if we have to do this for
more than NFS and we still need a get/set type interface)
3) make the interface generic and knowledgeable of everything so there
is little/no cross knowledge.  If the FS happens to send an selinux mnt
opt flag to SMACK (say a user mounts his NFS filesystem with fscontext=^
when running SMACK) then SMACK should return an EINVAL since it does not
implement such a thing.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
