Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s07HMu0c020351
 for <selinux@tycho.nsa.gov>; Tue, 7 Jan 2014 12:22:56 -0500
Received: by mail-pb0-f46.google.com with SMTP id md12so392361pbc.33
 for <selinux@tycho.nsa.gov>; Tue, 07 Jan 2014 09:22:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CACLa4pvfGq45vS36Vq2e=0Ze+83rdXGgj2BehCOZLJSESLLf=Q@mail.gmail.com>
References: <201401062128.EGC13224.HOFMOVFLFQJOtS@I-love.SAKURA.ne.jp>
 <2121445.eP5ZhhDIJm@sifl>
 <CACLa4ptz9Pp6tkwc0K7asfD2h5O-+bFtz_+465TVS62X3DFQHg@mail.gmail.com>
 <15791866.iqhIohnBDV@sifl>
 <CACLa4pvfGq45vS36Vq2e=0Ze+83rdXGgj2BehCOZLJSESLLf=Q@mail.gmail.com>
Date: Tue, 7 Jan 2014 12:22:54 -0500
Message-ID: <CAHC9VhRa9h7GhM31-QXT6wds90qVUdF4NA8dsNfe7BiY+V1PJA@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Fix memory leak upon loading policy
From: Paul Moore <paul@paul-moore.com>
To: Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 LSM List <linux-security-module@vger.kernel.org>,
 SE-Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Merged the patch and everything passes the SELinux testsuite.  I'll
push this to James today.

Thanks all.

