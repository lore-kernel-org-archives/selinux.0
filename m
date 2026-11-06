Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793994851;
	b=Bjd4rk0WevJ/yEPrE9qlgFVV1KOSKeA32DuD88UvdB4NWusjZOmkPqeTyFCOh13bX03P
	 yinEH2MoJbRPBT4wzbL55HfHj+m4l2EaBMoRi5DYaX1afK7yX1G8ZVHwjhKrsC1x5Mvye
	 KAdKLzaboRpuVwe458Rn6YutLgbEZWbMeBS0NWw/WnT3af+zlxTnf2YbYY3Brn+nuZRfZ
	 8i3+Q7WGCFigmtuJpnwfiboxBm+yq4aOdZURKmOW3Zc/6dhrf1HPAeDVuZflsViA2t6UV
	 gMI2gjHB7D8xn795sN4HbPXc+O2xRJUvhJlxKeYi5OxN5pt/WRB0pC+w+Y2UFyOvvsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=O4/BKSrfbPeGPim10wKwPI+FdMk+5LA6+odvxgoI18s=;
	b=g4VUdsVKUfWYYF95lhrkIsekMCE+VKBeS7VDJHjg7vuMXNpXDMogvO/CwuIgGbG/vTqr
	 SnIn0VBAQaHUomKa9Jt+75gSZjgQ9CW59PRpmo6VJf09iHcgjhiLnGyqI9t94f/Wmgqh5
	 qw5ibl3iAeUN5KWZRbHfISEu3MP696IK6hpFuUMpN29P5luiZrnXymedKGUOJ/d+3HuFn
	 ElDFgrKsQ/ynAsugy9lFapbAUxPwQSFEPuzKdrsJAMLvZtiedjJa1eCBKvCXGmEo0PfaG
	 VbdXm4f2w7JFLy8Cb33ubYNyMdHu4QTrt5dq/6IWa6OoSWaG7Ks9qcCWebseIr8qZsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kamnkCrz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E710B606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 19:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E710B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kamnkCrz
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67bf3c6654fso1096833d50.1
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 11:54:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793994850; cv=none;
        d=google.com; s=arc-20260327;
        b=DOcv7KEsqinkc4E2gbyv5WTN/XhHvk50f7ZFY0YkWVR8iPQUK7+FvW/NodwPtNSdAh
         lgcHsO7pO0uGR2LSqp4VzIac5gt+bHjeviQZQIAZirBtpoFIpP/BCpfHRdTENMdBD36m
         xTvUPwZW8kJL/TVrZIe6x2xZCmn0SqY8nN+rBwwkmdqzotoMexDf/qcw3crU3+8/bXrU
         s+QQB2Y/pNuCiSlpdSKb211po3PwNzev6tV3hFjkTQNnPfsu+GZTpTyN3kyPKNFp5av5
         dBPwYwEktZQ8ZWHuLyENYaBpTCW2NK7C2iNPDLmpPJtI5hn8Yv3eoAUjXONkOvuhmZFw
         ckuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O4/BKSrfbPeGPim10wKwPI+FdMk+5LA6+odvxgoI18s=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=H+qptik6cUcA5E3eM8Bhlz1//ThbzVNx5guUXH/bHwSlxwS/EZyzz28WEknwrlMMtG
         +VpUOnngiLe4mz7XM7CK+SZdYlS6an9Fph1OhcX3arvzYOD6aGPU0FUE2LtVuVD82iqo
         5UcMlwj5DOUc4HLPQ/7bjAxk8n026pvqiOhkfSi+vbsrNGcQ1iVZaf0lKd07bhm44Ubw
         KvTiZd6H3bI6CS7N5+oQ/4iQKttVEqqV8eiAEgd50SG4FFq1tJJ1qsGXvbPeWmxiYJtw
         urrHHLcmhBwClfADBb1qbJUan0wY5w7rfH10c/ZiBJtXk0MyZmQWv5urrs0T6o7eaqGI
         WGgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793994850; x=1794599650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O4/BKSrfbPeGPim10wKwPI+FdMk+5LA6+odvxgoI18s=;
        b=kamnkCrz5VCEpD6NC2hUyrz+cKdE0CTP0sv2u2q7PS7QttWYkJ1VlxxP5wm3fCq+UR
         MxGzhCAvfCuZ2NgPdo4SZxAh0JobHdttjlVnB87/FwmUWn+wm/RO2shpz5UvOFel3wR2
         MTfx2UwnVuYOoDWVLsL+oMra4W9OAHhlgOxTjx8Vo4FOuVIAdggxnyc9nb9RMFwNiWYW
         h8QBBGC4JOSyRbNWj8xdFgorXVQLUNMHBfJ5Yg98xMYJwH6ghudj1WTo+To5EH70ND5u
         rvtGaMqGT6oXaWzdn5P9rncXZ7kMD/DXJ7Po5ilFpROiFb+1W00qi8FH+ZZxbAh9M12t
         ls5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793994850; x=1794599650;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O4/BKSrfbPeGPim10wKwPI+FdMk+5LA6+odvxgoI18s=;
        b=sNY0da18w0WyGC8FbFZ3L1wFqgm8/ysZH2O0A+l3uLb0OQ6npYyobmWncO6vaz4ZAj
         CCgPJMVuSmrf6f7qPBK83+PZUBNOCJCnExCuYCd5qR1BpI39H7SQFtkmoV3kx5pC5SzD
         r9E3ImenerHJqJP86Klb1EIT0ABSPAcJbS2mfmUO0ZLsIjsP5YqRIq7hsbOx7FJ3j+HA
         R7VXsyQDcU0McSF78KZR6apcC1qBIFuUe5q1VHm19wZWvpBxbt/3rgfP5hk6zmgaYXP7
         H8oTBFdiFfUBzb1ycVx/Ht/XKY4SYaW0cC8RJry+ZMzm1rsIw4fGZ1IPznHvt71NVvvp
         nvoA==
