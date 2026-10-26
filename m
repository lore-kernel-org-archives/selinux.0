Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793022077;
	b=RYzPwOHCLPrEmweDjgRPrhJh+Ri4UaCniCeN23/vWjeONEspeLxfrqionVPG/mC7e76C
	 lihmgIYnEzYVBtts62IVvU/3e4/XcbW+e55ZQZYtGGlk7gBD/F1hJ2Ntpg1YXidH7yLqr
	 +2Ilh577mGV9UwDijlDcHZrsimpqs4vR86xT1bkZ1E5EHwEIbMypwGVnQxK+wpGWvbugM
	 klic2xsTNRW0O6ScWRIRHBd2NBnibAYYwke90Z+gUj6IgRiGJMrsjqhLTWdY+ftwlot+m
	 n5//IuhNr4zkJoc2BZOrtiWwGGOFHsNBH/AgDyQOiY6e8vHFXNK5PZ/hzdr5AGtyd1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022077;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=b3ynvQQWB7ocdlTzwqkWvrAEm8/ZVJMqte37ZoiXWyU=;
	b=bI6OmDTwXtfA5aMQkkXa/maikPONSADpbzP5m+ymLlKmvGmZisjdiAYVedDv3kdJDNQz
	 BRnbOR0YKznsnzakZJfQpRh8/Y1C2XKL0Szw7cMXTVOl3xbvp/M5wb+czoPPhlNg65mT7
	 n3phZIwfXL8qzGRDfbVHAzuqtb25ZZ2GfGmXJzzPxvKwNcDGvtqdW9Yn1YiHG5HTQ6aJB
	 vU1/LkPE6BkKxI+6DU+IpQsKSutnzaRP3KvdiYn6nfAlrEQZ9q9FAgoMVR3QM8jY5hWDn
	 4ysdKhZWMs9Iclr3kRBNiEARtiPjiLF1i7t1O7xy7ZRztziYME6vy4koKUOeJGIdD3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T7CTricN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9E3606A31B
	for <selinux@vger.kernel.org>; Mon, 26 Oct 2026 13:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C9E3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T7CTricN
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-679a2297c55so3549794d50.1
        for <selinux@vger.kernel.org>; Mon, 26 Oct 2026 06:41:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793022076; cv=none;
        d=google.com; s=arc-20260327;
        b=s87CTFszbckjpwB+5k7bauLL/mfS0hh4p9iQhKsk/3aOHYwNcz5kQdkvNuzdsxnuyd
         uYkgxCdoFdoqM/n/TlSwufMqqx8vn+Wwa2JK80sRcBRsYEGNKLqqPqcM/4Pi+yqU//m+
         Lle5evGltiW0bhyP9OJuk4Xg2b523aIZ2qRf0oWyfsiJspRrc2ysv1xnx/Na6OEMQtrG
         qEoW399721aUpJ3BmIFPNKyebNq7alcZQe4d66yhR2P6TL4D9ppfHNbSXON1boKgq7NB
         XXS/rv4fKC4NWh47XK3Korz/luLkaEC/di72IgJlCOyBtSrqCcferCHNLWAYFNhQjauX
         knbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b3ynvQQWB7ocdlTzwqkWvrAEm8/ZVJMqte37ZoiXWyU=;
        fh=oY3YJwlQJe6qc1tfsT1YP2sL1SDhL9BUcCb87gGht54=;
        b=OawkuUGEcboHGkvdspKIyFTckXX4AaTulJN1/aUfhv4o4KT5suxAgiiYXbnmiD2bkS
         dvGfUBUp7xEdaJ8zK2DS2cXDZODVdOa0mFPiQnFhyZit0xFIJ5jFvJUzjqwCLTVOT5c4
         w53Uq4rq2qeOnK5tWynepfpObISszblvNGP4MLD8xu7lQCIrM7KmlERQMuasLJdbnRtX
         JuQjMmYjarxsweKVzGt69xmQceds+tQRrrEPUw9KswnwlDe7OzwjVGZcm5qoBZN11fxQ
         pv1t5matadkmeG6D854MSzSZ99pBrpIsmDrvMQxUFcmdbVaD+cLz6A1x4X3e3aVzP7eI
         GmgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793022076; x=1793626876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b3ynvQQWB7ocdlTzwqkWvrAEm8/ZVJMqte37ZoiXWyU=;
        b=T7CTricNaIVRkK/7h7t+2vIg+6J6n7L0c05uKvytaUSZC4ch+LQK+r/idlU9Ri6olF
         zJFEPmMyDB6MC7pv6ogJa5aMUIJ0Kbg4pR8qXRN/k/w79g4A3t6eXqsB5wXw79pay6I+
         0ocaBcNZbBAM4eSbCVNp/q7UpXJJTsdIMJ+YUt6QuOSmFNAUOWUEsOkzqfhvUBW+TEI3
         x6mHu0q3ib014i6OfBHD1PwpWuzbxfp4GC8ubGww6XzE7njfjbooub8f8Mk52xYRmCCB
         GCtWl1hQVe7B5+Za1+REb5V3uCiqSYDhinx1gXXjvIyGUEqHMZB/BqiM3+S+1xIOLSCT
         rz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793022076; x=1793626876;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b3ynvQQWB7ocdlTzwqkWvrAEm8/ZVJMqte37ZoiXWyU=;
        b=rUytSUdO96QYzARJwLx9OE2azg6lLjXYStSn3FMCrb7oEFk8FwNXg3cKkSiJbvQb51
         YL5Fe0+j1FIQmfY/y4uM65rhW7xDJET3G1pS8/7LsRgcqAgVAEP+h/Ons0VJ5DQiKLOd
         jQLYVMrY+pJ8q/5wCqhNmZiyVHCMs7fD+GOCjT25uZcnj2DwUX6LfX5fNLeb4gXf6sSX
         +lfEjonSommlymLYyqxBo1bfaE01uBB4UhvAGcNHmuxMtEUKeRVydR16xLOIZDy/94Aj
         Wc8Lh+W58QQy6GMjiEQcBbK5JfLKPAvkoLDAIo2chHivSQAu7oDXVVOPKt4YjpmCXhF5
         sqCw==
