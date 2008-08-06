Date: Thu, 7 Aug 2008 09:47:23 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Vesa-Matti Kari <vmkari@cc.helsinki.fi>
cc: sds@tycho.nsa.gov, eparis@parisplace.org, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: conditional expression type validation was
 off-by-one
In-Reply-To: <200808061546.m76Fkwq1005199@ruuvi.it.helsinki.fi>
Message-ID: <alpine.LRH.1.10.0808070945400.15561@tundra.namei.org>
References: <200808061546.m76Fkwq1005199@ruuvi.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 6 Aug 2008, Vesa-Matti Kari wrote:

> expr_isvalid() in conditional.c was off-by-one and allowed
> invalid expression type COND_LAST. However, it is this header file
> that needs to be fixed. That way the if-statement's disjunction's
> second component reads more naturally, "if expr type is greater than
> the last allowed value" ( rather than using ">=" in conditional.c):
> 
>   if (expr->expr_type <= 0 || expr->expr_type > COND_LAST)
> 
> Signed-off-by: Vesa-Matti Kari <vmkari@cc.helsinki.fi>

Thanks, nice catch.

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
