Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6EJwMOB009207
 for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2016 15:58:22 -0400
Received: by mail-oi0-f65.google.com with SMTP id c199so7584599oig.1
 for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2016 12:57:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <37a0011d-b32f-d24b-3771-f6eb6cae5342@schaufler-ca.com>
References: <1468512050-26272-1-git-send-email-javier@osg.samsung.com>
 <adc7dca8-9685-c9f0-7d61-d3537963cf6f@schaufler-ca.com>
 <3f0053fa-8824-f86f-e04f-16ad1204abc7@osg.samsung.com>
 <37a0011d-b32f-d24b-3771-f6eb6cae5342@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 Jul 2016 15:57:35 -0400
Message-ID: <CAHC9VhSgTSEKhis2j6vBKa1Wejg65BLmMOC40iyCwMWjerV_Xw@mail.gmail.com>
Subject: Re: [PATCH] security: Use IS_ENABLED() instead of checking for
 built-in or module
To: Casey Schaufler <casey@schaufler-ca.com>,
 Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 James Morris <james.l.morris@oracle.com>
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

On Thu, Jul 14, 2016 at 12:30 PM, Casey Schaufler
<casey@schaufler-ca.com> wrote:
> On 7/14/2016 9:20 AM, Javier Martinez Canillas wrote:
>> Hello Casey,
>>
>> On 07/14/2016 12:17 PM, Casey Schaufler wrote:
>>> On 7/14/2016 9:00 AM, Javier Martinez Canillas wrote:
>>>> The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
>>>> built-in or as a module, use that macro instead of open coding the same.
>>> Why?
>>
>> Why not? We have a macro for this so why is better to open coding it?
>
> Unless there is a real advantage to IS_ENABLED() over ifdef there
> is no value in making the change. Any change can introduce a problem,
> so we don't make changes based on "why not". It's called code churn.

I think the IS_ENABLED() macro makes the code more readable by helping
abstract away some of the Kconfig/module details; not to mention it
provides some insulation from Kconfig changes (although I suppose it
is doubtful this will be a real issue anytime soon).

Javier, if you want to respin this patch without the Smack changes
I'll merge it into the SELinux tree (not for the v4.8 merge window,
but for the next merge window).  However, if Casey changes his mind
and ACKs this patch, I'll go ahead and merge the original patch.

-- 
paul moore
www.paul-moore.com
