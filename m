Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDG1G+WK"
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AFDDF
	for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 07:29:40 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50bdec453c8so5400364e87.3
        for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 07:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702308578; x=1702913378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XR5qQkRI3td3MZKLHSn3ERTBXq3y/6vIdB3z15rqh6E=;
        b=gDG1G+WKpwyXILZlzhoCPCpn/lvjbVjqUZbMq0wXQ4sJYpgLVpgf6EYk98ovBByNNG
         glMLVfWzH4kxnGwX6441oQ9zawaIpIdPKWfU6UOCjsqM/wATCDG4KDy/ZexzogHk1Byb
         w+H7zNOeEjhP9TI11DpfFgJdC75bI9uyT5QXOrbL8iPWuybJx53tqPOjvxqb2PksWBHg
         18xlLpI69QfWWRdOqOmKdyKiHahIi+RvmWC3aIPr1qIx11c57V3MJnR8mxAflI7UKQRt
         YyhynVvWlevrT8o34nKgnLqXJ9CgBwNONxZMeQByGLAsdgR3+YT+J1p+mAFdSgSGTxfb
         EQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308578; x=1702913378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XR5qQkRI3td3MZKLHSn3ERTBXq3y/6vIdB3z15rqh6E=;
        b=e73b4HsvWAJSPPdmcmPba1+UA9SsOngv5b7erGCWBq9ekPzwcfizsETlX6qG5WfN2W
         pq8A7mYXcetjQCHrWgwRl0aMWrVV2v9NcksOHzMcWWm0q2vHLm3rougM4EvTsbyD/TB1
         IXQAc8eoVI8cQM54O3yVt8evV3UlpSSOYryfZYdgFl5g7yd/R95sPgmQYgk/Mh1twys1
         wPfKuIJsalOKkkb5fKtsHAdiAJJ8yobSxDZeFIp/GJTsk3IGVDljivLG/Zz+G0qNLd4F
         rH6OHq/vRBNtKyLrNnQoa8DIN+tT3KVBVmbNMqY4eWUvkAthRyPuC9mw6DVjLTNG1XBF
         SclA==
X-Gm-Message-State: AOJu0Ywhwo1W8++valyxup6fu7TWT78tY9BEcx9gO0edWBVz1fC9lcdM
	S6HYijHEXS1/vLIUYUGOjocpUHgtwFTozlfGeHkvPXXN
X-Google-Smtp-Source: AGHT+IG8w0pFuAyf49gGuK9IAvwga8nR1Pdelc+kbfmBgyCjyb4iDNmYCZeVxKoywo71QicIqeT7EgR2KF9UMhC759g=
X-Received: by 2002:ac2:5fcb:0:b0:50b:f8f8:f83c with SMTP id
 q11-20020ac25fcb000000b0050bf8f8f83cmr1556230lfg.125.1702308578272; Mon, 11
 Dec 2023 07:29:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87o7ewsy7f.fsf@redhat.com> <ZXclzTjExZpvWrew@suse.com>
In-Reply-To: <ZXclzTjExZpvWrew@suse.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 11 Dec 2023 10:29:26 -0500
Message-ID: <CAP+JOzRaEO91z1th-zfVi4-pNokJaQqXGDCKGyv=rz+5UWeRvg@mail.gmail.com>
Subject: Re: Where's 3.6-rc3 and plan with 3.6 release
To: Johannes Segitz <jsegitz@suse.de>
Cc: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 10:08=E2=80=AFAM Johannes Segitz <jsegitz@suse.de> =
wrote:
>
> On Mon, Dec 11, 2023 at 01:47:16PM +0100, Petr Lautrbach wrote:
> > I consider two options now - a) to release 3.6-rc3 on this Wednesday an=
d
> > leave 3.6 to the next year; b) to release directly 3.6 this Wednesday.
>
> I would be fine with b. In my experience there's not that much breakage a=
nd
> the chance that a rc3 will uncover something significant seems small
>

I am fine with option b. The only reason I would want to delay would
be for the prefix/suffix patches, but it seems like there might be
more work required on the kernel side, so I don't think that they'll
be ready for this release regardless.

Jim


> Johannes
> --
> GPG Key                EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
> Subkey fingerprint:    250F 43F5 F7CE 6F1E 9C59  4F95 BC27 DD9D 2CC4 FD66
> SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=
=BCrnberg, Germany
> Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andrew McDonald, Werner Knoblich (H=
RB 36809, AG N=C3=BCrnberg)
