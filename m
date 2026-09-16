Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A57352021
	for <selinux@vger.kernel.org>; Wed, 16 Sep 2026 03:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529557; cv=pass; b=Mx0DOpbYU2BbHDIVsXsJ435w4Y9YemG/O35evlp3YoUXB3/h/TqoDTgXrKMD2QJIGJXTiT6qa8padsG8Baj2e+G2nubwPYGVnBKigeM+vJoNpWmaPSsk7z2DtMUnbjr6Myh3OTLxk9e8nbee0RBR/BlyzT0ZWnv6e3ZCzwQeMIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529557; c=relaxed/simple;
	bh=awJZqiJlCs7vKgMBdkjB6ZA/qV1jULtIkmNIcL1+2pY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swBgN2Bxkg0jHpWltWGIb5pBTPTi3I35irOlBt8UpYvA0iSZJo6vKdSGnlWGV6+V3WTiCDMIRZeqs89q0qP6wO8fF0vRJm3NmBTcoaIx3nQiXtjUbFPNEm0MylstOcTJQeDx1V7pCHv0ukVTxG9egLvdBBkQdZlxR3fS6GjxY1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KdRMNQ6h; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KdRMNQ6h"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8692a8568e9so344126b3a.3
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 20:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789529555; cv=none;
        d=google.com; s=arc-20260327;
        b=HMSoNRg6Kui0pSHf0aU3WRrcTlVLoCFN4MHtSw8ypNrgLCMXJ7gO3pmuvrvYcZR2CS
         i6V/Mbh1XNgvSGOrfHpOVemZZlm5h+Um7qgYRi+6DymWS7hV73uhDodUqybwbH/6KyC2
         kvOJw5aGxLum5El9MzBKG6A/8YMe6awNbGO3WFBHDVgCXBvUXl0QUFGLxXCdlsgMJt9N
         7deCDrxr13z+LjhlihHyOY83ETle7RwIiDVJMV9WtUzDxc/8arlq2oI8Nl4tPWJu8tiG
         o4GY6aCIPqyXlTgmlw1rWUw4UhW7XRcrmU7vH5hbAHntWZYdz/7BtoQZ7fk0rNxDou7C
         JjaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZZGiDKwj2R3jFYZKWyR0Etbc/+MS14NnG4Mrli250L8=;
        fh=HNsrhB71fdoO+juJHXjXQATtTqTaFBGmy52C25/oqkw=;
        b=QmkSKMiXkoDHEIqc+2syD5Yi6/bSX7vwqpiSNeEWZfRkPyjxgRhhbY9IKy4ROP3dlF
         qJdmQLCVoIuRv4tmNmCUxlPHU9LO+t9WLN0wl8r9tydS/J1ed2by3RkTXQ5Gb/jqjwrO
         R5IfxxlrLn9sTlyIf2u9aJfYUCwwinUoAk8dbMofzd06LF26dvc46yJIo9Zt5u2XSk0H
         5Sjjpl104M8g4TXiarLhkMe1VJgQ0d5DJn1lF7g5CIeXX6QVGT6NTHkOMc145dPCFhEU
         AgxAGddcsUixbgooAcRQIl08poERYdwq9evjbDm/sdNoLRJX8HuCsg3hmDPsDc4FNNbj
         yh/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789529555; x=1790134355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZZGiDKwj2R3jFYZKWyR0Etbc/+MS14NnG4Mrli250L8=;
        b=KdRMNQ6hHyyXrlh0N8voX7qGWCFZRfzOw/gKfGskbBMm6ZPVfv4fPRqF4UEide5m1L
         fujVYiu6CAr1gA7E24MSve17C3uQ6ZAKj333epL1AQb7XBGDMyLLFJE6rPly6js9UAaG
         GAbovCrhkOIEFvmcj4aihQRlyKPT5FknK1+FNglipR2J3BOwWjDiwtCX9qqmF25ZDCms
         QoojN5+JzqoYyFx+wjDsRKwzVRbdthv3OdnPhj6Bqw/owlhUbI+V4NubH0LrrD+BRttb
         OMRN1IpOphyd2P4sRoYJdDYDlHxlA4rR3Z8mhJCrayYH1Vz28eKdaT7M6rMFp/EgYc9O
         cTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789529555; x=1790134355;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZGiDKwj2R3jFYZKWyR0Etbc/+MS14NnG4Mrli250L8=;
        b=WkljVdMewAxZQ2bBWIQohnPPLyUOJwkIdKcpzJ+1I9qoa1K+vMmsgHQwZjPT8ULshb
         RsIrT+THiBmhMGFj/76izYcWXHrDL9oOctg3KkZ5jUCVpHCE8tq5SOtAoGDrRLXu/5UC
         fObEJV2tROvRUwv7s8nsNO77Jh+QJQhVe6jkO++BqkbB+Da7DN8cBcqLZeIROMmEveDb
         u/sUzRVbL06oMscosrebcjundXLMxMZytFuVAcFrEdkZsqc2HdxOG1dAqjqakf1REMAz
         OSKg0XD5iomVu+LoHdM6jff1u722jTuDhcwb/Ra+INUivqCZo6XK3Z0WnH2XXb+q/aLx
         WcLA==
