Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6FKKfS4020805
 for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2016 16:20:41 -0400
Received: by mail-yw0-f179.google.com with SMTP id v186so50359271ywd.0
 for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2016 13:20:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALAqxLWsjdzNeR3qB5gQhL1GHt1ukxTGzi7yjN2TDETLbyWKJw@mail.gmail.com>
References: <1468603460-17034-1-git-send-email-john.stultz@linaro.org>
 <CAFJ0LnGaKDEozyZnfrdC9a+c83UWhTg2Vrw0Xe+=eb2CO=h4yg@mail.gmail.com>
 <CALAqxLWsjdzNeR3qB5gQhL1GHt1ukxTGzi7yjN2TDETLbyWKJw@mail.gmail.com>
From: Nick Kralevich <nnk@google.com>
Date: Fri, 15 Jul 2016 13:20:38 -0700
Message-ID: <CAFJ0LnHHCxza7DZBWax3XuO1QH+YQCzBWecA2s2QaM9PCq_Ciw@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2 v2] proc: Relax /proc/<tid>/timerslack_ns
 capability requirements
To: John Stultz <john.stultz@linaro.org>
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

On Fri, Jul 15, 2016 at 1:03 PM, John Stultz <john.stultz@linaro.org> wrote:
> On Fri, Jul 15, 2016 at 12:55 PM, Nick Kralevich <nnk@google.com> wrote:
>> This should also have a similar LSM check for reads. For the SELinux
>> implementation, this can map to the PROCESS__GETSCHED permission.
>
> Ok. I'll wire that in as well.
>
> Would adding both selinux_task_get and set methods in the same patch
> be ok? Or would folks prefer they be split into two?

I would prefer 1 patch.


-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
