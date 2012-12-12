Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBCKpmRq031192
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2012 15:51:48 -0500
Received: by mail-ee0-f53.google.com with SMTP id c50so887542eek.12
        for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2012 12:51:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50C8ED0C.2010904@schaufler-ca.com>
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
	<CACLa4pvAhASKuKH6uH7+6iEt1dqfUrQZKAC2CSmYzAtyVOgf4w@mail.gmail.com>
	<50C8CC2D.7030108@schaufler-ca.com>
	<CACLa4pu89Sc7hiTE3aDhrLG0Q9ikwwdb2nkyBBfLm3zpa0hyrw@mail.gmail.com>
	<50C8ED0C.2010904@schaufler-ca.com>
Date: Wed, 12 Dec 2012 15:51:15 -0500
Message-ID: <CACLa4pvUTyfH6ZSvY3gnWW3Un8T86bKUs=ct21P+Yqh5FvgOgQ@mail.gmail.com>
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

On Wed, Dec 12, 2012 at 3:46 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:

> You want loading SELinux policy to fail in this case, because
> you know that the system isn't going to work properly. You are
> suggesting a kernel change that inhibits loading the SELinux
> policy unless userspace tells the kernel it is OK to do so
> if present is not selinux.

Now you get me.  I just don't understand why all LSMs wouldn't want
this.  If they know they will fail, they should fail early and cleanly
rather than unpredictably later.  If you LSM can't fail due to attr
issues, this doesn't apply.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
