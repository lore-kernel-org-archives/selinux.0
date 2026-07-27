Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D7037755C
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174565; cv=pass; b=cgK9ZKfY8jTVOvtqv5CUZgOjZCORl62KTQKRcszDXjrS7YaglInZocIy8My4PiTaCfCkWSlvBFyvvbNtUqGULiXyhvSDgAUvQlWBSS2bA5mciDS4NHISvPq2XnVPJdJh4Oa0Y7saf+E2Oa81yvDf8BOFHKq8GCS9PFbAAddl1aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174565; c=relaxed/simple;
	bh=TaRoa8HU8ix8MSD+Un6tQsnPjt4AovfdTkGeCCEJJZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TK6aON30bEOWOsPWTYLQzGFiAnGSNm5QEzdBg8HXlRUWaRXAMyqTvlHGC90LI11rzHMTI8i0IDjbtbM24PQriN3790/cqUyru9jHhEmJA/Q17RyZoBtOl0i1M8Y2UC69yEjZoIlR0VjQnQ/mV+hccTxl3j8XRNIWweBzhQn5xUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISgqfBrY; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISgqfBrY"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-455a61c53d3so1580734fac.2
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 10:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785174558; cv=none;
        d=google.com; s=arc-20260327;
        b=d7AuGq1Fh5E5x+NF9Wr2REDJ6OwFYERD2rdehKdIqxDxgqJR+4EpoWIpKmaaZSAKBt
         doN+Rt63iJZ2mhBshYmUiRtPy46LH/NtC49xDo2Vul19ksZwEIUhCxfdKjw5sz3M48C2
         vtTMzF8gkpeknVKzIBVRFuj8dmEffgkXQ0G+HHwQAZbBnyx3sUWXtW4diBbU5AmA2wj1
         6tM6sppqDIQnC/mt+IsmmRybI0LtUJqm2sD+fi4XN1SR9T77zOvyOObhJw8eqlhioi6n
         KtN7y8gfKjd96XYt9xmz0gFz4QVZPSpb0qkYOUNB1fCRaF6CHAjqy5stGUQEYHf7sL86
         4lyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TaRoa8HU8ix8MSD+Un6tQsnPjt4AovfdTkGeCCEJJZw=;
        fh=J61V3OUGMbPg9PEhaVOaAjeaFLNhlaRAyHIlP9GupwM=;
        b=DvrCmPvPQyUN9OqvQbWTnXgN6LU/6mDGZDJQhWYiYxCy9lYLnxGTQQLJoKpkBZvhBp
         AdCqytrVTHube1YznnejxwWOLnJxK7Rj2JEp6GpXOOn9GETpvkx5wCrHtcw8BrvhqbzQ
         Rze5P5Q4v1dIiHvRJfBOXrca4ivRt8Eyp8U1Luu99FGozeQSXVBsXTfeaIEd1UmfKXF4
         NDDcZ/1R3W1REzQbuU9badVw4ZKcaemGSMw39mtAT5jh4vFYHIfhQe8eRE51vYt7dF5h
         QLgnSU9Z3VVwS3YHFAwcnhdXgjD2hs8IsF/1hErxEmyhzL2ltOloS2+AG5QQ1fuiGozT
         cWwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785174558; x=1785779358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TaRoa8HU8ix8MSD+Un6tQsnPjt4AovfdTkGeCCEJJZw=;
        b=ISgqfBrY1lNu1s1BdS6ri1nS9wRIaxAg+evnEhMMZagBhKEgL7V6aGZkjQQqDqaCRE
         0Uu1XFWY8MOdKwYBA0BC7t6XWYzuB50ewsVblnUfhdsQVVg4f9rVYEVl7+HnLotGaQJB
         0aw1XKtxEjaM3h6H6/9IQvJiitDQ+N/U8avovDWv0SsCnDmqY5EKPh24r4uQUbVZvqqE
         dURu3oYYuOInKRw4xJ8LDRtDhDO8JB42nOOnxvSH5Q1XWVoJdIAbDj5BN7uf62xQxUR9
         pQMsiEDh5iFKxaGN3VwFLg+qp1OHOsZWv8My8zKQVlkpGmQAoXWie3DJurkiEGLLSGAB
         ORQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785174558; x=1785779358;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TaRoa8HU8ix8MSD+Un6tQsnPjt4AovfdTkGeCCEJJZw=;
        b=UCcH0+Vr4oQjqKhcpV1ixMjllmMenmXJW9rUqIvQQUdhRlWaOyYyk/DqyHSMf6Fqji
         nHS9bJtQmuys+BOzqnYkmYPwl9f7CpWIMdSQNxh6aolFPB88ElWATIMDZTL2GdnOTZXu
         k0wtKPUvpzwv0CfwPcbbELyg6O4F2f65aK1bgIoA9tW0Vhnw7RTXhBME0E64PShFQ5X7
         vzK/Py/VVxSjiQJZJcuQqLlxBL/Z+NkrNbGFyazJX4ZbJRx2XnZy4T+MEog7cxCfR0fG
         +wvRYkOI2WKlSFU5plPwwcLkXyxsnbg7haLoRuDbkxtyS+PBuBZe+tr8HvZohZfei3re
         d4pA==
