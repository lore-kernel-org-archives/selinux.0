Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D691396D2B
	for <selinux@vger.kernel.org>; Thu,  5 Feb 2026 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770284753; cv=pass; b=lqsKH950DMlklqZ4aMhT6UF8qgfiI20sNWISSrKk7d9lBMoHW3/74KzUHKaytx9x8h+LKMCWm4pV2tjY1XGq1nz0U2VfIy8R/gsrrfq/qxfJzeh+4B567/4bxh2x8+pXpc56BpFK7GC9E67hB52qdVmMVEmNTj7gdCnnBowT2aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770284753; c=relaxed/simple;
	bh=gTHjRNg48uqIhlFUjNVy6w29gFOiVNhUd1etS9WljNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFsENoh4XI4q5jBQB3HDvxKMotvDVBnRiGnS1zUobp1DuSCw0VvclCKrtNQfvKhPqum2EBHzL61M40Tcz3spUbMPAlgLnmQmrB3RFlrWyRW+vggM7oiuz2w9BRARRDxaotMcHAizqeb0Ib1D5O8YcpWJOSJx0yCHIzT/bdkidu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7wZYF6o; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7wZYF6o"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8d7f22d405so103917566b.0
        for <selinux@vger.kernel.org>; Thu, 05 Feb 2026 01:45:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770284751; cv=none;
        d=google.com; s=arc-20240605;
        b=CYWSFS+LsLbFe7qbgq9H7dX4w5L0i8HjyBf+HegqAsahaevNfGrnxw7ymLNn33nKzC
         nXSrquTWzCsqX3aeGmMXo49qMwiBTacfndK4bOsShWNXLH5JW7SSfnDfYgeKxsFJJ/cJ
         3ny5rfAqezK8F83AOidLYJzyBxy8lbKQmeMgDbn33FM1zZHomr1faZPfhxW/OT1vVd1X
         nuRFQ+DZU3vdBLRB6s81e/HZyzMVv8wZdVWPuLqeit+En65M59aXlv4a90wuFofIfuPS
         olIttu2OI8EevKieVDftosFPzrtNXxRAInfoMO2336Wz90zd/WNUA4knDO7lMocub2f7
         /CAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gTHjRNg48uqIhlFUjNVy6w29gFOiVNhUd1etS9WljNU=;
        fh=dwazjfzu4rUqskEQ6DHETVpaolD8Lv/VLyrcpk69Hqc=;
        b=WK7CYidcqZ3IL8yxAC324ey1Nv5S+2jXln3MNGjfMhdTwFgOs52NB0T8ClKmoGgCkb
         rLEjPRYZ0eQ7TieQcbdvxfxndDAOvyHz8dLeK+CjrKR0iWLhEuV75jSIKJ0BvP+MCJOz
         uBVj6nYXe8tmPxlRMTxJ88QO+2sRiVrSWyuovqTMSjMMxSkgAkKH5IP6t4HYx+13ZoTl
         sCuqrtVWQDkIcg71o6oOapJFolJFDhuv/aUYjAPn4zqke7l81TqL80ahwVoACnoes64f
         0qW5dnynatA2Mc9OY+knvTBNclrjlBJUKJJgtuoyVU/5wakwakLiYAc2IzcvoX3o6n7u
         g6dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770284751; x=1770889551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTHjRNg48uqIhlFUjNVy6w29gFOiVNhUd1etS9WljNU=;
        b=X7wZYF6oGkxVE+gLTBtcX28o4eYBAX3e3P5/p1DkotCtFvnSm+dNdGmggiKQnap9HF
         uJoR8Y/7jQwtGKgtwXZNQtMOcaDouskzI9DbFRdinBwM2G8kpSDc+wVOPd9ayKvPaZtX
         qDZsWavmVfL8txVAZaxKDRyNO2gl3nDKYj6Y08WRzZFoXlLH4OBDdd4dCHPmAv9LaYhV
         aYyqyMoVjKFMXFsylm9qYTAL0LLdTNasCpSpfzLfkc3XzkPNORx9OBQJnvhWeWVvJgyV
         IFPElSh1GAM0WngNDgAYeJbIEwtbP3kxmdE1hnqP1mOoFVug/wkO0WrOFsaHCyIytL65
         aJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770284751; x=1770889551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gTHjRNg48uqIhlFUjNVy6w29gFOiVNhUd1etS9WljNU=;
        b=cpVhgGLKkGX/pslul58nYDxW3sfP/5NGgpv+6kpPHZrYua3XWy+YRdtCjfKFb6p9Ne
         RaJGFI0w3ttjj7SV1DxJvGEU+U3F+94QiHy+eCNJNtDz/8wUB+O5X+pWXLaw9p2EovFJ
         MgJcaWZkcaqaLI2WoMgN+65TOI84yiD2Fv7U/rouvVTiSoXJ9X0UTCRSRdMUEPWykpy4
         xrTGBPfclWp/yOCoClt1qo5vnP1xlA9XXB+tqz6yTw1G7uZwWdm0dnxRCKK3YOOPax5U
         1FgRECp04pS5HwaaIHM9N5hSpwFQOVJqixVjWRZSHZkL0SXPQC3iul3YMkjbg6Y5SG1g
         NAiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7WCZUM3skXwEaZsswpoBnuZFQqrgHWZ1OJalA38VoiIKv3R0DTlGagS0TlXvmk8fZ/n4cGlhv@vger.kernel.org
