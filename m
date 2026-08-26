Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8239233DED9
	for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787775325; cv=pass; b=i7crW9yxOFF021rDRjX8z9r6bcEt3mSgf3vy3LuresqDZuzXc/qukhSCRzA/eslVtPaJH0zJ008V6hIOqmo6XYCkSd6GRTLUNStkU/flTOogEZaPIaEtqfSyw1kwpMrSKFXy1q7rrjaPRBBmxhfUS0y0mYDTJd7IqiATd2vImrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787775325; c=relaxed/simple;
	bh=jbqu3iytfqwPQMb3yPQTDqRsmFEY35ekGWMbJkDWrTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dm2HOmSavcdldGmhaynZDKSQx+0zwjTGD9/H0SSBHcgf4UktbolUCwGYHrE2ajTdY2hdn5N2iX+rC5EYIJWI0rCyYa2+QvedFp6dgpyDj67uyBZVoZKH62GZ+DPC0Rrx82v/POlGvI1fGvHN9tk5ruaHQCvlCdzN/zmtzK8FbkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FP4SqTp1; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FP4SqTp1"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-448b69cfc6dso1578225fac.3
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 13:15:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787775323; cv=none;
        d=google.com; s=arc-20260327;
        b=lGcbUaiOx/G42EeyegaajsrqYGoUIhNHiAUfpRYCR2/+xDmN6PXeumpLa4fYkV1LRz
         KKPURExoNIAVx03f5Eph5AO9u2nEPB+0e28Jfe5Y/CS+1XhoKcChv2JvoWnN3mXULVWp
         cdU+CF2yFWf6L3X7VK4HwlK3ZGh/+WrSbMyoBTHvB6IDhSUdsIRTN+kj7JU7KPE920tR
         4Vu/VDer4s/cnz/Q8XTmhzl3J1l6/ped+JyERUC2FhaXBNMybjgFNS+4lUqMhHk+VD26
         TMx3DWtXb1hSm6NS39y9oTxsgqu2JgSXe7XzlUptuDUfVZrEde5ed+wc1kQ/0PUARVzv
         /xeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jbqu3iytfqwPQMb3yPQTDqRsmFEY35ekGWMbJkDWrTA=;
        fh=Zj1IMa/s0GDs2tXbiD0MgH3G+uXEgEZ586fq4Mmx8S4=;
        b=VkRLFEmAl9xTU/6YAq0Q9Xqf+FIuXioj/Jxg2Zfa9nDw86vn7aXQ+hECFNWVPLzerU
         bJmD0IvlmERTy9O+YU6YuENnoHKoA/bOGzlFqP0grQ3m9TXObQcO6IKZ0LiEzGqAj9ew
         n47KuFLITnUtrcqro3z/r07SN85mxAnIoiVly4O7whmB27uBa5GAA3t91Q/FvlhT4eI7
         cjtdctgJYSrvz6J/Vdq4OChD788TvNVVDSGjsvjLx77F2nEs7QMLitn6tfz3ZCDhLzq5
         DmPlxFzTEsj0HAFjJonPByyG7Xnmq/KprRG+ki16olypAVgNPBbZnIz7ZZDpy49+6+Dr
         ByGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787775323; x=1788380123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jbqu3iytfqwPQMb3yPQTDqRsmFEY35ekGWMbJkDWrTA=;
        b=FP4SqTp1hAAaPFsf/P10y0LcW+rZU7Rpf2Kg/TaC5CGLR/tFdTI709tVQXLDzVkmFi
         5UEkXplTs0f/lprl2BfxL+NuVESD2iOZLxFYIR5ArTD+5EI1XLOOkno1QTiRDEuxVCoM
         3IDqG+66bo2eYgRKf0gb8J8HTPLNfaUbutgB2KQbYUNBUBPo86C2gLNb9Ucbs6PoGLnV
         cmx67wyYTzDl3bCUVNISZy7g9tZ5OQRnIW8Lned3rUuXX9ywfIfM2B5TBuYNw1kwyNVz
         v5faE3NnOsflV+vhnbYTiwW/Nxprf5TAvi3tugvfDZGdupWJo7oWd1KZ+bDmnUrp0bsz
         JX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787775323; x=1788380123;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jbqu3iytfqwPQMb3yPQTDqRsmFEY35ekGWMbJkDWrTA=;
        b=de4LBjyFKEvjwjDETpVvieK6VrE8wZ42m2D7NHFlzmXzwHGXK0VDETvlYHfES3XfR1
         2DSRn2sJwUnGKc59amZW/W8cBvikWfspIFXhGjtelCOjIwGFn/TyaShwLezu8j9O0/aS
         yEutgF1ENRQd+/nDJhMV/FUQI2cfeZ2DjpeOzX8d/6HRzr2veMbjLX2Dct0TsRoGHVV/
         sBsVI/265nqI07ZkLwNmfD/k1S/ILgPPzI5gomzJeSrJDPLjJ63JHUCSLDKgWqd0a9wH
         55dtKyDA+gQ7d4zM5tf7Qxn/y+FquRn5YbPAy/Pit0Ny4lRAEg9M5XcyPabMmfKv5TXj
         VEWg==
