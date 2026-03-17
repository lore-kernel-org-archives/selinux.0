Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF413F54C6
	for <selinux@vger.kernel.org>; Tue, 17 Mar 2026 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773772794; cv=pass; b=gmGvhPzU3oCijG766SBRI/+3QH1/JGFbG1RP4JpoPSigHNx1pq7SRe90iinz/8z16dIwi3P+qee1XnrNkhjyjvC+X/fOX4QWaco9R/LO8s7dTUBBYAKnmTYIEO/m+r0Jmj6y3fw1Ncj8HoC//Eij7Imp3AjtZmtCTeCEW4dBc84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773772794; c=relaxed/simple;
	bh=NPpeZAWfnOdI1uHGGY3LCnZtVp8nE5Ty3myJpBAiqSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0JoW6opk438REhmUsKZE9L0aO3JSseAJcmrIZXJP2AzPjtnex1NkbLmLas46oikbGmDBLJ4CAytDL6W6qZdX/nNJC53HyM7PAh8db2tPR6cvEppkt1n9UG4dqX8teufMOWPgT2uRLa5wL+kBP11b3ENWkcIlvoja1lkadoSSxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQOv28tE; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQOv28tE"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8296d553142so2855161b3a.3
        for <selinux@vger.kernel.org>; Tue, 17 Mar 2026 11:39:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773772793; cv=none;
        d=google.com; s=arc-20240605;
        b=cen+U3+qxmD2NdUqI7rXP1RrNDIy7KfRlKmNHyrWHcTj6K9cSzsMTVCdT5Gy76OEXn
         bvdASHGvmEVUZ4WkKn102n7PpqWXTckGOLC6MD7Htn9H2pRWCBOS09yNpVtQ929LETOP
         XjY8Y4kihgXKPYEzKxSbPVXgfyYqHNWnIch17gFBWem2aUlT3eTJAumtfcah2gDFUGtV
         gxbrPtO2liBjQdMBABQ3KhJYF/iRfIvwh0ZXoqllW8lrQjWpJ6zXi9sdco3XmkF7WONE
         yQe4yBQdFKMieC32Uz21TGW6TbJXMq+k+ol0Imor0u+QSvZQc2EBwXE5jXZIxG+nKiJ1
         GRAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0UxcPkaT/sVF9hRfH4zjki72izcgKGz2NvNqlhp6Ct8=;
        fh=x2Mhf3hCaWx+ktIpQCoss3dkJF3mceq6IEg7nlK3baY=;
        b=YkCIfCczmmujJx6s+E0n2w4F2nrSpNF9QsV4HG9VWeH7lk6NrlmC8Phsk1EhA3lffk
         npUYlALt87r3nxqH5uMN+m5t7EyHJPiwsuBHGuJf8mmE1J8CQ3KOfVv7UnhNB+EHM+BC
         IyxnkHicdEHbNgzptzTu22seIqz4V/LhAofLKhBdt5sZm1Pulpd9U/zEIXkWWSwi2TG5
         BgBcAnH2wXKgUvmLPW9LiEUNUu1ha/TCez9g3SH++xRrILBp/fQnP6NBkY0u+yT5RM+D
         kpHSPoJxk0JkoEYjGqwAfFYxYOMx89nA5zi5I9IdLiprWyNu7YN/2nHa4xWPS2jIadBs
         MnSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773772793; x=1774377593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UxcPkaT/sVF9hRfH4zjki72izcgKGz2NvNqlhp6Ct8=;
        b=IQOv28tE8rg4OJHqP4CDERVd54UnizOYobLZpPn14L4Oz1b1cs7rDsHPJnbxnhhxu0
         Pw84ykUDjhTKZmiGuqaX1YxQtWttuEmsiDeIE7cZZRAbo6cZ+kgz7hxHX7oiQu2xYHyi
         JB91dTfKaifXT3iJ2/qWCnS0O8UkOlorZ4zTeuF50WkZqcySmZ1kdjPK10sBk7sAB/+2
         aUp9nV9D5NPh+znMhQNIVdVSLMKasCcCU0yXN+9lKbZxKiNtZK3ZytPpfj2SFq4hvdTr
         DE/LQ9PK5sh8hzcC7DcpCndkY1CyVogVs8eDH0sUIsK3H4Fu0LswccPhDB0mttVDcwyl
         G/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773772793; x=1774377593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0UxcPkaT/sVF9hRfH4zjki72izcgKGz2NvNqlhp6Ct8=;
        b=BV5q8ePofe9aVuaPI/U1Rl+sdUz8uWc8KbbTzVR7CGA+IOACv1RcUbNO94konfLI9E
         MkmXzsjttAGs2JOyVkZC0MEKyZF/jDLm/k1CBOwSyy31lcwdKjr9SIF4uIjiLz0uaheo
         ouVKYbRb2Hz9CEiptcw4qz6YqXDNOrEIYKnkp2QgoLjaZMv5i64qOgkGWH87sfp/QBSc
         hyVDj6hEZSUyDzGLoJXlEewB50cnOTGhCxYCTnFwW6gIjjBctB1dMaS+woe+7SCzN3DD
         xdQg3givQTNLbm4LNf/Y5BCIKvgUA3JEE97oWKsEjVHyzS9aE+2BTTN3F/DK07tiKzRT
         sTKQ==
