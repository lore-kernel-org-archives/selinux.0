Subject: Re: kernel access to device comm is kdevtmpfs
To: "Roberts, William C" <william.c.roberts@intel.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
References: <476DC76E7D1DF2438D32BFADF679FC56010597CC@ORSMSX103.amr.corp.intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
 SELinux <selinux@tycho.nsa.gov>
Message-ID: <55DDC373.8030509@tycho.nsa.gov>
Date: Wed, 26 Aug 2015 09:47:31 -0400
MIME-Version: 1.0
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC56010597CC@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/26/2015 12:33 AM, Roberts, William C wrote:
> I get these records with comm set to kdevtempfs. The targert context is
> device, however when interrogating the node from userspace, I notice 2
> things:
> 
>  
> 
> 1.       The inode doesn’t match
> 
> 2.       The label is correct per file_contexts
> 
>  
> 
> root@device:/dev # ls -laiZ media0                                      
> 
>    10000 crw-rw---- system   camera           
> u:object_r:camera_device:s0 media0
> 
> root@device:/dev # ls -laiZ ttyS1                                      
> 
>     1217 crw-rw---- bluetooth bluetooth         
> u:object_r:hci_attach_dev:s0 ttyS1
> 
>  
> 
> [    4.421817] audit: type=1400 audit(1263534127.178:4): avc:  denied  {
> write } for  pid=24 comm="kdevtmpfs" name="/" dev="devtmpfs" ino=1025
> scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=dir permissive=1
> 
> [    4.421859] audit: type=1400 audit(1263534127.178:5): avc:  denied  {
> add_name } for  pid=24 comm="kdevtmpfs" name="dm-0"
> scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=dir permissive=1
> 
> [    5.745165] type=1400 audit(1263534128.499:23): avc: denied { getattr
> } for pid=24 comm="kdevtmpfs" path="/ttyS1" dev="devtmpfs" ino=1051
> scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=chr_file
> permissive=1
> 
> [    5.746180] type=1400 audit(1263534128.499:24): avc: denied { setattr
> } for pid=24 comm="kdevtmpfs" name="ttyS1" dev="devtmpfs" ino=1051
> scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=chr_file
> permissive=1
> 
> [    5.746384] type=1400 audit(1263534128.499:25): avc: denied {
> remove_name } for pid=24 comm="kdevtmpfs" name="ttyS1" dev="devtmpfs"
> ino=1051 scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=dir
> permissive=1
> 
> [    5.746742] type=1400 audit(1263534128.499:26): avc: denied { unlink
> } for pid=24 comm="kdevtmpfs" name="ttyS1" dev="devtmpfs" ino=1051
> scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=chr_file
> permissive=1
> 
> [    5.746966] type=1400 audit(1263534128.500:27): avc: denied { create
> } for pid=24 comm="kdevtmpfs" name="ttyS1" scontext=u:r:kernel:s0
> tcontext=u:object_r:device:s0 tclass=chr_file permissive=1
> 
> [    7.605775] type=1400 audit(1263534130.358:35): avc: denied { write }
> for pid=24 comm="kdevtmpfs" name="/" dev="devtmpfs" ino=1025
> scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=dir permissive=1
> 
> [    7.606116] type=1400 audit(1263534130.358:36): avc: denied {
> add_name } for pid=24 comm="kdevtmpfs" name="media0"
> scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=dir permissive=1
> 
> [    7.606350] type=1400 audit(1263534130.358:37): avc: denied { create
> } for pid=24 comm="kdevtmpfs" name="media0" scontext=u:r:kernel:s0
> tcontext=u:object_r:device:s0 tclass=chr_file permissive=1
> 
> [    7.606582] type=1400 audit(1263534130.358:38): avc: denied { setattr
> } for pid=24 comm="kdevtmpfs" name="media0" dev="devtmpfs" ino=9999
> scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=chr_file
> permissive=1
> 
> [   10.152747] type=1400 audit(1263534132.902:52): avc: denied { write }
> for pid=24 comm="kdevtmpfs" name="/" dev="devtmpfs" ino=1025
> scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=dir permissive=1
> 
> [   10.153026] type=1400 audit(1263534132.902:53): avc: denied {
> add_name } for pid=24 comm="kdevtmpfs" name="dm-1"
> scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=dir permissive=1
> 
> [    4.421817] audit: type=1400 audit(1263534127.178:4): avc:  denied  {
> write } for  pid=24 comm="kdevtmpfs" name="/" dev="devtmpfs" ino=1025
> scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=dir permissive=1
> 
> [    4.421859] audit: type=1400 audit(1263534127.178:5): avc:  denied  {
> add_name } for  pid=24 comm="kdevtmpfs" name="dm-0"
> scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=dir permissive=1
> 
> [    5.745165] type=1400 audit(1263534128.499:23): avc: denied { getattr
> } for pid=24 comm="kdevtmpfs" path="/ttyS1" dev="devtmpfs" ino=1051
> scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=chr_file
> permissive=1
> 
> [    5.746180] type=1400 audit(1263534128.499:24): avc: denied { setattr
> } for pid=24 comm="kdevtmpfs" name="ttyS1" dev="devtmpfs" ino=1051
> scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=chr_file
> permissive=1
> 
> [    5.746384] type=1400 audit(1263534128.499:25): avc: denied {
> remove_name } for pid=24 comm="kdevtmpfs" name="ttyS1" dev="devtmpfs"
> ino=1051 scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=dir
> permissive=1
> 
> [    5.746742] type=1400 audit(1263534128.499:26): avc: denied { unlink
> } for pid=24 comm="kdevtmpfs" name="ttyS1" dev="devtmpfs" ino=1051
> scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=chr_file
> permissive=1
> 
> [    5.746966] type=1400 audit(1263534128.500:27): avc: denied { create
> } for pid=24 comm="kdevtmpfs" name="ttyS1" scontext=u:r:kernel:s0
> tcontext=u:object_r:device:s0 tclass=chr_file permissive=1
> 
> [    7.605775] type=1400 audit(1263534130.358:35): avc: denied { write }
> for pid=24 comm="kdevtmpfs" name="/" dev="devtmpfs" ino=1025
> scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=dir permissive=1
> 
> [    7.606116] type=1400 audit(1263534130.358:36): avc: denied {
> add_name } for pid=24 comm="kdevtmpfs" name="media0"
> scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=dir permissive=1
> 
> [    7.606350] type=1400 audit(1263534130.358:37): avc: denied { create
> } for pid=24 comm="kdevtmpfs" name="media0" scontext=u:r:kernel:s0
> tcontext=u:object_r:device:s0 tclass=chr_file permissive=1
> 
> [    7.606582] type=1400 audit(1263534130.358:38): avc: denied { setattr
> } for pid=24 comm="kdevtmpfs" name="media0" dev="devtmpfs" ino=9999
> scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=chr_file
> permissive=1
> 
> [   10.152747] type=1400 audit(1263534132.902:52): avc: denied { write }
> for pid=24 comm="kdevtmpfs" name="/" dev="devtmpfs" ino=1025
> scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=dir permissive=1
> 
> [   10.153026] type=1400 audit(1263534132.902:53): avc: denied {
> add_name } for pid=24 comm="kdevtmpfs" name="dm-1"
> scontext=u:r:kernel:s0 tcontext=u:object_r:device:s0 tclass=dir permissive=1
> 
>  
> 
> Ive never really ran into these before, can someone perhaps enlighten me
> as to what’s going on here?

