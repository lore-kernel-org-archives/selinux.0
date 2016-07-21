Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6L5tJgk013444
 for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2016 01:55:19 -0400
Received: by mail-oi0-f54.google.com with SMTP id w18so103195066oiw.3
 for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2016 22:54:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.20.1607201612020.23817@namei.org>
References: <1468872671-9002-1-git-send-email-john.stultz@linaro.org>
 <1468872671-9002-2-git-send-email-john.stultz@linaro.org>
 <alpine.LRH.2.20.1607201612020.23817@namei.org>
From: John Stultz <john.stultz@linaro.org>
Date: Wed, 20 Jul 2016 22:54:53 -0700
Message-ID: <CALAqxLXx3kDWs2SzuEumaqK6=f6=dJYZMRMYA5urHgo7JDtqMg@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2 v3] security: Add
 task_settimerslack/task_gettimerslack LSM hook
To: James Morris <jmorris@namei.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Arjan van de Ven <arjan@linux.intel.com>,
 Oren Laadan <orenl@cellrox.com>, Ruchi Kandoi <kandoiruchi@google.com>,
 Rom Lemarchand <romlem@android.com>, Todd Kjos <tkjos@google.com>,
 Colin Cross <ccross@android.com>, Nick Kralevich <nnk@google.com>,
 Dmitry Shmidt <dimitrysh@google.com>, Elliott Hughes <enh@google.com>,
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

On Tue, Jul 19, 2016 at 11:12 PM, James Morris <jmorris@namei.org> wrote:
> On Mon, 18 Jul 2016, John Stultz wrote:
>
>> As requested, this patch implements a task_settimerslack and
>> task_gettimerslack LSM hooks so that the /proc/<tid>/timerslack_ns
>> interface can have finer grained security policies applied to it.
>>
>> I've kept the CAP_SYS_NICE check in the timerslack_ns_write/show
>> functions, as hiding it in the LSM hook seems too opaque, and doesn't
>> seem like a widely enough adopted practice.
>>
>
> I may have missed something in the earlier discussion, but why do we need
> new LSM hooks here vs. calling the existing set/getscheduler hooks?

Mostly since adding a new hook was suggested originally. I don't think
there's much difference as it stands, but I guess more fine grained
checks could be added on the slack amounts, etc.

I can rework it, so let me know if using the existing hooks would be
preferred, but otherwise I'll be sending out the non-rfc patches
tomorrow.

thanks
-john
