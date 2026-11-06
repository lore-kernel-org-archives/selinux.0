Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793990354;
	b=ZoSZZI55AweTRdjYp674HoZ0D9l2rw5BVMDVKpcJfqbsUj28brdPx9Cmaz9ckRj04z2e
	 RI4GFTfdAnU3n4nGokzxIyZXgJMBB9KP9IGnpP9adKvnGGLqEnPBaqv6OfiQ/7a8WLFrC
	 3ZUXQj3QRQuIrsoTLYV50A2tKDtWHmWYWS8si32IPOwqc55YSYkB88YQKRkVmYrE1u+36
	 a5ymjw56QwIMEtgP+JhUTi30X+qOeAAHsFgjMthdllAHmv/YGgohAhV5ZsXl29w6983AB
	 h0MJqdoNztMyrSyPFHLvTqQ1BQAcx6lPtWJFtGj52MPnUMxa1kr6BOjVMe+DoDNkZRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ATyMhhJGIB23Hzjo7Qzme9eqPS4SHvYbWr/Rw7HaC54=;
	b=y80W1smbpD6UInP3znt2XwI237UlcsoYLXKGbUA3boRFw+LGiIsKb5R/6kFseOXrNWah
	 3Bb3Fnq3GuB+maQQp6quReYmK/+ZeKPcUgNY1hCy/o5Pb1ysOSm4PgDHc/Ja92cF2z5AO
	 qzzrfcybv6yu64lty9wPGassite8gYfum5iaSXq5R6yDS7g6LSWGSQrqI0S0YXBt2ddKf
	 1+YBXNabBdgwwVQhNj+1VAKq06+qrd5/4+iJwmJIfSkSfTONkB8P1+6VOdpa6p2VrkEyA
	 xzR0WO/ozBVq6ooFdrawJS9ZYJ+AwkIOhIyzF+vK9HHhaVL+s1sw7DoWs8w14Bi3jfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NSuj2YJT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56741606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 18:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56741606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NSuj2YJT
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67c11318ad1so642029d50.1
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 10:39:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793990353; cv=none;
        d=google.com; s=arc-20260327;
        b=T2EzBXziSq5XLtZfzXWzCf2JWu6JutZ+iYCB438Zwwtoirq1CVNwS10XJqtSIyMYzD
         ryWE0O2nKs8wdHu89Ai5nc7A9c7CbMvBINs6kYCuz/LHHC2putUElFZmhPsGXnHQtr+U
         YUVgFL8a3XBNYdkXoRpHGl9OFiIDy3L4oze9yHq9xzlnij2CNu5SamLyoOo8FV1+fcEr
         SXjgA4qv5nuQ81o9OgRpdmbW8QxH7094t+3RV6LeFatRKmQTxdTQz4NlYtA6S6CkDfZ7
         /4AoFB1u4GCjujd45pxxeR3ZZIbZ2TJoRJJaFLlRgzykXSEFo1VFb1PNkjvPRu6lyMwL
         iD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ATyMhhJGIB23Hzjo7Qzme9eqPS4SHvYbWr/Rw7HaC54=;
        fh=kczRwGnsiWgDBFR2afO5JnXPh+lj2M8Xzx7+Kw+Dk7M=;
        b=qZ18qIM22k5xHnaw6cgoa8KG9TCX1bRZfK0xZVFUndyU4BAGwVH3xga8sa3+8VvvF/
         Z+mG3Ed51uHmfOXQIeNT0CTG5UJSa7uMurPnnPICOOyjidmkwvDeFbd9mKcmj4DA78Ay
         Jq4lTmXW0BxV0FnQZ87HuIlPWI0LpbpahZeURf3tSjpZkAN2yshDRxQqgAfvPPpIlDA5
         Ag+xehr5vPhSpYafmnUbjnyTgkM8IP7vO2E6cl5JkMmadn05jwN+jIKjyoYrYru9Zmaz
         1tgineFZDWgWf4w8LgIzjQhLTeMDiJLR+DDsVq5RVF5Xo/Flp8I5SerXyfU8p0aQLU8s
         yGOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990353; x=1794595153; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ATyMhhJGIB23Hzjo7Qzme9eqPS4SHvYbWr/Rw7HaC54=;
        b=NSuj2YJTRCZ7dz1EAci1OuDfAi05/rVWaGD2wtc8T2PX2GC7h6GThDO/ueJGGia/fv
         iraHr17NJIsb+p7EHzAEjPXBsjKeKBYr6UZbxaLoozji55QlbZp/tI5CUUakuGJUOCD7
         VSPiigzXuigiXR8qQ90V5SB6SoYNwirdgWnW2WC2b30O9U2KfS9VKLVOD6hwKUlwyq/Y
         /yZdKRNlU6s4oC8NY9luP4jAtt1mVUBRC9+z2U/Yt2DPaq7wlC4E/4X/OviCAwebyiH9
         qV0PAKx6q+bXNaCFWhKCHVFVDZgSOaXp18cQ29t2n3Ux4llAv1xV0ZG3ccGYjdp0PEwQ
         mfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990353; x=1794595153;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ATyMhhJGIB23Hzjo7Qzme9eqPS4SHvYbWr/Rw7HaC54=;
        b=ntUReodbIr11vvy8xRIrVGETnCGFOUDLFKequrohOQrAAmC1I9R1m1LblLpKpy2sXy
         CwSbuLhKIggUtEK7vIev1lFwOqx7ArCM+uSPqnGp6lnRFHllks8AsXHLHGuH5W/glCjV
         tpMYXkXFSdIIpU5Mow3P+l7Oj3mu3/fp4YM/vgRjfyzx7OLouDH8VNiRzm/DPahC9ODh
         Ke0Q9IaFa8huP3U8I0v8IZj+kT/BmTOaRgJcSCPAsVNtLo6txovGy30+waWIVC6Hx8rK
         whmPotaahy5EgcDv5r8a97O8Lyrg1eGz5XN7t/MUXbG737J+Hb1tVgSE7Hvu3CBAQsTp
         vgpw==
