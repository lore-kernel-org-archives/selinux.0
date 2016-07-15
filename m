Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6FKHbUU020152
 for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2016 16:17:37 -0400
Subject: Re: [RFC][PATCH 1/2 v2] proc: Relax /proc/<tid>/timerslack_ns
 capability requirements
To: Kees Cook <keescook@chromium.org>, John Stultz <john.stultz@linaro.org>,
 James Morris <jmorris@namei.org>
References: <1468603460-17034-1-git-send-email-john.stultz@linaro.org>
 <CAFJ0LnEBDjZyHb1cBr6Wck9c_z1ATcfnmWtOTYBS2F0TEK5_vA@mail.gmail.com>
 <CALAqxLW6kzj06jsurWb=3YLAa7r__+5aEAfKH50zcpt0s_u-Aw@mail.gmail.com>
 <CAGXu5jKPu2pwgPdGmRdTad3eLrDPYSkj8u2VT7CCk5zNSexQTw@mail.gmail.com>
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
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <78837e66-e905-4d8f-3b41-c3ac0e86e67d@schaufler-ca.com>
Date: Fri, 15 Jul 2016 13:17:28 -0700
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKPu2pwgPdGmRdTad3eLrDPYSkj8u2VT7CCk5zNSexQTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On 7/15/2016 11:56 AM, Kees Cook wrote:
> On Fri, Jul 15, 2016 at 11:42 AM, John Stultz <john.stultz@linaro.org> wrote:
>> On Fri, Jul 15, 2016 at 10:51 AM, Nick Kralevich <nnk@google.com> wrote:
>>> On Fri, Jul 15, 2016 at 10:24 AM, John Stultz <john.stultz@linaro.org> wrote:
>>>> +       if (!capable(CAP_SYS_NICE))
>>>> +               return -EPERM;
>>>> +
>>> Since you're going the LSM route (from your second patch of this
>> Well, you suggested it, so I sent out an RFC. I'm not married to it yet. :)
>>
>>
>>> series), the capability check above should be moved to the LSM hook in
>>> security/commoncap.c.  Only one security call to
>>> security_task_settimerslack is needed, which will cover the standard
>>> capabilities check as well as the SELinux check.
>> Huh. Ok. I was looking at the implementation of nice(), which does:
>>
>>  if (increment < 0 && !can_nice(current, nice))
>>                 return -EPERM;
>> retval = security_task_setnice(current, nice);
>> if (retval)
>> ...
>>
>> Which made it seem like standard checks are done first, then finer
>> grain lsm checks second.
> I'm on the fence about this: it can be argued that if it's a cap check
> it should live in the commoncap.c checks, but most of our cap checks
> for these kinds of access controls are directly in the function, prior
> the the security_* calls. I've added James and Casey who may have a
> more well constructed rationale for doing this one way or the other.

Let's say that at some point in the future someone wanted to replace
POSIX capabilities with some other privilege scheme[1]. Having as much
of the capability checking hooked in via the LSM infrastructure would
be a big help. On the other hand, there's a lot to be said for locality
of reference, and having the capability check off in another place may
make it harder to understand what's going on.

I don't object to either approach. If I have a recommendation it's to
put it in commoncap.c and hook it in on the off chance that the capability
model will implode after the next round of "improvements". Or if someone
comes up with a really spiffy alternative.

[1] Some years ago I offered to make a proposal for a customizable
    privilege scheme, but failed to deliver. Could it be as simple
    as providing a replacement for commoncap.c? I don't think so,
    because the cap calls are not positioned generically, they are
    placed based on the assumptions of the capability mechanism.
    On the other hand, A little hard work goes a long way to fixing
    that sort of problem.

>
>> (...and now you can guess where my accidental "current" usage in the
>> next patch came from :)
>>
>>
>>>>         p = get_proc_task(inode);
>>>>         if (!p)
>>>>                 return -ESRCH;
>>>>
>>> Per your patch #2, you'd call security_task_settimerslack here. This
>>> would call into the capability LSM hook you added in
>>> security/commoncap.c
>> Though I was hoping to keep the CAP_SYS_PTRACE -> CAP_SYS_NICE change
>> first, then add the LSM hooks, as it makes the needed ABI change more
>> obvious. I worry swapping it around with the LSM hook being added
>> first makes it significantly less obvious, as (at least for me) the
>> security_task_* functions get indirect and difficult to follow quickly
>> ("wait, why are we checking SETSCHED for nice?").
>>
>> A side curiosity: why does "git grep PROCESS__SETSCHED" miss the
>> definition? Is the av_permissions.h file somehow caught by .gitignore?
>>
>> thanks
>> -john
> -Kees
>
