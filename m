Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6FIAYNv004013
 for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2016 14:10:34 -0400
Received: by mail-oi0-f42.google.com with SMTP id l72so28352739oig.2
 for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2016 11:10:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFJ0LnExf1L=JaGwW5=qyZsutVucx7b8f0Ti63oLB-NuMr20yA@mail.gmail.com>
References: <1468603460-17034-1-git-send-email-john.stultz@linaro.org>
 <1468603460-17034-2-git-send-email-john.stultz@linaro.org>
 <CAFJ0LnExf1L=JaGwW5=qyZsutVucx7b8f0Ti63oLB-NuMr20yA@mail.gmail.com>
From: John Stultz <john.stultz@linaro.org>
Date: Fri, 15 Jul 2016 11:10:32 -0700
Message-ID: <CALAqxLVQHvm5yQj=AY8akAcqSf0bXdmAFdYWC+gSCSDom4COBA@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2 v2] security: Add task_settimerslack LSM hook
To: Nick Kralevich <nnk@google.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Arjan van de Ven <arjan@linux.intel.com>,
 Oren Laadan <orenl@cellrox.com>, Ruchi Kandoi <kandoiruchi@google.com>,
 Rom Lemarchand <romlem@android.com>, Todd Kjos <tkjos@google.com>,
 Colin Cross <ccross@android.com>, Dmitry Shmidt <dimitrysh@google.com>,
 Elliott Hughes <enh@google.com>,
 Android Kernel Team <kernel-team@android.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On Fri, Jul 15, 2016 at 10:51 AM, Nick Kralevich <nnk@google.com> wrote:
> On Fri, Jul 15, 2016 at 10:24 AM, John Stultz <john.stultz@linaro.org> wrote:
>> As requested, this patch implements a task_settimerslack LSM hook
>> so that the /proc/<tid>/timerslack_ns interface can have finer
>> grained security policies applied to it.
>>
>> Don't really know what I'm doing here, so close review would be
>> appreciated!
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
>> Cc: Android Kernel Team <kernel-team@android.com>
>> Signed-off-by: John Stultz <john.stultz@linaro.org>
>> ---
>> v2: Initial swing at adding LSM hook
>>
>>  fs/proc/base.c            | 7 +++++++
>>  include/linux/lsm_hooks.h | 7 +++++++
>>  include/linux/security.h  | 6 ++++++
>>  security/security.c       | 7 +++++++
>>  security/selinux/hooks.c  | 6 ++++++
>>  5 files changed, 33 insertions(+)
>>
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index 8f4f8d7..7f10b37 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -2284,6 +2284,12 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
>>         if (!p)
>>                 return -ESRCH;
>>
>> +       err = security_task_settimerslack(current, slack_ns);
>
> The first argument should be "p", not "current". "p" is the target
> process you're trying to adjust.

Ah, yes. Thanks. Clearly I don't know what I'm doing here. :)
-john
