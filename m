Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7HLaD49025363
 for <selinux@tycho.nsa.gov>; Wed, 17 Aug 2016 17:36:13 -0400
Received: by mail-oi0-f48.google.com with SMTP id c15so815749oig.0
 for <selinux@tycho.nsa.gov>; Wed, 17 Aug 2016 14:36:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhR8FUsPjt8KgW8Ub9Z5E4yXGesJ9314Z5hjH_QtR3kORw@mail.gmail.com>
References: <1469132667-17377-1-git-send-email-john.stultz@linaro.org>
 <1469132667-17377-2-git-send-email-john.stultz@linaro.org>
 <CAHC9VhR8FUsPjt8KgW8Ub9Z5E4yXGesJ9314Z5hjH_QtR3kORw@mail.gmail.com>
From: John Stultz <john.stultz@linaro.org>
Date: Wed, 17 Aug 2016 14:36:10 -0700
Message-ID: <CALAqxLXQ0J5vvYrdLaiM_Akm-27h-hSy0wMTdeLG2MxyD+zgfA@mail.gmail.com>
Subject: Re: [PATCH 2/2 v4] proc: Add LSM hook checks to
 /proc/<tid>/timerslack_ns
To: Paul Moore <paul@paul-moore.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Arjan van de Ven <arjan@linux.intel.com>,
 Oren Laadan <orenl@cellrox.com>, Ruchi Kandoi <kandoiruchi@google.com>,
 Rom Lemarchand <romlem@android.com>, Todd Kjos <tkjos@google.com>,
 Colin Cross <ccross@android.com>, Nick Kralevich <nnk@google.com>,
 Dmitry Shmidt <dimitrysh@google.com>, Elliott Hughes <enh@google.com>,
 James Morris <jmorris@namei.org>,
 Android Kernel Team <kernel-team@android.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Aug 17, 2016 at 2:21 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Jul 21, 2016 at 4:24 PM, John Stultz <john.stultz@linaro.org> wrote:
>> As requested, this patch checks the existing LSM hooks
>> task_getscheduler/task_setscheduler when reading or modifying
>> the task's timerslack value.
>>
>> Previous versions added new get/settimerslack LSM hooks, but
>> since they checked the same PROCESS__SET/GETSCHED values as
>> existing hooks, it was suggested we just use the existing ones.
>>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: "Serge E. Hallyn" <serge@hallyn.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> CC: Arjan van de Ven <arjan@linux.intel.com>
>> Cc: Oren Laadan <orenl@cellrox.com>
>> Cc: Ruchi Kandoi <kandoiruchi@google.com>
>> Cc: Rom Lemarchand <romlem@android.com>
>> Cc: Todd Kjos <tkjos@google.com>
>> Cc: Colin Cross <ccross@android.com>
>> Cc: Nick Kralevich <nnk@google.com>
>> Cc: Dmitry Shmidt <dimitrysh@google.com>
>> Cc: Elliott Hughes <enh@google.com>
>> Cc: James Morris <jmorris@namei.org>
>> Cc: Android Kernel Team <kernel-team@android.com>
>> Cc: linux-security-module@vger.kernel.org
>> Cc: selinux@tycho.nsa.gov
>> Signed-off-by: John Stultz <john.stultz@linaro.org>
>> ---
>> v2:
>>  * Initial swing at adding settimerslack LSM hook
>> v3:
>>  * Fix current/p switchup bug noted by NickK
>>  * Add gettimerslack hook suggested by NickK
>> v4:
>>  * Dropped adding get/settimerslack LSM hooks, and
>>    just reuse the get/setscheduler ones.
>>
>>  fs/proc/base.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>
> For some reason I'm having a hard time finding patch 1/2 in the
> patchset, but this patch looks reasonable to me.  We already have some

https://lkml.org/lkml/2016/7/21/522

> LSM checking via the ptrace_may_access() call, but this adds some
> additional granularity which could be a good thing.
>
> Acked-by: Paul Moore <paul@paul-moore.com>

Thanks. There's also this follow-on patch (and discussion thread) that
adds a fix to the 1/2 patch linked above.

https://lkml.org/lkml/2016/8/9/876

thanks
-john