X-Gm-Message-State: AOJu0YwOP9GrsZU3QwBJdkaCuRSMnoPDTuSVOmykACb0EdHoZbS+Y7f9
	NCVRHeZMgeT0fiHljxywFSmlK+TaYAjW8ib5rDT1LeG1HdGbwRg2QOY3doWV794TAJzVD3dXIU1
	3mirqRgbFyToXddwxcz6Xq+T5teK8kqo=
X-Gm-Gg: AZuq6aJpYAfgw7rYsyQRQIIM8e/thRB+M8zpUC8rlQV6s0eP+i2n/5Dhm4UYXdytU18
	nhHGQYSIUz2MInubnT0zheJfKhNdUEHNMMgXPojPQ1pO9QfOy0xJkE9YfAoPiE3SixaL44CNqh0
	yXFWPnnoFZClp9ymfFda4Fh1ocdrPzTFbpnbqN/0i4yXdQQE3ozlOGHS4drhhpT51gHtccB5P8U
	tWOA1Nd1fcjk5LMjYsMfxQis41j68tqRc8vsnWwV3/M/0bgXMRWdqn6gQt+W9yce6CNBfcpDr1a
	y6ikGw46AmR9CM/v5x7nRR9uBYyRVQ==
X-Received: by 2002:a17:907:7f92:b0:b87:31d1:4131 with SMTP id
 a640c23a62f3a-b8e9f64603cmr435430866b.60.1770284751163; Thu, 05 Feb 2026
 01:45:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-13-neilb@ownmail.net>
In-Reply-To: <20260204050726.177283-13-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Feb 2026 10:45:38 +0100
X-Gm-Features: AZwV_Qg7CM-kXxjB2Qin-euJkaOUd7ni190R_n_ZLhun34eHr5T-i9uF6CbqXdo
Message-ID: <CAOQ4uxi3bNYq1b4=qL-JLi19hRwurntfLZXhUMVL003NarBdGg@mail.gmail.com>
Subject: Re: [PATCH 12/13] ovl: remove ovl_lock_rename_workdir()
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 6:09=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> From: NeilBrown <neil@brown.name>
>
> This function is unused.
>

I am confused.
What was this "fix" fixing an unused function:

e9c70084a64e5 ovl: fail ovl_lock_rename_workdir() if either target is unhas=
hed

What am I missing?

Otherwise, feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