This implies you have CONFIG_DEVTMPFS=y in your kernel config (and maybe
CONFIG_DEVTMPFS_MOUNT=y?). That hasn't been present in Android kernels
to date AFAIK, so current Android SELinux policy doesn't support it.
What do you actually have mounted on /dev - devtmpfs or regular tmpfs
(look at /proc/self/mounts)?

With devtmpfs, the kernel itself automatically populates and maintains a
device node tree.  The claim is that this provides you with a working
/dev tree before udev comes up, and that you can even dispense with
running udev entirely on simple systems (e.g. embedded).  However, it
seems like everyone continues to run udev on top of devtmpfs in Linux
distributions.

The problem of course is that the kernel has no clue how to label the
device nodes, so it is still necessary to have udev or ueventd handle
that.  And with the kernel creation of the device nodes, we then have a
race condition where the device node briefly exists in the wrong, most
likely inaccessible label.

Fedora has tried to work around this by defining name-based type
transitions for the kernel domain on /dev to label the device nodes
correctly on creation.  However, name-based type transitions aren't well
suited to that purpose; they only support exact match (no prefix, glob,
or regex matching), they only match the last component, and they were
only intended to cover exceptional cases where regular type transitions
weren't sufficiently granular and one couldn't modify the creating
program to explicitly label the file based on file_contexts (so they
aren't designed to scale well).  Maybe we could use genfs_contexts
instead (i.e. add devtmpfs to the list of filesystems that have
SE_SBGENFS set in sbsec->flags, then you can specify path prefixes
relative to the root of devtmpfs and label them that way).

But first you ought to decide whether you truly want devtmpfs at all,
and whether you are actually using it, or just overlaying it with a
regular tmpfs mount in userspace.
