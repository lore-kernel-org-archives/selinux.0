Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-id: <1440149407.2227.5.camel@samsung.com>
Subject: Re: [PATCH v3 02/11] lsm: /proc/$PID/attr/label_map file and
 getprocattr_seq hook
From: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
To: Paul Moore <paul@paul-moore.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@amacapital.net>, Arnd Bergmann <arnd@arndb.de>,
 Casey Schaufler <casey@schaufler-ca.com>,
 David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Eric Paris <eparis@parisplace.org>,
 Fabian Frederick <fabf@skynet.be>, Greg KH <gregkh@linuxfoundation.org>,
 James Morris <james.l.morris@oracle.com>, Jiri Slaby <jslaby@suse.com>,
 Joe Perches <joe@perches.com>, John Johansen <john.johansen@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
 Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 NeilBrown <neilb@suse.de>, Oleg Nesterov <oleg@redhat.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Zefan Li <lizefan@huawei.com>, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 havner@gmail.com
Date: Fri, 21 Aug 2015 11:30:07 +0200
In-reply-to: <CAHC9VhQy+qH09O1u6ZJPF226hx03j6h-dpuxHdykJjiiV6obbg@mail.gmail.com>
References: <1437732285-11524-1-git-send-email-l.pawelczyk@samsung.com>
 <1437732285-11524-3-git-send-email-l.pawelczyk@samsung.com>
 <CAHC9VhQy+qH09O1u6ZJPF226hx03j6h-dpuxHdykJjiiV6obbg@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On pią, 2015-08-21 at 01:14 -0400, Paul Moore wrote:
> On Fri, Jul 24, 2015 at 6:04 AM, Lukasz Pawelczyk
> <l.pawelczyk@samsung.com> wrote:
> > This commit adds a new proc attribute, label_map that is required 
> > by an
> > upcoming Smack namespace. In general it can be used to hold a map 
> > of
> > labels, e.g. to be used in namespaces.
> > 
> > Due to the nature of this file, the standard getprocattr hook might 
> > not
> > be enough to handle it. The map's output can in principle be 
> > greater
> > than page size to which the aforementioned hook is limited.
> > To handle this properly a getprocattr_seq LSM hook has been added 
> > that
> > makes it possible to handle any chosen proc attr by seq operations.
> > 
> > See the documentation in the patch below for the details about how 
> > to
> > use the hook.
> > 
> > Signed-off-by: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
> > ---
> >  fs/proc/base.c            | 81 
> > +++++++++++++++++++++++++++++++++++++++++++----
> >  include/linux/lsm_hooks.h | 15 +++++++++
> >  include/linux/security.h  |  9 ++++++
> >  security/security.c       |  8 +++++
> >  4 files changed, 107 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index aa50d1a..e5ac827 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -2338,20 +2338,77 @@ out:
> >  }
> > 
> >  #ifdef CONFIG_SECURITY
> > +static int proc_pid_attr_open(struct inode *inode, struct file 
> > *file)
> > +{
> > +       const char *name = file->f_path.dentry->d_name.name;
> > +       const struct seq_operations *ops;
> > +       struct task_struct *task;
> > +       struct seq_file *seq;
> > +       int ret;
> > +
> > +       file->private_data = NULL;
> > +
> > +       task = get_proc_task(inode);
> > +       if (!task)
> > +               return -ESRCH;
> > +
> > +       /* don't use seq_ops if they are not provided by LSM */
> > +       ret = security_getprocattr_seq(task, name, &ops);
> > +       if (ret == -EOPNOTSUPP) {
> > +               put_task_struct(task);
> > +               return 0;
> > +       }
> > +       if (ret) {
> > +               put_task_struct(task);
> > +               return ret;
> > +       }
> > +
> > +       ret = seq_open(file, ops);
> > +       if (ret) {
> > +               put_task_struct(task);
> > +               return ret;
> > +       }
> > +
> > +       seq = file->private_data;
> > +       seq->private = task;
> > +
> > +       return 0;
> > +}
> 
> If you end up having to respin this patchset, you might consider
> moving the "put_task_struct(...); return X;" code into a block at the
> end of the function to simplify things a bit, for example:

I will do so, thanks.

> 
> static int proc_pid_attr_open(struct inode *inode, struct file *file)
> {
>        const char *name = file->f_path.dentry->d_name.name;
>        const struct seq_operations *ops;
>        struct task_struct *task;
>        struct seq_file *seq;
>        int ret;
> 
>        file->private_data = NULL;
> 
>        task = get_proc_task(inode);
>        if (!task)
>                return -ESRCH;
> 
>        /* don't use seq_ops if they are not provided by LSM */
>        ret = security_getprocattr_seq(task, name, &ops);
>        if (ret == -EOPNOTSUPP) {
>                ret = 0;
>                goto put_task;
>        }
>        if (ret)
>                goto put_task;
> 
>        ret = seq_open(file, ops);
>        if (ret)
>                goto put_task;
> 
>        seq = file->private_data;
>        seq->private = task;
> 
>        return 0;
> 
> put_task:
>        put_task_struct(task);
>        return ret;
> }
> 
-- 
Lukasz Pawelczyk
Samsung R&D Institute Poland
Samsung Electronics