X-Gm-Message-State: AFuF++mWkDks4oSVWpJz3Muc+FKILlhPZsijlf0DTa6PilZDCZKgdJHh
	+FjxVW5SkBBY+ui5HgAqAe0vmdgnLk94DSMpxzecrC8bBainWMUnT9dMTmnL4Ev3u7VZZVTjPoq
	bUeZ3JgKH3s52YugjktGGe2R8zvtCeirZFM5WBcTIqE51Wsxo6bwxVA==
X-Gm-Gg: AYBFou2CCgxUhHBmRo4OfOxi6vI1zuHfHctpqQk35FrdLoX1hC7BoxjhDEIvbyl4hcy
	+XmYTJf3Gc3faOGuhacTV1rBje5jS77KIE3otIJpr34XXSuuXcjYAnGCJT5Zrln8Lxsq9OjsFlT
	Hdx/dKIzrUBEagrKRKElaDsOH1nRiVvEfB1hwa/jjOweup98noG/DJsM4NcfbRlLhdSDoU2pci5
	9fk1LUcm4c5h///eMqeILSGKowSQigNMa2NjSK/I3MTsyL/+/Lo/YsIfwIXAs0JY/Mf9sa8WyJ0
	2bMQZgi59FIbclbssjbSTPSZQT897C4ZCn1rvs1XiE0D2pF+7oVxluFtHGm3XGSYxMYbMH+2Wmy
	R4Letm79wgfU=
X-Received: by 2002:a05:6a20:9395:b0:3d3:ae40:51e5 with SMTP id
 adf61e73a8af0-3dd5f77cae9mr2526254637.25.1789529555224; Tue, 15 Sep 2026
 20:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915213807.481355-2-paul@paul-moore.com>
In-Reply-To: <20260915213807.481355-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 15 Sep 2026 23:32:23 -0400
X-Gm-Features: AcwNN1VVqfDQOzfm-hfdN2akteHJA3g95E2MYQYciOQiBcrWfXRJHfJdbeAmFww
Message-ID: <CAHC9VhQsSMCZUH-LvmMoCK_7t-bdCDcp2YhYjzKt5YbsJnqXFw@mail.gmail.com>
Subject: Re: [PATCH] selinux: avoid 64-bit division of inode numbers
To: selinux@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 5:38=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> As reported by Arnd, a previous change to convert the selinuxfs inode
> numbers to u64 to match the rest of the kernel caused a problem on 32-bit
> systems:
>
>   arm-linux-gnueabi-ld: .../selinuxfs.o: in function `sel_read_class':
>    selinuxfs.c:(.text+0xdcc): undefined reference to `__aeabi_uldivmod'
>   arm-linux-gnueabi-ld: .../selinuxfs.o: in function `sel_read_perm':
>    selinuxfs.c:(.text+0xed0): undefined reference to `__aeabi_uldivmod'
>
> Since we don't currently use more than 24-bits in the selinuxfs inodes
> (see SEL_INO_MASK), fix this by applying the SEL_INO_MASK to the
> selinuxfs inode numbers and casting to a u32 before performing any
> division operations.
>
> Fixes: fc68b6a45f16 ("selinux: convert selinuxfs inode numbers from unsig=
ned long to u64")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/selinuxfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Merged into selinux/dev.

--=20
paul-moore.com
