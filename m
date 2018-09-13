Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8DJNZpj014259
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 15:23:35 -0400
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so5568757lji.6
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 12:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000038dab0575476b73@google.com>
 <f3bcebc6-47a7-518e-70f7-c7e167621841@I-love.SAKURA.ne.jp>
 <CAHC9VhT-Thu6KppC-MWzqkB7R1CaQA9DWXOQnG0b2uS9+rvzoA@mail.gmail.com>
 <ea29a8bf-95b2-91d2-043b-ed73c9023166@i-love.sakura.ne.jp>
In-Reply-To: <ea29a8bf-95b2-91d2-043b-ed73c9023166@i-love.sakura.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 13 Sep 2018 15:23:15 -0400
Message-ID: <CAHC9VhR8My9_Dt=4OhUoHsN8MRViLaBmcfzbeJWmvnGn_AQmzw@mail.gmail.com>
To: penguin-kernel@i-love.sakura.ne.jp
Cc: selinux@tycho.nsa.gov,
 syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com,
 Eric Paris <eparis@parisplace.org>, linux-kernel@vger.kernel.org,
 peter.enderborg@sony.com, Stephen Smalley <sds@tycho.nsa.gov>,
 syzkaller-bugs@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: Add __GFP_NOWARN to allocation at
 str_read()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Sep 13, 2018 at 2:26 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2018/09/13 12:02, Paul Moore wrote:
> > On Fri, Sep 7, 2018 at 12:43 PM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >> syzbot is hitting warning at str_read() [1] because len parameter can
> >> become larger than KMALLOC_MAX_SIZE. We don't need to emit warning for
> >> this case.
> >>
> >> [1] https://syzkaller.appspot.com/bug?id=7f2f5aad79ea8663c296a2eedb81978401a908f0
> >>
> >> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >> Reported-by: syzbot <syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com>
> >> ---
> >>  security/selinux/ss/policydb.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> >> index e9394e7..f4eadd3 100644
> >> --- a/security/selinux/ss/policydb.c
> >> +++ b/security/selinux/ss/policydb.c
> >> @@ -1101,7 +1101,7 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
> >>         if ((len == 0) || (len == (u32)-1))
> >>                 return -EINVAL;
> >>
> >> -       str = kmalloc(len + 1, flags);
> >> +       str = kmalloc(len + 1, flags | __GFP_NOWARN);
> >>         if (!str)
> >>                 return -ENOMEM;
> >
> > Thanks for the patch.
> >
> > My eyes are starting to glaze over a bit chasing down all of the
> > different kmalloc() code paths trying to ensure that this always does
> > the right thing based on size of the allocation and the different slab
> > allocators ... are we sure that this will always return NULL when (len
> > + 1) is greater than KMALLOC_MAX_SIZE for the different slab allocator
> > configurations?
>
> Yes, for (len + 1) cannot become 0 (which causes kmalloc() to return
> ZERO_SIZE_PTR) due to (len == (u32)-1) check above.
>
> The only concern would be whether you want allocation failure messages.
> I assumed you don't need it because we are returning -ENOMEM to the caller.

I'm not to worried about the failure messages, returning -ENOMEM
should be sufficient in this case.

-- 
paul moore
www.paul-moore.com
