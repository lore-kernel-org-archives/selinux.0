Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3FC1A00F3
	for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638433; cv=none; b=FhQtkBqHlP+KUNjnEQKz7zeix+NZKhxKWhZkDG72rz1l0l/NJ3WXDdE1NEIe9sDo87zAF2ZHJhWm85wH/gkmT+Hj6hzIXqYEwG+cCEx4CSW5yoEWjq3iD19g0vP7vT80Fg+tLQ1TA4V0NsvBUln3GkhCouIQVtE9PyETZoaK6aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638433; c=relaxed/simple;
	bh=/YOCQGla96lyi9+WZYThkgr172xIPgYN6781ye7MXrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZUhCfwlnMPpXDGBE8x6Yicnx/KKIZUN4eM8GNY8ewHyzxg4IIM9EcLoRxp0CtYsblJARDeurAYqwFkqPxRC1JRwvfq2PIAZyWeEczVrDBaogpijsfXIKMDhWzDTkFRgcZuyw8IkFy5a2v4Z0KbiEMHOGS2UZXCsPIUjMvaJRnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1+W9Owu; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1+W9Owu"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7bb75419123so4480716a12.3
        for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 05:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723638431; x=1724243231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efSYHJ7+GWRrjUh0zT3IPHzCzxlMWqj3wYeNgY5t6cU=;
        b=k1+W9OwuQpfa2W05/dDXmnfN8rnpFZwHjnd6+i9SLxeYAMdV8IvAp68CiBL6SGBxFi
         EzUBtm6SwFbueIB/0wEtjepOHZZzGuast2DP159RbvLVJnpVkIunF1KQD3xrnwYaOoIq
         OIjV5Y79EQmOtEi3SRP7TWv498tJ3cy9k0qaYGCNPYES6S3iri5n/PV+6rsQIUpxsc4f
         fzEC232ILYFD93EoIdaQQJJ/aqIq/20oRq319E+EFl42qUpqRdhIIsF/qPCLo2KPVkQq
         QA462xHwVV2kmXgXFm7oINGmatz/SkJxc90ojdpfqWZKHsU9uirCETHgBvxceO8LX0DH
         hpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723638431; x=1724243231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efSYHJ7+GWRrjUh0zT3IPHzCzxlMWqj3wYeNgY5t6cU=;
        b=aMgGG7Xvh8QgwwYq6yz0OEGEVqdaVMT3crQw299I/yhIaoNrv4T5mqf4Hx+ChfSd4b
         8yjlJ3FSr+F/qKPdkzeuW8OorUnsoOManCP2l8ZlJe7I/Sf4uZ3g3cOzjaMs2uCNGMgR
         aeNsqyqjGlKD6GDCSrcXjF+8sk6OAxcbJJFvN6e7QnZtWQoY2//ug9zMUwoqH+akLBoG
         fjdKU56I/mG1fX4Vc2Ebw3rN4uVcqUAQRiBEKkDGXWx5yN63tWzswz48f7hXgyj/2TzK
         fTDF8ZYd32QttbcOiQbdNht6TJL45GIS2c3wCaXIRvqcIWBCNwsyGhZEHXVWpWx2SKLS
         RKbg==
X-Gm-Message-State: AOJu0YylWIcQLVF9N7a7s+imQTxNmyofzYUL4IUBJJMyHsOrvH2xCYTD
	pyZlG+y8h4Xc8CiHreA/0Z0DQoNqcl6nUikMhSBBYsNKxuLiVVPWqLAI2ZW8v8DxCnzve6y0Fw0
	M2XzloyaaC33SFaaH740SqsHti259VA==
X-Google-Smtp-Source: AGHT+IEObdaKh7tO9OHr98xpYVJej0iNcYsVfgZdOCcZBTmOXvLQbACv+fSmEu2LCBovCqq2S+F5NZk2anvj37PQn1w=
X-Received: by 2002:a05:6a21:3945:b0:1c0:f26e:2296 with SMTP id
 adf61e73a8af0-1c8eaf8aeddmr3006641637.48.1723638430670; Wed, 14 Aug 2024
 05:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fe7ad5f53d674b8c98e46be0b0fa56ef@quicinc.com>