X-Gm-Message-State: AOJu0YyE0X29rDpHkerT1Kcer0pA8fnefRhoxqz3w7fIpjx7ZhiQxvLy
	ZneXShdUHTsVsSGIlR99nWBGGortE4D9P5FUQ/WeK4ZSD9frxCMy2GBjLJf0BgR4LhqgJ+PG5IA
	tZ/wrkQhHNdSTxv6xfGg2u/WMHL1ALhzUaw==
X-Gm-Gg: ATEYQzzikqP9v75AjgnoLsz+Sl9UySXP0OemwVa0gPfqtzdLXVCdwPIOpxnNRXFo8oB
	52ytFLNG7U5WKeFVJr1L6OARYK3ElwnJZOAXWLc/nhrTVVJdd4oUI3Q/c5RoJtEdAMuOTfw+n+i
	P6/xx/NV79p642WCXjRya352ovjXf7OdCN9/NF1bf82488agTmDpT541pDXAnHOeIQ5R83+7EFF
	itmKUaPcLwqeP6zyg64Qa+hSLxcIlBtsgaIjjdyrnxcCDrVmwB9DcpXdEBUZb7aAoCGEStFtq5w
	KQ5k/AkqiEQz2WzUQQ==
X-Received: by 2002:a05:6a00:4208:b0:82a:88a:1363 with SMTP id
 d2e1a72fcca58-82a6adc7e22mr342970b3a.2.1773772792946; Tue, 17 Mar 2026
 11:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310015453.1978412-1-tweek@google.com>
In-Reply-To: <20260310015453.1978412-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 17 Mar 2026 14:39:41 -0400
X-Gm-Features: AaiRm53hsWY81hmN8ONk96wC8wN3IicpeKqwsZLsaD6PYnyS5WEgO9ibRZ_Vfec
Message-ID: <CAEjxPJ4LyCvazGuviyuPw7rVrzNdugQEukK=WMo2=SXdF4gRzw@mail.gmail.com>
Subject: Re: [PATCH testsuite v2] Add tests for selabel_file backend
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	James Carter <jwcart2@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 9:55=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@google=
.com> wrote:
>
> Add basic set of tests to validate the behaviour of the selabel_file
> backend. The parsing and usage of file_contexts is confirmed, in the
> following scenarios:
>
>  - selabel_open with no options,
>  - selabel_open with a NULL SELABEL_OPT_PATH,
>  - selabel_open with a valid SELABEL_OPT_PATH,
>  - selabel_open with a valid SELABEL_OPT_PATH and SELABEL_OPT_BASEONLY,
>  - selabel_open with SELABEL_OPT_VALIDATE and known types,
>  - selabel_open with SELABEL_OPT_VALIDATE and unknown types.
>
> Validate that substitutions and local customizations are loaded
> according to selabel_file(5).
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Thanks, applied.
