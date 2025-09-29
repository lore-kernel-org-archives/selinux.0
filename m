Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D42C859
	for <selinux@vger.kernel.org>; Mon, 29 Sep 2025 02:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759112973; cv=none; b=D7KrrAiGb9sRh7gl9zKZakDsVd124TliTSqvkW7h34wK6yMnXUO5W2dp8f2gaXjD/c0qa4+7BqdVurFhphMHJgUjYlSUWvw73J/3ys1ZugCvUM1ax8sKLSG/1SLNIF9gYGeiLpPjqdXHIa6kD3CZ7zOQ1YmLcVOQwL7jcZdH1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759112973; c=relaxed/simple;
	bh=V4fWq6pqai6SmUUA5dAUKGAje3GtYo3VekoRoQJRZdc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 In-Reply-To; b=iH47l1B540EH/++4TbTE8Si6KcNAzXjw6CWHDsmnaoERSyFAcgaqqPSKAQfSGuFWY3HWYmN9UZW/fDCuNGAK09LhuDy0U8+KFKIDk2u/r4C1NKuhe9jpKALQNFbeIW4+phqe3pOiR/SWgs6DOHFqPEHkrNw7wGe+b7QmFcGtzxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dj7Xlr2Q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dj7Xlr2Q"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso14617235e9.3
        for <selinux@vger.kernel.org>; Sun, 28 Sep 2025 19:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759112970; x=1759717770; darn=vger.kernel.org;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7Dwm/3No1cFVCQKUo7V2KTNxobsnDiRLcX+B9pGxSA=;
        b=dj7Xlr2QONpOS1FmZr6APY6fHvLFHFMFtzJRbJmFIX8eOjHf6X9ESI7LTJHdxqHhJB
         xOMC3qraS8CykF3cRvtZFrVEWJKi8UqD1+adgEFb+Rm9Q39MddR4AXnl5ZLF0gubhbkF
         tcvY4g6GJev1PsgRFXCamqUZltnLe/ieAvHW+7q8H1dXT2PVkm9KbDHODJJjBCYcvg3D
         W/mNJB7uJKVpYXlZYcJZ45anf2MbctaPQ2Y0DLzpJSiRavog9l4CaRE22vXKaN3z6hf1
         IKyCziy/C7QVpCo9gIJhwacGpUh47jzQO6k91yVwl4oGCWKjfHC9Rlhmni9R7O4qTO7u
         llyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759112970; x=1759717770;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k7Dwm/3No1cFVCQKUo7V2KTNxobsnDiRLcX+B9pGxSA=;
        b=iFOfaHDAtTgbe8CHXf4iYu64jhZf5FcUPjpaA5ZunFm4SvtPingsXj6hczYQ+mdYyC
         uZvtCfPsXebkTB9RtGUlDdptVN85iivXPeGCvyIyQXcKXWI2X9eBlU2kCXL//KXr1UAd
         q4rBs1f0aO10GnYVqrrjqLIAtKKg9xKTNa9rYevC01iy2MZ05omjXZWHxdfgG2I4yka1
         QBvdPxfuJSkB5O8fSdcnnVHpSALbEkLsbvFN88pH5f3lheREUvYd5OmOG451vSDX++BY
         S16KURLA8ccgpCC4iyyHRUT6Z55xVxL1O3cHTIQB4sArlZSdXBQhMxD3jqlEbIVkE8aQ
         kULw==
X-Gm-Message-State: AOJu0Yzdi8LrwiCqaukUa3Q7yPwCGpmthY3RU6L56sHeraD6spmbdw8s
	DUB0OejrlDOzV1FQgviYFys4d5i0efvfbpQ2x4r95D3KuLpgArGp301S
X-Gm-Gg: ASbGncvaA8/2Ya1Oh2pnmzJeSjiMAcF0yCLFetr+djLh0/IRXCnP6PUBeFVuP0wnUMU
	sjZ7Yp+d+ryMOoHTGqSYoidELbxEmBAANqhL7HAQNjIr6zDjzPfDmYIQYRqeSQTOVE6dvVUqpKt
	qZ0ot67WtlFzBQ4JuMKqNEPb+smFQJuircFbEOnPIaHpPuiHv/MFX/+ddfy6NnqMJ+bWqIRmdEm
	6IK4txGqife8H/p1U8jGkBqM7gtCZEHpALyX2ZVXL5GO5JLGbLBLKno1MHTa15afKbOEW6TmC5Q
	YJWv/n3Uaaczn3+XK7NhKk4B2vEXcj58t1+M8RokQXgovFbHL2oZDIEmMNy0QZNuJny58UzAqTZ
	+eTu6RXS82jc3iH5J4qAzkNPMzkh1ovul
X-Google-Smtp-Source: AGHT+IEhqxhP75UguxL8o+bOsAe/PJGn0j/199FfZwReOrLwBhIJ9w27FLKcCEF3h4dCpypQKDAkrA==
X-Received: by 2002:a05:600c:3148:b0:46e:4b8b:75f2 with SMTP id 5b1f17b1804b1-46e4b8b7a3dmr47032315e9.16.1759112969674;
        Sun, 28 Sep 2025 19:29:29 -0700 (PDT)
Received: from localhost ([81.79.59.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b9e3bdsm173097355e9.2.2025.09.28.19.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 19:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Sep 2025 03:29:23 +0100
Message-Id: <DD4XI30UAJ8U.1XMTXFPG4NYJ2@gmail.com>
Cc: <selinux@vger.kernel.org>, <stephen.smalley.work@gmail.com>
Subject: Re: systemd.exec(5) PAMName= with libselinux
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <dominick.grift@defensec.nl>
X-Mailer: aerc 0.20.1
In-Reply-To: <87pldq40fr.fsf@defensec.nl>

Hi,

I think this is solveable but this is going to need a new field added to
default_contexts + $selinux_root/$policy_type/contexts/users/*. I had a
look around tonight, couple notes:

1. We can't really change (and shouldn't change) the function signature
   for get_ordered_context_list (3) and friends.  However, we shouldn't
   need to do that (see point 2).

2. So long as get_ordered_context_list (3) and friends still can parse
   the user context files, we should be fine.  They all seem to rely on
   the same underlying function to parse those files, get_context_user,
   so along as we update that to support multiple "fields", and to just
   ignore extra fields, then that should be okay. This should mean that
   backwards compatability should not be a problem at all.

Then, we adapt pam_selinux (8) to use getseuserbyname (3) to lookup all
fields it needs manually (without using any of the libselinux helpers
for that). Alternatively, we could add a helper to libselinux for that
that supports the new "fields" so that we don't break compatability. If
that's a desired route, any suggestions for that?

One concern I do have (and something I'm trying to keep in mind) is
ensuring that libselinux doesn't have a dependency on PAM, or at least
that our entire user login flow is completely dependent on PAM such
that it's impossible or hard to replace it, given that we don't have it
as a hard dependency right now, and I would be cautious to make it one.
However, we are just adding a field here, so although we can have that
new field by *convention* be for a PAM login stack, other software is
free to interpret as it wishes.

Another option would be to try and deprecate default_contexts, given
that it seems to be showing some age in terms of no longer being enough
for one of the major pieces of software in today's landspace (systemd),
and introducing a new file that supports a configuration format with
some kind of KV system so we have named "fields". However, myself I am
not convinced that this is needed or worth it right now, but of course
open to ideas and suggestions.

Thoughts?
Rahul
