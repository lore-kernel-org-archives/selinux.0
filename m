Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794318845;
	b=jNbwA6oZ/lgY2BsiYoLdPOYeSf0jZ/NpwfwyFiwCHc8s334lthYldNXEDo6UGeik36gB
	 yDry1/2rNCiKkdf9ZzIXJMBvvQ0SLx/7L/ilapPj5JVi7/9oCKE/LzxyqkM++qrfjevKU
	 XyMusivS9kU1Vl62/2Fp8+kGhBj8Quk+z6m9W8NQGileQEmZCMzhamrEKmmlrXyAgxm/L
	 yuIu/nmHRJJLBnlYZ8hWHSWlbi1djNcvyA/39PxeIhTHa10reSsBhfjkwUP9C+713JKGi
	 4slJCH0/dtM/JZBOzU9StE/kJ/IX6zijT4ZQpHDGESKRkginX0r+KKp1xJP3nUJHbXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=L0KEmNbaeGUrJjWJfvOOPMv27yR8L08pJ0S56jL+15M=;
	b=5nTwD1aG88EEMWBggrHnC45z9ITTthu92Nm6e0gfzz9FXGqplUXvhoGoSMbviM34OZVC
	 moUrwS2lVuMVKpToWg5uEg0xAmmslylZtMBdDumexRB1iZhC6z5bDr1zj8/DBfWOq6r/h
	 WXYb9GDvGqxyszAeTW1vd/YrjWeCwd5Wj17l4V/wdB1/OkeTVEuYZNaPOYUvFQJczCFEg
	 swGziIBtblPoahS29nkZRxutlySl3f283hXFCbJ8AscumPZwSLMOBTS3MlUxxSvcf3nOD
	 h/Kak657LJT3m/VxeIpqPp5apyhFW9Ha+fUD30ALZ3UHjN+MvCv01qIQmEpfSDtBX/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VtKpFtNW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDF3606A31C
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 13:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CDF3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VtKpFtNW
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-677d35fd1d2so2449451d50.1
        for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 05:54:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794318844; cv=none;
        d=google.com; s=arc-20260327;
        b=PuDgL0EdAJP5xi/zZEOIWge8GmuDLTcVxShphaPoJxzo7eM4NRC4XP91Y0p2ZT1cIK
         tYz/I6hk+0Olpw62ZLOBuZJMkMMgArifXIiiicncsByx+qwEOj30fg4jqVwv9z/zkkJE
         1goBRI07/aK3iODacNOg8a17JJkI09f89+gXSV9N6GeJcvw6DzRarQ3ld/YFGOmE/5e+
         88UxXXs/7dK/prCOAYZWDDeeRkg1IzGYZGMBKp5vaSt/47oFXx3LihZH2HyhwcAElajV
         mrAd5iIILdESk0cpropubgObNNpdlmX2YZFLt/MslGA10c8mP2gIjG54xWPVmKE24CWA
         xeWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L0KEmNbaeGUrJjWJfvOOPMv27yR8L08pJ0S56jL+15M=;
        fh=QFKa48eN4AZKFIyrSiZk3FCE4nUKAEfyzhRYxfFXB60=;
        b=D6t2XzJnZCP5LO3iW7WEAZ45eooxnYp826KRu8+4ZJ54vs3e+G+9v8/OTbPIWAYwDe
         xU5eOHIeCIiB76BJuOsff6bRuFd3OVr3FDD44UBbtvMa4ly1zHAPiefWcsKCehHZG4Y3
         trpupu7GUYyAfBcpEUjsxhNTT6cg107lBNhKTh/wBhx4dgeMDpCJzcxiiPSviLyGh09u
         PWU8p7MaasIJvfOkeJ34jAO1yYWGZVRdSSU60ZW668P98AkW27G+qwY8PxeFxzf1CQLa
         UcH5K1cdkeDytOWfXYUz3vRmEiSGwHMX3baceWqZB0fpJKoNLiy8wBriORmqjzx86NLc
         f/6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794318844; x=1794923644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L0KEmNbaeGUrJjWJfvOOPMv27yR8L08pJ0S56jL+15M=;
        b=VtKpFtNWZqy0+l3rm0fPoHDbpmSuAzmmx+eOxQEnHrocv8FSSqc0GcL9bh36EyUqgO
         P0/xV1eKUYckK/nV3K5MMQuTmEPeSf1p89rB5nKM6bSZ7uvs2Z0F+eoyu6GLRKHZl8Md
         eroSVG4hXdPHe5ncLGrKPlWG5wcZMRh6Hf75lnX46y76+2tS4deyeYgd4AwauGMhCx7G
         P2XFHXA2YEO/BzT9LO2jtudQ5Jh8E0EgW/S7+BQ+7ieRTfiD9wQN7R7xgjJCXSKlS4yB
         kRv1TATKWA4RvYnkiYYgM6nUXRuOn9+5lvTPfNrqvkDEHqdZhys6ZDTHCOwPKOS/c/Z+
         q5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794318844; x=1794923644;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L0KEmNbaeGUrJjWJfvOOPMv27yR8L08pJ0S56jL+15M=;
        b=gjlIQjN7aXP3POtN0PatYO7ayP5ow7XdDuviA10IYsaIfsQVwSQeURFPUAX7k0y4mQ
         uX2sY0HnnQyARcXtIo6qmH4Th6g1xI3gFLW+BJgbDV98vs/2z9/xTqL5W81xABHCCB5N
         VH5QdBvMVao13FTtonX79Z5ght9Wx8/SwqivbBIS07rsUri/tArbmiqhoLdASWo7ymEP
         BSqs53efvxyVks1BZN7YIb1az4m7jB0LLC6NC8HlnUENHkz4M9OxSv9DnJoA3Pd9zuMu
         3eXZT8/d/eH1YaGr45HEeUE2vXudIWpRPNUqIGu5Iwg/6xqQX/5AcS68Py28fweXQ/kd
         56mQ==
