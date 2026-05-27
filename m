Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24D3644BE
	for <selinux@vger.kernel.org>; Wed, 27 May 2026 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779908980; cv=pass; b=BGVbNEBO4rrwIaknj+dNGCOHOK3sJ/yeTx2zTIg8mO9rXdgK6LyLdl0kkRQc6GwqTgyXte8n9BiOxityz/EA2GocO4b3QKu0V0m3K02XERILPjYyNLQmcl/tCFf/wFMeoLC5UoKc2esrRFh3t3TW1S+Y/W+HSfPvinzL4fopxEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779908980; c=relaxed/simple;
	bh=CxLPdShtDK2PrizQifxPfaipn4IXThJs5iKE9/OJdJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3qt2e3KzAqrz6cvXUgTXA8RQual2U2XZegD7wQ8Mf5mgKf6poRnBeoMZtmVYsOaQaOa+MDwz1p3C5DlbH45pmEyuY9qFiyI5PauF2HDNYgRUDJ2zW/OkWlchZzqQVnfcrg69GeMECDMhL+Z5SNneoRDlW5qUlXALOCmThLtNaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrHGnkug; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrHGnkug"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b9ea536877so80396005ad.1
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 12:09:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779908978; cv=none;
        d=google.com; s=arc-20240605;
        b=NbMbexi3IFw0MqBIQjxm1u56BpYoM8QpAwdszkokNpWA6UBuyWaj5XhU7aImEAgBdv
         mqbDbUhGW9RyHwH0W+Sb6aB/cYKx2K+F0k1PqrvV89u+u3WUwmLqHUAQDaLTiCiT6Uov
         ZozhUJa68Yb2UnLsIkNR6ySprGTo6N7OsLLzKZaY1A0AK+SyHfhZI26y5nkYfuvuK27B
         Cwd9rOX54lNfkluKLvfDyImmlYq7ZDfMi/HBQHZm0+VmSoAaB0qhMuvu33VKPm5EHTzP
         h1/DokemMlLx15sltUs3RztgNIX1Kkgh2GcLSoxDi4y7GaLUDs2gTSkHmskkagb91MaO
         pPrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g5f+TfiKSv0L8RwXJVwIApWdmCoBhwgrsbzKwp14Eis=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=GNIE5nMo57ZLfWyWOWSsi1Ag8zBXlvHv5TTpE34pR/OAOY5Gr3AHhgHJvLDxFdmu1b
         svCBI+JmD37StfTajmWTuG+YSPID0uaLC5qwPOD+3gHFgrQJOGCqKLkcivbsQrLwaHv3
         rJFsQ0ZWnAb5akEDSbzT0HOR6K73NF3BupklcvD85fETqO/c8rPgb17Jx02b+XbC4Yze
         uMKOmizEzkeX6yEeQg7/FYDWn16mITsFB1QI2IXLEUQK5rC8B2RV2EIQsWJJUP9XAacb
         R/VBK0QxB5YVQPhb6S3VuWZKmEbYmLcVLQyLkIkSwmQ1+HmpoTyR3F/F8rzFHMruXT9a
         cIqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779908978; x=1780513778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5f+TfiKSv0L8RwXJVwIApWdmCoBhwgrsbzKwp14Eis=;
        b=QrHGnkugDdUcDXYcGTVIb517F6RKetSqmJX8U6n1A1ad29ajIJteQhe60o8DNUxX4+
         8FBNNGw5DdUrdgVJOMdT8hUVlJ4kvuu35CoV+DUpI4O0/E10OZEFhArIQxTI1+wxkPAT
         KSDrFriJUvWs46GKSyjmO3Rt+q7CrR1JQxgwubXn9v30A0y89IveQDqNxGb8su9cuEzm
         c7OntdEOGRWkOpoxmcIYEDphsmGD7rNzhdeC2kIhNAmhSivbLW2nUXNRJFMIXT1eDJJJ
         vzcVgL+XcS0KXAV4u7GAaahe1cbZCq3VmWp/tTdHLg3VHrmaA0vkDOCraPe8KOcfz6LS
         wRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779908978; x=1780513778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g5f+TfiKSv0L8RwXJVwIApWdmCoBhwgrsbzKwp14Eis=;
        b=IQiR4FvAC4PxkqD1X7rm8ZCsqniEgI+exj4pl4haBdV7j7zpThpH2KoHQ5CTwWdyZN
         R6StG7n7PmPVKZ2YfUVA0nMyO4RovruEGH3YHgvM+lMAE+yfdj+I5WXSw02bGIS0qC/C
         /gt4qbxBEW+rvEP3yM+pjpd8TGQDhGjxHRNWKzxaE0MV1u4leO7A86vZol4w+Y88XUsK
         NqB0QGnjGjwvH9yP/MTCaB4k8mEzQ+0V5PZVN+D05HFTo6q4SZyvwv7+SudmD3/R9gni
         oIjZAjgcAtnCla0+wEQO9y/9MFaxaeIhhjS+2QGjcRwRwBJeSlQ97roZlmpEgHnh5ZL9
         hj3A==
