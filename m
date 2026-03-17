Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE63E5574
	for <selinux@vger.kernel.org>; Tue, 17 Mar 2026 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773787370; cv=pass; b=Nq99B2fIGuf6UeLDrUj7lulBYuUONSvj9hNgXQlzsYPsA5S/zCcVWe25n7C1fibiSuC3HlCEwokJETFavcXTVKfXIdu62PZu1zUihbFqI/G5ZQCq3ZV9pWiNBBmKhT1UBTWjfne+ONl3qXNuLr9E1hbCJ9UZs8H5R+yh9eNpXy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773787370; c=relaxed/simple;
	bh=oScUuIjIjb/tZulbsi2FkIBZwopgeujtHsSn1k3PGiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWOmHH9/vv61V0GTtPUjdKeMLqx9SfIxy1cMXtMRCNypMIvkAdEiryhjB7KKK2pxlr233XfacTD5iTNIB8dgS93Z+gT0v/Nom24epdl3U4WeTS5CR5V8Cal2ztcnF2TtAT22Von6DaBcnbruH4gBACWwjGNX8xBMga0F6bLSln8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Rp4KChT/; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Rp4KChT/"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c738aa3cbbcso4429447a12.2
        for <selinux@vger.kernel.org>; Tue, 17 Mar 2026 15:42:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773787369; cv=none;
        d=google.com; s=arc-20240605;
        b=dHOSdYgwH78pPWj4MhvU48D9wuYLdnTHnUMOS3TFzFkizAlRj0NdJBLBrUPwh/XPvW
         Gu3ToFlF3JSYlQHeu/8cP2k7Hy2LYfN06Hjn8YZBlT+CWhEGgDihOcUrPK9hgxy6Noa9
         ZWdAFG5D+I8L0p0wPfSJVeksu9v27ae895Qflu/cJMdHGrNtskbGjDq4484QmP0jUTva
         F2ywd6oFabRLaBVnVE/pWRGS/ltrqo6UPII36InJOY+1sNSmkgqsvE0ZskXVtDMYfhXr
         1LbuWlUFfvGrk3xHfoJTwoFToeaxKmzqIPDURWwE6klbDaOQVIEGidbniNaLkjf4/Wzl
         8IQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B8weZ6sz5Sw0SJMaIbsh0p66JDKF/4Vt78zNnjgP+G0=;
        fh=RecgQhr79/qbUQRw9qAupS24H7o30d6OOW8FOctLktY=;
        b=f966yU5p6yF7JTERXNePYTSIyyV8ggH3OtAOEaXtz2En21bEGSmT0Q1OLPkTUP6EYp
         9QrjKLdoqCxdTdet2ufAmTczO2gzUx1nlCPvH3Z/mkWjFpK666QCn3Y7H0nJ1i6YAFws
         wk0CYKuvieLVQkJv8veJ/GS9b0h/dGY7MY8vjEJXY8R+x6nHE6gPgUDRToHrEX1ygkD6
         RKl4ARBvY3qgVnqdRJSM+kZhC38hoXXG+R5U4lFJmOgJ1O7vgtpF06Dl+fNG1wKTNVVR
         cMNVIfBwv9ha3/drkPR3GznfKLfc+5NyrUw40KGEH18BCORGl9UMXlgPJjdh+dNeJxWm
         3gvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773787369; x=1774392169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8weZ6sz5Sw0SJMaIbsh0p66JDKF/4Vt78zNnjgP+G0=;
        b=Rp4KChT/WWpTu8I8ai/ucT9lIndTLNcnHKlKHGJEhA9cz9/jOtKHRfTj8Mt4k99hLz
         /I89gTL4UvFCXEXQ+emW/vqxpORQl6tRIFW8QI509j2GTSrVZtaum8vUBrpYmpT8jd0A
         wISeWETh5lykScg+b9x3/WRqzlb+SKvIZCRY3dNv6Dl6SFOWy6A033zHv7EsB5rYeEko
         x5aPlsVTKpmigGziLqh1SSMCTlzwf+Rl1EejgXkWvWLlaOaqd9ELuzLTq9ZeivFTN19l
         O/ftWife1HLsD1vxt+eBkShi1+KqmNcKNpSCyVKzgaGVSMOMFeuIaCIQZbGea997OFsZ
         J51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773787369; x=1774392169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B8weZ6sz5Sw0SJMaIbsh0p66JDKF/4Vt78zNnjgP+G0=;
        b=clCoPd+7gyXmjaIaxknTwS6cVlhJisoyqgpd5Rd6fo9y0v0BhjhB9HS85UR7tKy6Rh
         GVoJ+sF3sqKDtB3pt6c4l/mSRaQpXk15Qr7y1qhB7crbOGHAEavGwi3v47nG4cQb6AZE
         znSFST0SNV5xeFl1TOvWx0fe/7RPqfYOv69szT3es09MEbDoeUDS3twyQJ2OF6BGGDhP
         AdokV0x7FJJRZ0HJugPIHCjLdfxaHh+tFTexEyM223IwVhslLvkYS76wq5b44kwSbJo9
         GI8lPqDGmNPz8MW5m3G4YUqz2xg14wb9pm0O4qVCz1cIzb4Xj4Aid5xMp9qrtE6qgTGO
         gigQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA95J+b+1TwrRNiwrR+/4mYZSTZHPkr3zIqBwNHaRWvXqkUZlRRnMMv4AGy0twaXlEkhC4fADH@vger.kernel.org
