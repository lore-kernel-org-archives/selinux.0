Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAF22E5B2D
	for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982378; cv=pass; b=F3E5vH0Mh8bOzl5GGRyTZVag23PorNH5JGIpO8DV8jmye5ChxpdZvSrNKBOQj+RwL7jXMnl34WlL9/PyHvVg9EjIiOsu+jVd1wFhPikJXIdTpY4KtPfxWyyMGecX/lrbpb03zByoWjokCzOW6RETV+aAW/uSLl6cXbbsH0icAwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982378; c=relaxed/simple;
	bh=sDnFcWAmn4obUi+S2Zvl5YioXEcpUNKy0vwyHW8HP7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnQc08LbZJ5dspGWzKX4Chth9UUFIPVpymuqK1u02l8zcrWuHpO2qejnzg0VkkAitzdu7Ppj3ST4MzcUvuT/jvMNyXi4AWWUh36VBOdoxlpEuVuEk6hjSNplB+uRQTj4xTFn+clH7gYX4DYGYa8SOAfe0hgZaklvEqbuRuke59A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hv/MAafT; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv/MAafT"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6740e7ae219so3190581d50.1
        for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 05:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791982327; cv=none;
        d=google.com; s=arc-20260327;
        b=INiVCxlbi1bJSWuE1Mb+JkxVlt1r+3Eb+uK3kxXfTObw6vyd8OQtUE9dguDcMzleY7
         1CGOr1qPs0BZYOxuwNI00dGEdAHt8Lo5jI91pyax7Tq+94/iTSmnY9QYIkEL5YD+ICLR
         b60+wxUFsBZEmxYueQXHm4LsmNibXU1op28PamJw1VzX3Swwts7ymme6d+0mVwcRCZJd
         KNRPZMD/Ms3EsiJeQhBaHSo2Xul45h1o8RvvXa85Y5i41YL0ZPugBA634lml6AtlOPlF
         Jg7xx7ymK7mrvoccoiQGXKeqE15dLe4g3PeCIqKCzwS2PuzO91eMQvMMD1b7gBknrqGr
         Z2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sDnFcWAmn4obUi+S2Zvl5YioXEcpUNKy0vwyHW8HP7c=;
        fh=9CvfyTln6mlGi4sBe9JH0kMBicdx1bffQat4jneQZt8=;
        b=C8uMm5/UW95WhUN7UZZPDdjfVO1AEdWT07i3a0BIPNcdx5SAB2FgXsOIzwhVvy4NUk
         aFaCOH19YnoFzugw0L4GRTGFQ1sSCqCuQv9VidjmbFXxKzvwWcgp+rk669NTxo1Ngfon
         uTIHk2JhFh++pSUSoU0a/8oCBaJrIz+zZAjLTENxedQoAIgsWIcMebbfP9i+wazYRS46
         BgrepTehYcBYtPJvxXisVKTk6idvcNQLpmjeVzXXkiAH0VyqaBAZnfE6UTImexrevvC3
         R2zv3sfU1JLDBFqeAbBNeFXEno/L3GI8OoeRTpHpbc/pVrUfIiGInS20nafWuLqxsd9u
         nLtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791982327; x=1792587127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sDnFcWAmn4obUi+S2Zvl5YioXEcpUNKy0vwyHW8HP7c=;
        b=Hv/MAafTG3nui6a/7yxXiuLFdG/ms20CL99BaQbYF8bojDrxJIq8Vex0EtkZH+HGRB
         d7pwy6wVY5I3SxzZAsBbUmb1ssJd6XbzAeFs93Zloi3u7x87DOpyIkiMJWRT0+qu4lF6
         YdYvWEmE+Xh1et1tVyQvNDFwhZvlJcAzxMD0yBTxKg+FfCehtMrPfGimKA9bc4xxaeqb
         GNcEOk/kKmYKLvqh4AA24cGEquZ90xT65QLl2qENi5lf0AzcxMtStwbkoxg9RUIbEU+E
         HJ/Y94eGClaArW+CzPV6TQiQBfCSA+9uZZQEg0TX7Mw7IU3MfM1YVBGZ9+8BgNYSguYa
         5iJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791982327; x=1792587127;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sDnFcWAmn4obUi+S2Zvl5YioXEcpUNKy0vwyHW8HP7c=;
        b=znfrD9z4N09kuBbpNAsdwpMRIDhH9zz8rldMLstQyQ3snG580grHqlfRIb6AcAxzps
         Mm1FFlQuAtdUKj6zA7fc25BB4aYuoZsYkUDYTUA571CHUQxs3vD6VytyWPZdDgmYBtrp
         p2nXbCd6g53jDcbdCPxVNPDlL/NYepCuDsVSnFfEW1pkJsfiLp923/o1Y0U73p2HJH5T
         cbEWCptscC9EkM8r0a8fhULtb79gdZirIPwPTsv5vbRM26GhepM87uyzxg+gIdmj44Nb
         RQgHPcWzmtClRbqlLRZ9xatBf5Ig4X5XpznCm2sv0rNX2T9MTfnf0/kvTYhaBSghTx39
         MNPg==
