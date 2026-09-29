Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D08D3D8116
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696853; cv=pass; b=J+WnTWiPNKdrhdgTWh7Dl8y/oqrrKpfCpF8lhFhBbQIHh7VBQ4ssuEDUJYM8M5Jx0cqB3dfFmd4Q7AKsfDQ9/8oBN7r7Sx0sKi2InL1JfaMrA8Vab67lBm5yov9fLtp3ZEFbsFReRWWAc8KjI9PWcfmScjPOmwudsjjpz0tv7b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696853; c=relaxed/simple;
	bh=dF6NI/kgI/yjU294VEWR/snuyygj7xLYUMuVCvMs00o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTabAtHd8n7uoh9vQmI9Cs1L0ustPTlXf+6NdH8rYTmjG8r/GL48aPr2QkSAHRGETihuo+5VIQvGPe8/6Hwu/FEtQlkd14Kwb5ZSBBsC9tBy0JHDycyiZ7ltEqSvbhf049OBsLOwYosBQcHxeh+OJbBMsTIZ9qCQ4rGWHiRXHLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuZ1kVMi; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuZ1kVMi"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a8496fd8c3so46449897b3.0
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790696851; cv=none;
        d=google.com; s=arc-20260327;
        b=gzurs7mB9R4BLjAZdPTLL36UL/Lrl5bRylltTNOpzecb8HLiIKedaWj1TTkhzZTxgE
         HMj53dYXHscejpyXPy4jd9H3li+TaQ8BhkDaI9mjiUaXQH80+uKI0+MJfTbDy0OlrUs4
         gzUkQE6scrkifpmo5iS00+wPG19sF2FvyYsGOiqEkchr9XEieseO9MfLT6EEh4mBPXZe
         j5o2SFTesVEiVQUUb6wDPgEsmGp9j8nBSvgt6LvTV/I+5/aeBA1+tHyjDxYY27v9HC8I
         0CJQ2WOWcgmOsoEk8rnw9Wu2LtDyFpFnSe9edY9jy6x9Pb8opXG+PYIvt157cCnh7fXT
         0fCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rsj+n+C09JlqvEwFZI+3f30UwvPsYK7QYEnyYNZ9jbc=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=AER+9O5h69+UEqyW6yNrWw0cAkn2F0MwyHWOR77sxwie/ijmTqHLukMFTuk2RTt6JY
         yNvxF7y1GEmLmQoECraV+AEe7V0Hlyr/ebsQsfXk2MAPftPv/xFjLkbe4jGBctRS+/b0
         65wSn40gzegCe+8Rja733hoI3q0/icjkKsgFrHrDc5gVlhQVuhdate8URWBhWRuCXpB9
         bfbl6g1wZh+jRL3xbVbO1QeGML50tPTlSCQrjF1fVix4UadpnfYl/ljJs7tB1CW0rW2A
         kA/i4ArujIW5HKNCSkVWjArkeoVYklLVnDDydDwDTfQfPokw3AKjqy1aa7PDIMzSNoF4
         37gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790696851; x=1791301651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rsj+n+C09JlqvEwFZI+3f30UwvPsYK7QYEnyYNZ9jbc=;
        b=RuZ1kVMiPAG3e90oAKKmjsd3sE+ds0hc1tvgWI0XpG2HHPSUNlxGKkHhGsS1IM9khX
         dFSfhoJwsG1xynoFlcFTTILzGGr8T/eBw7ICRMHCsVB0j5mY+l6M4eqfluvQZ7NwsI1/
         Eu0cbDb84ypOva4drohhA1CzpDIu35H1p6qcxpTNLrsrqBdZVFfp/jsBT+69/HSL0cUr
         cmQ7L1xmj/yDNdc9qgtrc553RrUx7yh4fidSP2EaZ/IsYiBE06vBNq+ZbN6ZZFRnPOCi
         pI5yCJ6F4xNrVR/qdcTpGfvbP3pnXy9jASqW7poCF/RQQj5XAIgw6sZ8CO8itiW8etX3
         QC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790696851; x=1791301651;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rsj+n+C09JlqvEwFZI+3f30UwvPsYK7QYEnyYNZ9jbc=;
        b=Awa1Z4ho3AeiknLhbjsxTDJGq3hdJ7YGiB/hZoaryb+h/T7lxaRBgW7zi+f/GozGe7
         5ZF5XyD5OAsYVxcR5ul+96cD3dIP6y9FF/FWQyfVTJZESD8Dapi3dVfEneviqS8Ht/rP
         /Nx+FgTtq/DVyTaEP7BkoOq9S6fDaI83GA6KivM7MLfq4sXDOvFr8nAvUDLLcvocHsuZ
         51Pdu2aabUv2Y6yUNZSgST5NmmQBpGBFlmplm0YvlxJ3BMu2X0VRs/zAt5GszkrD3vhH
         cFtBb80ZyTVmkgQDoI6a9fa9nXmM8iqHttYpy0VvY+yBOHWVFj5DqwIsg1acxuF8emqk
         c/Ng==
X-Gm-Message-State: AFq9FYLSYmmqzMrb3nfHhJnhGDoRRP8lkjNVr7PNtrXvB/LqwNaes4D8
	7qlj+RmJvJfKycQvcTUnEzrmfbXyIdP9U6yktvX+mJEa98ZKMldRJCK0mdnqKt4720LE5QLoQqi
	nOnQGO6AV5bftHhvuAkcjnIkyKfjuwl8=
X-Gm-Gg: AYBFou3kwsR1u8y5LC1w88C4y0tErSqPQ0lUIqVaziW0c0FXw3Q48KL5aN2mTLkUdHQ
	zDx85gQVdzKfz8JhPM/Q1hynYfIvTWrqvGNjgeWasAyu+Ax42VWpFPkTU8eY8Ky06Oo3NtEoB+r
	4NLaMPPeQmANOVhoKicu/F6nB5OQw0ptEUgV7K5pTx5BAhHgTpcn6iKQqjRtXvB+v7s4jf1ymfZ
	BX5AvYU3p08yc1l0GryoaXhbhIJYetBw+hi/qbtvDdQVhK6sirLrNiXpGxExbF41YV9RpAhccdt
	PU6iUJoMaOl7KNMd1Yz+ecM8u3WSDIC2KIlitupvf3xxnA6aaw4DzjI=
X-Received: by 2002:a05:690c:10d:b0:886:550b:c14f with SMTP id
 00721157ae682-8a64bd56cf8mr60424497b3.32.1790696851584; Tue, 29 Sep 2026
 08:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-16-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-16-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:47:20 -0400
X-Gm-Features: AclHuK8MLwT3d4HTohYfUXmeqmvrTDg8AuY5_y3xDofXs7nffJ5FFdL1S1lbEp0
Message-ID: <CAEjxPJ4FzJJrU5JdpS3sW2vrp-3Znrfb=cYrF38MtJY+7N4nKQ@mail.gmail.com>
Subject: Re: [RFC PATCH 17/32] selinux: drop redundant last_class_ino parameter
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
> sel_make_classes() is always passed a pointer to the last_class_ino
> member of the superblock's selinux_fs_info, which its callee
> sel_make_class_dir_entries() already accesses directly.  Do the same.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