X-Gm-Message-State: AOJu0YynpKuNyIAl0BN2Zqnkd51jTtp+F3c+6hTCXoqmwlLvG7n01D3X
	3CojBtxpPJqrk2YFAlt0gMCuGiAweU9Shvb1tDAvQtLLf+LV61PHUiE5fwWJFlq4MNrFB2E0OlB
	AZD1RL0u1bfda/T6YDFqqN7S8qfsVrk+hShpegsfq
X-Gm-Gg: ATEYQzzkpbiVbEJ9YMEenXXzbvP5Q65UGwxa4NupXZyvCEUTctjOz9hC6+JE2oHQhkb
	9chkP4jiPHZLw3lGYxD3d26Ms1R7kcvdgCVrMhEtP2p/BQtwWXYvWnVX8QUcnbhN+dX9hptYInZ
	+dnajghDtuHeieODUyqdkWA4sm4y1GvbDCU3tma9CB22s5i5C5mguNRv6FApK4N7G62QgeXCvMe
	fqjUyQB6+y7FksoPJhLa82l8KbnaF2Ie0T3+MG+NN4wweWyaDyWGFcdCpbYi24/SLTLDI3ZXJx/
	XhRDy1EkEkSkUDKB7w==
X-Received: by 2002:a05:6a00:1816:b0:827:2ec9:e1bc with SMTP id
 d2e1a72fcca58-82a6af3b680mr1004833b3a.61.1773787368885; Tue, 17 Mar 2026
 15:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316213606.374109-5-paul@paul-moore.com> <20260316213606.374109-7-paul@paul-moore.com>
In-Reply-To: <20260316213606.374109-7-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Mar 2026 18:42:37 -0400
X-Gm-Features: AaiRm51ktGDW1-usZMxMHsT1xbcaRYx3q6Ml_vERE0ki9AcWlEliFtDWBIy0vmI
Message-ID: <CAHC9VhTiB73F9fB1o3K4NfJ-Fa50MsVA_=79kn6X34L62J_TwA@mail.gmail.com>
Subject: Re: [PATCH 2/3] lsm: add the security_mmap_backing_file() hook
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Add the security_mmap_backing_file() hook to allow LSMs to properly
> enforce access controls on mmap() operations on stacked filesystems
> such as overlayfs.
>
> The existing security_mmap_file() hook exists as an access control point
> for mmap() but on stacked filesystems it only provides a way to enforce
> access controls on the user visible file.  In order to enforce access
> controls on the underlying backing file, the new
> security_mmap_backing_file() hook is needed.
>
> In addition the LSM hook additions, this patch also constifies the file
> struct field in the LSM common_audit_data struct to better support LSMs
> that will likely need to pass a const file struct pointer from the new
> backing_file_user_path_file() API into the common LSM audit code.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  fs/backing-file.c             |  8 +++++++-
>  fs/erofs/ishare.c             |  6 ++++++
>  include/linux/lsm_audit.h     |  2 +-
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      | 10 ++++++++++
>  security/security.c           | 25 +++++++++++++++++++++++++
>  6 files changed, 51 insertions(+), 2 deletions(-)

...

> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> index 17a4941d4518..d66c3a935d83 100644
> --- a/fs/erofs/ishare.c
> +++ b/fs/erofs/ishare.c
> @@ -150,8 +150,14 @@ static ssize_t erofs_ishare_file_read_iter(struct ki=
ocb *iocb,
>  static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *v=
ma)
>  {
>         struct file *realfile =3D file->private_data;
> +       int err;
>
>         vma_set_file(vma, realfile);
> +
> +       err =3D security_mmap_backing_file(vma, realfile, file);
> +       if (err)
> +               return err;
> +
>         return generic_file_readonly_mmap(file, vma);
>  }

The kernel test robot helpfully pointed out that this patch was
missing a security.h include for the newly added LSM hook.  The fixup
below has been applied to the patch in lsm/stable-7.0.

diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index d66c3a935d83..f80925b66599 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -4,6 +4,7 @@
 */
#include <linux/xxhash.h>
#include <linux/mount.h>
+#include <linux/security.h>
#include "internal.h"
#include "xattr.h"

--=20
paul-moore.com
