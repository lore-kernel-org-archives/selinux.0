From: David Caplan <dac@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, dE <de.techno@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: RE: Default context with context mount option.
Date: Tue, 10 Jun 2014 15:41:26 +0000
Message-ID: <1343FC85B4E44A44AF8443678DB560E2A8F059@Exchange10.columbia.tresys.com>
References: <539477AF.20408@gmail.com> <5395B7E9.90304@tycho.nsa.gov>
 <5396BEC4.3000801@gmail.com> <5396F475.9030601@tycho.nsa.gov>
In-Reply-To: <5396F475.9030601@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> -----Original Message-----
> From: Selinux [mailto:selinux-bounces@tycho.nsa.gov] On Behalf Of
> Stephen Smalley
> Sent: Tuesday, June 10, 2014 8:05 AM
> To: dE; selinux@tycho.nsa.gov
> Subject: Re: Default context with context mount option.
> 
> On 06/10/2014 04:16 AM, dE wrote:
> > On 06/09/14 19:04, Stephen Smalley wrote:
> >> On 06/08/2014 10:48 AM, dE wrote:
> >>> When a new file is created on a FS which supports security
> namespace but
> >>> the FS is mounted using context= option, then what will be the
> context
> >>> of the newly created file on the FS?
> >>>
> >>> I did exactly this, and next, umount and then mount the FS readonly
> to
> >>> get the getfattr dump to realize the security namespace is not
> empty
> >>> (this came as a surprise).
> >>>
> >>> So, can someone explain what exactly happens in this case?
> >> The kernel lies to you ;)
> >>
> >> If SELinux (or another security module that implements the
> >> inode_getsecurity and inode_listsecurity hooks) is enabled, then the
> >> security module gets to report its view of the security.* attributes
> to
> >> userspace instead of whatever may or may not be stored by the
> >> filesystem.  That allows SELinux to handle such requests even for
> >> filesystems that do not natively support the security.* namespace as
> >> well as remap attribute values as needed to deal with removed types
> or
> >> conversion from non-MLS to MLS policies or various other situations.
> >
> > Yes, if I mount vfat for e.g. check the xattr using getfattr, there
> does
> > exist a security attribute. But these FSs are defined by genfscon.
> >
> > But about FSs which do support the security namespace (like XFS), and
> so
> > do not have a genfscon statement associated to them they but still
> have
> > a security namespace value (as reported by the kernel, which lies to
> > userspace).
> >
> > Question is -- are these values actually written to the FS or are
> they
> > just empty? Things get more confusing cause I get permission denied
> when
> > trying to delete the security namespace values.
> 
> It shouldn't be written to the filesystem.  You can check by booting
> with SELinux disabled (selinux=0 on the kernel command-line or
> /etc/selinux/config SELINUX=disabled) and then running getfattr; then
> the kernel will just call down to the filesystem code to fetch the
> attribute without any interference by the security module.  However,
> note that this will trigger an automatic filesystem relabel upon reboot
> into SELinux to ensure that all files are labeled, which can take some
> time.
> 
> With regard to removing the security.selinux attributes, SELinux also
> prohibits that entirely; see
> security/selinux/hooks.c:selinux_inode_removexattr() in the kernel.  So
> again, to do that, you'd have to boot with SELinux disabled, but it
> shouldn't be necessary.
> 

How about creating a file based filesystem image and mounting it with a loop device? You can mount it with context mount options or straight up and easily see changes (or no changes) to the filesystem. That way you don't have to disable selinux and reboot the whole system. You can easily experiment with whichever filesystem types you'd like. 

David
