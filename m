Return-Path: <SRS0=zdOf=SS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0E8C10F13
	for <selinux@archiver.kernel.org>; Tue, 16 Apr 2019 14:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B897620693
	for <selinux@archiver.kernel.org>; Tue, 16 Apr 2019 14:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfDPOqV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:46:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726215AbfDPOqV (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 16 Apr 2019 10:46:21 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F22EA117BB146257894D;
        Tue, 16 Apr 2019 22:46:17 +0800 (CST)
Received: from [127.0.0.1] (10.184.38.59) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Tue, 16 Apr 2019
 22:46:08 +0800
Subject: Re: kernel BUG at kernel/cred.c:434!
To:     Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>
CC:     Oleg Nesterov <oleg@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        NeilBrown <neilb@suse.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>,
        "Li Bin" <huawei.libin@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Linux Security Module list" <linux-security-module@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>
References: <6e4428ca-3da1-a033-08f7-a51e57503989@huawei.com>
 <b1575d02-fd88-65e6-2f16-70a96985087e@schaufler-ca.com>
 <20190415134331.GC22204@redhat.com>
 <CAHC9VhQ7ihqU0K57ctwzoHq0t0QVJPKiQQZn5TXB1FUqsvOSEQ@mail.gmail.com>
 <20190415150520.GA13257@redhat.com>
 <CAHC9VhSk1_fWooexHK0+5cKum55qTvj3uv5sRE=aJ4mv2GHJZg@mail.gmail.com>
 <CAGXu5jKYmoaR6bxW82ogN4iOeKi8AtEwkvVvCXd_gn3CCwFU2Q@mail.gmail.com>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <fa325d38-db66-0ae7-0a6c-75934a9b0653@huawei.com>
Date:   Tue, 16 Apr 2019 22:46:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKYmoaR6bxW82ogN4iOeKi8AtEwkvVvCXd_gn3CCwFU2Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.184.38.59]
X-CFilter-Loop: Reflected
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 2019/4/16 11:40, Kees Cook wrote:
> On Mon, Apr 15, 2019 at 11:20 AM Paul Moore <paul@paul-moore.com> wrote:
>> On Mon, Apr 15, 2019 at 11:05 AM Oleg Nesterov <oleg@redhat.com> wrote:
>>> On 04/15, Paul Moore wrote:
>>>> On Mon, Apr 15, 2019 at 9:43 AM Oleg Nesterov <oleg@redhat.com> wrote:
>>>>> Well, acct("/proc/self/attr/current") doesn't look like a good idea, but I do
>>>>> not know where should we put the additional check... And probably
>>>>> "echo /proc/self/attr/current > /proc/sys/kernel/core_pattern" can hit the
>>>>> same problem, do_coredump() does override_creds() too.
>>>>>
>>>>> May be just add
>>>>>
>>>>>          if (current->cred != current->real_cred)
>>>>>                  return -EACCES;
>>>>>
>>>>> into proc_pid_attr_write(), I dunno.
>>>> Is the problem that do_acct_process() is calling override_creds() and
>>>> the returned/old credentials are being freed before do_acct_process()
>>>> can reinstall the creds via revert_creds()?  Presumably because the
>>>> process accounting is causing the credentials to be replaced?
>>> Afaics, the problem is that do_acct_process() does override_creds() and
>>> then __kernel_write(). Which calls proc_pid_attr_write(), which in turn calls
>>> selinux_setprocattr(), which does another prepare_creds() + commit_creds();
>>> and commit_creds() hits
>>>
>>>          BUG_ON(task->cred != old);
>> Gotcha.  In the process of looking at the backtrace I forgot about the
>> BUG_ON() at the top of the oops message.
>>
>> I wonder what terrible things would happen if we changed the BUG_ON()
>> in commit_creds to simple returning an error an error code to the
>> caller.  There is a warning/requirement in commit_creds() function
>> header comment that it should always return 0.
> Would callers be expected to call abort_creds() on failure? There are
> a number of places where it'd need fixing up. And would likely be best
> with a __must_check marking.
>
> It seems like avoiding the pathological case might be simpler?


Yeah, Avoiding this pathological case is a better solution.

It seems like that we can't commit_creds() during

override_creds() and revert_creds().

So how about just put commit_creds outside !


just like:

     override_creds()   // cred  -=> new

     // may BUG_ON if commit_creds done.

     revert_creds()     //  cred -=> old                         
<-----------|

     commit_creds   //  cred = real_cred = new                |

[revert_creds]--------------------------------------------------|


[1]--Before we call commit_creds in selinux_setprocattr(),

if we find that cred != real_cred, it may have been overridden

before, we should revert it.

[2]--The same to revert_creds, when we found someone have committed,

orig_cred != current->real_cred may hits, this means that

we have reverted before(see [1]).

[3]--Sometimes new and old are the same, then we need to consider this

situation specially.


The code just like:


From: Yang Yingliang <yangyingliang@huawei.com>
Date: Sat, 13 Apr 2019 21:56:01 +0800
Subject: [PATCH] fix cred bug_on

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
  kernel/acct.c            | 3 ++-
  kernel/cred.c            | 6 ++++++
  security/selinux/hooks.c | 2 ++
  3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index addf7732fb56..f2065f899eee 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -522,7 +522,8 @@ static void do_acct_process(struct bsd_acct_struct 
*acct)
      }
  out:
      current->signal->rlim[RLIMIT_FSIZE].rlim_cur = flim;
-    revert_creds(orig_cred);
+    if (orig_cred == current->real_cred)    // [2]
+        revert_creds(orig_cred);
  }

  /**
diff --git a/kernel/cred.c b/kernel/cred.c
index ecf03657e71c..c4d5ba92fb9b 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -522,6 +522,9 @@ const struct cred *override_creds(const struct cred 
*new)
  {
      const struct cred *old = current->cred;

+    if (old == new)    //  [3]
+        return old;
+
      kdebug("override_creds(%p{%d,%d})", new,
             atomic_read(&new->usage),
             read_cred_subscribers(new));
@@ -551,6 +554,9 @@ void revert_creds(const struct cred *old)
  {
      const struct cred *override = current->cred;

+    if (override == old)    // [3]
+        return;
+
      kdebug("revert_creds(%p{%d,%d})", old,
             atomic_read(&old->usage),
             read_cred_subscribers(old));
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b5017beb4ef7..bc8108e4e90f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6590,6 +6590,8 @@ static int selinux_setprocattr(const char *name, 
void *value, size_t size)
          goto abort_change;
      }

+    if (current->cred != current->real_cred)    // [1]
+        revert_creds(current->real_cred);
      commit_creds(new);
      return size;

-- 
2.17.1


We have tested this patch for 3 days and it works well.

Are there any cases that are not covered here ?


Thanks.

     Cheng Jian


