Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBCM0qgb003154
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2012 17:00:52 -0500
Message-ID: <50C8FEA6.7050706@schaufler-ca.com>
Date: Wed, 12 Dec 2012 14:01:10 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>
CC: Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SE-Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v10] LSM: Multiple concurrent LSMs
References: <50C65DE2.5090909@schaufler-ca.com> <201212112128.ADI26010.OQJVLOFSOFtHMF@I-love.SAKURA.ne.jp> <50C751D3.60409@schaufler-ca.com> <201212122159.CEC09839.HMOFtQFLJSVFOO@I-love.SAKURA.ne.jp> <50C8A757.3050907@schaufler-ca.com> <1355327754.3527.37.camel@localhost> <50C8AFD1.1070905@schaufler-ca.com> <1355330026.3527.44.camel@localhost> <50C8B919.2060102@schaufler-ca.com> <1355332292.3527.48.camel@localhost> <50C8BF7A.6060506@schaufler-ca.com> <CACLa4pvAhASKuKH6uH7+6iEt1dqfUrQZKAC2CSmYzAtyVOgf4w@mail.gmail.com> <50C8CC2D.7030108@schaufler-ca.com> <CACLa4pu89Sc7hiTE3aDhrLG0Q9ikwwdb2nkyBBfLm3zpa0hyrw@mail.gmail.com> <50C8ED0C.2010904@schaufler-ca.com> <CACLa4pvUTyfH6ZSvY3gnWW3Un8T86bKUs=ct21P+Yqh5FvgOgQ@mail.gmail.com>
In-Reply-To: <CACLa4pvUTyfH6ZSvY3gnWW3Un8T86bKUs=ct21P+Yqh5FvgOgQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/12/2012 12:51 PM, Eric Paris wrote:
> On Wed, Dec 12, 2012 at 3:46 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>> You want loading SELinux policy to fail in this case, because
>> you know that the system isn't going to work properly. You are
>> suggesting a kernel change that inhibits loading the SELinux
>> policy unless userspace tells the kernel it is OK to do so
>> if present is not selinux.
> Now you get me.  I just don't understand why all LSMs wouldn't want
> this.  If they know they will fail, they should fail early and cleanly
> rather than unpredictably later.  If you LSM can't fail due to attr
> issues, this doesn't apply.
>
Ah. Any LSM see it, but each LSM is going to have to decide
what it does about it. SELinux can refuse to load policy.
Smack is perfectly happy to run without any rules set. There
is no major configuration event to fail.

Smack will be aggressively updating userspace. Smack does not
(alas) have the install base that SELinux enjoys. I am not
especially concerned for Smack, while I understand fully the
SELinux concern.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
