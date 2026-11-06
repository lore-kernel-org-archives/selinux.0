Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793993040;
	b=wpLsNcxlbBvGKhLS+Fp0x/LEIYc9e/f5zOUVujyNNeCZaskgktJqOPAFbua8aSsCKuSf
	 RidDXcgMppUX7IIHDekyXduPHOmjsx50cxU8BTVuWqeyWk3L1+NwTpL2IjqBeQqAtRHOd
	 yHt12GZ5H8sPG3hgmzJ4APrbcr0PCAWIUnWQtifpRjFzX/XwhCM6lz00j2iv266fIF93J
	 OsXmfH6JnB6y+RLY5Z+E2W4Dc1GSQkKxQ5u9YhJndccN61Kvv3CHeotW4IrgTEjk9dXu3
	 j0WKl+JinPh1oiV9eH7YFxfV05OQkXmoqrb0h0yc3/Nlo98kq/QtM9ZJKgRUK6GbKGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=pB6jILtqWyvYXf6qYaFETjDTJxQYSVmYT6cL3i6Kbj0=;
	b=ui8ixDJV2MFX+XhT6dRwM6x1EpH8rSzMNDDoodJMRWAEbS+SO6ZcmLKjUYvRFjWBXbl8
	 Vu/WUmanBxR6KIhnOQ7ugR27qQ4PI+Rzn5PZmuPpwKbeo2x6i9ptMVLpUR0dod32mtIgN
	 oIGLdDqITp4xJlYecW6Qb84VFuzLjIwZabKE4PVmUVCrqxAr+ldkxB+RSTp8d0PkF6SRV
	 GgtmqlqXhGdRgTIy2dF7Qs3NtNClcATKv8wJ0iXXKumSUh2hn6+IqTyDU4HLeEWWO6WUA
	 zXSQoFFnStI3A/QdYVkQwQb35w+xV0W6vsiIg5wl9h2KQQaVp8OpPQOMyI5KrDAWn9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UPnWNUg+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F3E606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 19:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4F3E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UPnWNUg+
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-677bc4704cbso1190334d50.0
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 11:23:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793993039; cv=none;
        d=google.com; s=arc-20260327;
        b=SlD93JG5+g7QoWFSjd7bhs2nphBxGjla5ZLIhDnuotVCs+6cnT0hHQhohd8nTSjtTy
         mOFRfJIw3K7i+OrqkuQbtVrLZ+ML1ovVKsnVGj+VpJhT0AyVk2KtelS3Q3pdv9xxo4Kn
         XrJ0ctP/ZDv1AAOBkvzdliwkVrOpho9k1hQXpUtcRjJgqMureEodTPAXJVyZG1tz1J29
         I99UUXHLpNOhM29ATUaJRCl0uU/3m5hnGu7kEhcT45wPKYVr5cf96GVt9I9TpaJkSxJA
         pk8W2tP+Tlw/tnyJw8+qVQ2I+srLyrIbTv4l83L/+AB0sBSynVcDuiQWqtqx6vLB+1yk
         dIHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pB6jILtqWyvYXf6qYaFETjDTJxQYSVmYT6cL3i6Kbj0=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=GuIEO29KAMu0QDPJM97CqXVqZujcMDaHXWvg+HQxEXInXSiX4GAi2zDE+KaEkk59ay
         yfy6AQbPvd4IRixVsMOTxNeMUeGioVcIgxWmBr3pBVVOKMp0A4+plJtkKBkhSPfLaW6m
         Jr+w1JgMN+X/b5Dl9esYxbcKntkI6TVJErXcIdP80smFB0JgRRw+XcZDvX4SKKkKFC7U
         SE0mKKkn5ShqZkHH/m8vLNZfTOqqLOz90iijRlnrpfKx5bvQ9v3MhrYJLojH/SwRf7wz
         L39Y42AebDFnEqK9RxAIt9Ybh0ev9lAjupQZznytOo2AHB/CjgKQ82SyTEMAifqornfx
         TJbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793993039; x=1794597839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pB6jILtqWyvYXf6qYaFETjDTJxQYSVmYT6cL3i6Kbj0=;
        b=UPnWNUg+Yx3rnih0wHlsNzGWSpXwtGWlVr9x46W6BgASp5uJqEbBqT/f3PkpLFkPQ2
         dJoJ1HiA1dCNzm+f1EjPt79tzDOnMj5mxsGlS3odmuPJhYujoO7YvZXCT4fZDfJEAB8C
         3e9+/bF8FIe7rZHZTbowhugzA3nxdsyJ87b3dsYk8djQ3C52jr4oMo9uoT42a80Izc09
         4yN9XMrTW9UQFYrrt9WAfjffjUVP5YV4GYo6psYyHsnouRDgX+3u2/ibKd+jUH7AMYte
         v4MobWBAzdsTcPvNicAFW1H5RlzSI/eXBt6lPRNiFjDA5dWBnzPjQBrpXG8zxvnst7dN
         45RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793993039; x=1794597839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pB6jILtqWyvYXf6qYaFETjDTJxQYSVmYT6cL3i6Kbj0=;
        b=LZyz004AekTyi/mMEpKAsA/jQ66U5LEb1WKb1JsqKGpDNblABye7Mv/WC4BtIMakSJ
         cMT1Ki7E1Bo8MPLU1E/d4rb3pBBbnGPHe4rXnkvI88Z/Jv2fxCxwjzxNiKwZXtSrFyGn
         t0sCqQSShagLIP3cBKbU6KfLnZtlkGwrjBmaj3F+4gQLwdkH9ccYbtaCyUmxjpgIlfFQ
         qjarOdI62m1AF4yya3jlInx+zVfofrClV3CTD5dE+nmzDm3EfZUkUkifdgMwsDNQNF7E
         Ld4rYPmF1J2s6E8gSaATyBjBGDY8Z8edU/KtDiSQJskfyYilMDzQNsOIOj9bUgVp9TNX
         gS+w==
