Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF96414883F
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821478; cv=pass; b=J7jp+pnLKwADjDyQ4xBuTY5npEvkITP5wPFaQOg1iccBhad9AUsTwc8DDSLRhVhPOFpkLarSZdNlDkhVs+sS2Bv/OOT8f8lL6CCv0TfFrDMv2QmENzZnBbyXGa2QyoKbEr19Xsvf6MYoQ4IMURQMpdAXG5PD7kolGNLiMgdI9b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821478; c=relaxed/simple;
	bh=Jm0ncxmOfnNcPuAMKHL2C1SXD3+sA2tNi69n1mLMMFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hmq0RIYmHhbbxskDt/hrf89An1menGFlStw0Tnp94Hw0Ihov8UOTce0/ynHfSgiDSZK2dcaePqUN3accRT0sSAXCrMfHgAF9LUqWbJkrl3g8NxsiTSdWTBgU1bZoWpU82OieHBqRwmRpLEL/SUutB+IXywaFeQABmhBJyXpKijo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkRP+X82; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkRP+X82"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cf41bab353so10989725ad.0
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 08:44:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784821476; cv=none;
        d=google.com; s=arc-20260327;
        b=Oq/AhfpGnSdNkzPXsXT39tHiVDdYmn7+QvrZ/+gEFQFAuhkUQ/u+Wu2D5xdxXcDQyJ
         IPFYX2CZbX6kgaN+z7AsNhxNokGTzIrJHsQW3Sr0czOrHVs00hy71KjldUy2Lbfkjn/4
         toxQ69i8Q0nJlCWg7pvKZusmM794IBKE1/cBDkW2F2Sh3KDPux7x5dmLteWfILJgpbhm
         tSrSV38Qi5xTvvRMD1Q7cYK8hKDBH1E7szFIg8KDIYJWD8bXlpGytvSbFy+z5NqR3sab
         PAlzDr4fZHRZG62VO8K/lvTpW8q6/F8O/K2G0FUOE97+Om72DWy+iKJz8otOZJuYBczl
         Y/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aOBG63OAJZMtVVBWoyxNwgPr6Fo3Y3WspNU3sQmqdgQ=;
        fh=JsrRvKH9zDWSQo/ocMDcDF7TXemqKX2q7s6wLCPWz4s=;
        b=CsLAUmb93ctGoPzIRARRuSiB8rPmswY9hNoMuk5bnC8wj6owLubmJyB6sBiv1b13pu
         FWpMmedCuX+DHWcWUGZ/jSVtvTh6tw9UlTkYqHj8cno7x4zGBIhbB0CZ8nYjjrtHbsgK
         97NluI3ByaGt8dg0hXdXApUFCfGKpQVDl1nynpKRQe/Rroy/TJK/XLS9bsxX6usW/ox4
         sdb/tRNgHNkCP0K45aHxb+xp7I1VnBFrVx4PwquVcxTVt0lgOzO2RhLA61sS780lKnVK
         /9S7bkFb0iZ87fMuOo2OawWbwuZyMGYWQu72CLY5E3o8AxsKYtw58hXsnFKp9gARvOpR
         s5aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784821476; x=1785426276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aOBG63OAJZMtVVBWoyxNwgPr6Fo3Y3WspNU3sQmqdgQ=;
        b=dkRP+X82TZ7sLmPyRVvSEol+9zyYxe6W76vSpZI3cbuzQs4wZqQuNCvDVvrzQVAZPY
         ZOnWO9bZpX+qfu5YGfT0SVf5ou9CNe78EyCtOpUlV+D2nNq3yF3QPBFlUYHND4Fd01mt
         Bq+CT+0h94RGNLvNMWOzla/EWlmsd9VuMyVAnVufAfVB4h8HMaBx0UNPBQ7w0r7yxhwJ
         obcGadlwN/hQs1aaMegeK4psxLJdyoeZ/noj4k8UKpbXA7uBbIYD7QAityU+cJuzW/Cz
         83fgUqGZNI93jsM35rkmZgkZs0HsIrUaI5t5qI2QBq2Da2CnJ067R3N5iMIDn2FHLye0
         DeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784821476; x=1785426276;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aOBG63OAJZMtVVBWoyxNwgPr6Fo3Y3WspNU3sQmqdgQ=;
        b=hvZL9wetza4JFvPOp/3YLt1BuwlM8OxAJJro2rxA7+tC1HqxyFOaoBsx7+QhxeIHDi
         VxIDbWVyPwtGmpIyJpGYEdiFVK8wtUH2E6u517UsNXkWGJdorJYM/3hrN3s3DbQXxEze
         /IZNdsQjjyTTg8auwQE7xSrDpizLY1QfiGMyFLdpn2oQEWYaH8/le/x7Hh9GE3GfN0oP
         eSBU46QAe8JIPnztnMKOFe3NHebitLOhhiEcU5wORxsL0V+ArtjMZW0WiKlJJV5+F492
         BQ5K7BPdH/t5DNPq+Sfd9neU16viKYqvHwecQxPhfS80CiqA/9DXgIX8tRTn69YVmKnZ
         joSQ==
