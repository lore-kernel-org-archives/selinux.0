Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3PF1sbd004691
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2013 11:02:11 -0400
Received: by mail-yh0-f50.google.com with SMTP id b20so269484yha.23
        for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2013 08:01:53 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: John Johansen <john.johansen@canonical.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>, SE Linux <selinux@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v13 0/9] LSM: Multiple concurrent LSMs
Date: Thu, 25 Apr 2013 11:01:50 -0400
Message-ID: <47138397.PP25Tg7m1s@sifl>
In-Reply-To: <51787C1C.1040301@schaufler-ca.com>
References: <5176ABB7.5080300@schaufler-ca.com> <517863F8.7050606@canonical.com> <51787C1C.1040301@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, April 24, 2013 05:43:08 PM Casey Schaufler wrote:
> On 4/24/2013 4:00 PM, John Johansen wrote:
> > On 04/24/2013 02:15 PM, Paul Moore wrote:
> >> On Wednesday, April 24, 2013 01:22:20 PM Casey Schaufler wrote:

...

> >>> An interesting aside that may be relevant is that the error
> >>> condition behavior makes it advisable to have the LSM you care
> >>> about most go last. If the networking components were strictly
> >>> FCFS you might have to chose an ordering you might not want for
> >>> other reasons.
> >> 
> >> Well, maybe not ... I think.  If we take a FCFS approach to the network
> >> controls then only one LSM is really ever going to throw an error on the
> >> network hooks, yes?
> 
> You set up the order you want to get the networking handled
> correctly and you could get filesystem hooks in the wrong order.
> Not that that really ought to be a problem, but there are wonky
> admin tools out there.

I don't quite follow; can you be a bit more explicit about getting the 
filesystem hooks in the wrong order?

> >> I'm still in favor of assigning the network hooks to the LSM at boot
> >> based on the "security=" configuration.
> > 
> > yeah dealing with selection at boot time is going to be needed
> > at some point, whether its now or later ...
> 
> I'll have a go at it then. What that would mean is that:
> 
> 	security=smack,selinux
> 
> gives Smack NetLabel and SELinux xfrm and secmark while
> 
> 	security=selinux,smack
> 
> gives SELinux all three.

That seems reasonable, it also keeps the door open for adding a specific 
network hook ordering option, e.g. "security_net=", at a later date if 
necessary.

> I would still like it to be possible to explicitly configure the allocation
> at build time.

I suppose I have no object to that, I would just place my vote to have the 
dynamic FCFS (or LCFS if that makes more sense) assignment be the Kconfig 
default.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