X-Gm-Message-State: AOJu0YzDOeSMLYFk7CvdOe8DeVLCgB0dn15SS5X9BZU8Sa9cuRoRFWHB
	RiuxJhmKn3uSLwFFP4T7ebLwwGfZBakurJ5Y8YmdnEpiZySj+cAu7b63M02fOtBvNMDIlvYx4Kx
	zj8EBzlKzhtIP9DzXXghaPKd1KAFjSPUICw==
X-Gm-Gg: AR+sD12m050tSEhWdo6iV4vcVghW4fFvtjB/ijA9DtJNJUY34dZ4pa4J/Kss8T88JHB
	o92utlxRBXajFUnlUoZXAzcTqCs3atK+K5v+CV82ACXvK1wZ89JwSd4DhtbtDE9AdqrAtYv+bJD
	6q0F/Ma94AhfFoUn932bBgDuxG3PmguC9+bo7tm6t3QDAqPgjGQyqxCYD9cOGmqG7HsyGEv5XGf
	dJOf3M8uJ3gePUYbk2bfV3pzuFwe4UqMGHf4q4gMn0vmEUquE4JYZcsKypumg==
X-Received: by 2002:a05:6871:6916:b0:447:2ca4:918 with SMTP id
 586e51a60fabf-4585e48a271mr377261fac.33.1785174558218; Mon, 27 Jul 2026
 10:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727152518.2495266-1-akkohli@redhat.com> <20260727152518.2495266-2-akkohli@redhat.com>
In-Reply-To: <20260727152518.2495266-2-akkohli@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Jul 2026 13:49:07 -0400
X-Gm-Features: AUfX_mxlbwbqbGjCorrKZlj8zqN7-Y1xR2pc3PQ4fACe_O0PIOvh5jlLPa_8Lt8
Message-ID: <CAEjxPJ7pQjCk9vv+p6uT6j82w+ybw+78WcAyJUv2ZYm=ki+9hA@mail.gmail.com>
Subject: Re: [PATCH 1/2] checkpolicy: extend bad-data tests for type, role,
 and user errors
To: Akhil Kohli <akkohli@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 11:44=E2=80=AFAM Akhil Kohli <akkohli@redhat.com> w=
rote:
>
> Add negative .te fixtures for duplicate type/attribute declarations,
> type/attribute name conflicts, invalid type names, and malformed role
> and user stanzas. Run checkmodule negative tests as non-root in CI so
> the unreadable .te case is exercised outside root-only skips.
>
> Signed-off-by: Akhil Kohli <akkohli@redhat.com>
> ---
> diff --git a/checkpolicy/tests/negative/bad_user.te b/checkpolicy/tests/n=
egative/bad_user.te
> new file mode 100644
> index 00000000..e7460dd7
> --- /dev/null
> +++ b/checkpolicy/tests/negative/bad_user.te
> @@ -0,0 +1,3 @@
> +module bad_user 1.0;
> +
> +user bad_user_u garbage_token;

This won't reach the garbage_token because it fails on token "user"
due to lacking any avrule_decls, e.g. require { }.
Not sure if that was your intent.
