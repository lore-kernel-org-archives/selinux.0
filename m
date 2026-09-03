Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8771E3242BD
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448699; cv=pass; b=JVjvr+/0OZ1m4ZlhYM2wHAwlHc52HKhLbn52CXL8EvZH6KNoxF5f0FM+UDcPTw5tiMeJjTuO6MM+lL1684grGds4rHQvumj9DrmvBcrj9wSnRetM0Ph1pLFw4tSHoRQdpaUng6WuMZD8QG0LTQY33aQWwSIzluXCdzQKwX1WnhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448699; c=relaxed/simple;
	bh=85m2y8KnXzX4YCGVI8S6DInjJ+s9qYYTXlC6MufyGAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnMJt1dJpTsPMQ8K8Rpje0Kd2vzp5y1PNaeDr5y/H3ACQReA/yxZkMqbh930fhpT4OLcb3g8d877CLcTxE5j1wVBJEm9cuUoehWB+W7GA0Rxxy+IRPQzkP0F3KDId6I5Nus/gWr+GJdcJOnIfZr7oo7gziUXakn7Zj+uemfV3lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=J1R0kYa4; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="J1R0kYa4"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66c7e3a2332so2658256d50.2
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 08:18:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788448697; cv=none;
        d=google.com; s=arc-20260327;
        b=nnIIg70GIo90+JoaNAkLl5tUBc11bYuUu2r15l8/wwm3PiR9dAtgjHwPKKWZXYGZUh
         OaKDwO1Pqv+lcVZDs3bQzsVGn6XZFu02GCRJNDwFogQedU3480CfH5yM4twUo83HVv6M
         vFQi/QDsyup2psN0abVVv/0H3/DM0CJM4R5rCUC52yVEmyRulUa9V1fCDS+ypqS4B7hv
         wxySHkQeeATWmX0Cxe55fbHeazq+EBkJPCrwcHdYmzihamR1za4d231N/8A2ny0e23j2
         rP/SkiiO0JgUOAXIsPzBT+6FunXDxU1pjRlGuusTkppJuUZ2FXvELKaTuq37LfOvXhYq
         3DkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=85m2y8KnXzX4YCGVI8S6DInjJ+s9qYYTXlC6MufyGAs=;
        fh=YM8J+RuerLYVnDPLKvUcqOy+Itr84Vjiv1LgFH8OtYc=;
        b=DCFsnwdFApH70bIR4pViiol1O5PvGYCwyNWaSopP52vmXu+t6pdVlYCk/kicfAJvci
         wdxw8dG2UK/s5/WNtbnbApa/FAZQ+lcfjf1zGdNDEYzg66e4rTM0cae53aD0GTGWJFCk
         uAncLMV5crHdXbIgc2Anuk8f5RDGoLJeX+rHm5Dn4FfaLqJrFMV5gt5R7KXWa3t2u+CQ
         k9j/oxF35Fzvfat8V+zKD/U7llfSSEXbPsbV5+UJX64rQMb77KfDnJiRa2CL1AsSsGob
         2tFt1WyAuD/wSGoLjicwQXCKmqAYtPLtxClVshiOB6ohnFi8stZVBXrol9BGiHGMYtci
         7jnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1788448697; x=1789053497; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=85m2y8KnXzX4YCGVI8S6DInjJ+s9qYYTXlC6MufyGAs=;
        b=J1R0kYa4hthmmMZy1HoPhIqYq2rS89tWa/XPW9ovJNIoBEWTQNTQjF4ROVjL0vEjK1
         AUID1oHbJL51xHvNTHFBeFWRBBonmIz8456K1QiibfteWLuv2mJ/FGNZ36cE//2dw6bG
         1M/4RC3AXfrblQ9m+LWLsr7sLxgUegDC+q/MZbLThRxxRK0aSe9KFRMimRe8fhKiBYBr
         amtyfVlZQHfzxycMhvD7fVjGN+1jLp+eZONC6HNrKxeqmX6d8RQ9rXHgLlOiyqUgMHZi
         pnx2Q1vpEFhd2ZVGQLRcXLGRMOgcD2ZMP4RnFAC4TJRUahF8ai3P5YNLC2+TQzU3BCmu
         wfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788448697; x=1789053497;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=85m2y8KnXzX4YCGVI8S6DInjJ+s9qYYTXlC6MufyGAs=;
        b=B3wY6+Tc2CSuLBzKiHmrRklVMG5/xO6FPyhmqZa1liYzaOt/GpVBfmCgEXYR8EnzVd
         1Byy/7fEZpn7qN3SsZTufvuYoYQGv0MjXo5kJdYsVeF8vHmbST5RWHqqO0RvYo8+thb9
         wd4SneLqBNppPGgnh3wkgGZ0IVtoKT+hBH+fzMfc1NGLBjkOZ2CdFUPY00SFzeMQ0HQd
         M6OUUKags6qp8aiI52LNGu4eiKmYztD/ZTQhZfr4WW/m0w9OY6h5qWV+/yxpuZEcOSDk
         N/HvZCMCpipdPqjYg5Y34wB0790KNK0dR1LeQ7mgMPd8qW/UtsxZBN47KA7Ij2WpPEod
         DUgQ==