X-Gm-Message-State: AFuF++m6TApCEF93BU/IqSxsOUyuHR8iXB4Omn9X9uwbwXe6SS1OoyQp
	ylswkWhH+FuIHqMtqx+5o19kzCm2VjDZPT8KKBQEFzUaAZBM4S3u7X9HsrO92biGbdV9vYHxj9G
	jrE5X3ekMgbBqCWstkwyp1JtAP6rCU07tow==
X-Gm-Gg: AR+sD11o4JHzMT/fsgN1nSVTpJFQiT+hHSufnPd/lDqmTkH2g0CewOHbEpyi1JjN4pp
	XWp+E+OdS6MXYGdE2qn9gwJjDAD47P0EUOuR8JHyBiwqC3//Oy3/Cxq0tUeuTGLfMTb0VAQwvHM
	S2lO9zfJyN3WhH+Fzce5gbVZxhUfDZqY2gGvOdiRyOFzNEdkMV03Uk18cNlpNnFVE8Pc9NiEk9J
	l2386Se1bN81DuwSXEsofISfQ9zU+OQQcha7uWt9nIswbeEZpviyRI8oVQgFGpLq5gF6b80ilm5
	bd7IVmEq2H7KSw1BsyJTtC5jHAKPxtXa/lhorsminpZIQlRQr3cMaeSv
X-Received: by 2002:a05:6871:2e99:b0:464:c9dc:41dd with SMTP id
 586e51a60fabf-4659bc22ef0mr10546344fac.19.1787775323184; Wed, 26 Aug 2026
 13:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826140626.40798-1-stephen.smalley.work@gmail.com> <CAP+JOzTrwtHA0zbdq-Qbv6WNxSL-FN9jUFgutH_PMiTwP0mz1w@mail.gmail.com>
In-Reply-To: <CAP+JOzTrwtHA0zbdq-Qbv6WNxSL-FN9jUFgutH_PMiTwP0mz1w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 26 Aug 2026 16:15:12 -0400
X-Gm-Features: AcwNN1XoCnTy1PA0Q3OGu93uExqy_oTVaynirSc8v4VZgP4CL3x4BmP--qeLNTY
Message-ID: <CAEjxPJ7iiQ1U26dNxjks7DnMmhpZoG0f=gprUB0aDvN43gQKAg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: setrans_client: free daemon response on error
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 2:11=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Aug 26, 2026 at 10:06=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > receive_response() writes the allocated response buffer into *outp on
> > any successful read, regardless of the ret_val the daemon reported.
> > The static helpers then propagate ret_val as their own return, so on a
> > translation failure the caller sees a non-zero return with *outp still
> > pointing at the empty response, and selinux_raw_to_trans_context() or
> > selinux_trans_to_raw_context() overwrite it with strdup() of the
> > input (i.e. they fall back to the identity function for translations).
> >
> > Free and NULL the response on non-zero ret_val so the helpers hold the
> > same *outp is NULL on any non-zero return invariant as their other
> > error paths.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.