In-Reply-To: <fe7ad5f53d674b8c98e46be0b0fa56ef@quicinc.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 14 Aug 2024 08:26:59 -0400
Message-ID: <CAEjxPJ4i_y0gnJ0WPsmJ4KEAhbD4Gd4AuenggajSHWDmAqFR+Q@mail.gmail.com>
Subject: Re: kernel NULL pointer dereference in selinux_cred
To: "Jaihind Yadav (QUIC)" <quic_jaihindy@quicinc.com>
Cc: "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 1:52=E2=80=AFAM Jaihind Yadav (QUIC)
<quic_jaihindy@quicinc.com> wrote:
>
> Hi @selinux@vger.kernel.org,
>
> We are getting below Crash while doing "cp" exectutables to /system/bin i=
nside adb shell.
> Reproducible steps:
> adb root
> adb remount
> adb shell
> cp <file_name> /system/bin
>
>
> Crash :
>
> [  298.902980][ T7012] pstate: 60400005 (nZCv daif +PAN -UAO)
> [  298.908637][ T7012] pc : file_has_perm+0x64/0x1f0
> [  298.913483][ T7012] lr : file_has_perm+0x1bc/0x1f0
> [  298.918415][ T7012] sp : ffffffc02a3c3b80
> [  298.922556][ T7012] x29: ffffffc02a3c3bb0 x28: 0000000000010000
> [  298.928744][ T7012] x27: 0000000000010000 x26: ffffffe94ca17000
> [  298.934927][ T7012] x25: 0000000000000000 x24: ffffffaca6e90008
> [  298.941102][ T7012] x23: ffffffe94bf77000 x22: ffffffad42699d00
> [  298.947283][ T7012] x21: ffffffacb8829b40 x20: 0000000000000000
> [  298.953467][ T7012] x19: 0000000000000002 x18: ffffffc01ffb3050
> [  298.959652][ T7012] x17: 0000000000000031 x16: ffffffe94b265120
> [  298.965836][ T7012] x15: ffffffe94bf76417 x14: ffffffad3d3cfa00
> [  298.972014][ T7012] x13: 0000000000000004 x12: 0000000155de28d6
> [  298.978197][ T7012] x11: 0000000000000015 x10: 000000000682aaab
> [  298.984379][ T7012] x9 : dcd4944bf4caa800 x8 : 0000000000000000
> [  298.990561][ T7012] x7 : ffffffe949f06644 x6 : ffffffad3cbce518
> [  298.996741][ T7012] x5 : 0000000000000000 x4 : 0000000000000008
> [  299.002919][ T7012] x3 : ffffffad3cbce468 x2 : ffffffe949fb6d84
> [  299.009106][ T7012] x1 : ffffffe949fb6d84 x0 : 000000000000001a
> [  299.015286][ T7012] Call trace:
> [  299.018527][ T7012]  file_has_perm+0x64/0x1f0
> [  299.023025][ T7012]  selinux_file_permission+0x1a0/0x224
> [  299.028501][ T7012]  security_file_permission+0x54/0x150
> [  299.033972][ T7012]  rw_verify_area+0x70/0xe8
> [  299.038460][ T7012]  splice_direct_to_actor+0xc0/0x318
> [  299.043757][ T7012]  do_splice_direct+0x84/0xd8
> [  299.048423][ T7012]  vfs_copy_file_range+0x1c4/0x458
> [  299.053545][ T7012]  __arm64_sys_copy_file_range+0xe8/0x1a8
> [  299.059289][ T7012]  el0_svc_common+0xcc/0x1d8
> [  299.063876][ T7012]  el0_svc_handler+0x84/0x90
> [  299.068456][ T7012]  el0_svc+0x8/0x100
> [  299.072318][ T7012] Code: b4000ae0 f9403e88 b987cee9 8b090108 (b940050=
1)
> [  299.079300][ T7012] ---[ end trace 9ef748cec7fd66eb ]---
> [  299.084775][ T7012] Kernel panic - not syncing: Fatal exception
>
>
> Analysis :
>
> We added the log in current_sid function and found out current_cred is co=
ming as NULL.
>
> /*
>  * get the subjective security ID of the current task
>  */
> static inline u32 current_sid(void)
> {
> const struct task_security_struct *tsec =3D selinux_cred(current_cred());
>
> return tsec->sid;
> }
>
> extern struct lsm_blob_sizes selinux_blob_sizes;
> static inline struct task_security_struct *selinux_cred(const struct cred=
 *cred)
> {
>   +         if (cred =3D=3D NULL) {
> +               pr_err("SELinux: cred is NULL  ...\n");
> +                return 0;
> +       }
> return cred->security + selinux_blob_sizes.lbs_cred;
> }
>
> comm 'cp' has 'cred' value as zero which is causing above crash.
>
> Could you please provide your expert opinion on how to fix this issue .

A NULL current_cred() is not a bug in SELinux but rather a bug
elsewhere in the kernel - that should never be NULL, at least not in
process context.
You didn't mention the kernel version or whether it has any
out-of-tree patches or modules, which is where I would suggest looking
first.
-
