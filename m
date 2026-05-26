Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EF62D6E58
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800943; cv=pass; b=WWh9nFEieSYoiQvxsAUV4hGG0Hmd+hAY4xZ3CZ0RVyaAZR8fqCZZHLjZsy5Mkr9JFT9h5w+DtmXlEvGMcr+3lq62GJ7h42ZkrQI47nXhAAZKQI8Lf0Ucf7jLN2QIX0uHp5TYfXsijETmajS5/LZA3T7AiROKWlyGdLIvlM/hyFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800943; c=relaxed/simple;
	bh=5sm+oS3Td/obnhwX3oq/R9y/5Oap5QewapK/4xO439k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rS1nVVEfja08cb7RoRcshVAEor+WyEAMN8/NEvxOLR1RsPaRFH5InD4J8wzaisbVh7vS6mAd2GwRVT94cajpsUZP47jZXqMzexrmAARksyjMFxUFmUWlwijjxfTKKe/ohTTUp+Sg0IlpjZ/Ain/mqIHTe+846NJf91Jgal+4rSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rnLhiSj7; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnLhiSj7"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36abfe17c11so2473279a91.0
        for <selinux@vger.kernel.org>; Tue, 26 May 2026 06:09:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779800941; cv=none;
        d=google.com; s=arc-20240605;
        b=kvtS/u2yYlKlVXxEhHj6AooQI92g6zrnA94EodV+DFusfmLx3h2SKbR8TONcdPJiJp
         e8SrTa3tp1FmwIM2E16l1NSMhQO2fqCbFxUpwXz5HcGge1TACfaLAFHW4zy6Gf5BbNSL
         sfihM+5tfhB+5EwtUcjuMeHLgpqHUwz/V/O8SQZF1h1vwglv7k1RPCCz+W+ERYIbFTmR
         16J9DS91yF1Ie/he/Jbytv7voF+FZbAuiPmZGlyrpaCCXz8BSJD4HKDMBu/kxiW6qUK8
         XknrVGWPyt2rSkHd3PtjPwmLF5fL9X833Y6rYh8Yy23b0v20uDFuYjTXJ6ttBZE5R6Os
         esUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cEbpOzHqThzJWdQuYbp1njeZQQJBbqk9nMZ0x2Nydtk=;
        fh=/rSmSShKrmgiNH5jMuL5PV05YurIjgg9S49vtr0Sfhk=;
        b=C8+zUG0n5v662hisFfyPEH7IIq/iPHbWViQbtp9Nu1orUIVB8ha2RlJ0moyDERkrxI
         GMF+WvzPupwj+d6/Ip2P4D5BMDNecZnO7ZcQ/4wkhBxlH1b8fBv6U33NidrHYrZdMDKM
         nTl+AiJ72h9VMztl3ZxRmswKcE6F/Y5GDYepGnYBtOM/IjXA1bNjtRz/zuHP1bbI45Zs
         t/NucZM19dOl0L2eNQMUR8TdIDlasAhg+7/OVIMu05ImtZZ7bD/epAWMc7UBB/6ilXqq
         UMhDbPArdnLkhAQluBjMZsnUFVbBaCqzXYnxXyHYdvEKJQ3/pHT+lRvxH6ena+sSUbgS
         kw1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779800941; x=1780405741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEbpOzHqThzJWdQuYbp1njeZQQJBbqk9nMZ0x2Nydtk=;
        b=rnLhiSj7vFoCHxV3GW5RU/EYEec3+OWfeAjoBEB4StV13Cihmq1XvNfUY+AHhQcIYe
         ZhzPz5hSar/H7RsTTRf1/3hrQzULa3Z0gZgs9X6aLe8V2TttdIgAsMfMHNUOND8bJEAX
         CoyvilzdhUpeLE38vo5xuAHshuc8Fp/+YeHY1iFTSeeXwPmUUrYea3b2u5Kepv8wlum0
         ImZei0S1YgKvFypgIeiH2RWN1X+U8881XawRH/BlZT/vN3Z8Tw3KLV5ACGyZDlLFkT8j
         h3SeHRpCi0Fxp2yc96spN20Y9nTibYwNtIfJlRLB6FhQZU6OCQQkBLikAiB8JFWqcCX0
         4+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779800941; x=1780405741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cEbpOzHqThzJWdQuYbp1njeZQQJBbqk9nMZ0x2Nydtk=;
        b=HQOaEzsFITZyf8aqMJVAzgfGuhKtXqO3VED0XGrWVsit8abjMIffzsYrDb25x9ID0v
         bI14SvO4OWnypUVj/+DEkynjQt5N0mzRQeMAzwSkF8LvF1anNQxPeeh+qVBezbiyJTkd
         WIIQ/cz8ZqzVtC0Nzg7LDghuQea/Iu9kMVPnPa8ivd+uepbd3ggdxYL5Jc7Y4yzRZI8M
         rjwMK/gGBRmTPw0d7nnCy9pDqtkbHx8YyDBPw22vkMHA6EQAZfoHaARdvhtqm3OCTtmT
         jKn6cSHxvZYWlysi4Q6oBabNjPiKCtZChOfXrdlPhxq0vrw6AycSrSAKne7a3M3CXtKx
         BF8g==
