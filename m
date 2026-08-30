Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7425E31A555
	for <selinux@vger.kernel.org>; Sun, 30 Aug 2026 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788121116; cv=none; b=VEgWYXX5luYwQWM/QnUTGyux4TRMdmHgoEUMdb/crF4AC6CdhrwjczJQw4oDJpuuiRVFWtud0KgZLX1i81a2oRjuoIDJnrMh5oUYwFi3U9uGJA8idhmrDEPSLCfldo9YpxTy4xRr3vK+P5ldC/8eFxV8j5f4a4v2OEEl/ix+HSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788121116; c=relaxed/simple;
	bh=VMG2LH/F+w18y8ek5RhYaB7XBpCHU7jcAOg/2glLET8=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ulwas3YHeYlAsJjLX7PhsXo4c8nnf7iy27Y7sm0mdi7DneEJ7o3YN0vsakwk0mUnSxmRPFQSTbD3YrEPcgsr8Mvangp4IDmuj1DSmJDEs0Aa9pyXb3yT8wkBoocUtv7vfXUs+6zdiatla8CDQTKc/2cT29KkolVfMNv+q+/hjK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jz5Rqmun; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jz5Rqmun"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F751F000E9
	for <selinux@vger.kernel.org>; Sun, 30 Aug 2026 20:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788121113;
	bh=CsUHNcoleKc7AYIA5z8C5jaw5J9FX26BJTCTfkJfzLc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Jz5Rqmun4y3hSudUXb1ZnAsbr7amQIVXDYu1r2URvauVVyPHfuALOk604vD7By5hC
	 YuGYxPidV1NZxAADWp7CboVNY7wNZTPAJ2AVrQolXEaSXsB+YkfAsLh2NqAl1+suG+
	 VCYajh7rsdBZ1dHhrENmSg2LM0Y8xWwn8G9PVrLdsI+mrqcDnBzdgbg5uemE+G4vrS
	 3pMNHHcH+7YKiAKJD+E7y1G12Xw6E1eD+/gEGMV/aK3fFWj09lIWv2ALyygVM9ZJVN
	 5Dd0cusO4GjpUXO1P2AMRZIAnt0JkdWu/7EgDTgXyQqmyILAQD2LjTGo3hq/EzMi28
	 qX16JD8bKp9sA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] selinux: use socket SID for SCTP ASCONF permission
 checks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260830201157.2084730-1-tristmd@gmail.com>
References: <20260830201157.2084730-1-tristmd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 20:18:33 +0000
Message-Id: <20260830201833.B0F751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> __selinux_socket_bind() and selinux_socket_connect_helper() call
> sock_has_perm() which uses current_sid() as the AVC subject.  When
> selinux_sctp_bind_connect() is invoked from the ASCONF processing
> path (sctp_process_asconf), current refers to whichever task was
> interrupted, so the permission check evaluates an unrelated subject.
>=20
> Fix by extracting the sock_has_perm() call out of
> __selinux_socket_bind() and selinux_socket_connect_helper() into
> their callers.  The process-context wrappers (selinux_socket_bind,
> selinux_socket_connect) call sock_has_perm() directly.
>=20
> For selinux_sctp_bind_connect(), determine the caller SID based on
> the optname: SCTP_PARAM_SET_PRIMARY and SCTP_PARAM_ADD_IP are ASCONF
> chunk parameter types only passed from the softirq processing path,
> so use the socket own SID (sksec->sid), consistent with other
> softirq-context hooks such as selinux_socket_sock_rcv_skb() and
> selinux_sctp_assoc_request().  All other optnames originate from
> process-context syscalls and use current_sid().
>=20
> Factor out __sock_has_perm() with an explicit subject SID parameter
> so that sock_has_perm() remains unchanged for all other callers.
>=20
> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> Cc: stable@vger.kernel.org
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830201157.2084=
730-1-tristmd@gmail.com?part=3D1

