Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28521443C29
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697242; cv=pass; b=UJmIufvhoXIZ/0mIzPcM17e1TfS80mxeCZoyTim57/hO0Uk5DZtANHYkThza++ebrEb+tjlvwr47Z+muzZB/tqOALYt3++xXkXBIJvN6K8VpCHXVWma7D3tv13q0uv8Y2T4U2yqLAuZ9QOReuAecMdI8pV9igDRrWF34PW0TsIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697242; c=relaxed/simple;
	bh=Zwy56GNm4hRWIz87eIIJ/LNafALntAO6MnkfJRHEWoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0lOkH7YaM499psYFXOX+kG3Sam8X0wP+uOpqPV/79BhbOECfH4krOeHlDT/s5xvHpcl3N9TSJ0EhVwuxwWBUOD8yMsswza/lKy7dc/XixELw1og2mqy6nSBu4F8xj7yR1X7zQbUUJaKRAt7BYB0st6slroZe8ou7NFLxtgEev4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVEXMdRe; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVEXMdRe"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8abc87cbd93so428657b3.1
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:54:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790697240; cv=none;
        d=google.com; s=arc-20260327;
        b=IRFdBnZr3Wj+rKmBQdloMQNmjt9CDJODwUmrRDBUdaSerKybNfZMFLA3bHuXHfnZwi
         inqIA2igRRZjxsDMJOpCSa3KLlc/BDHDG+zLF9tKDbTLfErSbWQEB7VlU4Ruz/j8n3RP
         Okjs/rhLLY7R7ZiqViVOfuZJHAM2PHeV1SMAY/e6V8j3aHNSZbuPRksIAPibBu13iF1H
         4+x6F5d2pciiWSvutBNUHmJzsEiBqi2sWhD6QD7eIEn5Ybd+dC6RhJCAPSLVLIxoRM/6
         t1+4XPHDbqYS31FUdB0EA2ofIOSalXzGyY/k9Zv+7lUKRO9W9A4RFV8YR4yRJ157XWGe
         LkKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=15HttzpEinnjHL1r2fsAcdLBkMhVzD5me/cFU6glEFA=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=Vi4pC3XWsXkOxi0qqGtt6Nqmgg4MM6524B44UL+8KNq6O/6wnQ9IdYcCeP5PvfGzZK
         1IsPamFs9X+PmYrLRgD6SFG1qk/vyLeMLuF2nOVpEvi1300flZV4+hI3WQ+zgmyllDeN
         5KqLsSS5aGT39llF7XydU+9g0yxBAnD8enK0vQvj9eHrmollOViDj3KHX5KYcAqtYCui
         2JVkAVxHf32zbFuRZq4zp8xsXCHYIQiqmmnuRjNfKqKV1e5Hw+VL6NKcd9vBU4O1pQ0r
         VXDnny6je+NUQcCJjjdNZbWrxq9E5qxZbCXYzpJva7iGI9Z0N2y+la6cj1XTUS8bNcZc
         V5SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790697240; x=1791302040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=15HttzpEinnjHL1r2fsAcdLBkMhVzD5me/cFU6glEFA=;
        b=WVEXMdReRg9eRL6psqNxGDPZV77ikTqXIu4Yg3CpOrwaBLggfCtRAf4gYWeob+NGXQ
         C8CqDxEHGLhTKVNUlHdc06YBA8n0gAF4FNiMysOGVSzjzJ5WHinZACv8kwlBKkjaVmzV
         Y+gMEFofrJ66oL91+AFgOhJwtXfpTq141S91FpHpligpVeFbkiq6H739w1Bc2HMVRR0j
         RI0DdIT/Ha5uaE+v2QGRFNk3vbJj0c/Vg4gcGjyOTAMo0EQ91VAJyUspI9BJF36YXVz8
         6/lOOarch/lZGfJ1YCXzOhD7SCoZmlKDng2pZUlRM/zarEF7P4CbQIkTkUS6qQ2gcCrb
         YC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697240; x=1791302040;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=15HttzpEinnjHL1r2fsAcdLBkMhVzD5me/cFU6glEFA=;
        b=ynaWsy2uF3u2y9ngqLHIRkbSFido72BXoQnJGVAcqhiOZZZbT6O0sW67aEVHYpjOUX
         +erQdzbY5HcZzctLPH61+MKd2qy/OMM8AwtpoNSkwpxQdLTxYalR//5FOYzWP3ilJ0xK
         mSz/DMsdThOSClrr6bXr/fgRshN3l4R6p/7Z1fJfX5f7MOW+H0X1HropGRAUzhuzCMAR
         xK15SOACXNMMnsU/lQ0nkYLOC9x8a4cZoZXDk/s4I+4f6ytmsCBV0GfjUPmWKVtDKU+0
         TwNjZ9tdUNL0d8RqFYDiDYiDhTV0V2gNmHMATJv51UMa6zxn+Y89f1Lcw3dBRogp2ici
         Fvcw==
X-Gm-Message-State: AFq9FYLKlGg5EPRxhraKaoG2+mCwMEVE5lm+bHH4SE5o8TRhaSKKyMgR
	2c+3LoOcImmUXN2HMOBfgRW/twxh46f5Mp/d/U17nUHb3AL0jOYcJT2GiITWjRe6dIjfdwAEsBf
	VMDWVZd11CmkEwyOhZhYk9bPmQN7uwD937VEy
X-Gm-Gg: AYBFou2XdXjHgsSXffe+VeHHyX+vmr5a7EUxtokeSz2q/GsOaFrvogb/MRW1VaHFoRh
	uocUkVtmiMWIMb9w2aQg+QNCWUW0mldvbyU9QWk8bvdS00wp210Cv2gHV52W8DLYQPSmrY64Oev
	Bue/n+myY49QgvLZiPb9ZbQgHqWbfnviHNF+ZCPN7xzvxPvnowMM6WtgHLb5RUzbWYOwWMxA0za
	pCahLUeXMomcC2CjMhXpU/xcwIEEUGT+OUvxBdxiv3MF2RD3wFDQ4DE+w0G28GLhT0jPfLBErPq
	YHKHjtq+lRfIDstUFDL+rZLJuZ78rSTKAK+CwpK0yXecxLezxeJfjK4=
X-Received: by 2002:a05:690c:c50d:b0:8a6:1f92:1f0a with SMTP id
 00721157ae682-8a64c232d67mr79340587b3.59.1790697240034; Tue, 29 Sep 2026
 08:54:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-21-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-21-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:53:49 -0400
X-Gm-Features: AclHuK_UmyhzI3DZyFVAk3wId1sWbY2_zQGIv3dJ8CnuhEoy4pTkCGWJKPqsbSg
Message-ID: <CAEjxPJ58x_2z1LxQb14bbGZOUL1W0LOGuuGGGzFj=PP9gi-pAA@mail.gmail.com>
Subject: Re: [RFC PATCH 22/32] selinux: factor out constraint_list_destroy()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> cls_destroy() tears down the constraints and validatetrans lists with
> the same code.  Move it into a helper.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
