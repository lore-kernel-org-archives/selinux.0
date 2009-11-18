Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAILqG0d031955
	for <selinux@tycho.nsa.gov>; Wed, 18 Nov 2009 16:52:16 -0500
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id nAILpEwQ026726
	for <selinux@tycho.nsa.gov>; Wed, 18 Nov 2009 21:51:14 GMT
Date: Wed, 18 Nov 2009 16:52:14 -0500
Subject: Re: [PATCH] [typo-fix]: cannnot -> cannot and suport -> support
From: Chad Sellers <csellers@tresys.com>
To: Manoj Srivastava <srivasta@golden-gryphon.com>, <selinux@tycho.nsa.gov>
CC: Manoj Srivastava <srivasta@debian.org>
Message-ID: <C729D6BE.AFF77%csellers@tresys.com>
In-Reply-To: <1258475277-10977-1-git-send-email-srivasta@golden-gryphon.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/17/09 11:27 AM, "Manoj Srivastava" <srivasta@golden-gryphon.com>
wrote:

> From: Manoj Srivastava <srivasta@debian.org>
> 
> This was reported after a lintian check found this on any package
> linked with libsepol.  Closes: #556390
> 
> Signed-off-by: Manoj Srivastava <srivasta@debian.org>
> ---
>  src/write.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/write.c b/src/write.c
> index 9906e35..00c605f 100644
> --- a/src/write.c
> +++ b/src/write.c
> @@ -1000,7 +1000,7 @@ static int type_write(hashtab_key_t key, hashtab_datum_t
> datum, void *ptr)
> buf[items++] = cpu_to_le32(typdatum->flags);
> else if (typdatum->flags & TYPE_FLAGS_PERMISSIVE)
> WARN(fp->handle, "Warning! Module policy "
> -         "version %d cannnot suport permissive "
> +         "version %d cannot support permissive "
>     "types, but one was defined",
>     p->policyvers);
> }

Acked-by: Chad Sellers <csellers@tresys.com>

Merged as of libsepol 2.0.41


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