X-Gm-Message-State: APuU4Z/W+VUkMseSs88TcvVpzXoHI56qBZ/TELicUy74HFhp4ZsRTe25
	uZGigTO8EHagsx/qWxGeeOhy1a2dXOwrQJqspk18P1q9aC0j9b/ZF8JaSgmgGuaP4V/ZCZ/JGPL
	oeNuUVGVuGpsPqMD68IwhtMXqT1X9aeISTSF+cMI=
X-Gm-Gg: AYBFou12rSp+NiIckHaUZKQ1WEWpgXKkrRLGDurfji+98hJHmGQVTEWYi7xUWAo2JxT
	AZ1QSrRVl1SXhlKzaxESuyWsFsDJB555Cw4yFDMqQwhVzFr2MF8Xf+Wy5te5By3YDy7JCOoynyu
	OF4cf2n1bWzW70/D2vn75bhzqoavisSSR6/YTeHb3AZVOwn9RaMc7D0L1avbARiB706E3kR0ZmP
	2mYxej/vonH47hTFcR9b3NMHlZWz5jZzeE1chmoTqL4clVUrosE5WjRSnGOK4/58zy9deWzW+AL
	YzfZv+uCl+TKq1Dsc936gzYHBbLif5enMKPDcWMmjL4s5BV31M6515tQSPE24QkNFY0CD7WJi+9
	ca9YPX9+coZMTmSM4ys++b1RSx5zdzC4r4mBoWU2+reslUtGnq+LlUmSJftBw/1jOlrsQOCq/On
	1ZBxD/tw+hoNhhbKIButNKaVP399qN2FIaMwgtXqF7rmtlddAI0hCEmwntUQ==
X-Received: by 2002:a05:690e:1505:b0:675:c1e8:d522 with SMTP id
 956f58d0204a3-67c146028d2mr1371260d50.134.1793994849638; Fri, 06 Nov 2026
 11:54:09 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106123510.76727-1-cgoettsche@seltendoof.de> <20261106123510.76727-9-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-9-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 14:53:58 -0500
X-Gm-Features: AclHuK9hrwKgE6907wszSqCapeg8rLSgLWuYl1OfEZUOBHoxi2ZxxFOqUv7Ji2Q
Message-ID: <CAEjxPJ6qJNxFOgX-p2V45Np445Yo4V4yOWsgn=MUNvjtehh-Rg@mail.gmail.com>
Subject: Re: [PATCH 10/16] libsepol/cil: verify the contexts of sidcontext statements
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:35=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> __cil_verify_helper() checks the anonymous contexts of every labeling
> statement against the user's roles, the role's types and the user's
> range, except those of sidcontext. An initial SID context whose range
> exceeds the user's range, e.g.
>
>     (userrange USER ((s0) (s0)))
>     (sidcontext SID (USER ROLE TYPE ((s0) (s1))))
>
> compiles without error, while checkpolicy rejects the equivalent
> "sid kernel USER:ROLE:TYPE:s0 - s1" as an invalid security context and
> the kernel refuses to load the policy. The same context given as a
> named context is already rejected.
>
> Verify anonymous sidcontext contexts like the other labeling
> statements.
>
> Assisted-by: Claude:claude-5.5-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
