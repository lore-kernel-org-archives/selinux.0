Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w73J1rLJ026992
 for <selinux@tycho.nsa.gov>; Fri, 3 Aug 2018 15:01:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id r13-v6so5725974ljg.10
 for <selinux@tycho.nsa.gov>; Fri, 03 Aug 2018 12:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <E490CD805F7529488761C40FD9D26EF12A72A2C9@dggemm507-mbx.china.huawei.com>
In-Reply-To: <E490CD805F7529488761C40FD9D26EF12A72A2C9@dggemm507-mbx.china.huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 3 Aug 2018 15:01:16 -0400
Message-ID: <CAHC9VhS4nwcErVriwBzvvRQTFLZ=U_p8gA7xQnjs1wBKtmSgxQ@mail.gmail.com>
To: nixiaoming@huawei.com
Cc: viro@zeniv.linux.org.uk, serge@hallyn.com,
 James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, lizefan@huawei.com,
 miaoxie@huawei.com, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: maybe resource leak in security/selinux/selinuxfs.c
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Aug 1, 2018 at 5:39 AM Nixiaoming <nixiaoming@huawei.com> wrote:
>
> advisory:
> 1 After creating dentry in d_alloc_name, should I call dput to release resources before the exception exit?
> 2 After calling the new_inode to create an inode, should the inode resource be released before the exception exit?
>
> If the dentry and inode resources need to be actively released, there are multiple resource leaks in security/selinux/selinuxfs.c.

Hello.  Sorry for the delay in responding, comments inline ...

> Example:
> Linux master branch v4.18-rc5
> The function sel_make_avc_files in security/selinux/selinuxfs.c.
>
> 1566 static int sel_make_avc_files(struct dentry *dir)
> .......
> 1580     for (i = 0; i < ARRAY_SIZE(files); i++) {
> 1581         struct inode *inode;
> 1582         struct dentry *dentry;
> 1583
> 1584         dentry = d_alloc_name(dir, files[i].name);
> 1585         if (!dentry)
> /*Resource leak: when i!=0, the release action of dentry and inode resources is missing*/

I don't understand the leak in this case?  If d_alloc_name() fails on
a partially constructed /sys/fs/selinux/avc directory the previously
allocated dentry/inodes are not lost or leaked, d_alloc_name()
attached them to the parent dentry.

> 1586             return -ENOMEM;
> 1587
> 1588         inode = sel_make_inode(dir->d_sb, S_IFREG|files[i].mode);
> 1589         if (!inode)
> /*Resource leak: missing dput(dentry)*/
> /*Resource leak: when i!=0, the release action of dentry and inode resources is missing*/

Yes, in this case it does look like we are missing a call to dput().
Would you like to submit a patch to fix this as well as the others in
selinuxfs.c?

> 1590             return -ENOMEM;
> 1591
> 1592         inode->i_fop = files[i].ops;
> 1593         inode->i_ino = ++fsi->last_ino;
> 1594         d_add(dentry, inode);
> 1595     }
> 1596
> 1597     return 0;
> 1598 }
>
> There are similar resource leaking functions:
> Sel_make_bools
> Sel_make_avc_files
> Sel_make_initcon_files
> Sel_make_perm_files
> Sel_make_class_dir_entries
> Sel_make_policycap
> Sel_fill_super
> Sel_make_policy_nodes
> Sel_make_classes

-- 
paul moore
www.paul-moore.com