X-Gm-Message-State: AOJu0YzK5/rocOVZGkMOp+Z13gBROOsZzw4DYFv8/6mEptP2w3ZbLfF3
	oNOo6GcGRu0nfj1X5MkHJtSZtgAhw3Gq8FJDdO4rj+SLOF0B5wxRC38hriaBUffDjENgmYLWeKS
	po3u63NpKDaFwHt33n0o4C4gZafwvBhnV1YMq
X-Gm-Gg: Acq92OH/jYpThDsET4xvCNUu4xiCrLYcligA9l8pxeoC1z66awawB6I9WA7fRmtxjpf
	5hGnFvrSMaiG37gjtKkvYiS3EpTa19TGxo2sY/EpCTzxqL5nl1DdoMydS10nGpGKh84KHKkhhmp
	DR/3riDZdHY3eck3Xn7f7QvMVMWZE4DlXY2ccCXVqjUprQHxJQW/k93fJqM5aJ7M1QRZFPdLq7z
	MBGIews+kAq0RZDjKJeXn4dBXqkf3JVgIGU8nUGDJQjm7zOLKVu3m1KEO8QDFXhWUFGFfbCEuBR
	d4tRyItCSAKlWWAx62d/y2lysiaA
X-Received: by 2002:a17:903:1b0f:b0:2ae:5ab4:f4c0 with SMTP id
 d9443c01a7336-2beb085f72emr224572095ad.13.1779908977989; Wed, 27 May 2026
 12:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527153953.27606-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260527153953.27606-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 27 May 2026 15:09:26 -0400
X-Gm-Features: AVHnY4LYbZab5XoYlNhs4vz_1krfVRPmpmdZ1GM89fY6yTLvD0rjADRwu73Un_4
Message-ID: <CAEjxPJ4NnKopbaYcL1fbtHGy7bEwLYuGFuuE7OMD0qUjj1SmPA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mcstrans: fix memory leak of sortable
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 11:40=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Fix memory leak of sortable on the error path.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  mcstrans/src/mcstrans.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index daf9b7a6..d12ea587 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -1030,6 +1030,7 @@ build_regexp(pcre2_code **r, char *buffer) {
>  static int
>  build_regexps(domain_t *domain) {
>         char *buffer =3D NULL;
> +       char **sortable =3D NULL;
>         size_t cap =3D 0, len =3D 0;
>         base_classification_t *bc;
>         word_group_t *g;
> @@ -1047,7 +1048,7 @@ build_regexps(domain_t *domain) {
>                 n_el++;
>         }
>
> -       char **sortable =3D calloc(n_el, sizeof(char *));
> +       sortable =3D calloc(n_el, sizeof(char *));
>         if (!sortable) {
>                 log_error("allocation error %s", strerror(errno));
>                 goto err;
> @@ -1065,6 +1066,7 @@ build_regexps(domain_t *domain) {
>         }
>
>         free(sortable);
> +       sortable =3D NULL;
>
>         log_debug(">>> %s classification regexp=3D%s\n", domain->name, bu=
ffer);
>         build_regexp(&domain->base_classification_regexp, buffer);
> @@ -1142,6 +1144,7 @@ build_regexps(domain_t *domain) {
>         free(buffer);
>         return 0;
>  err:
> +       free(sortable);
>         free(buffer);
>         return -1;
>  #undef APPEND
> --
> 2.54.0
>
