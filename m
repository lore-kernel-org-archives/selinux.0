Subject: Re: [PATCH] labeled-ipsec-policy: Cleanup
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
In-Reply-To: <4554FEE5.9060200@trustedcs.com>
References: <4554FEE5.9060200@trustedcs.com>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 08:35:48 -0500
Message-Id: <1163684148.7374.16.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-11-10 at 16:36 -0600, Venkat Yekkirala wrote:
> This modifies the mls constraint for polmatch in the association class.
> Specifically:
> 
> - polmatch need no longer make an exception for unlabeled_t
>   since a flow will now always match SPD rules with no contexts (per
>   the IPSec leak fix patch upstreamed a few weeks back), as
>   opposed to needing polmatch access to unlabeled_t.
> 
> Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
