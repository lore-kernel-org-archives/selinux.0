Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA9GQBtJ013124
 for <selinux@tycho.nsa.gov>; Wed, 9 Nov 2016 11:26:12 -0500
Received: by mail-qk0-f199.google.com with SMTP id k201so159301412qke.6
 for <selinux@tycho.nsa.gov>; Wed, 09 Nov 2016 08:25:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQXrybHPt41-f-hcXZJ=i=N5qexdoM2VFLTxFfmuq8Yzg@mail.gmail.com>
References: <1478551587-33892-1-git-send-email-david.graziano@rockwellcollins.com>
 <CAHC9VhQXrybHPt41-f-hcXZJ=i=N5qexdoM2VFLTxFfmuq8Yzg@mail.gmail.com>
From: David Graziano <david.graziano@rockwellcollins.com>
Date: Wed, 9 Nov 2016 10:25:28 -0600
Message-ID: <CA+RmS--i8PiHmt1foeVEYP+uGDxhGLaROzxLvU=GNXW76fDy5A@mail.gmail.com>
Subject: Re: [PATCH 1/1 V2] mqueue: Implment generic xattr support
To: Paul Moore <paul@paul-moore.com>
Cc: golbi@mat.uni.torun.pl, michal.wronski@gmail.com,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 Stephen Smalley <sds@tycho.nsa.gov>, seth.forshee@canonical.com,
 ebiederm@xmission.com, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Nov 7, 2016 at 4:23 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Nov 7, 2016 at 3:46 PM, David Graziano
> <david.graziano@rockwellcollins.com> wrote:
>> This patch adds support for generic extended attributes within the
>> POSIX message queues filesystem and setting them by consulting the LSM.
>> This is needed so that the security.selinux extended attribute can be
>> set via a SELinux named type transition on file inodes created within
>> the filesystem. The implementation and LSM call back function are based
>> off tmpfs/shmem.
>>
>> Signed-off-by: David Graziano <david.graziano@rockwellcollins.com>
>> ---
>>  ipc/mqueue.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>
> Hi David,
>
> At first glance this looks reasonable to me, I just have a two
> questions/comments:
>
> * Can you explain your current need for this functionality?  For
> example, what are you trying to do that is made easier by allowing
> greater message queue labeling flexibility?  This helps put things in
> context and helps people review and comment on your patch.
>
> * How have you tested this?  While this patch is not SELinux specific,
> I think adding a test to the selinux-testsuite[1] would be worthwhile.
> The other LSM maintainers may suggest something similar if they have
> an established public testsuite.
>
> [1] https://github.com/SELinuxProject/selinux-testsuite

Hi Paul,

I needed to write a selinux policy for a set of custom applications that use
POSIX message queues for their IPC. The queues are created by one
application and we needed a way for selinux to enforce which of the other
apps are able to read/write to each individual queue. Uniquely labeling them
based on the app that created them and the file name seemed to be our best
solution since it’s an embedded system and we don’t have restorecond to
handle any relabeling.


To test this patch I used both a selinux enabled, buildroot based qemu target
with a customized selinux policy and test C app to create the mqueues. I also
tested with our real apps and selinux policy on our target hardware. I can
certainly look at adding a test to the selinux-testsuite if that would
be helpful.

Thanks,
David

>
>> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
>> index 0b13ace..512a546 100644
>> --- a/ipc/mqueue.c
>> +++ b/ipc/mqueue.c
>> @@ -35,6 +35,7 @@
>>  #include <linux/ipc_namespace.h>
>>  #include <linux/user_namespace.h>
>>  #include <linux/slab.h>
>> +#include <linux/xattr.h>
>>
>>  #include <net/sock.h>
>>  #include "util.h"
>> @@ -70,6 +71,7 @@ struct mqueue_inode_info {
>>         struct rb_root msg_tree;
>>         struct posix_msg_tree_node *node_cache;
>>         struct mq_attr attr;
>> +       struct simple_xattrs xattrs;    /* list of xattrs */
>>
>>         struct sigevent notify;
>>         struct pid *notify_owner;
>> @@ -254,6 +256,7 @@ static struct inode *mqueue_get_inode(struct super_block *sb,
>>                         info->attr.mq_maxmsg = attr->mq_maxmsg;
>>                         info->attr.mq_msgsize = attr->mq_msgsize;
>>                 }
>> +               simple_xattrs_init(&info->xattrs);
>>                 /*
>>                  * We used to allocate a static array of pointers and account
>>                  * the size of that array as well as one msg_msg struct per
>> @@ -413,6 +416,41 @@ static void mqueue_evict_inode(struct inode *inode)
>>                 put_ipc_ns(ipc_ns);
>>  }
>>
>> +/*
>> + * Callback for security_inode_init_security() for acquiring xattrs.
>> + */
>> +static int mqueue_initxattrs(struct inode *inode,
>> +                           const struct xattr *xattr_array,
>> +                           void *fs_info)
>> +{
>> +       struct mqueue_inode_info *info = MQUEUE_I(inode);
>> +       const struct xattr *xattr;
>> +       struct simple_xattr *new_xattr;
>> +       size_t len;
>> +
>> +       for (xattr = xattr_array; xattr->name != NULL; xattr++) {
>> +               new_xattr = simple_xattr_alloc(xattr->value, xattr->value_len);
>> +               if (!new_xattr)
>> +                       return -ENOMEM;
>> +               len = strlen(xattr->name) + 1;
>> +               new_xattr->name = kmalloc(XATTR_SECURITY_PREFIX_LEN + len,
>> +                                         GFP_KERNEL);
>> +               if (!new_xattr->name) {
>> +                       kfree(new_xattr);
>> +                       return -ENOMEM;
>> +               }
>> +
>> +               memcpy(new_xattr->name, XATTR_SECURITY_PREFIX,
>> +                      XATTR_SECURITY_PREFIX_LEN);
>> +               memcpy(new_xattr->name + XATTR_SECURITY_PREFIX_LEN,
>> +                      xattr->name, len);
>> +
>> +               simple_xattr_list_add(&info->xattrs, new_xattr);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  static int mqueue_create(struct inode *dir, struct dentry *dentry,
>>                                 umode_t mode, bool excl)
>>  {
>> @@ -443,6 +481,14 @@ static int mqueue_create(struct inode *dir, struct dentry *dentry,
>>                 ipc_ns->mq_queues_count--;
>>                 goto out_unlock;
>>         }
>> +       error = security_inode_init_security(inode, dir,
>> +                                            &dentry->d_name,
>> +                                            mqueue_initxattrs, NULL);
>> +       if (error && error != -EOPNOTSUPP) {
>> +               spin_lock(&mq_lock);
>> +               ipc_ns->mq_queues_count--;
>> +               goto out_unlock;
>> +       }
>>
>>         put_ipc_ns(ipc_ns);
>>         dir->i_size += DIRENT_SIZE;
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> paul moore
> www.paul-moore.com
