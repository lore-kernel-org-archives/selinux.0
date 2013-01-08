Message-ID: <50EC3644.2000600@tycho.nsa.gov>
Date: Tue, 08 Jan 2013 10:07:48 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Alice Chu <alice.chu@sta.samsung.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Subject: Re: Fixing external/checkpolicy issues found by Klocwork
References: <C1432A7484D61749AF22A060C2B03C5D1632046A18@StaEx7mb3.telecom.sna.samsung.com>
In-Reply-To: <C1432A7484D61749AF22A060C2B03C5D1632046A18@StaEx7mb3.telecom.sna.samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 01/07/2013 08:29 PM, Alice Chu wrote:
> Hello,
>
> Attached you will find the Klocwork report on seandroid master branch external/checkpolicy. The following is the fix for issues found in policy_define.c.
> Please review and give me your feedback.
>
> Thank you very much,
> Alice Chu
>
> ============================================================================
>>From 18555451c5831fd95044e665d3dc514eb69e3b75 Mon Sep 17 00:00:00 2001
> From: Alice Chu <alice.chu@sta.samsung.com>
> Date: Mon, 7 Jan 2013 15:29:29 -0800
> Subject: [PATCH] Fix issues found by Klocwork
>
> Change-Id: Ic3a01364b6855529f6b58a8820c6011a22c21841
> ---
>   policy_define.c |   24 +++++++++++++++++++-----
>   1 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/policy_define.c b/policy_define.c
> index 2c12447..504af69 100644
> --- a/policy_define.c
> +++ b/policy_define.c
> @@ -3583,6 +3591,11 @@ static int parse_security_context(context_struct_t * c)
>   	}
>
>   	context_init(c);
> +	/* check context c to make sure ok to dereference c later */
> +	if (c == NULL) {
> +		yyerror("null context pointer!");
> +		goto bad;
> +	}
>
>   	/* extract the user */
>   	id = queue_remove(id_queue);

I think you want this check before context_init(), as it dereferences c.
And then just return -1 in the error path.
This btw is an illegal state as NULL should only be passed if pass == 1.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
