Message-ID: <4B710A1E.10205@ak.jp.nec.com>
Date: Tue, 09 Feb 2010 16:09:18 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        KaiGai Kohei <kaigai@kaigai.gr.jp>
Subject: Re: [PATCH][RFC] selinux: fix a couple of sparse warnings
References: <alpine.LRH.2.00.1002081013130.25332@tundra.namei.org>
In-Reply-To: <alpine.LRH.2.00.1002081013130.25332@tundra.namei.org>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(2010/02/08 8:14), James Morris wrote:
> Please review.
> 
> These warnings were introduced in commit
> 44c2d9bdd7022ca7d240d5adc009296fc1c6ce08

Please wait for a few days more.

It might be the right answer to revert this commit, not fixing
compiler warning.

http://marc.info/?l=selinux&m=126569829629708&w=2

> ----
> 
> 
>      selinux: fix a couple of sparse warnings
> 
>      Fix a couple of sparse warnings for callers of
>      context_struct_to_string, which takes a *u32, not an *int.
> 
>      These cases are harmless as the values are not used.
> 
>      Signed-off-by: James Morris<jmorris@namei.org>
> 
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 4e976f5..0e5c3a4 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -455,7 +455,8 @@ static void security_dump_masked_av(struct context *scontext,
>   	char *scontext_name = NULL;
>   	char *tcontext_name = NULL;
>   	char *permission_names[32];
> -	int index, length;
> +	int index;
> +	u32 length;
>   	bool need_comma = false;
> 
>   	if (!permissions)
> @@ -807,7 +808,7 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
>   	if (rc) {
>   		char *old_name = NULL;
>   		char *new_name = NULL;
> -		int length;
> +		u32 length;
> 
>   		if (!context_struct_to_string(old_context,
>   					&old_name,&length)&&
> 
> 
> 


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
