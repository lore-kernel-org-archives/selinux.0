MIME-Version: 1.0
In-Reply-To: <AANLkTin16BrQyNYAfbU95=0c3_R9uzPqqiORDz-Nrvu8@mail.gmail.com>
References: <AANLkTinTLamY+tesxS3W7ocnQCmEDCFhGT973jttYk_z@mail.gmail.com>
	<1279909967.8180.43.camel@moss-terrapins.epoch.ncsc.mil>
	<AANLkTiniFb1LjDJQRoc7zOVgD0FVXi=gBaxjusP36RZ3@mail.gmail.com>
	<1279913697.32473.8.camel@moss-pluto.epoch.ncsc.mil>
	<AANLkTi=CwucVcfRWN5Uk5=5HbVZRtuwVC6zW_w=_UEyH@mail.gmail.com>
	<AANLkTimNxi1bOPQU1jrC6H--sCdX4Cm0PuNJZa4hNkwv@mail.gmail.com>
	<4C4D0310.5040703@countercultured.net>
	<AANLkTin16BrQyNYAfbU95=0c3_R9uzPqqiORDz-Nrvu8@mail.gmail.com>
Date: Mon, 26 Jul 2010 13:13:03 -0500
Message-ID: <AANLkTin-e33oxHUVJ2wX92YmQou-pN5MR8kKTG7LMZEM@mail.gmail.com>
Subject: Re: fuse and selinux don't seem to work well together
From: Xavier Toth <txtoth@gmail.com>
To: merlin <merlin@countercultured.net>
Cc: Eric Paris <eparis@parisplace.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>,
        SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jul 26, 2010 at 8:44 AM, Xavier Toth <txtoth@gmail.com> wrote:
