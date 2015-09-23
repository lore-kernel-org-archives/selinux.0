Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8NL0QSs029661
 for <selinux@tycho.nsa.gov>; Wed, 23 Sep 2015 17:00:27 -0400
Received: by obbbh8 with SMTP id bh8so43553221obb.0
 for <selinux@tycho.nsa.gov>; Wed, 23 Sep 2015 14:00:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150917124921.GA85188@ubuntu-hedt>
References: <1442433764-80826-1-git-send-email-seth.forshee@canonical.com>
 <1442433764-80826-6-git-send-email-seth.forshee@canonical.com>
 <CALCETrUHUwYYdah-H48NY94xzxf7ws0rtEmegh+v6JZVByUPHQ@mail.gmail.com>
 <20150917124921.GA85188@ubuntu-hedt>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 23 Sep 2015 14:00:05 -0700
Message-ID: <CALCETrVCPYcLrt4yzWosouK00RZ+hnCofjKGMQqp5EtqJXZkDQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] fs: Treat foreign mounts as nosuid
To: Seth Forshee <seth.forshee@canonical.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-mtd@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Sep 17, 2015 at 5:49 AM, Seth Forshee
<seth.forshee@canonical.com> wrote:
> On Wed, Sep 16, 2015 at 01:57:10PM -0700, Andy Lutomirski wrote:
>> On Wed, Sep 16, 2015 at 1:02 PM, Seth Forshee
>> <seth.forshee@canonical.com> wrote:
>> > From: Andy Lutomirski <luto@amacapital.net>
>> >
>> > If a process gets access to a mount from a different user
>> > namespace, that process should not be able to take advantage of
>> > setuid files or selinux entrypoints from that filesystem.  Prevent
>> > this by treating mounts from other mount namespaces and those not
>> > owned by current_user_ns() or an ancestor as nosuid.
>> >
>> > This will make it safer to allow more complex filesystems to be
>> > mounted in non-root user namespaces.
>> >
>> > This does not remove the need for MNT_LOCK_NOSUID.  The setuid,
>> > setgid, and file capability bits can no longer be abused if code in
>> > a user namespace were to clear nosuid on an untrusted filesystem,
>> > but this patch, by itself, is insufficient to protect the system
>> > from abuse of files that, when execed, would increase MAC privilege.
>> >
>> > As a more concrete explanation, any task that can manipulate a
>> > vfsmount associated with a given user namespace already has
>> > capabilities in that namespace and all of its descendents.  If they
>> > can cause a malicious setuid, setgid, or file-caps executable to
>> > appear in that mount, then that executable will only allow them to
>> > elevate privileges in exactly the set of namespaces in which they
>> > are already privileges.
>> >
>> > On the other hand, if they can cause a malicious executable to
>> > appear with a dangerous MAC label, running it could change the
>> > caller's security context in a way that should not have been
>> > possible, even inside the namespace in which the task is confined.
>> >
>> > As a hardening measure, this would have made CVE-2014-5207 much
>> > more difficult to exploit.
>> >
>> > Signed-off-by: Andy Lutomirski <luto@amacapital.net>
>> > Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
>> > ---
>> >  fs/exec.c                |  2 +-
>> >  fs/namespace.c           | 13 +++++++++++++
>> >  include/linux/mount.h    |  1 +
>> >  security/commoncap.c     |  2 +-
>> >  security/selinux/hooks.c |  2 +-
>> >  5 files changed, 17 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/fs/exec.c b/fs/exec.c
>> > index b06623a9347f..ea7311d72cc3 100644
>> > --- a/fs/exec.c
>> > +++ b/fs/exec.c
>> > @@ -1295,7 +1295,7 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
>> >         bprm->cred->euid = current_euid();
>> >         bprm->cred->egid = current_egid();
>> >
>> > -       if (bprm->file->f_path.mnt->mnt_flags & MNT_NOSUID)
>> > +       if (!mnt_may_suid(bprm->file->f_path.mnt))
>> >                 return;
>> >
>> >         if (task_no_new_privs(current))
>> > diff --git a/fs/namespace.c b/fs/namespace.c
>> > index da70f7c4ece1..2101ce7b96ab 100644
>> > --- a/fs/namespace.c
>> > +++ b/fs/namespace.c
>> > @@ -3276,6 +3276,19 @@ found:
>> >         return visible;
>> >  }
>> >
>> > +bool mnt_may_suid(struct vfsmount *mnt)
>> > +{
>> > +       /*
>> > +        * Foreign mounts (accessed via fchdir or through /proc
>> > +        * symlinks) are always treated as if they are nosuid.  This
>> > +        * prevents namespaces from trusting potentially unsafe
>> > +        * suid/sgid bits, file caps, or security labels that originate
>> > +        * in other namespaces.
>> > +        */
>> > +       return !(mnt->mnt_flags & MNT_NOSUID) && check_mnt(real_mount(mnt)) &&
>> > +              in_userns(current_user_ns(), mnt->mnt_sb->s_user_ns);
>>
>> Is check_mnt correct here?  If I read it correctly, this means that,
>> if I just unshare my userns and do nothing else (and, in particular,
>> don't unshare my mount namespace), then everything will have
>> mnt_may_suid return false.
>
> The condition in check_mnt is exactly the same as the condition that
> check_mnt replaces. If mnt_may_suid returned true before you unshared
> only your user namespace then it should also return true after unshare.
> The mount ns is the same as it was before so check_mnt returns true, and
> the new user namespace is a child of the previous one so in_userns also
> returns true.

Indeed, I was wrong.

--Andy
