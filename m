Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8301528CF5D
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528326; cv=pass; b=pqz7zQ0satKwP10myKKUqQN/e5TGYlRX+KSAQlz1QKCsB7ZFURtVTvf+916QD8GIxhfMDS7a29wGPLGz8joxfbnhyLfEb9+K8NxvRolC+g4ojCcdFR7twNxTwmnu7l3Hka/SCtyj3kpY04g0InhUmOlmgOKEgC8oSq1tu0yzWvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528326; c=relaxed/simple;
	bh=f+D2ck3YaHHAmAxWo0yCTKZUUiJGnTjFjBWg7onrSHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSUxV2r5ECHJFA/oNx42o3s/xaULd2akGSAXrO9c3+iMDFRBrNHWTXb9HqzpEyrsv+SO5It2im50CWhKcaQ4cY/L5BjtQ6NUKl487eYe0fGowYDrU5l5ebYnXSDJ+uJiYXC1LshrgFQJAceMXG7jGrL/fHzS76fcIr1kRmkRqtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTCEFbh/; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTCEFbh/"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-448b69cfc6dso1164428fac.3
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 13:05:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785528324; cv=none;
        d=google.com; s=arc-20260327;
        b=slm+AIwsp/4oqOOgOHhxTxv88oUNGp65w0nTZ5DR+Sklmmk3SwODhhqO+FrptALXOd
         FZgnr17Zbzx2S0g4pCv77gDM6+2wOAct99+A8DcXD2Ifz9/+hgRQSJRcELN4MSgPbXtE
         0adnWdC1Wjrpnden+XzapOLcLL1yrZx2k77mtziHytrQEadpMyO7TUnITeFczM4ON7R9
         K33s6hAiMtalbah4eYrhSN6adtP4SmGVdmt7ywXOlG5aH8x77nxe6UTmz8pxhbwLRt6H
         FB4CpqUlcG0iXzYEd8D+xeSeB68g/sToIzNsXSlQPgufzD25gx3Jb8zwoIYmjBBZnDW+
         mo7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f+D2ck3YaHHAmAxWo0yCTKZUUiJGnTjFjBWg7onrSHU=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=WEWdUTSE8JuL6jXdcERV1A3/E7kz8DcRGLF8I4rS7+ot0jYIYX/Xwi+V+bDcw3hGVl
         d4Int5dq3SvvzILd39DVCywZbzwgZ0uzMaEIPLfjNwJLplTJw+bKpX2+UD7UG3/FaArH
         NewhtthT+KiyxgeGIevpK+sTHJ8ASVUtJB9bB4ZlBT53uwZm4bQeVMm/5fp0sdoTXfSu
         P/8m066KUICIwPkpDuFk3XC0mOjlWs8SxqhTAEq1dkgQRt8zsy3avF00+ri8MCc07iIl
         L7T2oycZWrm/7QD85sBs2k47dDy5Oo798Oh3ctIHyeQNMHWXqW0apNqtRf36BsxBXoaH
         KwdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785528324; x=1786133124; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f+D2ck3YaHHAmAxWo0yCTKZUUiJGnTjFjBWg7onrSHU=;
        b=gTCEFbh/AFJ226Ek/gYPmgconRc/W11Ae1LAz1NIyDXpbu1PZRq9x9cWGOcOTTNTWg
         MfYGicvrN/+vXiz1holO+vk+bZlle9MjriyfKX2cw0YNyvSAZ43CTv+DgmMy5j7MgXUH
         fPiegwAUXMQqVjd+GLaMgsud70q9sCUUk69kiK+Ql2oROeM2WZ9yenzL9YLhVl0CXyth
         ZepWg+GPWKH5viFi96Czu+c8ct74pgk5iWkISTGn2GR5fUsg9q00R9vPlspTOIabtglQ
         wbFSYI9HONnuf/KHVJjFm+/4mV9JbuK/cFBgULWtiSrWsOzZDTZCyISXRWwBi6k3D+3P
         1G+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528324; x=1786133124;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+D2ck3YaHHAmAxWo0yCTKZUUiJGnTjFjBWg7onrSHU=;
        b=R+4I+sGYtYka9ycj8WLQDzGPnXFJ/Dfp2kaILuGryIVH0CoYAfRxPiQawimfsXePUm
         KHwA8A6ifCmVzjU2P03Tm/KL9J5b9w39LYdQ13GXZ3pdsL66v8V+2cDMmAxolojnWxUj
         msGnXe9U14l5tjtnOxHZ2lXJfOy8HczSnBf7f1C6jNfG7ppNVlbJlwLno0IfpdyFbrBB
         5U+NdxOTHYVWO5hqwKLwdFi9WKyTFhBgpbST95H/N/3yHgESLV7zhKbLcliIE5/fhB7u
         Zn1Za8pgpOMbeQyQxVzop+PQHMbjp2L/9uwzhEUroSYOCdf7/H0moIjpggEYlta08DjE
         crcw==
X-Gm-Message-State: AOJu0Yz5ra/CRNXK/IU6FK6bu7UWZ2wRwepEDdiEjcKCShkHwhvUgG6G
	6qhWzX3nqwkMLlGeD2U5xTuzeXX3UIBbZCDgj4SENu1DJt4FvJY3eYYLKbMXo1XDJ20q/kSEHb9
	/wta5luDZdGLP3aPMrxVoSFNFbl+A0L8=
X-Gm-Gg: AR+sD10jYxPoJJcrA0caO/jNxqAnP/1nDEl6u3arx6xrfD65iy3f6t44F4srX3wX+b6
	qaVcxQNubCtpL6f4LNM0sjXRrDxFN1AlX2MMqgX3vkbJSYsSEeYmUyFUDqjEfuW0a/tBt+RqJRD
	oY4o2UYuzMG1lNIstjSXQbYjIJ36lMf6EPkRpIXnK8/FdGu3gUBgUuHzKn3pONp7nuQ4zH4f7PJ
	xP2+F/ta/uxJ8OQhx0vx6aP14hpRfhSGfXhLY3hmbobjbx2/QaNam0B5u37DD3xBqdUZdPGaZ6F
	Tuk9LyVCEOrA+6KVKlcZzFA903taataq0oSNVGu8y/7V
X-Received: by 2002:a05:6870:16cf:b0:43d:7b24:96 with SMTP id
 586e51a60fabf-459054ae264mr3007092fac.0.1785528324434; Fri, 31 Jul 2026
 13:05:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731175123.52557-1-jwcart2@gmail.com> <CAEjxPJ4sSm_jEd5MvziAqVGLMZCv91BLnwdGTpKEvACko8BMgQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4sSm_jEd5MvziAqVGLMZCv91BLnwdGTpKEvACko8BMgQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 31 Jul 2026 16:05:12 -0400
X-Gm-Features: AUfX_myz1xxtfJ7nGhJn28avsWBFgs4PqUmxxZ5wNWg26nPMfJxrLISQ8iVEKPY
Message-ID: <CAEjxPJ5ASW_E1xgzHu-yX6JBLjwXfh-XuGS5S+PcWz2SOjOQeQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Check for zero when mapping identifier values
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 3:26=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jul 31, 2026 at 1:51=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > When expanding a base along with its modules, the identifier values
> > of declarations are mapped from their values in the module to their
> > values in the kernel policy. A maliciously crafted policy could
> > create a situation where there is no mapping. This would leave the
> > new identifier value as zero. Identifier values must start at 1
> > because "value - 1" is used to reference zero-based arrays.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