X-Gm-Message-State: AFuF++lzGgotejx6VRFlkn5ixrBpmDV/+bDPVfHuygMUy44uV6QW6MTt
	vrqxlU1WJpyt/lB1mAf6BMtJNdAchTv2xRJGfs5sihTRCOd8wfPRh7yPiBaYzaENDY7XFyDt/96
	HiRJnXOyYA0IoZSXXt65FjghEAiCyrXo=
X-Gm-Gg: AYBFou18JbyWAxNQEueZclC6ojXkXJmiHfVeB42SWhO8me93a6GqVoCMG4vwMTrsWrV
	d+FGfOScETGTVYuMKkS/4JDWcT3e3CenYS9aqjsV3OW7/DlIWRPtFLZJfNtk18/x+NM8m30z5kf
	tR79IbJaiRsyyuCJl9/cXJ7Z8U94cg4h/CyWPMVxLg2TjqHBI89r8DXkuhG+8xcM64Oq0bl3YOp
	UnqB8NPv50qR2yYsDIHcEv2euOGiKbF+EllFtw/qrNs4nOOkiOfxZHWSQ87GVQMOxxW52qql5h8
	2bsjvXGJL8o0iDnTNrWZIzL6kdb4etM08Gue3zCQvcrKWT1p6ONbeLhB8n0to2JgKjh1J9I=
X-Received: by 2002:a53:a844:0:b0:66e:7301:18ba with SMTP id
 956f58d0204a3-66fb3ef0856mr258147d50.21.1788448697389; Thu, 03 Sep 2026
 08:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903113538.72942-1-cgoettsche@seltendoof.de> <CAEjxPJ5Yy+GQCjpddDQTjCcCLB=9DCJ-Bf2Wv9n26=vgwP84qA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5Yy+GQCjpddDQTjCcCLB=9DCJ-Bf2Wv9n26=vgwP84qA@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Thu, 3 Sep 2026 17:18:05 +0200
X-Gm-Features: AcwNN1UA-fdYFifXjIx928qRj6SogLtbn7vB6TpSZ5D-_kVcGMA3c1jodXs4sPs
Message-ID: <CAJ2a_DcCfeeEf4BBY5SEEHyMo2QwaQ2KtTuwAGGxnPWg_0CXJA@mail.gmail.com>
Subject: Re: [PATCH 2/5] selinux: bounds-check filename transition source
 types at load
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Sept 2026 at 15:47, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Sep 3, 2026 at 7:36=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > filename_trans_read_helper() validates the target type, target class an=
d
> > each datum's otype, but the per-datum stypes ebitmap is read without an=
y
> > bound on its set bits.
> > Reject a stypes bitmap whose highest set bit is not a defined type.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Technically this will reject a policy with an empty stypes bitmap and
> no types (p->p_types.nprim =3D=3D 0) but that's fine since no real policy
> should do that.

Since a valid policy needs at least one entry in the global avtab,
isn't at least one type already required?

> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
