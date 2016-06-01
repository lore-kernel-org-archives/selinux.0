Subject: Re: [RFC 1/2] selinux: Stop looking up dentries from inodes
To: Andreas Gruenbacher <agruenba@redhat.com>
References: <1464616742-29271-1-git-send-email-agruenba@redhat.com>
 <1464616742-29271-2-git-send-email-agruenba@redhat.com>
 <2748270d-1c74-b5c8-c9f2-85d898c065e1@tycho.nsa.gov>
 <CAHc6FU7z5bo44radMsKcadxqqhEqRpbfGGeUtR+CohJBMUfzKg@mail.gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7e716b38-f59b-eff3-152a-4f005b45abd9@tycho.nsa.gov>
Date: Wed, 1 Jun 2016 09:44:15 -0400
MIME-Version: 1.0
In-Reply-To: <CAHc6FU7z5bo44radMsKcadxqqhEqRpbfGGeUtR+CohJBMUfzKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/31/2016 11:22 AM, Andreas Gruenbacher wrote:
> On Tue, May 31, 2016 at 4:44 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 05/30/2016 09:59 AM, Andreas Gruenbacher wrote:
>>> SELinux sometimes needs to load the security label of an inode without
>>> knowing which dentry belongs to that inode (for example, in the
>>> inode_permission hook).  The security label is stored in an xattr;
>>> getxattr currently requires both the dentry and the inode.
>>>
>>> So far, SELinux has been using d_find_alias to find any dentry for the
>>> inode; there is no guarantee that d_find_alias finds a suitable dentry
>>> on all types of filesystems, though.
>>>
>>> This patch changes SELinux calls getxattr with a NULL dentry when the
>>> dentry is unknown.  On filesystems that require a dentry, getxattr fails
>>> with -ECHILD; on all others, it succeeds.
>>>
>>> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
>>> ---
>>>  fs/9p/acl.c              |  3 +++
>>>  fs/9p/xattr.c            |  3 +++
>>>  fs/cifs/xattr.c          |  9 +++++++--
>>>  fs/ecryptfs/inode.c      |  8 ++++++--
>>>  fs/overlayfs/inode.c     |  6 +++++-
>>>  net/socket.c             |  3 +++
>>>  security/selinux/hooks.c | 43 +++++++++++++++----------------------------
>>>  7 files changed, 42 insertions(+), 33 deletions(-)
>>>
>>
>>> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
>>> index 9d153b6..dd90e5d 100644
>>> --- a/fs/ecryptfs/inode.c
>>> +++ b/fs/ecryptfs/inode.c
>>> @@ -1043,8 +1043,12 @@ static ssize_t
>>>  ecryptfs_getxattr(struct dentry *dentry, struct inode *inode,
>>>                 const char *name, void *value, size_t size)
>>>  {
>>> -     return ecryptfs_getxattr_lower(ecryptfs_dentry_to_lower(dentry),
>>> -                                    ecryptfs_inode_to_lower(inode),
>>> +     struct dentry *lower_dentry;
>>> +     struct inode *lower_inode;
>>> +
>>> +     lower_dentry = dentry ? ecryptfs_dentry_to_lower(dentry) : NULL;
>>> +     lower_inode = ecryptfs_inode_to_lower(inode);
>>> +     return ecryptfs_getxattr_lower(lower_dentry, lower_inode,
>>>                                      name, value, size);
>>
>> ecryptfs_getxattr_lower() doesn't appear to handle a NULL lower_dentry.
> 
> Yes, it just calls the lower-layer filesystem's getxattr inode
> operation with a NULL dentry, as intended.
> 
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index a86d537..dd509c8 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -1387,33 +1387,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>>>       case SECURITY_FS_USE_NATIVE:
>>>               break;
>>>       case SECURITY_FS_USE_XATTR:
>>> -             if (!inode->i_op->getxattr) {
>>> -                     isec->sid = sbsec->def_sid;
>>> -                     break;
>>> -             }
>>
>> I don't think we can remove the above or we'll end up invoking
>> inode->i_op->getxattr == NULL below.
> 
> Indeed, that's a bug, thanks. I've fixed that on my work.selinux branch.
> 
> With that fixed, could you possibly put this change to test?

Falls over during boot in generic_getxattr(), which still needs a
non-NULL dentry in the work.selinux branch.

Is there a reason that this being done separately from work.xattr?

Also, if we aren't going to call d_find_alias() there, we can likely
also drop the dget() and dput().
