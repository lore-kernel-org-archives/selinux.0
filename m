Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6FIghra008036
 for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2016 14:42:43 -0400
Received: by mail-oi0-f51.google.com with SMTP id j185so169168347oih.0
 for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2016 11:42:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFJ0LnEBDjZyHb1cBr6Wck9c_z1ATcfnmWtOTYBS2F0TEK5_vA@mail.gmail.com>
References: <1468603460-17034-1-git-send-email-john.stultz@linaro.org>
 <CAFJ0LnEBDjZyHb1cBr6Wck9c_z1ATcfnmWtOTYBS2F0TEK5_vA@mail.gmail.com>
From: John Stultz <john.stultz@linaro.org>
Date: Fri, 15 Jul 2016 11:42:36 -0700
Message-ID: <CALAqxLW6kzj06jsurWb=3YLAa7r__+5aEAfKH50zcpt0s_u-Aw@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2 v2] proc: Relax /proc/<tid>/timerslack_ns
 capability requirements
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
>> +       if (!capable(CAP_SYS_NICE))
>> +               return -EPERM;
>> +
>
> Since you're going the LSM route (from your second patch of this

Well, you suggested it, so I sent out an RFC. I'm not married to it yet. :)


> series), the capability check above should be moved to the LSM hook in
> security/commoncap.c.  Only one security call to
> security_task_settimerslack is needed, which will cover the standard
> capabilities check as well as the SELinux check.

Huh. Ok. I was looking at the implementation of nice(), which does:

 if (increment < 0 && !can_nice(current, nice))
                return -EPERM;
retval = security_task_setnice(current, nice);
if (retval)
...

Which made it seem like standard checks are done first, then finer
grain lsm checks second.

(...and now you can guess where my accidental "current" usage in the
next patch came from :)


>
>>         p = get_proc_task(inode);
>>         if (!p)
>>                 return -ESRCH;
>>
>
> Per your patch #2, you'd call security_task_settimerslack here. This
> would call into the capability LSM hook you added in
> security/commoncap.c

Though I was hoping to keep the CAP_SYS_PTRACE -> CAP_SYS_NICE change
first, then add the LSM hooks, as it makes the needed ABI change more
obvious. I worry swapping it around with the LSM hook being added
first makes it significantly less obvious, as (at least for me) the
security_task_* functions get indirect and difficult to follow quickly
("wait, why are we checking SETSCHED for nice?").

A side curiosity: why does "git grep PROCESS__SETSCHED" miss the
definition? Is the av_permissions.h file somehow caught by .gitignore?

thanks
-john
