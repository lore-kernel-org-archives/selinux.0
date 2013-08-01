Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r71MIBBH012731
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2013 18:18:27 -0400
Received: by mail-qa0-f53.google.com with SMTP id hu14so73501qab.5
        for <selinux@tycho.nsa.gov>; Thu, 01 Aug 2013 15:18:10 -0700 (PDT)
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
Date: Thu, 01 Aug 2013 18:18:07 -0400
Message-ID: <3087749.g8XAFtub5d@sifl>
In-Reply-To: <51FADDE4.8080805@schaufler-ca.com>
References: <51F16CFB.6040603@schaufler-ca.com> <1875185.QyWUQZtYy0@sifl> <51FADDE4.8080805@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, August 01, 2013 03:15:00 PM Casey Schaufler wrote:
> On 8/1/2013 2:30 PM, Paul Moore wrote:
> > On Thursday, August 01, 2013 11:52:14 AM Casey Schaufler wrote:
> >> On 8/1/2013 11:35 AM, Paul Moore wrote:
> >>> Okay, so if I understand everything correctly, there are no new entries
> >>> in
> >>> /proc relating specifically to NetLabel, XFRM, or Secmark; although
> >>> there
> >>> are new LSM specific entries for the general /proc entries that exist
> >>> now.  Yes?
> >> 
> >> That's correct.
> >> 
> >> There is /sys/kernel/security/present, which tells you which LSM is going
> >> to show up in /proc/.../attr/current.
> >> 
> >> Should we have /sys/kernel/security/XFRM, /sys/kernel/security/secmark,
> >> /sys/kernel/security/NetLabel and /sys/kernel/security/SO_PEERCRED?
> > 
> > Maybe.
> > 
> > While they might be helpful, I'm not 100% certain they are needed and
> > further I'm not sure they are the "right" solution at this point.  Any
> > thoughts, both for and against, are welcome.
> 
> What might be a more correct solution? Assuming, of course, that there's
> a real problem.

Well, like I said, I'm not sure they are needed in the first place, in other 
words, I'm not sure there is a problem.  As for the correct solution, I think 
we need to understand the problem, if there is one, before we can understand 
the solution.

How is that for an answer? :)

In short, I think we are best leaving them out until something comes along 
which requires that we add the /proc entries.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
