Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91551C433F5
	for <selinux@archiver.kernel.org>; Mon, 24 Jan 2022 08:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiAXIvR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Jan 2022 03:51:17 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40598 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbiAXIvQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Jan 2022 03:51:16 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C8E8B1F38F;
        Mon, 24 Jan 2022 08:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643014275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ndM2PCneOQnHFg2lbiPXLUu6OZEUwWl95nJ80j1d+DM=;
        b=jA/pQUEObDI49lmnnm97HIQjxMwqvCTwkjSefnsUIxf4x76lAobhmonGNmc5fef9vNfRWa
        WCL9OUzuWblT6koYfpKhtPUxjUOLHxm0nuwbWcZl8w8m8fWiAn5wNVmHqZQfHSqwKnxHDR
        TgSu3VcIn6UQPEyp3+W3B0X8+gDNKck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643014275;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ndM2PCneOQnHFg2lbiPXLUu6OZEUwWl95nJ80j1d+DM=;
        b=U71BmAIHY9QeLC0MeVWFrWAX22eiJMqkkpXJgEFeGLnydUfq1aQz/mfB6Vn8rJevzqYWJe
        Nv3E0WwvrSO5MHDA==
Received: from suse.com (unknown [10.163.42.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B2562A3B8A;
        Mon, 24 Jan 2022 08:51:15 +0000 (UTC)
Date:   Mon, 24 Jan 2022 09:51:13 +0100
From:   Johannes Segitz <jsegitz@suse.de>
To:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH] libselinux: Cached security context not accurate
Message-ID: <20220124085113.GC5813@suse.com>
References: <20220121084012.GS7643@suse.com>
 <CAJ2a_Ded5vUji+FmPZ0F09aZ_QGzk_aSAVKiejbAkwJNcPfEDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline
In-Reply-To: <CAJ2a_Ded5vUji+FmPZ0F09aZ_QGzk_aSAVKiejbAkwJNcPfEDg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--4zI0WCX1RcnW9Hbu
Content-Type: multipart/mixed; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 21, 2022 at 01:06:16PM +0100, Christian G=F6ttsche wrote:
> Wouldn't it make logically more sense to first check if pid is zero
> and then check if the cache is set, cause we never want to access the
> cache if not operating on out own process?

Yes, I changed that

> Also isn't setprocattrcon_raw() affected too?

Of course. I managed to attach the wrong file that only had the change for
getprocattrcon_raw. Attached is the full patch

Johannes
--=20
GPG Key                EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
Subkey fingerprint:    250F 43F5 F7CE 6F1E 9C59  4F95 BC27 DD9D 2CC4 FD66
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nuernberg
Gesch=E4ftsf=FChrer: Ivo Totev (HRB 36809, AG N=FCrnberg)

--5QAgd0e35j3NYeGe
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="libselinux_procattr_cache.patch"
Content-Transfer-Encoding: quoted-printable

Index: libselinux-3.3/src/procattr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- libselinux-3.3.orig/src/procattr.c
+++ libselinux-3.3/src/procattr.c
@@ -148,7 +148,7 @@ static int getprocattrcon_raw(char ** co
 			return -1;
 	}
=20
-	if (prev_context && prev_context !=3D UNSET) {
+	if (pid =3D=3D 0 && prev_context && prev_context !=3D UNSET) {
 		*context =3D strdup(prev_context);
 		if (!(*context)) {
 			return -1;
@@ -242,9 +242,9 @@ static int setprocattrcon_raw(const char
 			return -1;
 	}
=20
-	if (!context && !*prev_context)
+	if (pid =3D=3D 0 && !context && !*prev_context)
 		return 0;
-	if (context && *prev_context && *prev_context !=3D UNSET
+	if (pid =3D=3D 0 && context && *prev_context && *prev_context !=3D UNSET
 	    && !strcmp(context, *prev_context))
 		return 0;
=20
@@ -272,9 +272,11 @@ out:
 		free(context2);
 		return -1;
 	} else {
-		if (*prev_context !=3D UNSET)
-			free(*prev_context);
-		*prev_context =3D context2;
+		if (pid =3D=3D 0) {
+			if (*prev_context !=3D UNSET)
+				free(*prev_context);
+			*prev_context =3D context2;
+		}
 		return 0;
 	}
 }

--5QAgd0e35j3NYeGe--

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEJQ9D9ffObx6cWU+VvCfdnSzE/WYFAmHuaIEACgkQvCfdnSzE
/WZ4exAAxJFUg3qgTB4bVon//r312wCAnkk8UL5ZVts/PIYM3YY1uJ4ioCdxXiHw
DhN/OyQbd37bpZ4+erTWg1Y8ZdrVZgDrbqGX6sbCBRnPoZFczbKPcGh+Yuj2X9ic
HMksFg2i5vASSHaXnHzeEQSnXKRqQhFdWNbYo1GpiMjceZLJB5J0cHrcW1yxUtxr
W8iJAQ2QX3GIFCh2BfVUKCAgU08MBCkOBCPt3XhGYBCBQrtvA//1xo320BRXn3Ax
ktAb01kIHPXOLcYJ4FnyLKz11RFAOLnsSkR2nkmuzVIf6+8f/sPeC9VHoz3XBZrs
leeTp998Xtlp9KLXCwnA1E8nM7ZyWc6zu5R3+DtNsdTMeS9y20gO5uvoc8Wrvm9b
OQO57XHHRUrT29mbH7IlGax4dUIf6o0RvzS2Uhqcl/MY3/UfbT1mJ/ZG6ZsVEBat
i85VsLU9EupcAcjwlsE368phRX+HbCmFz6KswTUZoFZLwxeh72MhpyD2BqYJwArl
FdHw0aIVr4wjyKysoqzVNfEOtY0Ot0TUCy3fEEsACTKQ86YKzP2Tp7hBjQ7XPglv
V2QxMRKJ2WCEKWCStegALcfkoMFVxKDzS9q9No+FofugUSt27nh1/5qmY1Bbx/zu
JbQt+sRlBNvVFnZazPJucIoYvYYjk+OFeqKT0HlpgF7QIGPGn3Q=
=QPJX
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