X-Gm-Message-State: AFq9FYJrbOsvxU76zZDUDMch6uyNvDohUTnWGIkW6eazQeKNL8PzDYYi
	4IA8SNEgCNC9IT/jqKahDl+DNtaIEKR5Dy7Bwv641N4efCqj+prF6MmyemSXFjsganHpKsx2i+j
	UQU5dKFN5x+ju2zYJHJVt6qBwHef47paJ10tz
X-Gm-Gg: AYBFou0lxyU+ZPl+HEKTxV/kV9iEGLNTphLr+xdQubbAOxZRLNIDYp43cPtL+cNnoBy
	LbnpepGTs42C3VVD65+9u5Z6Gsd7GFhobWotioCbYuDHuoPK7nwZv6GxxugNHaW2iR0t72+czjv
	II0crVvDiCC6lhKMkUa90gjZ56WRwqYTg+5Vn7f/qAQRpmZdn9VR16OLC4Fj1O6GBrVbxsmkDHz
	yInWWY1opN6t32dzg4Sy6+n2ob1dKEi+AjpUEICJ08EXAfJAC+sUP/KCLbyikwKKOKZpPcu8cos
	xjVQKpM/t5XmJYKn5UZwDkSWoyKTpYq2S9tOBGcWUoAZU1c1v5aTnNQT7vhkB/7k7Ig/jb/4Jse
	8j8Disd2DjoGOFrI92aOSZUV9JuTg0HTctQvPMVB8Udrq2/wk27zQhwueNCE95zAVMrgwrthxVU
	D3Pj5Cmw97iv2XC+NNrELSCQ==
X-Received: by 2002:a05:690e:e84:b0:672:ede8:d1f4 with SMTP id
 956f58d0204a3-67a4544ea56mr4382878d50.62.1793022076343; Mon, 26 Oct 2026
 06:41:16 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023180442.60362-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261023180442.60362-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 26 Oct 2026 09:41:03 -0400
X-Gm-Features: AclHuK85QwHmM4WEYNeoxUu69-VFYbjkQuaAloW5lm8BtV2L0Ah_GFjS2Y1Ma1o
Message-ID: <CAEjxPJ5tUTLmbhXPPXkepXpc7OOGUtGmq5hz5rRkW47QiwT5Zw@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: preserve read-only store overrides
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cathy.hu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 2:04=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Keep per-file store fallback, but stop CIL lookup at an earlier HLL
> source whose cache is missing. Create writable module directories
> before compiling vendor-only HLL, refresh the extraction path after
> compilation, and report enabled state from RO-aware module metadata.
>
> RO HLL can change independently of a writable derived CIL cache.
> Recompile externally sourced HLL when processing it for a build or CIL
> extraction; retain normal caching for writable HLL.
>
> Resolve store-backed file databases at cache time rather than pinning
> the first active path at connect. Permit TMP fallbacks only for local
> record files and invalidate cached views across transaction-state
> changes.  Existing flush-on-modification provides file-level
> copy-on-write, including an empty file that shadows vendor records
> after deleting the last entry.  Use the same fallback when publishing
> local file contexts.
>
> For ACTIVE as well as TMP, stop fallback when checking the writable
> path fails for a reason other than ENOENT, so errors are not hidden by
> a read-only copy.
>
> This prevents replacement HLL from silently using vendor CIL, stale
> vendor-derived policy after rebuild, and loss of RO local overrides
> during transactions. No public API or policy format change is needed.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
