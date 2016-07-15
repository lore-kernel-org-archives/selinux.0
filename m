Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6FIubal009407
 for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2016 14:56:37 -0400
Received: by mail-wm0-f46.google.com with SMTP id f65so36277268wmi.0
 for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2016 11:56:35 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CALAqxLW6kzj06jsurWb=3YLAa7r__+5aEAfKH50zcpt0s_u-Aw@mail.gmail.com>
References: <1468603460-17034-1-git-send-email-john.stultz@linaro.org>
 <CAFJ0LnEBDjZyHb1cBr6Wck9c_z1ATcfnmWtOTYBS2F0TEK5_vA@mail.gmail.com>
 <CALAqxLW6kzj06jsurWb=3YLAa7r__+5aEAfKH50zcpt0s_u-Aw@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 15 Jul 2016 11:56:33 -0700
Message-ID: <CAGXu5jKPu2pwgPdGmRdTad3eLrDPYSkj8u2VT7CCk5zNSexQTw@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2 v2] proc: Relax /proc/<tid>/timerslack_ns
 capability requirements
To: John Stultz <john.stultz@linaro.org>, James Morris <jmorris@namei.org>,
 Casey Schaufler <casey@schaufler-ca.com>
Cc: Nick Kralevich <nnk@google.com>, lkml <linux-kernel@vger.kernel.org>,
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

On Fri, Jul 15, 2016 at 11:42 AM, John Stultz <john.stultz@linaro.org> wrote:
> On Fri, Jul 15, 2016 at 10:51 AM, Nick Kralevich <nnk@google.com> wrote:
>> On Fri, Jul 15, 2016 at 10:24 AM, John Stultz <john.stultz@linaro.org> wrote:
>>> +       if (!capable(CAP_SYS_NICE))
>>> +               return -EPERM;
>>> +
>>
>> Since you're going the LSM route (from your second patch of this
>
> Well, you suggested it, so I sent out an RFC. I'm not married to it yet. :)
>
>
>> series), the capability check above should be moved to the LSM hook in
>> security/commoncap.c.  Only one security call to
>> security_task_settimerslack is needed, which will cover the standard
>> capabilities check as well as the SELinux check.
>
> Huh. Ok. I was looking at the implementation of nice(), which does:
>
>  if (increment < 0 && !can_nice(current, nice))
>                 return -EPERM;
> retval = security_task_setnice(current, nice);
> if (retval)
> ...
>
> Which made it seem like standard checks are done first, then finer
> grain lsm checks second.

I'm on the fence about this: it can be argued that if it's a cap check
it should live in the commoncap.c checks, but most of our cap checks
for these kinds of access controls are directly in the function, prior
the the security_* calls. I've added James and Casey who may have a
more well constructed rationale for doing this one way or the other.

> (...and now you can guess where my accidental "current" usage in the
> next patch came from :)
>
>
>>
>>>         p = get_proc_task(inode);
>>>         if (!p)
>>>                 return -ESRCH;
>>>
>>
>> Per your patch #2, you'd call security_task_settimerslack here. This
>> would call into the capability LSM hook you added in
>> security/commoncap.c
>
> Though I was hoping to keep the CAP_SYS_PTRACE -> CAP_SYS_NICE change
> first, then add the LSM hooks, as it makes the needed ABI change more
> obvious. I worry swapping it around with the LSM hook being added
> first makes it significantly less obvious, as (at least for me) the
> security_task_* functions get indirect and difficult to follow quickly
> ("wait, why are we checking SETSCHED for nice?").
>
> A side curiosity: why does "git grep PROCESS__SETSCHED" miss the
> definition? Is the av_permissions.h file somehow caught by .gitignore?
>
> thanks
> -john

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