X-Gm-Message-State: APuU4Z+YjodQd3dinGyHaqTPn4Jz8GeeblEzg7JaMp88yKnVHjDvltb+
	eK5eIkIr2lKeOCsg+rPg6alo5CER/YWn1yq+/a/bCrmQprc65R5RYTIKHyKX3JS1F+aLZI3W7wU
	+M9hqO29dmhEDFpJ/bgFWA4X2BQd7XeR9Odhc
X-Gm-Gg: AYBFou3pPKXHoqhUZQ8D7DkQ1DaWRAISZLtyVgzbG34nmbRTf8NP20+kGN91bwsAeK/
	4HtcguLFJmeYU2P4aWLSo+ULeZ9qU732TrPZAdZdyzymD2WaWQ9O9toDNaRN+D3iVUtCHar7bqy
	YbOwfsvVE0eFzdcTiBnksV3C1ddxU6Arqkwy3pb6Ve8BU19nZxKrdq6bq8CVz2RnLv5ueFL6HPC
	k+iqLfm9j9iu8q1O0496rdreR7IhnuI4IKyY2C0lwMSsBMRrLnDm3/Oo1+P/stFExWAC1Yn0OTo
	RfktVUInyBNwshMIpunC2DR7JDeNpKTP3HPNvpZylZoKE2HM90hhGdhhG2dt7Qgeafd5nQ+RG4T
	+N+Z/DJ4gVa8DLHYiBxjWOxSPUCCUztwYXdUb77f1bo51d/e4ACzcpRP41d+giR90TNnkWHWqO+
	CquFRi89WDSJ0GS57tudwzvg9hFLS1uU4pPnhgemWIzAmHXmiw+HfaYUqL4A==
X-Received: by 2002:a05:690e:4093:b0:67c:1c64:45e9 with SMTP id
 956f58d0204a3-67c1c64554bmr1350999d50.101.1793990353270; Fri, 06 Nov 2026
 10:39:13 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928154323.48910-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ7fSVCf2y9f11YbMOzz9FwmcG8n0skqCFs4UTaQ-vtNBQ@mail.gmail.com> <CAHC9VhQ-DH8wQ0h2QBRek=UgXcT8LPDMSkbdE7As-=D6QPTnyg@mail.gmail.com>
In-Reply-To: <CAHC9VhQ-DH8wQ0h2QBRek=UgXcT8LPDMSkbdE7As-=D6QPTnyg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 13:39:01 -0500
X-Gm-Features: AclHuK-0d_fvbABpGu0aQ5DRcnzipQj0-y82fLSb2Fuz1jFLWC_PXYjHOVeNntw
Message-ID: <CAEjxPJ7aGxD=ReXLAU0v7EGkx6hGB6je5sUOpCYN1FvrZkmMDw@mail.gmail.com>
Subject: Re: [PATCH testsuite] Revert "tools/nfs.sh: comment out the
 fscontext= tests for now"
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnacek@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 11:23=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Nov 5, 2026 at 10:32=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Mon, Sep 28, 2026 at 11:43=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > This reverts commit 7738f9f68cedfe36ace71a15ae49ed3d9dd85b36. The
> > > linked kernel patch below fixes the underlying kernel bug that
> > > prevented us from successfully running this test.
> > >
> > > This change also updates the test scripts to skip a second Test
> > > Invalid Mount test on NFS because since kernel commit ec1ade6a0448
> > > ("nfs: account for selinux security context when deciding to share
> > > superblock"), NFS allocates a fresh superblock when the security
> > > options differ, so the "same sb, different settings" error this test
> > > checks for is unreachable on NFS.
> > >
> > > Link: https://lore.kernel.org/selinux/20260928141917.17577-1-stephen.=
smalley.work@gmail.com/
> > > Fixes: https://github.com/SELinuxProject/selinux-testsuite/issues/91
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Is it ok to merge this and the other testsuite patch to re-enable all
> > the NFS tests now that the fixes have gone upstream and marked for
> > stable?
>
> From my perspective I'm typically testing just the bleeding edge
> stuff, e.g. the patches in selinux/dev or selinux/stable-<latest>, so
> this is okay with me.  I think even for those testing older kernels it
> should be easy enough to avoid this patch as the commit message
> clearly explains the situation.

Thanks, merged.
