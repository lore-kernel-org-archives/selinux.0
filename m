Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676E3FA5C8
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535495; cv=pass; b=UNbiSFwpZbAkarwbHfAv0hNwnCPhvVrflE+C0D+MHduMUbv/I5lxrffcfGO7wK3ULIIdclV3EhyxmtVrw0vmENZh0dbUBDQi4XjJkdbFPnYAs1G4/xK759QOVi9/ZN6QtdSD/Nohfge6mWUnJ6PZ2J0EBm9jKCH6Otx6PhEMXvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535495; c=relaxed/simple;
	bh=KaCh13EUluMGd3z0rWzWPEyKMTnF4psmauMdDVJlOSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ql1p6/+x3HZUyfMKhQhElY05iBGlhtQMcRQjb9aqmVcFpTgQXaC1eK+ONmKi0xw77waRgzwzeptvJNE2oEUJ9JqT9oa7Ad2wYoEnNZtNTdSt1/tlpGfaQHTyN2m4uYEwFwpAzp8mSUquc0ufjmMPvawu0sZpTH1TJOD9yrjYW9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWtc6ZZV; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWtc6ZZV"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c40397e3caso33691655ad.2
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 07:58:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781535493; cv=none;
        d=google.com; s=arc-20240605;
        b=dLzq1fcWIQGU3J+RidQs49KWWdBFCVv3aitCXL3WbR21LM96AhiTAEnw2AM3fXuLLE
         dlbgITlVjU+wArFVmMgFDIcC1YcogQq1Upkalog5w88/9fNO6GLlAOi/rWgx61R7Bi7O
         WIYq+yeRkDnBwv0Eo76wllTrTXS+7T1fYRqihBn9wMp/8tdCnagfbe4g5Ia21yg8nuNg
         orrhnZjDviMH6phLOI+zJMm/tQ3HR2uIGWC8CqgQ04j3NfKq7oudjnvrwdJtZ7/NzWOr
         937NuRAUnxkX86YYa+Eq11TCuVOtearf0JrHMArJVnbe4dWbPsNRJfJLuedTE/lCqQgs
         wtww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S2z6/9tXwB4c6wfyU0FTMs6M98fk0uiqa40V8rTVrl4=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=K9G4Kg2o1lcPIANdRvvvklWeVJvf8REijVZVB5tuMbGnP4hXMMIrSKjX8soNPXJgAQ
         JCEKmjLAcVY6g4JfzXAUoswYgpiEhdH7Fqu98jdZryV9qNVCasrN8TBgxhWUwvteTjXP
         sKPKhxa7G7YNmZI3jHf0CdpO8dNEHRfcr8KTG4vEUsl+MhJTMaPxyUx4nu8BLePsYRLp
         1xPFF6FILDR8RRt0rxTdZU6rmKdnaDFVa1eoQwhFSVjCSRayaY55sUFmG5Y7EKpmGocp
         9u+aC99WC/6wPj8NQ6pBP2e+/uDhC9YO8yYoA7L6SF5VHD5pjR4Ek8go2eYz4qpPZKaV
         trvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781535493; x=1782140293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2z6/9tXwB4c6wfyU0FTMs6M98fk0uiqa40V8rTVrl4=;
        b=SWtc6ZZVktt02Dx6Up+r2cx+AlvAs3NXd56bT/Of+Yq43vVvHM9sYzc+Lb0Ckjq/q3
         mKHPRSdBBjeFmmcDF0vOGeIWkKC0CAN8e9sM9ttQrMzZ+ayugnfymg3l4I3pPC/2OoWO
         m6+XbBtr/0csNUIn40ICCjco/bDf8alfsCnswzKEJertpFcgzzipvDsvG+u4c0TSe2I9
         7EPIe3zlQHaf34aNFf9Yoz8tABxVSHj9zPwjVgMSujSazygGmUfnl2quQXr4NH/v17/P
         64gu0od/jiolkbJwSGMwfKNrKKOEh/BCYertj4vnZ66Yn8twaP1fMQ/+yTJRUym+BQO5
         FLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781535493; x=1782140293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S2z6/9tXwB4c6wfyU0FTMs6M98fk0uiqa40V8rTVrl4=;
        b=eeWfK7Ez9/AQIGxVabzBLcxerZEKnQQG3KU49kd9cCUSBrshFvXNPBAqar4MP8gB2W
         Y1jg8GOClNrcJV+jkZNqxk/BHN5bx4fVMZhkq/TvEF66S/Q3XZd2fTWCoCDUJxUilkkh
         GIL7+TbkIpqEm5M2piYC/g7YBSrLPv5hb+yaH/6/wo2InTpP61cc1PmDl9E9lP95eH5L
         5luFEDow2k/3HWxAXtKzNympNXDKtOkkHeUWQGmAYKXc3J/TV79xFEe22Nt3RCxOy4Ol
         HzT4VfG2BiOlzkruae15QYVe+5pUt8BVeHBIyqK5KUAvL/vJB7anMmjmfDLh1N9MZ/88
         VkBQ==