X-Gm-Message-State: AOJu0YwvbEGwUiB1p3/losLQe53nsrL++E+lAexOe5QaToR+I87Bj+4q
	GOt5jgpsCxCWoh7YnM40yPgOlcOS4Tz9YhAeM6LOdRqImO7WOozDBMt24bjyJKp1fHd+o0TAZ/P
	5hlNiljHn2zlyeAWHypbOn6uZFhTljyULoHQv
X-Gm-Gg: Acq92OEg25cXnw3Y/Ym4EBdtuun6H/zEPnCTTsRJs7G+UevPpv3gxUOZwA5AFYR9NxY
	eIZOZtObXyvSqPB0S/RZLzHe70YyUXLjyZk1X8j4NazxtNuXy5bvsilswR5WYALqHbmByUmPmn4
	EQ+U5wPNDV3xJYg0UhnNncpuu1J97Z3CZT+KyBh65GhA/WHRGs4zXwOfHHRIRNyXa6VcMsTFktz
	ySXMertcWgPKbCUIhlYuVUF1Gpv+xcWUkOwgnibb8/ReK0ona0rY5iquo2JpnYTG6Z4QJ8Z8jnI
	1XqywzWK2GTnOuQw9A==
X-Received: by 2002:a17:90b:5746:b0:364:78a5:8d40 with SMTP id
 98e67ed59e1d1-36a67639d6dmr18913467a91.20.1779800941151; Tue, 26 May 2026
 06:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514161936.55432-1-karlwmacmillan@gmail.com>
In-Reply-To: <20260514161936.55432-1-karlwmacmillan@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 26 May 2026 09:08:49 -0400
X-Gm-Features: AVHnY4KqE77qZL1a_wpRJ9sckKDYOH_XumEQ9c9cKYgzE5-ABlKTtP0Jwq_lyvI
Message-ID: <CAEjxPJ6AJdfK6PKT7JurNk+xd=5yBaLAQgbXk227G6+h2=NUyg@mail.gmail.com>
Subject: Re: [PATCH v1] Improve sepolicy audit log parsing.
To: Karl MacMillan <karlwmacmillan@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 12:25=E2=80=AFPM Karl MacMillan
<karlwmacmillan@gmail.com> wrote:
>
> This patch improves audit log parsing to include more information in the
> audit messages. This is restoring functionality in some ways, as it
> appears that the audit message formats subtly shifted over the years
> (though this is solely based on the test_audit.py messages - Google is
> not yielding any information on those old PATH messages).
>
> This is really to make the -v (verbose) output useful for policy
> development by including the original audit ids (so that you can lookup
> the actual audit messages if needed) and include path, exe, comm, and
> other information in many more cases.
>
> This also includes a fix for when you are running audit2allow without a
> standard tty / pty (e.g., `ssh host "sudo audit2allow -al"`). Before
> ausearch would assume that you were trying to read from stdin and no
> output would be produced. Now we are explicit that we want to read from
> the audit log.
> ---
>  python/sepolgen/src/sepolgen/access.py    |   6 +-
>  python/sepolgen/src/sepolgen/audit.py     | 344 ++++++++++++++++------
>  python/sepolgen/src/sepolgen/policygen.py |  22 +-
>  python/sepolgen/src/sepolgen/refparser.py |   2 +-
>  python/sepolgen/tests/test_audit.py       |  15 +-
>  5 files changed, 273 insertions(+), 116 deletions(-)

Per Claude:

Actual bugs
1. add_av() now appends None to audit_msgs (access.py:294). The if
auditmsg: guard was removed, but audit_msg=3DNone is still the default
and is used by every caller in interfaces.py and
access.py/test_access.py/test_policygen.py.
policygen.explain_access() accesses msg.comm, msg.exe, msg.name on each
entry producing AttributeError. Also changes test semantics in
test_access.py/test_policygen.py.
2. rec =3D=3D "MAC_CONFIG_CHANGE" never matches (audit.py:527); should be
rec =3D=3D "type=3DMAC_CONFIG_CHANGE" or rec =3D=3D"type=3D1405".
3. by_audit_id grouping leaks on None. audit_id defaults to None and
if msg.audit_id !=3D "" should be if msg.audit_id:, None !=3D "" is always
true so every message that
failed header parsing gets bucketed under None.
4. refparser.py p_devicetreecon c.name =3D p[2] is wrong;
refpolicy.DeviceTreeCon has .path not .name. The rule is already dead;
refpolicy.DevicetTeeCon is a typo for
DeviceTreeCon.
5. assign_field_from_rec: value[0] =3D=3D '"' on empty value. Guard with
if value and value[0] =3D=3D'"'.

Correct but worth noting
6. PolicyLoadMessage gained 12 fields but no from_split_string
override to populate them - they stay "" forever.
7. Dead writes: found_src/found_tgt (audit.py:317,320) are assigned
but never read.
8. Proctitle.decode_proctitle assumes hex. audit will sometimes emit
proctitle=3D"literal string" when it doesn't contain whitespace or
control characters; unhexlify raises binascii.Error promotes to
ValueError, caught and replaces entire line with InvalidMessage.
9. API surface change: AVCMessage.path no longer exists (folded into
.name). policygen.py was updated but external consumers
(setroubleshoot, sepolicy gui, etc) that read avc.path will break.
10.  __post_process overwrites a.name/a.comm unconditionally. Probably
fine in practice but "last comm wins" behavior.

Cosmetic
Gratuitous whitespace churn in access.py (163, 312) and audit.py (689).
__rep__ returning a multi-line pretty-print is unconventional; makes
lists of messages unreadable in a debugger.
