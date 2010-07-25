MIME-Version: 1.0
In-Reply-To: <1279913697.32473.8.camel@moss-pluto.epoch.ncsc.mil>
References: <AANLkTinTLamY+tesxS3W7ocnQCmEDCFhGT973jttYk_z@mail.gmail.com>
	<1279909967.8180.43.camel@moss-terrapins.epoch.ncsc.mil>
	<AANLkTiniFb1LjDJQRoc7zOVgD0FVXi=gBaxjusP36RZ3@mail.gmail.com>
	<1279913697.32473.8.camel@moss-pluto.epoch.ncsc.mil>
Date: Sun, 25 Jul 2010 11:14:14 -0400
Message-ID: <AANLkTi=CwucVcfRWN5Uk5=5HbVZRtuwVC6zW_w=_UEyH@mail.gmail.com>
Subject: Re: fuse and selinux don't seem to work well together
From: Xavier Toth <txtoth@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>,
        SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jul 23, 2010 at 3:34 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Fri, 2010-07-23 at 13:57 -0500, Xavier Toth wrote:
>> On Fri, Jul 23, 2010 at 1:32 PM, David P. Quigley <dpquigl@tycho.nsa.gov> wrote:
>> > On Fri, 2010-07-23 at 12:14 -0500, Xavier Toth wrote:
>> >> I'm looking at building a fuse filesystem for polyinstantiated
>> >> directories which could be used as a alternative to pam_namespace.
>> >> I've noticed that my filesystem is never queried for the xattr
>> >> security.selinux and that the file contexts are defaulting to a fuse
>> >> file type. I've seen some list posting from 2004 related to this
>> >> subject but not much else. Is this a bug or a feature?
>> >>
>> >> Ted
>> >>
>> >> --
>> >> This message was distributed to subscribers of the selinux mailing list.
>> >> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> >> the words "unsubscribe selinux" without quotes as the message.
>> >
>> > After a brief conversation with Steve more information has come up with
>> > respect to this. A while back Eric Paris had developed a patch to
>> > dynamically probe the file system's getxattr handler to determine if we
>> > can use xattr support on the file system for SELinux labels. The major
>> > stumbling block that Eric ran into was that he was experiencing
>> > deadlocks when using the code. Apparently there were and still might be
>> > locking issues between the fuse and SELinux code. I'm sure you could dig
>> > up Eric's old patch and try to forward port it to see if those locking
>> > issues still exist.
>> >
>> > Dave
>> >
>> >
>>
>> Thanks I'll try and run down the patch and contact Eric. I'll report
>> back if I can get this to work.
>
> Patch was posted here:
> http://marc.info/?l=selinux&m=121379719014155&w=2
>
> This bug is relevant:
> https://bugzilla.redhat.com/show_bug.cgi?id=493565
>
> --
> Stephen Smalley
> National Security Agency
>
>

I'm testing on FC13 which has equal to or greater than versions of the
packages referenced in the bug report.


For test purposes I patched my policy with:

fs_use_xattr fuse.bbfs gen_context(system_u:object_r:fs_t,s0);

Mount shows:
/home/tedx/Downloads/fuse-tutorial/src/bbfs on /home/tedx/test type
fuse.bbfs (rw,nosuid,nodev,user=tedx)

I'm runnning kernel-debug but I don't see a "SELinux: initialized (dev
" message for the fuse.bbfs type. Shouldn't the fusermount cause one
of these messages to be generated?

I do see fuse attempting to access the system.posix_acl_access and
system.posix_acl_default:
getxattr /Music system.posix_acl_access 0
   unique: 174, error: -61 (No data available), outsize: 16
unique: 175, opcode: GETXATTR (22), nodeid: 36, insize: 73
getxattr /Music system.posix_acl_default 0
   unique: 175, error: -61 (No data available), outsize: 16

So fuse seems to be able to deal with xattrs.

I'm pretty new to all of the pieces and could use a little help with
figuring out where to focus my investigation. Is the fuse mounts
superblock initializing its security structure properly?

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
