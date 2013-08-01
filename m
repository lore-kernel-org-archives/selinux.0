Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r71LUd8S009899
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2013 17:30:55 -0400
Received: by mail-qa0-f54.google.com with SMTP id bv4so50442qab.13
        for <selinux@tycho.nsa.gov>; Thu, 01 Aug 2013 14:30:38 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LKLM <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v14 3/6] LSM: Explicit individual LSM associations
Date: Thu, 01 Aug 2013 17:30:32 -0400
Message-ID: <1875185.QyWUQZtYy0@sifl>
In-Reply-To: <51FAAE5E.4060801@schaufler-ca.com>
References: <51F16CFB.6040603@schaufler-ca.com> <1991449.AFacmybWrj@sifl> <51FAAE5E.4060801@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, August 01, 2013 11:52:14 AM Casey Schaufler wrote:
> On 8/1/2013 11:35 AM, Paul Moore wrote:
> > Okay, so if I understand everything correctly, there are no new entries in
> > /proc relating specifically to NetLabel, XFRM, or Secmark; although there
> > are new LSM specific entries for the general /proc entries that exist
> > now.  Yes?
>
> That's correct.
> 
> There is /sys/kernel/security/present, which tells you which LSM is going to
> show up in /proc/.../attr/current.
> 
> Should we have /sys/kernel/security/XFRM, /sys/kernel/security/secmark,
> /sys/kernel/security/NetLabel and /sys/kernel/security/SO_PEERCRED?

Maybe.

While they might be helpful, I'm not 100% certain they are needed and further 
I'm not sure they are the "right" solution at this point.  Any thoughts, both 
for and against, are welcome.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
