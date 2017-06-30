Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5UMUQMc011498
 for <selinux@tycho.nsa.gov>; Fri, 30 Jun 2017 18:30:26 -0400
Received: by mail-lf0-f67.google.com with SMTP id g21so11012892lfk.1
 for <selinux@tycho.nsa.gov>; Fri, 30 Jun 2017 15:30:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201706302210.GCA05089.MFFOtQVJSOLHOF@I-love.SAKURA.ne.jp>
References: <20170630075614.ywv3y3tptor5ox7g@mwanda>
 <1498826894.16913.1.camel@tycho.nsa.gov>
 <201706302210.GCA05089.MFFOtQVJSOLHOF@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 30 Jun 2017 18:30:19 -0400
Message-ID: <CAHC9VhTpBEJE3oYShNMNrLP7sL5hM2aSLDAcoLn0TMhpMma8Yg@mail.gmail.com>
Subject: Re: [PATCH] selinux: return -ENOMEM if kzalloc() fails
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, dan.carpenter@oracle.com,
 danielj@mellanox.com, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, serge@hallyn.com,
 selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jun 30, 2017 at 9:10 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Stephen Smalley wrote:
>> On Fri, 2017-06-30 at 10:56 +0300, Dan Carpenter wrote:
>> > We accidentally return success instead of -ENOMEM on this failure
>> > path.
>> >
>> > Fixes: 409dcf31538a ("selinux: Add a cache for quicker retreival of
>> > PKey SIDs")
>> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>
>> NAK, that's intentional.  See the comment just above the code in
>> question.
>
> If allocation failure is no problem, please consider using
> GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN instead of
> GFP_ATOMIC, for memory reserves is mainly targeted for OOM victims.

I have a todo item to try and consolidate some of the SELinux object
cache code, this seems like something worth experimenting with when
that happens.

-- 
paul moore
www.paul-moore.com
