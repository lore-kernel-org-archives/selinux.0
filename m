From: Paul Moore <paul.moore@hp.com>
To: tmiller@tresys.com
Subject: Re: [patch 0/2] policy capability support
Date: Wed, 5 Dec 2007 14:21:39 -0500
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jbrindle@tresys.com
References: <20071205184848.180973622@tresys.com>
In-Reply-To: <20071205184848.180973622@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712051421.39624.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 05 December 2007 1:48:48 pm tmiller@tresys.com wrote:
> This is a respin of the policy capability support patch that preserves
> the policycaps in the final policy binary and includes support for
> displaying policy caps in dispol/dismod.

Thanks, I'm trying to take care of some more IPsec auditing stuff right now 
but I'll give this patch a quick try tomorrow and let you know what happens.

> I still need to address the equivalence vs. union issue.

The discussion for this appears to have gone quiet (at least I haven't seen 
anything else on this list).  Where do things currently stand?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