On Mon, Jan 6, 2014 at 6:12 PM, Eric Paris <eparis@parisplace.org> wrote:
> The only way to get EEXIST is for h->keycmp(h, new_entry,
> existing_entry) to be 0.  keycmp == filenametr_cmp() which does:
>
> static int filenametr_cmp(struct hashtab *h, const void *k1, const void *k2)
> {
>         const struct filename_trans *ft1 = k1;
>         const struct filename_trans *ft2 = k2;
>         int v;
>
>         v = ft1->stype - ft2->stype;
>         if (v)
>                 return v;
>
>         v = ft1->ttype - ft2->ttype;
>         if (v)
>                 return v;
>
>         v = ft1->tclass - ft2->tclass;
>         if (v)
>                 return v;
>
>         return strcmp(ft1->name, ft2->name);
>
> }
>
> so we know for a fact stype, ttype, tclass, and filename are all the
> same.  We don't know if the otype is the same.  But if it is, that's a
> toolchain problem.  It should not have let things through.
>
> I know we do duplicate checking at expand time and the code looks ok
> to me...   I dunno, but there is a real bug here somewhere.
>
> This patch does the right thing by returning errors on error, except
> for the known/currently working EEXIST case.  Then we don't leak or
> destroy user's systems that we know exist...
>
> On Mon, Jan 6, 2014 at 5:54 PM, Paul Moore <paul@paul-moore.com> wrote:
>> On Monday, January 06, 2014 05:22:20 PM Eric Paris wrote:
>>> Paul,
>>>
>>> I do not understand your objection.  While we believe that userspace
>>> should not be sending multiple copies of the same filename trans rule
>>> we know it is, we know it isn't fatal, and we know we are leaking
>>> memory.  I think this patch is doing the right thing.  On EEXIST it is
>>> freeing the memory and moving along (instead of leaking it and moving
>>> along).  On any other error it will cause the policy load to fail.  I
>>> can't think of any kernel patch which makes more sense.  We know these
>>> policies exist.  Sure, we should fix the EEXIST in the toolchain, but
>>> we should also stop leaking memory and not break anything.
>>>
>>> Acked-by: Eric Paris <eparis@redhat.com>
>>
>> My concern/objection was that I wasn't confident the core problem was with the
>> toolchain; I wanted to make sure we weren't covering up a kernel bug.  Since
>> you're confident this is a toolchain issue I'll go ahead and merge this.
>>
>> As soon as I can get this build and tested, I'll push this up to James.  I'm
>> thinking we should be able to make it before the 3.14 merge window and I also
>> think this is a good stable candidate.
>>
>>> On Mon, Jan 6, 2014 at 5:12 PM, Paul Moore <paul@paul-moore.com> wrote:
>>> > On Monday, January 06, 2014 09:28:15 PM Tetsuo Handa wrote:
>>> >> Hello.
>>> >>
>>> >> I got below leak with linux-3.10.0-54.0.1.el7.x86_64 .
>>> >>
>>> >> [  681.903890] kmemleak: 5538 new suspected memory leaks (see
>>> >> /sys/kernel/debug/kmemleak)
>>> >>
>>> >> Below is a patch, but I don't know whether we need special handing for
>>> >> undoing ebitmap_set_bit() call.
>>> >> ----------
>>> >>
>>> >> >From fe97527a90fe95e2239dfbaa7558f0ed559c0992 Mon Sep 17 00:00:00 2001
>>> >>
>>> >> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>> >> Date: Mon, 6 Jan 2014 16:30:21 +0900
>>> >> Subject: [PATCH] SELinux: Fix memory leak upon loading policy
>>> >>
>>> >> Commit 2463c26d "SELinux: put name based create rules in a hashtable" did
>>> >> not check return value from hashtab_insert() in filename_trans_read(). It
>>> >> leaks memory if hashtab_insert() returns error.
>>> >>
>>> >>   unreferenced object 0xffff88005c9160d0 (size 8):
>>> >>     comm "systemd", pid 1, jiffies 4294688674 (age 235.265s)
>>> >>
>>> >>     hex dump (first 8 bytes):
>>> >>       57 0b 00 00 6b 6b 6b a5                          W...kkk.
>>> >>
>>> >>     backtrace:
>>> >>       [<ffffffff816604ae>] kmemleak_alloc+0x4e/0xb0
>>> >>       [<ffffffff811cba5e>] kmem_cache_alloc_trace+0x12e/0x360
>>> >>       [<ffffffff812aec5d>] policydb_read+0xd1d/0xf70
>>> >>       [<ffffffff812b345c>] security_load_policy+0x6c/0x500
>>> >>       [<ffffffff812a623c>] sel_write_load+0xac/0x750
>>> >>       [<ffffffff811eb680>] vfs_write+0xc0/0x1f0
>>> >>       [<ffffffff811ec08c>] SyS_write+0x4c/0xa0
>>> >>       [<ffffffff81690419>] system_call_fastpath+0x16/0x1b
>>> >>       [<ffffffffffffffff>] 0xffffffffffffffff
>>> >>
>>> >> However, we should not return EEXIST error to the caller, or the systemd
>>> >> will show below message and the boot sequence freezes.
>>> >>
>>> >>   systemd[1]: Failed to load SELinux policy. Freezing.
>>> >>
>>> >> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>> >> ---
>>> >>
>>> >>  security/selinux/ss/policydb.c |   14 +++++++++++++-
>>> >>  1 files changed, 13 insertions(+), 1 deletions(-)
>>> >>
>>> >> diff --git a/security/selinux/ss/policydb.c
>>> >> b/security/selinux/ss/policydb.c index f6195eb..c8985db 100644
>>> >> --- a/security/selinux/ss/policydb.c
>>> >> +++ b/security/selinux/ss/policydb.c
>>> >> @@ -1941,7 +1941,19 @@ static int filename_trans_read(struct policydb *p,
>>> >> void *fp) if (rc)
>>> >>
>>> >>                       goto out;
>>> >>
>>> >> -             hashtab_insert(p->filename_trans, ft, otype);
>>> >> +             rc = hashtab_insert(p->filename_trans, ft, otype);
>>> >> +             if (rc) {
>>> >> +                     /*
>>> >> +                      * Do not return -EEXIST to the caller, or the
>>> >> system
>>> >> +                      * will not boot.
>>> >> +                      */
>>> >> +                     if (rc != -EEXIST)
>>> >> +                             goto out;
>>> >> +                     /* But free memory to avoid memory leak. */
>>> >> +                     kfree(ft);
>>> >> +                     kfree(name);
>>> >> +                     kfree(otype);
>>> >> +             }
>>> >>
>>> >>       }
>>> >>       hash_eval(p->filename_trans, "filenametr");
>>> >>       return 0;
>>> >
>>> > Thanks for sending this patch.  Mimi found a similar issue a little while
>>> > ago and found a number of hashtab_insert() failures which were causing a
>>> > fair number of memory leaks.
>>> >
>>> > I'm not going to merge this patch at the moment.  While we should check
>>> > the
>>> > return value of hashtab_insert(), and fix the memory leaks when it fails,
>>> > I
>>> > still want to better understand why that hashtab_insert() function is
>>> > failing in the first place on what would appear to be a "normal"
>>> > operation.  Ideally we would first resolve the hashtab_insert() failures,
>>> > then we could check the return value, release the memory when necessary,
>>> > and return errors to the caller.
>>> >
>>> > --
>>> > paul moore
>>> > www.paul-moore.com
>>> >
>>> > --
>>> > To unsubscribe from this list: send the line "unsubscribe
>>> > linux-security-module" in the body of a message to
>>> > majordomo@vger.kernel.org
>>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> paul moore
>> www.paul-moore.com
>>



-- 
paul moore
www.paul-moore.com
