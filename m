Subject: Re: overlayfs+selinux error: OPNOTSUPP
To: Matthew Cengia <mattcen@cyber.com.au>
References: <20150921022517.GH22582@cyber.com.au>
 <56006BBA.4070602@tycho.nsa.gov> <56006CC7.2070605@tycho.nsa.gov>
 <20150922012425.GO22582@cyber.com.au>
Cc: selinux@tycho.nsa.gov, russell@coker.com.au
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5601596F.4010502@tycho.nsa.gov>
Date: Tue, 22 Sep 2015 09:36:47 -0400
MIME-Version: 1.0
In-Reply-To: <20150922012425.GO22582@cyber.com.au>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/21/2015 09:24 PM, Matthew Cengia wrote:
> On 2015-09-21 16:47, Stephen Smalley wrote:
> [...]
>>>> This problem *ONLY* occurs in the initrd,
>>>> which is *BEFORE* the SELinux policy loads.
>>>> I'm not sure if this is relevant.
>>>
>>> Yes, I believe it is.  Most likely culprit is:
>>> security/selinux/hooks.c:
>>>    2890 static int selinux_inode_setxattr(struct dentry *dentry, const
>>> char *name,
>>>    2891                                   const void *value, size_t
>>> size, int flags)
>>>    2892 {
>>>    2893         struct inode *inode = dentry->d_inode;
>>>    2894         struct inode_security_struct *isec = inode->i_security;
>>>    2895         struct superblock_security_struct *sbsec;
>>>    2896         struct common_audit_data ad;
>>>    2897         u32 newsid, sid = current_sid();
>>>    2898         int rc = 0;
>>>    2899
>>>    2900         if (strcmp(name, XATTR_NAME_SELINUX))
>>>    2901                 return selinux_inode_setotherxattr(dentry, name);
>>>    2902
>>>    2903         sbsec = inode->i_sb->s_security;
>>>    2904         if (!(sbsec->flags & SBLABEL_MNT))
>>>    2905                 return -EOPNOTSUPP;
>>>                                ^^^^^^^^^^^^
>>> That's to prevent setting SELinux attributes on a filesystem that does
>>> not support labeling due to use of a context= mount or policy genfscon
>>> rules to override any xattrs on the filesystem.  Maybe that should be
>>> exempted if no policy is loaded (!ss_initialized).
>>>
>>> At this point, I have to ask:  which is easier, patching systemd to do
>>> what you want, loading policy earlier (in general, the earlier you load
>>> SELinux policy, the better), or patching the kernel.
>>
>> BTW, IIUC, the reason that this manifests on an open(2) call is that
>> overlayfs is trying to copy-up any xattrs from the lower filesystem to
>> the upper filesystem when you touch the file, which triggers a
>> vfs_getxattr on the lower filesystem and then a vfs_setxattr on the
>> upper filesystem, and then we fail here.  Not something we would see on
>> open(2) otherwise.
> 
> Thanks for your response Stephen!
> 
> Let me confirm I understand correctly. The problem doesn't occur when I
> write a file to the root of the overlay mountpoint. Are you saying this
> is because I'm not attempting to copy/set ant SELinux attributes on this
> file, but when I write something to /etc or /home, copy-up attempts and
> fails to write the SELinux attribute xattr?

That's my theory, yes.

> As for possible solutions: I'm not sure I want to contemplate patching
> systemd, so I'll leave that as a last resort.

I will caveat that working through all the potential issues of SELinux +
overlayfs + squashfs (and I am not sure how well or if it actually does
work with that combination) and getting a functional policy that works
for your setup and actually enforces the equivalent to noexec for your
XDG_RUNTIME_DIR might be a lot more work than just patching systemd to
add the noexec mount option if that is really all you wanted.  Not
trying to dissuade you, but just want you to be aware of the potential
work factor.

> I'm happy to investigate loading the policy earlier; I'll need to talk
> to some Debian SELinux people to understand better how the policy gets
> loaded so I can duplicate that functionality into the initrd; I'm still
> getting my head around SELinux.

To do that, you'd have to copy the policy files (i.e. entire
/etc/selinux tree) into the initrd itself.  I think systemd will then
load them automatically if you are using systemd as the initrd's init,
or if not, you can always add a direct call to load_policy -i to your
/linuxrc or equivalent.

> Your final suggestion was a kernel change (!ss_initialized). Are you
> suggesting this is something you'd consider changing in mainline, or
> something I might want to patch for my specific instance?

I'd be open to the former, although I can't say that I have fully
considered all the implications.

> I want to
> avoid the latter, but if you think the former may be sensible, that'd be
> cool. Would that mean, however, that SELinux attributes may not be set
> correctly and that the files create wouldn't be accessible by everything
> that needs them after the policy has loaded?

Potentially, yes.  That's why it is better to load policy as early as
possible.  On the other hand, if the files are only ever used prior to
the switch root (and thus prior to the normal policy load from the real
root), then it might not matter.
