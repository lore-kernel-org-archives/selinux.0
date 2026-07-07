Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0539124DD17
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 00:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783382442; cv=none; b=FaOde1SasepD2N5fl5jF6f+Wy0xcfGTWhsHH57+ByrYs6eEEFsiar7qSOc/abFtdbqppsWFQw8T4H5VIczu/GTiXA/sYkstkA3D9Gd1y1fxFZIOEKzBUjzjwom+yZ+jWPPPNYzR8RJIElcAXqESrk4XaaNBfzY0ejIna9FHpJ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783382442; c=relaxed/simple;
	bh=P31hN8AOt06aGzCH3SlqhaqFWrTfvMuReInQJ7bC8RQ=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=feBuE3g5LQB5Q7E6TWI6nheSVb96OhIJgAfy/vWkcLWfzvCkPSzliY6F0hzhVu8RCFDVk4K7sVmW0fYbj0TR0Ikk31Y8JCYNL1/7r5heZetgqFywd5aW//mfbvb+sQfMBRr3+dSBdmblLpYh0DVzqrucalfaPOJp5Nz8eWePEek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wg1eIl+k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wg1eIl+k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968731F000E9
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 00:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783382440;
	bh=EL4jLkk0VROxTdA1oyswmEVVJQjwu02ktaAnJVErud8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Wg1eIl+kfWzN2UPXLYkCPUiTchcq5bpFvhEmIEgFjbD7wUvRu1eJWSVmE76mK2xlF
	 dI/Jr35OqUN9sJwiviJTx/zjGlWsz3ycExBqSTYIFilbd2VoY2xnG1A6Gl/hEEzrNO
	 9QxjiJS1Yt5SUbIdY5BAxQ+DqITGgTYxpmByvap9FISTacWxthY/ip9dHo+A3wzyQb
	 5pzXtw6O89xFepKXAIlsJZb+KA4hFki83452mMPTcGvNNROgDKaTXrRz62CenLGrST
	 WINvQeX4bb84YKKYSxOEIL0GDkBP6dQld0P9rbxi47I1FFa0s9QNcUJousJSuwmakf
	 bxLAHVhxhWUvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/8] lsm: Add granular mount hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260706235053.4104951-2-song@kernel.org>
References: <20260706235053.4104951-1-song@kernel.org>
 <20260706235053.4104951-2-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 00:00:39 +0000
Message-Id: <20260707000040.968731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> Add the new granular mount hook declarations and implementations
> to the LSM framework:
>=20
>   mount_bind        - bind mount (pre-resolved source path)
>   mount_new         - new filesystem mount (with fs_context)
>   mount_remount     - filesystem remount (with fs_context)
>   mount_reconfigure - mount flag reconfiguration (MS_REMOUNT|MS_BIND)
>   mount_move        - move mount (pre-resolved source, target and top
>                       paths; target =3D=3D top unless MOVE_MOUNT_BENEATH)
>   mount_change_type - propagation type changes
>=20
> These hooks are added alongside the existing security_sb_mount() and
> security_move_mount() hooks, which remain in place until all LSMs
> are converted.
>=20
> Code generated with the assistance of Claude, reviewed by human.
>=20
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com> # for selinux=
 only
> Signed-off-by: Song Liu <song@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706235053.4104=
951-1-song@kernel.org?part=3D1

