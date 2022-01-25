Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D9CC433FE
	for <selinux@archiver.kernel.org>; Tue, 25 Jan 2022 15:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358508AbiAYPJI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Jan 2022 10:09:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58272 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1581371AbiAYPGx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Jan 2022 10:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643123210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YSK5U80LtjEj9FEsCEHJ0Vn2ufnGDAvqNCrOj3BjcgY=;
        b=ZQk0v+00IBmUKIkZD46wpNAnbUdYdmKhJtOQ7MdU3iUmOrUivPLQsqx6urJ5/VE2rUfS6f
        +t6lPWFXywMeXKoeE+kHnV9mZaGRY1gDIqKjlXYogncvwNZklM0tENMsFdnKbDtjHm9fga
        sdoA37W7UWxLyz7dsZdaDYtJnbiLxaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-SvPAo93nNOKv1pxMmqrygg-1; Tue, 25 Jan 2022 10:06:47 -0500
X-MC-Unique: SvPAo93nNOKv1pxMmqrygg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F67281C49A;
        Tue, 25 Jan 2022 15:06:45 +0000 (UTC)
Received: from localhost (unknown [10.40.195.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB53B7E131;
        Tue, 25 Jan 2022 15:06:44 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Johannes Segitz <jsegitz@suse.de>,
        Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH] libselinux: Cached security context not accurate
In-Reply-To: <20220124085113.GC5813@suse.com>
References: <20220121084012.GS7643@suse.com>
 <CAJ2a_Ded5vUji+FmPZ0F09aZ_QGzk_aSAVKiejbAkwJNcPfEDg@mail.gmail.com>
 <20220124085113.GC5813@suse.com>
Date:   Tue, 25 Jan 2022 16:06:43 +0100
Message-ID: <877danua64.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Johannes Segitz <jsegitz@suse.de> writes:

> On Fri, Jan 21, 2022 at 01:06:16PM +0100, Christian G=C3=B6ttsche wrote:
>> Wouldn't it make logically more sense to first check if pid is zero
>> and then check if the cache is set, cause we never want to access the
>> cache if not operating on out own process?
>
> Yes, I changed that
>
>> Also isn't setprocattrcon_raw() affected too?
>
> Of course. I managed to attach the wrong file that only had the change for
> getprocattrcon_raw. Attached is the full patch

Hello,

thanks for the patch. I have only comments on the format.

The best way how to send a patch to the mailing list is to use `git send-em=
ail`, e.g.

   $ git send-email --from=3D'Johannes Segitz <jsegitz@suse.de>' --to=3Dsel=
inux@vger.kernel.org --smtp-server=3Dyour.smtp.server --confirm=3Dauto -1

Also as stated in CONTRIBUTING.md, the patch description must have signed-o=
ff.
See
https://github.com/SELinuxProject/selinux/pull/336/checks?check_run_id=3D45=
59976491
for the guidance.


Petr

> Johannes
> --=20
> GPG Key                EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
> Subkey fingerprint:    250F 43F5 F7CE 6F1E 9C59  4F95 BC27 DD9D 2CC4 FD66
> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nuernberg
> Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev (HRB 36809, AG N=C3=BCrnberg)
> Index: libselinux-3.3/src/procattr.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- libselinux-3.3.orig/src/procattr.c
> +++ libselinux-3.3/src/procattr.c
> @@ -148,7 +148,7 @@ static int getprocattrcon_raw(char ** co
>  			return -1;
>  	}
>=20=20
> -	if (prev_context && prev_context !=3D UNSET) {
> +	if (pid =3D=3D 0 && prev_context && prev_context !=3D UNSET) {
>  		*context =3D strdup(prev_context);
>  		if (!(*context)) {
>  			return -1;
> @@ -242,9 +242,9 @@ static int setprocattrcon_raw(const char
>  			return -1;
>  	}
>=20=20
> -	if (!context && !*prev_context)
> +	if (pid =3D=3D 0 && !context && !*prev_context)
>  		return 0;
> -	if (context && *prev_context && *prev_context !=3D UNSET
> +	if (pid =3D=3D 0 && context && *prev_context && *prev_context !=3D UNSET
>  	    && !strcmp(context, *prev_context))
>  		return 0;
>=20=20
> @@ -272,9 +272,11 @@ out:
>  		free(context2);
>  		return -1;
>  	} else {
> -		if (*prev_context !=3D UNSET)
> -			free(*prev_context);
> -		*prev_context =3D context2;
> +		if (pid =3D=3D 0) {
> +			if (*prev_context !=3D UNSET)
> +				free(*prev_context);
> +			*prev_context =3D context2;
> +		}
>  		return 0;
>  	}
>  }

