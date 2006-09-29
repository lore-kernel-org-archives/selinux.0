Message-ID: <451D4A51.4000603@hp.com>
Date: Fri, 29 Sep 2006 12:31:13 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <method@gentoo.org>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Subject: Re: [PATCH 7/7] secid reconciliation-v03: Enforcement for SELinux
References: <36282A1733C57546BE392885C0618592015CF2BE@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C0618592015CF2BE@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>I tend to agree, I just can't see it being all that useful in the real
>>world.  However, each time it comes up (including the conference call
>>earlier this week) it seems that people would prefer to use 
>>both at the
>>same time.
>  
> A matter of providing options to users.

As long as those options receive the blessings of the maintainers ;)

> It seems more of a pain to actually
> prevent their use at the same time and/or explain strange/unnatural
> behavior.

Agreed, the solution that we agreed upon is much easier to implement and
explain than a lot of the alternatives.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