X-Gm-Message-State: AFq9FYLlU4H/fZTLTB4/V+dAtUacN4Z4HInicrx3ubAQvuJsrbyp/A7q
	vYM0jQGifBFjtFETkExifzutc/D669iVnErxCipm0Vk65PpsROGKdHAnHvEij9+221nyWYr/KvO
	J0MmIN22zWN59/h3Iv8LU7RkWD0LYH0nY1UX0hSQ=
X-Gm-Gg: AYBFou11u17MCdiBUa0UiWqspmSeoxxdaH/d7zJBc9/qSLK6oSc+UM+ev6NRIgTmj/W
	KVO0ECEn+KIqbKcs+tjc0pmdVQJGaRQTgq9nJLYGJ50sR6SS3cC4LJ/QGDwMfQjAYeysJVGqgHi
	6hnYmcIPTzvS5tUlya7XniSSPlPvChnw/QIWh1ZEJshNyAbsFTRsa3NN2yFuwyI7U8AOmGNT/VH
	bKwb63c3bxX9yiqX3OuB6RoV46wvIG4FcGCXKd+1XzSdYtHCfGueQexHjCudndaAJV8N3oyETS5
	RFsdD7m2y4aqzfIjPqWUfqjkbEwB7Lmxg7ZnV4TrcZTT1ytaVDYF1tY=
X-Received: by 2002:a53:ba43:0:b0:677:c29d:4fa8 with SMTP id
 956f58d0204a3-679362ba447mr3926881d50.138.1791982326690; Wed, 14 Oct 2026
 05:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013154625.218930-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261013154625.218930-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 14 Oct 2026 08:51:55 -0400
X-Gm-Features: AclHuK9lTsvO3mjImW7uXJ7x-42ErzvdjjQYCTlVkFCIL8TzDijDHo98WfSX048
Message-ID: <CAEjxPJ5G_nwqSR0ZQou8-z9VACK2i5bk8HrOo47_0-K7BhMoKg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: compare policy_type, not policyvers, with POLICY_KERN
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 11:46=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The RULE_SELF checks in validate_avrules() and
> validate_filename_trans_rules() guard the SELF_TYPETRANS version test
> with p->policyvers !=3D POLICY_KERN, but POLICY_KERN is a policy_type
> value, not a version. Since POLICY_KERN is zero and policyvers is
> never zero, the current incorrect guard is always true.
>
> No functional change: both callers walk avrule_t lists that only carry
> RULE_SELF with AVRULE_TYPE / filename_trans on BASE/MOD policies,
> where either expression is true.
>
> Fixes: 1c91bc84 ("libsepol: reject self flag in type rules in old policie=
s")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This patch has been merged.
