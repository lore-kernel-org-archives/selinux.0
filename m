Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2GLZ5pj002394
 for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2018 17:35:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC14.oob.disa.mil (Postfix) with SMTP id 402zJP5wW6zJ4B5
 for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2018 21:35:01 +0000 (UTC)
Received: from UPBD19PA05.eemsg.mil (unknown [192.168.18.6])
 by UPDCF3IC14.oob.disa.mil (Postfix) with ESMTP id 402zJP4tF4zJ3dt
 for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2018 21:35:01 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id e5-v6so13339197lfb.7
 for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2018 14:35:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB9W1A2tqo7LoYAh_C_2uS6r_btpZH=PG4KpVCvP5=XDCtEXhA@mail.gmail.com>
References: <20180305164756.7878-1-sds@tycho.nsa.gov>
 <CAHC9VhRmA8YcyH+YzKQUaOR4Go_c09WCQMOXHmvar2UQQv_eeA@mail.gmail.com>
 <CAB9W1A2tqo7LoYAh_C_2uS6r_btpZH=PG4KpVCvP5=XDCtEXhA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 16 Mar 2018 17:34:59 -0400
Message-ID: <CAHC9VhT-H2X=S7vF4ETZBfp91Tmofzqb0-PbLyqCKDuFGsYy-A@mail.gmail.com>
To: Stephen Smalley <stephen.smalley@gmail.com>
Cc: "Stephen D. Smalley" <sds@tycho.nsa.gov>, peter.enderborg@sony.com,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 1/2] selinux: wrap selinuxfs state
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Mar 14, 2018 at 11:44 AM, Stephen Smalley
<stephen.smalley@gmail.com> wrote:
> On Tue, Mar 13, 2018, 12:18 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Mon, Mar 5, 2018 at 11:47 AM, Stephen Smalley <sds@tycho.nsa.gov>
>> wrote:

...

>> >  static struct dentry *sel_mount(struct file_system_type *fs_type,
>> >                       int flags, const char *dev_name, void *data)
>> >  {
>> > -       return mount_single(fs_type, flags, data, sel_fill_super);
>> > +       int (*fill_super)(struct super_block *, void *, int) =
>> > sel_fill_super;
>> > +       struct super_block *s;
>> > +       int error;
>> > +
>> > +       s = sget(fs_type, selinuxfs_compare, set_anon_super, flags,
>> > NULL);
>> > +       if (IS_ERR(s))
>> > +               return ERR_CAST(s);
>> > +       if (!s->s_root) {
>> > +               error = fill_super(s, data, flags & MS_SILENT ? 1 : 0);
>> > +               if (error) {
>> > +                       deactivate_locked_super(s);
>> > +                       return ERR_PTR(error);
>> > +               }
>> > +               s->s_flags |= MS_ACTIVE;
>> > +       }
>> > +       return dget(s->s_root);
>> > +}
>>
>> Why is mount_single() no longer desirable here?  The only difference I
>> can see is the call to do_remount_sb().  If the do_remount_sb() call
>> is problematic we should handle that in a separate patch and not bury
>> it here.
>
> This is laying the groundwork for supporting multiple distinct selinux fs
> super blocks. That said, we could likely defer this part of the patch until
> namespaces are introduced.

I suspected it was something like that.  Let's keep the mount_single()
call for now.

>> >  struct vfsmount *selinuxfs_mount;
>> > +struct path selinux_null;
>> >
>> >  static int __init init_sel_fs(void)
>> >  {
>> > +       struct qstr null_name = QSTR_INIT(NULL_FILE_NAME,
>> > +                                         sizeof(NULL_FILE_NAME)-1);
>> >         int err;
>> >
>> >         if (!selinux_enabled)
>> > @@ -1945,6 +2054,13 @@ static int __init init_sel_fs(void)
>> >                 err = PTR_ERR(selinuxfs_mount);
>> >                 selinuxfs_mount = NULL;
>> >         }
>> > +       selinux_null.dentry =
>> > d_hash_and_lookup(selinux_null.mnt->mnt_root,
>> > +                                               &null_name);
>> > +       if (IS_ERR(selinux_null.dentry)) {
>> > +               pr_err("selinuxfs:  could not lookup null!\n");
>> > +               err = PTR_ERR(selinux_null.dentry);
>> > +               selinux_null.dentry = NULL;
>> > +       }
>>
>> I'm getting a very strong feeling that I'm missing something important
>> here, but on quick inspection it doesn't appear we ever use the value
>> stored in selinux_null, and I'm really lost as to why we ever make it
>> available in include/security.h ... can we simply get rid of it?
>
> It is used by flush_unauthorized_files() in hooks.c.

Yep, there it is.  How did I miss that?  Evidently I was wrong when I
thought I knew how to use grep ...

-- 
paul moore
www.paul-moore.com

×
