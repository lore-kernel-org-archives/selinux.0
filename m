Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C3244C66B
	for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997628; cv=pass; b=GTgeIsesPYm7CiGKddEttITDglrenWRJdlx9fy/DkKG2dKvQXXGWSzOoO2B+S1fx7gMtORnoUNyIJSsQ78xo2zrU+oxqHx1LLe0OGvoDaxvU8bKx9te0Dt/BAVmF03aCN4kajHlmgdNJZyXCVC4RIfIcSdBJtRy4300O/Hnaa6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997628; c=relaxed/simple;
	bh=/GhvqJqbQBfM//7XJE6nxCm9dhsv0uZ/NtnKx9K3jPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVgWyKanU7Zi6b2dZofEz7GudkTxSXructMhVbqtYBbgRtYwZ0WtwSlmgWp20G2/hIp0nhHNOc5p2vzt2ebj5Ljg0fX90pqJhycH7I7mrPW08ztvmYzbEWENi6neM4ha9TMNhB85vJnB/PxoGw9oRdtVa46idsURaIRKkiLdjqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPbZJ2BT; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPbZJ2BT"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-459281bc13bso2178035fac.2
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 13:13:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786997626; cv=none;
        d=google.com; s=arc-20260327;
        b=QT2PtP47ecoywki70SJyIwy3/KTQ4+zLcJG+lTdCxftwwParJj07t0Dvz3jT2uPRev
         WzJemZzIQFCxXe88RFlIIK0Z/owxA3hOGAMjI48ltcKt+eb+Gpk4rn//FrNxt8YWWUbE
         MMhLZNURXmOaK5F+/YnPV6YH69RTrrSxwK7+N5w1K0CiczD1OjXpXxlDPBsM1pXFU1gR
         s4l9clOq73s8MXJ0tSM3nosUbD+X/2HnjG19I1RyKiIwMiya5FU74sUGrMcBIQ797698
         WYHHJrACh4usHg2gB+6UL6JQfOUO8a4kHd9EadOYAeBrfJ7PrTwHUtsdjKbwMggXNlaQ
         RwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/GhvqJqbQBfM//7XJE6nxCm9dhsv0uZ/NtnKx9K3jPY=;
        fh=sgjSH80QHeD6JBccE5/TsmSKf3PiwcDnegQ026BGrz0=;
        b=aAt+ZxD+L5uNPsT36v3fBynzzyag9Qdr5Y4BWS/jGKvD8ly+AlV095iIqCt8DToC/+
         p4BBTX9uLcfhX+gmtRQETOxxv3amfQOtOPCJgvzG05tfTrlKqksgzxhdsOX3ophOsjtv
         Csz6Myw4i03S3cEDoVm1He/ZT6E557yAph8XV6AwpV/GSzcjI+j73frp++TgopGNdBsi
         cW3OXOJBD4KRTu6kcWE1uQEvYpZ7BiOy1vpLcxJnid+IDULdXOXt0ytzVGywdN9SNIfN
         PMpxUU9Mseh2OabqylNU+eChSOqfgilBnDc2EiEV12OFowXvVOFZy0oC/6dnDqjuWbRZ
         ExIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786997626; x=1787602426; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/GhvqJqbQBfM//7XJE6nxCm9dhsv0uZ/NtnKx9K3jPY=;
        b=WPbZJ2BT8W4YIK9hpv/1O9D03BU5B5xBoScO8lJSBSVxIEp8G4v8yG8mxCwa+oXKW6
         dFwfOzpPjHGlRAJhytNSxXHgMtJvfQX0Z1ShvxiQQJvMXl+AQF7vg1VyoFEcQmMoqcUP
         Ar6L3qySMcJtDINMCJvzFJXifz4qQ08vqNfRGMZmOGdOcwsNYqL+++Xdb/C1MiN9SAMg
         iTShvE9z9VOYAmAWg4Pn/eZ+RomkCQmVspuGDUNx5AwS8rmO7awpnFRTAyZtTYQyC2mU
         LI6TlGYyJFtZ7V09e3b/gjv1ejaCliW76E5BAYl4V54IlCQb/B7AIBvUMW+89XFZ5Fns
         MwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786997626; x=1787602426;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/GhvqJqbQBfM//7XJE6nxCm9dhsv0uZ/NtnKx9K3jPY=;
        b=UdabJVChxjpGFsw29PU/WjJNjjvX3tu7DaZfT+XaUHjQqnCKw78VeEtzE5TV8YzuHB
         dTPe5CjTJ1HocovMltBFxoHcwZ2BhVQyJ2V4QBW0ZVLYWtR0XmyOqeMO9QaSLURyEEaR
         CatqiQYIVszV+0M/GTWJavEBDqG8F1sOdKu28dcw1YqGXiQZP30ZFvcsjay7ZlcJqAtO
         vgloJPzKZmmAws20XSOS3QKM6VNgO3a8NN+ayp254Yox5LF/Bv3XpHvq7Rfayx+5DDc4
         55gypiSHS7+vI44djXzhAe22vChTbpySxEgmY/+kMvSokR0Po0Ouf3b7TeFAA5zcc7pY
         nVRQ==
