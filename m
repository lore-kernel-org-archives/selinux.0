From: ebiederm@xmission.com (Eric W. Biederman)
To: Casey Schaufler <casey@schaufler-ca.com>
References: <55A8398A.3000802@schaufler-ca.com>
 <CALCETrXA94MBrJ7Dni7RW68Wn3MxcxSmr082hG=haWWncL=feg@mail.gmail.com>
 <55A85041.2070301@schaufler-ca.com>
 <CALCETrUTgfRzzdk3T0wZASSE+KC9S+kmyZbD6-xStS2RRaGiBw@mail.gmail.com>
 <20150721203550.GA80838@ubuntu-hedt>
 <55AEF75F.9010703@schaufler-ca.com>
 <20150722155634.GB124342@ubuntu-hedt>
 <55AFDCA6.10201@schaufler-ca.com>
 <20150722193223.GD124342@ubuntu-hedt>
 <55B02FBD.4040606@schaufler-ca.com>
 <20150728204009.GF83521@ubuntu-hedt> <55BA4E48.50109@schaufler-ca.com>
Date: Thu, 30 Jul 2015 12:05:27 -0500
In-Reply-To: <55BA4E48.50109@schaufler-ca.com> (Casey Schaufler's message of
 "Thu, 30 Jul 2015 09:18:16 -0700")
Message-ID: <878u9xlgo8.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 Seth Forshee <seth.forshee@canonical.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, SELinux-NSA <selinux@tycho.nsa.gov>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Casey Schaufler <casey@schaufler-ca.com> writes:

> On 7/28/2015 1:40 PM, Seth Forshee wrote:
>> On Wed, Jul 22, 2015 at 05:05:17PM -0700, Casey Schaufler wrote:
>>>> This is what I currently think you want for user ns mounts:
>>>>
>>>>  1. smk_root and smk_default are assigned the label of the backing
>>>>     device.
>>>>  2. s_root is assigned the transmute property.
>>>>  3. For existing files:
>>>>     a. Files with the same label as the backing device are accessible.
>>>>     b. Files with any other label are not accessible.
>>> That's right. Accept correct data, reject anything that's not right.
>>>
>>>> If this is right, there are a couple lingering questions in my mind.
>>>>
>>>> First, what happens with files created in directories with the same
>>>> label as the backing device but without the transmute property set? The
>>>> inode for the new file will initially be labeled with smk_of_current(),
>>>> but then during d_instantiate it will get smk_default and thus end up
>>>> with the label we want. So that seems okay.
>>> Yes.
>>>
>>>> The second is whether files with the SMACK64EXEC attribute is still a
>>>> problem. It seems it is, for files with the same label as the backing
>>>> store at least. I think we can simply skip the code that reads out this
>>>> xattr and sets smk_task for user ns mounts, or else skip assigning the
>>>> label to the new task in bprm_set_creds. The latter seems more
>>>> consistent with the approach you've suggested for dealing with labels
>>>> from disk.
>>> Yes, I think that skipping the smk_fetch(XATTR_NAME_SMACKEXEC, ...) in
>>> smack_d_instantiate for unprivileged mounts would do the trick.
>>>
>>>> So I guess all of that seems okay, though perhaps a bit restrictive
>>>> given that the user who mounted the filesystem already has full access
>>>> to the backing store.
>>> In truth, there is no reason to expect that the "user" who did the
>>> mount will ever have a Smack label that differs from the label of
>>> the backing store. If what we've got here seems restrictive, it's
>>> because you've got access from someone other than the "user".
>>>
>>>> Please let me know whether or not this matches up with what you are
>>>> thinking, then I can procede with the implementation.
>>> My current mindset is that, if you're going to allow unprivileged
>>> mounts of user defined backing stores, this is as safe as we can
>>> make it.
>> All right, I've got a patch which I think does this, and I've managed to
>> do some testing to confirm that it behaves like I expect. How does this
>> look?
>>
>> What's missing is getting the label from the block device inode; as
>> Stephen discovered the inode that I thought we could get the label from
>> turned out to be the wrong one. Afaict we would need a new hook in order
>> to do that, so for now I'm using the label of the proccess calling
>> mount.
>
> That will be OK if the mount processing checks for write access to
> the backing store. I haven't looked to see if it does. If it doesn't
> the problems should be pretty obvious.


do_new_mount
  vfs_kern_mount
    mount_fs
      ...
        mount_bdev
          blkdev_get_by_path(...,FMODE_READ| FMODE_WRITE | FMODE_EXCL,...)
            lookup_bdev
              kern_path
                filename_lookup
                  path_lookupat
                    lookup_last
                      walk_component
            blkdev_get(...,mode,...)
              __blkdev_get(...,mode,...)
                devcgroup_inode_permission(bdev->bd_inode, perm)

*scratches my head*

It looks like we don't actually check the permissions on the block
device.  Tomoyo has a hack for it.  nfsd does something.  There is
devcgroup silliness.

But overall it looks like we depend on capable(CAP_SYS_ADMIN).

Seth I do believe we have found another area of the vfs we will need to
short up before allowing unprivileged mounts of block device based
filesystems.

It looks like there are enough hacks someone with a clue coming through
and making the code make more sense seems like a good idea anyway.

Eric
