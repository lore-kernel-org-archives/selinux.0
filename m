Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBCKjktQ030769
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2012 15:45:46 -0500
Message-ID: <50C8ED0C.2010904@schaufler-ca.com>
Date: Wed, 12 Dec 2012 12:46:04 -0800
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
References: <50C65DE2.5090909@schaufler-ca.com> <201212112128.ADI26010.OQJVLOFSOFtHMF@I-love.SAKURA.ne.jp> <50C751D3.60409@schaufler-ca.com> <201212122159.CEC09839.HMOFtQFLJSVFOO@I-love.SAKURA.ne.jp> <50C8A757.3050907@schaufler-ca.com> <1355327754.3527.37.camel@localhost> <50C8AFD1.1070905@schaufler-ca.com> <1355330026.3527.44.camel@localhost> <50C8B919.2060102@schaufler-ca.com> <1355332292.3527.48.camel@localhost> <50C8BF7A.6060506@schaufler-ca.com> <CACLa4pvAhASKuKH6uH7+6iEt1dqfUrQZKAC2CSmYzAtyVOgf4w@mail.gmail.com> <50C8CC2D.7030108@schaufler-ca.com> <CACLa4pu89Sc7hiTE3aDhrLG0Q9ikwwdb2nkyBBfLm3zpa0hyrw@mail.gmail.com>
In-Reply-To: <CACLa4pu89Sc7hiTE3aDhrLG0Q9ikwwdb2nkyBBfLm3zpa0hyrw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/12/2012 10:47 AM, Eric Paris wrote:
> On Wed, Dec 12, 2012 at 1:25 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>> Configure None as the presented LSM and all legacy userspace
>> will fail. Trouble for all.
> I think the question is when and how it fails.  I'd like SELinux to
> fail really early and in some clean way if it is non-present and you
> don't have new userspace.  I'd rather it fail on policy load than on
> some later /proc/*/attr/ issue.  I can do it myself even if you don't
> want to do it as part of the stacking work.

So the problem would be old userspace (new userspace can query
/sys/kernel/security/lsm and /sys/kernel/security/present) with
a kernel configured with present=apparmor.

You want loading SELinux policy to fail in this case, because
you know that the system isn't going to work properly. You are
suggesting a kernel change that inhibits loading the SELinux
policy unless userspace tells the kernel it is OK to do so
if present is not selinux.

I have no objection to such. You could look at CONFIG_PRESENT_SECURITY
in the SELinux initialization code and set a "don't load" trigger if
it isn't "selinux". Your selinuxfs (or some other) interface could
allow the trigger to get unset by the updated userspace.

 

>
> My current thought is a required ioctl before policy load if
> non-present otherwise reject policy load instead of the entirely new
> policy load file.
>
> -Eric
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