X-Gm-Message-State: APuU4Z9L1IP7c1y00hpUFgXsclKSS5rfphM7gi3hJGYpnZX5JUlj6CZt
	h7ag1QxadG4jdq4m3daMza+RoxI9JveIrKAUnc9fE3IduJVL4CK/385qhJxKn4MuZqGW+3P/8q/
	enLFetRTPQmHuVbppA1gyXfJS3SKlBxjgiNhv
X-Gm-Gg: AYBFou3MmW2yFNpNMWPzr9pBA01ycEEomTMRIYAdd0Okp1YuoM+kulFofRcFElOHLXy
	w3G9F4+AmJOznTM/nu1v27dRAhGllXsEjwDPj9WyU8cfrU2nJlFvxijSTRPdG0KDiPgA5G4XsnK
	a4Qm2adGjN6IEVgEs9K7l9US6UPRkd1+kxKRqnTEWPGe1qwlGJs17woZYdYDr7NyqladmGYV97p
	vBZKyX2hm8a4SD9Lwa+RTNiXihjOo9lTpXjrSo6SRvvABx5tM9C6RFMYrCsxi7sGLQ7OiTAv9qu
	kd8PqSPDdKooY//p04LQoaugjokR2o+PO9ed+ba1NAXjeNLsSRUSl1sckEw7sZK4LuItqpFUUQ5
	QrqiGh+zw0x8ltOT0+E6c7tPde/MPAopxy4blomXoCYNRChcIya61XVjczk2Xjv9wn/ZqR2tfhm
	znsRvS1Nkn/glLrSShM44PdJVDIFtmOLmdZMdDQ9wmr4qO5G72vOrUA5OpHg==
X-Received: by 2002:a05:690e:11cc:b0:67c:27ad:58c0 with SMTP id
 956f58d0204a3-67c27ad5efdmr207093d50.91.1793993038570; Fri, 06 Nov 2026
 11:23:58 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106121725.48778-1-cgoettsche@seltendoof.de> <20261106121725.48778-5-cgoettsche@seltendoof.de>
In-Reply-To: <20261106121725.48778-5-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 14:23:47 -0500
X-Gm-Features: AclHuK87ZJdHM7Ft4tJ4Gt8Hpav6jkjoP8uzp5WvfjAb_CXTH8Cjvyrgp--ZL3s
Message-ID: <CAEjxPJ6BeXzOfAz2Uk_EdT80op3o_8r6Cdx5JTtqOhQ-bCdbmg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] libselinux/audit2why: free boolean names returned
 by check_booleans()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:23=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> check_booleans() strdup()s each boolean name into the array it returns, b=
ut
> the BOOLEAN branch of analyze() only freed the array itself after copying=
 the
> names into the Python list, leaking every name on each call.  Add a helpe=
r
> that frees the names and the array.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

NB Linus has declared Assisted-by tags as unwelcome in the kernel
going forward and I am inclined to do the same for selinux userspace
but won't be strict about it.

My series will conflict with yours and mine covers adjacent error
paths yours doesn't touch but I'm fine with taking yours and re-doing
mine.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
