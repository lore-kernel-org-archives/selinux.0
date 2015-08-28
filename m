Date: Fri, 28 Aug 2015 16:27:12 +0200
From: Dominick Grift <dac.override@gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, seandroid-list@tycho.nsa.gov,
 Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: kernel access to device comm is kdevtmpfs
Message-ID: <20150828142711.GA23231@x250>
References: <476DC76E7D1DF2438D32BFADF679FC56010597CC@ORSMSX103.amr.corp.intel.com>
 <55DDC373.8030509@tycho.nsa.gov> <20150826140659.GA26572@x250>
 <55E0605F.7070002@tycho.nsa.gov>
 <CAFftDdrOtmcesn7SWzrg+XUqHLhsTqO+-UoN=HxS6nSfLdn7Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <CAFftDdrOtmcesn7SWzrg+XUqHLhsTqO+-UoN=HxS6nSfLdn7Qw@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, Aug 28, 2015 at 07:11:21AM -0700, William Roberts wrote:
> The best solution is to remove it if not needed. Android supports a full
> udev userspace (full enough). So removing this is the direction I'm headed.
> On Aug 28, 2015 6:24 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:

Sure, but this thread mixes up two topics.

1. to use devtmpfs or not to use devtmpfs
2. support genfscon style labeling for devtmpfs

I was focussing on the second question, and i saw no reason not to
support genfscon style labeling for devtmpfs, as it would have just
provided more flexibility and it wouldnt force anyone into anything.

Not that it matters now though. Since it turns out to not be so
straightforward to add this functionality

> 
> > On 08/26/2015 10:07 AM, Dominick Grift wrote:
> > > On Wed, Aug 26, 2015 at 09:47:31AM -0400, Stephen Smalley wrote:
> > >
> > > <snip>
> > >
> > >
> > >> Fedora has tried to work around this by defining name-based type
> > >> transitions for the kernel domain on /dev to label the device nodes
> > >> correctly on creation.  However, name-based type transitions aren't well
> > >> suited to that purpose; they only support exact match (no prefix, glob,
> > >> or regex matching), they only match the last component, and they were
> > >> only intended to cover exceptional cases where regular type transitions
> > >> weren't sufficiently granular and one couldn't modify the creating
> > >> program to explicitly label the file based on file_contexts (so they
> > >> aren't designed to scale well).  Maybe we could use genfs_contexts
> > >> instead (i.e. add devtmpfs to the list of filesystems that have
> > >> SE_SBGENFS set in sbsec->flags, then you can specify path prefixes
> > >> relative to the root of devtmpfs and label them that way).
> > >
> > > This sounds like a good idea to me.
> >
> > Unfortunately, I was wrong.  Merely setting SE_SBGENFS in sbsec->flags
> > for devtmpfs filesystems does NOT enable genfs_context-based labeling of
> > devtmpfs files, because devtmpfs is tmpfs-backed, and tmpfs, like ext4,
> > calls security_inode_init_security() upon new inode creation to
> > explicitly initialize the in-core inode security state and to obtain the
> > xattr name/value pair.  That's why type transitions work for devtmpfs
> > (and tmpfs).  Filesystems that use genfscon-based labeling (e.g. proc,
> > sysfs, debugfs, pstore) do not support userspace file creation and
> > therefore do not call that hook and their inode security state is
> > initialized upon security_d_instantiate(), at which point we have a
> > dentry and can therefore generate a path relative to the root.
> > So we can't do this as a one-liner patch; it would be more involved.
> > devtmpfs/tmpfs does ultimately call d_instantiate() ->
> > security_d_instantiate(), but at that point the inode security state is
> > already initialized in the usual way and we therefore don't do anything
> > further with it.  We would need to rework the way inode security
> > initialization works, and do it in a way that avoids weird side effects
> > (e.g. if the policy defines a type transition, as in current Fedora
> > policy, we don't want to override that with a genfscon-based lookup).
> > _______________________________________________
> > Seandroid-list mailing list
> > Seandroid-list@tycho.nsa.gov
> > To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> > Seandroid-list-request@tycho.nsa.gov.
> >

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=vindex&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV4G+7AAoJENAR6kfG5xmc2ZsMAKJ4QmUjoFpDlvvTHe56OzLq
wFNdebybP7q7D6/5brKuZjLhbrZYXPi+UgJzjy4w8K0T9qaMe0LWX6yHp8hNFwwb
w0NcJJttJxMtLeH/K5KzDRFHE8qiJwQkhCrcoTecFm/9/Ho08Z1G5v0MjSbrdqKg
pVkx2ZmzdN2WI6GH+lb7xTXfBUipylqMq7jLDyXPXxBAcjLhVsY+zS+vEcMzCUwr
eyb6pc2KIEa1jH98gplEToHU24P1SdeJf+AkJZM0pTexb3t/010SQHc2w67um8tA
+t5vEMp8jQxGIp56YmKqvGFAJChwRskYm/+5ghDcXZmMaSfrYIe1bHUFWbYLxJCV
sagT45FZBiVYPp/CE0OR8LAciIRnhTe8pb0Nek0US88OPY61n7rxnvpKzn+y2k2i
r9P6z9O8MygoOxARCDaIaEIPwCe1qbuWShH6vErN45EgL2shE55Jge11TD9U/APM
aBuEC6J6LJDNIMWfVcVKxM54/UhZCcbQcUOuyEKzbA==
=sL/v
-----END PGP SIGNATURE-----