> On Sun, Jul 25, 2010 at 10:37 PM, merlin <merlin@countercultured.net> wrote:
>>  On 7/25/2010 6:24 PM, Eric Paris wrote:
>>>
>>> On Sun, Jul 25, 2010 at 11:14 AM, Xavier Toth<txtoth@gmail.com>  wrote:
>>>>
>>>> On Fri, Jul 23, 2010 at 3:34 PM, Stephen Smalley<sds@tycho.nsa.gov>
>>>>  wrote:
>>>>>
>>>>> On Fri, 2010-07-23 at 13:57 -0500, Xavier Toth wrote:
>>>>>>
>>>>>> On Fri, Jul 23, 2010 at 1:32 PM, David P.
>>>>>> Quigley<dpquigl@tycho.nsa.gov>  wrote:
>>>>>>>
>>>>>>> On Fri, 2010-07-23 at 12:14 -0500, Xavier Toth wrote:
>>>>>>>>
>>>>>>>> I'm looking at building a fuse filesystem for polyinstantiated
>>>>>>>> directories which could be used as a alternative to pam_namespace.
>>>>>>>> I've noticed that my filesystem is never queried for the xattr
>>>>>>>> security.selinux and that the file contexts are defaulting to a fuse
>>>>>>>> file type. I've seen some list posting from 2004 related to this
>>>>>>>> subject but not much else. Is this a bug or a feature?
>>>>>>>>
>>>>>>>> Ted
>>>>>>>>
>>>>>>>> --
>>>>>>>> This message was distributed to subscribers of the selinux mailing
>>>>>>>> list.
>>>>>>>> If you no longer wish to subscribe, send mail to
>>>>>>>> majordomo@tycho.nsa.gov with
>>>>>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>>>>
>>>>>>> After a brief conversation with Steve more information has come up
>>>>>>> with
>>>>>>> respect to this. A while back Eric Paris had developed a patch to
>>>>>>> dynamically probe the file system's getxattr handler to determine if
>>>>>>> we
>>>>>>> can use xattr support on the file system for SELinux labels. The major
>>>>>>> stumbling block that Eric ran into was that he was experiencing
>>>>>>> deadlocks when using the code. Apparently there were and still might
>>>>>>> be
>>>>>>> locking issues between the fuse and SELinux code. I'm sure you could
>>>>>>> dig
>>>>>>> up Eric's old patch and try to forward port it to see if those locking
>>>>>>> issues still exist.
>>>>>>>
>>>>>>> Dave
>>>>>>>
>>>>>>>
>>>>>> Thanks I'll try and run down the patch and contact Eric. I'll report
>>>>>> back if I can get this to work.
>>>>>
>>>>> Patch was posted here:
>>>>> http://marc.info/?l=selinux&m=121379719014155&w=2
>>>>>
>>>>> This bug is relevant:
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=493565
>>>>>
>>>>> --
>>>>> Stephen Smalley
>>>>> National Security Agency
>>>>>
>>>>>
>>>> I'm testing on FC13 which has equal to or greater than versions of the
>>>> packages referenced in the bug report.
>>>>
>>>>
>>>> For test purposes I patched my policy with:
>>>>
>>>> fs_use_xattr fuse.bbfs gen_context(system_u:object_r:fs_t,s0);
>>>>
>>>> Mount shows:
>>>> /home/tedx/Downloads/fuse-tutorial/src/bbfs on /home/tedx/test type
>>>> fuse.bbfs (rw,nosuid,nodev,user=tedx)
>>>>
>>>> I'm runnning kernel-debug but I don't see a "SELinux: initialized (dev
>>>> " message for the fuse.bbfs type. Shouldn't the fusermount cause one
>>>> of these messages to be generated?
>>>>
>>>> I do see fuse attempting to access the system.posix_acl_access and
>>>> system.posix_acl_default:
>>>> getxattr /Music system.posix_acl_access 0
>>>>   unique: 174, error: -61 (No data available), outsize: 16
>>>> unique: 175, opcode: GETXATTR (22), nodeid: 36, insize: 73
>>>> getxattr /Music system.posix_acl_default 0
>>>>   unique: 175, error: -61 (No data available), outsize: 16
>>>>
>>>> So fuse seems to be able to deal with xattrs.
>>>>
>>>> I'm pretty new to all of the pieces and could use a little help with
>>>> figuring out where to focus my investigation. Is the fuse mounts
>>>> superblock initializing its security structure properly?
>>>
>>> Fuse can deal with xattrs but only AFTER the fuse userspace program
>>> believes the filesystem is mounted (and if the filesystem can handle
>>> it).  My original patches didn't work, because I was calling getxattr
>>> during the mount(2) syscall.  It gets even worse.  We had a 'bug' in
>>> which the mount(8) program would call stat (or something like that) on
>>> the root inode before it told the fuse userspace program the mount was
>>> finished.  The audit system checked for file capabilities on the stat
>>> call, which resulted in an xattr upcall, which resulted in a deadlock
>>> because the fuse userspace wouldn't answer until the mount finished.
>>> The 'fix' was to stop mount(8) from calling stat on fuse mounts.
>>>
>>> The 'right' solution (I think) is going to be 2 parts.  First we need
>>> to get more information in the superblock mounting.  I seem to recall
>>> that the only information we had was that it was 'fuse.'

After looking at this for awhile it seems to me that fuse_get_sb needs
to call security_sb_set_mnt_opts get its superblock security structure
initialized especially for the case when I used the fs_use_xattrs in
policy.


>>> Not that is
>>> was fuse mounting ntfs.  After that we need to fix the other bug you
>>> pointed out (and other bug I half worked on and you might be able to
>>> find the patch in the archives somewhere)
>>
>> I agree with you on this part. I was talking with Steve about this on Friday
>> and I said it would be a good idea to have fsues statements based on the
>> specific fuse file system type. To do this if you detected a fuse file
>> system type you'd take the device string and chop off everything up until
>> the first # and that would be the specific fuse file system type. Steve said
>
> Can you give me an idea of where this happens?
>
>
>> there were some other issues with locking between the fuse code and the
>> security code so I left it at that and didn't actually look into it further.
>>
>>> You cannot put fsuse in modules for a number of reasons today, but the
>>> last problem i never solved was that of holding the genfs context in a
>>> module.  We don't (as I recall) have a method to represent the MLS
>>> portion of a label in a module.  Once that is done (and I think to do
>>> it you actually have to store it as a string and then fix it up at
>>> link time) you can better handle fuse.  I keep telling myself I'm
>>> going to look at this stuff again, but people stopped harassing me in
>>> bugzilla so I never did.....
>
> Which bugzilla should I harass you on ;)?
>
>>>
>>> -Eric
>>>
>>>
>>> --
>>> This message was distributed to subscribers of the selinux mailing list.
>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>>> with
>>> the words "unsubscribe selinux" without quotes as the message.
>>>
>>
>>
>
> Ted
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
