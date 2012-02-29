Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1TDbrPS008009
	for <selinux@tycho.nsa.gov>; Wed, 29 Feb 2012 08:37:53 -0500
Message-ID: <20120229133749.42296bdip7rs06os@webmail.tuffmail.net>
Date: Wed, 29 Feb 2012 13:37:49 +0000
From: Martin Orr <martin@martinorr.name>
To: Harry Ciao <qingtao.cao@windriver.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: [v1 PATCH 1/1] role_fix_callback skips out-of-scope roles
	during expansion.
References: <1330134008-3259-1-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1330134008-3259-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat Feb 25 01:40:08 2012, Harry Ciao wrote:

> If a role identifier is out of scope it would be skipped over during
> expansion, accordingly, be it a role attribute, it should be skipped
> over as well when role_fix_callback tries to propagate its capability
> to all its sub-roles.

Acked-by: Martin Orr <martin@martinorr.name>

This fixes my assertion failure with role attributes required by  
optional blocks in the base module.

> Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
> ---
>  libsepol/src/expand.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 493e478..befb720 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -688,6 +688,11 @@ static int role_fix_callback(hashtab_key_t key,  
> hashtab_datum_t datum,
>  		return 0;
>  	}
>
> +	if (!is_id_enabled(id, state->base, SYM_ROLES)) {
> +		/* identifier's scope is not enabled */
> +		return 0;
> +	}
> +
>  	if (role->flavor != ROLE_ATTRIB)
>  		return 0;
>
> --
> 1.7.0.4
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