X-Gm-Message-State: APuU4Z+qLZyNMQ+j2C3qIoHeGec1aflrFHc+kXxF2fQ4niahfgRq6WqO
	c5vBub+44eZZhpQ+zXn5OA+1lQZ8QHXLzzhsSecCRiUnON+hQZEgo0dUBqyYU6T6oKuDbJsRht+
	XutBubvE2XBbLXui1IDBAa/rQ5nQGsALfzYdd
X-Gm-Gg: AYBFou2JIUJjoGYZI7fe8OWfC02coR1p/9JwwUlmSLAEAS2nswx6WbsjreV+/AaukQo
	+lU9wToYubmTERGGyLWR1gAcTh6ZxIvICgFwCAf/D5NhJMKS1Sk7DOBin4V6pqEZ1cDSSMKY08j
	WwBVNIhI0SJ2+/fjggB4HKIi7GnAgN+OEn89HhBusCt6pGjNaMLegw3KKwCYR3xjao8Qb0dPhtD
	Sibc37iDg54a9aufwWUbd2gqyG+ONYfovdtOkEImeMUKa+9r7BWCh726Xh4KzPwDVzeZ3Zke8m3
	urn0nHCsNglzbPiTU4PStmwwNaB+xJDUGLQqMDQBDh7JPia1yfaMts5YaXE7R533xCTGipk9GKJ
	390tK2Py+4DOk4LErrd2yBOAe5zZJ0oz4iwWm4iD4qMHMlT6giyxSEOnsEFOlkqee/2KpOR/jPH
	BLnFT+J5AicG3MqLQaKFe7fCKHpu66BmU4DJ+aZEnqIOOk12xykOO21CIIcQ==
X-Received: by 2002:a05:690e:212:b0:67a:3a11:cf1e with SMTP id
 956f58d0204a3-67c56608be3mr1057104d50.7.1794318844501; Tue, 10 Nov 2026
 05:54:04 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109183427.146748-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261109183427.146748-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 10 Nov 2026 08:53:52 -0500
X-Gm-Features: AclHuK8BWzaTNXcN8-tIuVJlFwBf3jqY8rLW6BBuH6wINErhQrb7a8vEo7QJuYc
Message-ID: <CAEjxPJ6VjiUxQ-M5h7eDCPf=gEd054R931ve2oGzeDnDt6rqww@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: canonicalize NSS homes before deriving their parent
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 1:34=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Apply path substitutions to the complete NSS home directory before
> removing its final component. Substituting the parent first misses
> rules that match the username, trailing wildcards, and per-user
> exceptions to broader equivalences.
>
> For example, /srv -> /canonical followed by /srv/alice -> /srv/special
> must retain /srv as a generated home root for Alice. The old ordering
> generated only /canonical, while runtime lookup used /srv/special and
> could no longer match the generated patterns.
>
> Keep the original-home filters and reject rewritten relative,
> root-level, or ignored homes before deriving the parent. Preserve
> conflict checks on the canonical parent and leave explicit-user
> handling unchanged.
>
> Add a standalone regression covering generated-pattern lookup, rule
> order, literal and wildcard mappings, two-stage substitutions, ignored
> paths, root guards, failure cleanup, and disabled NSS enumeration.
>
> Fixes: ff54a2d3cdca ("libsemanage/genhomedircon: apply path substitution =
rules to home directories")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This patch has been merged.
