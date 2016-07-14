Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6EGUEL0014785
 for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2016 12:30:16 -0400
Subject: Re: [PATCH] security: Use IS_ENABLED() instead of checking for
 built-in or module
To: Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-kernel@vger.kernel.org
References: <1468512050-26272-1-git-send-email-javier@osg.samsung.com>
 <adc7dca8-9685-c9f0-7d61-d3537963cf6f@schaufler-ca.com>
 <3f0053fa-8824-f86f-e04f-16ad1204abc7@osg.samsung.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
 linux-security-module@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 James Morris <james.l.morris@oracle.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <37a0011d-b32f-d24b-3771-f6eb6cae5342@schaufler-ca.com>
Date: Thu, 14 Jul 2016 09:30:07 -0700
MIME-Version: 1.0
In-Reply-To: <3f0053fa-8824-f86f-e04f-16ad1204abc7@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On 7/14/2016 9:20 AM, Javier Martinez Canillas wrote:
> Hello Casey,
>
> On 07/14/2016 12:17 PM, Casey Schaufler wrote:
>> On 7/14/2016 9:00 AM, Javier Martinez Canillas wrote:
>>> The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
>>> built-in or as a module, use that macro instead of open coding the same.
>> Why?
>>
> Why not? We have a macro for this so why is better to open coding it?

Unless there is a real advantage to IS_ENABLED() over ifdef there
is no value in making the change. Any change can introduce a problem,
so we don't make changes based on "why not". It's called code churn.


>
> Best regards,
