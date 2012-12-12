Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBCHlw3f026500
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2012 12:48:01 -0500
Received: by mail-ea0-f181.google.com with SMTP id k14so366076eaa.12
        for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2012 09:47:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50C8BF7A.6060506@schaufler-ca.com>
References: <50C65DE2.5090909@schaufler-ca.com>
	<201212112128.ADI26010.OQJVLOFSOFtHMF@I-love.SAKURA.ne.jp>
	<50C751D3.60409@schaufler-ca.com>
	<201212122159.CEC09839.HMOFtQFLJSVFOO@I-love.SAKURA.ne.jp>
	<50C8A757.3050907@schaufler-ca.com>
	<1355327754.3527.37.camel@localhost>
	<50C8AFD1.1070905@schaufler-ca.com>
	<1355330026.3527.44.camel@localhost>
	<50C8B919.2060102@schaufler-ca.com>
	<1355332292.3527.48.camel@localhost>
	<50C8BF7A.6060506@schaufler-ca.com>
Date: Wed, 12 Dec 2012 12:47:58 -0500
Message-ID: <CACLa4pvAhASKuKH6uH7+6iEt1dqfUrQZKAC2CSmYzAtyVOgf4w@mail.gmail.com>
Subject: Re: [PATCH v10] LSM: Multiple concurrent LSMs
From: Eric Paris <eparis@parisplace.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SE-Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Dec 12, 2012 at 12:31 PM, Casey Schaufler
<casey@schaufler-ca.com> wrote:

> We can't undo the sins of the past regarding /proc/.../attr.

Agreed

> With
> the scheme I'm putting forth you can have a working system with both
> SELinux and AppArmor if either runtime understands the multiple LSM
> environment.

Agreed.  (assuming the command line option was configured to present
the one that doesn't understand)

> If neither understands, at least one will have trouble.

Agreed.  I'm just of the belief the 'trouble' should be 'fails
completely' rather than 'fails partially' trying to use
/proc/self/attr...

> On a slightly different note, do we need a liblsm with interfaces like:
>
>         int lsm_presented(char *presented)
>         int lsm_supported(char *lsmname)
>
> so you're not reading the files directly?

If I have new enough userspace to call such functions, do I need them?
 Doesn't seem I need presented.  I can always use the selinux.*
version of attr files.  Maybe lsm_supported is slightly useful.  We
don't have to parse /proc/filesystems looking for selinuxfs.  I guess
that'd be faster, but I don't know if others would use it...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