X-Gm-Message-State: AOJu0YyVeomDjoqejzT6IroFTJJ5Ula/FI4myEMAo6A3wu29QbGbEbbx
	lQVJo6pq2FIYEe96QKJUf+HvvtqkpKuPAzllqMuQqi4N22tmk+lCeDEMsobw3Rh8QH8ddwhbY4F
	i5C6MPUXJgH/NkG6i1EvkEqgBOrgKof1OX4Hz
X-Gm-Gg: Acq92OHIAT7MjeRD2U8Z7C1wO8xTjYHXrI5wbZc5prg+4VLY2StaPpZaA9QCd0XnTf7
	kfzlbIoeDB2gF6yvDHrrjcDmVWBW0FfjTo1lVfEBSi27NA+cACf9742b/8kV+ZKtchUvWzvAJPo
	1BPjlIpp/eFJfLBSdbzEDJwIi+2jzEFiirQBX0PD1evJ00zcKWXEzSqQHxgTFUc07yBI4gsist5
	ZK4jdWuo3hlOfmPWPGSJ7Uqg3uh++QJQC2hzoJC2iuHTTlhKKXpZWKKcq6Qn+3GQyI40uDeO/kl
	tL4DoRg=
X-Received: by 2002:a17:902:fc8d:b0:2b9:6458:1a2c with SMTP id
 d9443c01a7336-2c4109ecfc5mr170314135ad.13.1781535493365; Mon, 15 Jun 2026
 07:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614155030.97082-1-kalevi@kolttonen.fi> <20260614155030.97082-3-kalevi@kolttonen.fi>
In-Reply-To: <20260614155030.97082-3-kalevi@kolttonen.fi>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 10:58:01 -0400
X-Gm-Features: AVVi8CePiC3h_PQwGRQtPOsdVRm7rZ78AXxHQYDrRskkGUotV7Dc7PPTkXtdVTs
Message-ID: <CAEjxPJ42=rNMoZV2-0FD103gmow3m5MMU1YEC+3NFyJfKr_g=w@mail.gmail.com>
Subject: Re: [PATCH 2/2] policycoreutils: use bool instead of int
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 11:50=E2=80=AFAM Kalevi Kolttonen <kalevi@kolttonen=
.fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policycoreutils/setfiles/setfiles.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfil=
es/setfiles.c
> index 656848e3..2d38ea8f 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -1,4 +1,5 @@
>  #include "restore.h"
> +#include <stdbool.h>
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include <fcntl.h>
> @@ -23,7 +24,7 @@ static struct restore_opts r_opts;
>
>  #define SETFILES "setfiles"
>  #define RESTORECON "restorecon"
> -static int iamrestorecon;
> +static bool iamrestorecon;
>
>  /* Behavior flags determined based on setfiles vs. restorecon */
>  static int ctx_validate; /* Validate contexts */
> @@ -181,7 +182,7 @@ int main(int argc, char **argv)
>                  * Does not follow mounts (sets SELINUX_RESTORECON_XDEV),
>                  * Validates all file contexts at init time.
>                  */
> -               iamrestorecon =3D 0;
> +               iamrestorecon =3D false;
>                 r_opts.recurse =3D SELINUX_RESTORECON_RECURSE;
>                 r_opts.userealpath =3D 0; /* SELINUX_RESTORECON_REALPATH =
*/
>                 r_opts.add_assoc =3D SELINUX_RESTORECON_ADD_ASSOC;
> @@ -204,7 +205,7 @@ int main(int argc, char **argv)
>                                 "Executed with unrecognized name (%s), de=
faulting to %s behavior.\n",
>                                 base, RESTORECON);
>
> -               iamrestorecon =3D 1;
> +               iamrestorecon =3D true;
>                 r_opts.recurse =3D 0;
>                 r_opts.userealpath =3D SELINUX_RESTORECON_REALPATH;
>                 r_opts.add_assoc =3D 0;
> --
> 2.54.0
>
>