X-Gm-Message-State: AOJu0Yzc2eW80p+FK+vBXp/uioLi5G5b8xItLK/Wvn9ZcKQPzh80CLu8
	6wM6kw1Z3zVp8pN5AqVHt1qm67JPovb2w3rwVejumAGdGdG8XgbGffWu5jm1eawYV0BWMs2LZB1
	s/hgr347m8nUa1gXwKUd9+j7zAStg6lurp3G4
X-Gm-Gg: AR+sD134cLX/oIG95MrH1IMGU0ROPZXxBTERfxxEQ0+dkyc33foUo3kmkNSEUfBQugC
	hOgp8hVKfNdUIm/uLxkEgIJ4gwI3CnNr/Yf83qhEEgs8V/epuQ30LLf0NjVV095mjsmmywTtPXP
	xfjpaZWGksaaSr5j/BYaAF5YlzdTFAlbDBWLzzy9ih6st+c//kXS/E1NtZwBijOwnqDt3bVLZ8I
	m36ll03YGn/TXnKj9RPHJUlDotnRdJWVvj8C4la+9nnazD/jQrPDT3rbSl2nu6069MyIBXsG1tg
	OLoWrqm6kCcAiHNqZZd8GVhtrKE5B6nyO31rizcRnKeeQi3qrqPnzw==
X-Received: by 2002:a05:6870:a085:b0:442:175:cea9 with SMTP id
 586e51a60fabf-45e91df60e8mr28344206fac.7.1786997624539; Mon, 17 Aug 2026
 13:13:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814133456.203958-1-stephen.smalley.work@gmail.com> <CAP+JOzQjGEDuxcS8BAzbCvUNzisDUF9KMsQv=Ay99DB8_NQTLg@mail.gmail.com>
In-Reply-To: <CAP+JOzQjGEDuxcS8BAzbCvUNzisDUF9KMsQv=Ay99DB8_NQTLg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 17 Aug 2026 16:13:33 -0400
X-Gm-Features: AcwNN1WFub012LXvSucwfZN87VYcJJq35t4Z1JAWr-aKaa1dng2yEXtYZN2Mf1U
Message-ID: <CAEjxPJ4=G7a_JSuXab1pfZJDx1c4a++3RNBSQ8W7ssQhG1+VDw@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: selinux_restorecon: fix error message on
 intermediate symlinks
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com, Krzesimir Nowak <qdlacz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 11:04=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Fri, Aug 14, 2026 at 9:35=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > selinux_restorecon(3) was changed by commit 67bc978bfaf9 ("libselinux:
> > restorecon: revisit pinning files to avoid TOCTOU issues") to avoid
> > following intermediate symlinks on the caller-supplied pathname unless
> > the SELINUX_RESTORECON_REALPATH flag was set in the restorecon_flags
> > parameter. However, because it calls openat(2) with both O_NOFOLLOW
> > and O_DIRECTORY, the errno was being set to ENOTDIR and a message was
> > logged with the pathname being "Not a directory" even if the terminal
> > node of the path was in fact a directory. Fix the error handling logic
> > and log message to correctly reflect the intermediate symlink-induced
> > failure.
> >
> > Reported-by: Krzesimir Nowak <qdlacz@gmail.com>
> > Fixes: 67bc978bfaf9 ("libselinux: restorecon: revisit pinning files to =
avoid TOCTOU issues")
> > Fixes: https://github.com/SELinuxProject/selinux/issues/540
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.