X-Gm-Message-State: AOJu0YxSj/8dmeGGGcOzUMOgUzauvvzqxmXmsoo3DnjcXWhuype6q0CJ
	774CMxeOrB3iZ7bsDjlDXiRsf+fTL8i68E5SHXv03hfH3FGcZO6r+GQpLfLp7YuKAR+HWs5Q4MJ
	5U2ec7Pk5PctZHxu2CKn8YXty/2hpR1UmPw==
X-Gm-Gg: AR+sD137zYLYgylWmVXQIGiG5CTAmCZWk/rNWtepPSBlyXyZowIKHH7K7J+ezUH1bmb
	kVAh92UnDSLC/KQXFmt9mDe19jFn8F7e//hzWIDcBmvwyszC/T6zsX1An+/wuKP8yO0Jn2USxrM
	joq8cs0AJzdOFl7E5Izb4s1Co0WaWogEqQ7At7Qt5GUsNO/SCrL3v5INL3RFQdeDg7FevRfVR51
	xIqwaO4iizI9uHoXQORdNqGgYlY7wx6KboYxwN0HAjON0a/NpuVIb8LvSC3uw==
X-Received: by 2002:a17:902:e850:b0:2c9:9a19:df with SMTP id
 d9443c01a7336-2cfa71dc761mr42240195ad.18.1784821476100; Thu, 23 Jul 2026
 08:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723085829.318778-1-inseob@google.com>
In-Reply-To: <20260723085829.318778-1-inseob@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 23 Jul 2026 11:44:25 -0400
X-Gm-Features: AUfX_mwr5nsWqRtvv-hRxgGZDPsgXVa2qPcA6L1Nr_9dktBXIwMxLzm8CWZRu_Y
Message-ID: <CAEjxPJ5pux18BCR4FoQ38LsWHz4faXhsQvPQCGyC-YsqVzibRw@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: improve performance with pcre matches
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, tweek@google.com, 
	Eric Biggers <ebiggers@kernel.org>, =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 4:58=E2=80=AFAM Inseob Kim <inseob@google.com> wrot=
e:
>
> From: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
>
> Since 30b3e9d2 (libselinux: Workaround for heap overhead of pcre,
> 2023-01-12), performance of PCRE2 matches has been affected due to
> excesive recreation of the match_data in an attempt to reduce memory

spelling /excessive/

> utilization; instead of a workaround, it would be better to address
> the problem and maybe even improve performance in the process.
>
> The issue is that currently the structure that holds PCRE state has
> both a pcre2_code (which is per pattern) and a pcre2_match_data (which
> is per match), forcing us to add a mutex to prevent multiple matches to
> step on each other.
>
> Lets remove the match_data and the mutex and instead allocate one once
> in a thread independent way that could be used and reused, by extending
> our pthread interface to not only store TLS variables but also retrieve
> them, and then use one of those.
>
> Since we are not interested on the capture groups (if any) lets only
> allocate 1 pair which is all that will be needed and change the logic
> so that a return of 0 (which means the pattern matched but there were
> not enough capture spots) is also considered a match.
>
> This will ensure that the memory use would be bound to the number of
> concurrent matches instead of the number of patterns and therefore
> reduce the impact that recent changes on the way that the frames used
> for matching are allocated might had brough since 10.41 was released.

should this be "have brought"? And is 10.41 the pcre version?

>
> For cases where threads are not available, just keep it working in slow
> mode as done before the workaround was reverted.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> Signed-off-by: Inseob Kim <inseob@google.com>
> ---
> v2:
>  - Fix the dual destructor antipattern by separating the thread-exit
>    destructor (match_data_thread_free) from the library-unload key cleanu=
p
>    (match_data_key_destroy, annotated with __attribute__((destructor))).

This won't free the data on dlclose() of libselinux, right? Not sure if we =
care.

>  - Eliminate the data race on match_data_key_initialized by using pthread=
_once
>    (via __selinux_once) for safe, race-free initialization of match_data_=
key.
>  - Remove redundant match_data_initialized thread-local variable, making
>    lookups purely based on __selinux_getspecific().
> ---
