Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901631598F4
	for <selinux@vger.kernel.org>; Mon, 17 Mar 2025 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232594; cv=none; b=DIbM2L+KgPxeiCP0sqp37Qo7dzVvOoP2tX4pTnhPIeTUibLAOAw3NrLFr9CweG/ncNuEZQj3acUCzWTHmR13zzfnkLfM+SNI7tuHR0/aqzLGkPoPrDFJKCgSGXLRY73w3iOawd7cvCjQYpN+f5nEIfgvsAmxX0bLt55H2ArsXmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232594; c=relaxed/simple;
	bh=KgS0GUOnAM298xWCuw+ZzeWyWVqHGU7gBlCKm+qm9ho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J4HgkjqMaqT0OQHOyUmJUv2xsPaJOlkVobw80QfUv13EgsZDHDseY2oIxr997dL7J7mqCsEdMSaLxnYKhUra7dmuVAXSYoSlXAFqPDFpANvBg5TLVSSWqVBU7Y2ihgXYVZ77BpY8dtMtRzAb5OxEKb24bPjE7WeGToUlhpu8zfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UcFQRbRv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcFQRbRv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742232591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KgS0GUOnAM298xWCuw+ZzeWyWVqHGU7gBlCKm+qm9ho=;
	b=UcFQRbRv8IoNZiRLQ/dgMSh2Z0rJEFzCAGAKJS01wKkmdEHWKopT+xW3sPvrBepCxXpR6q
	GaEbKYvVdBbz4hQboVRiYIDIOj0akgFvPbu0YceVvP4GqaAkFbS9iGaya25p+ZWOLmT3V/
	2TnPJvgJTqpT8c3Ew+SJJDKaI7KOO8c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314--TU26zTdN0Sj1vZTx5DANg-1; Mon,
 17 Mar 2025 13:29:48 -0400
X-MC-Unique: -TU26zTdN0Sj1vZTx5DANg-1
X-Mimecast-MFC-AGG-ID: -TU26zTdN0Sj1vZTx5DANg_1742232587
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0679180AF4E;
	Mon, 17 Mar 2025 17:29:46 +0000 (UTC)
Received: from localhost (unknown [10.45.224.166])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64DBA19560AD;
	Mon, 17 Mar 2025 17:29:46 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Cathy Hu <cahu@suse.de>, selinux@vger.kernel.org
Cc: fvogt@suse.com, selinux@suse.de
Subject: Re: Question regarding restorecon and btrfs read-only snapshots
In-Reply-To: <8ca3a1ed-0f53-4da9-a86b-75699f306f8c@suse.de>
References: <98f87fd6-6d3e-4539-ad8f-1a0dc09aa890@suse.de>
 <87senb7mt4.fsf@redhat.com> <8ca3a1ed-0f53-4da9-a86b-75699f306f8c@suse.de>
Date: Mon, 17 Mar 2025 18:29:45 +0100
Message-ID: <87plif7egm.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Cathy Hu <cahu@suse.de> writes:

> On 17.03.25 15:29, Petr Lautrbach wrote:
>>=20
>> You could use `-e <directory>` to exclude read only subdirectories.
>>=20
>
> Yes that is possible, but also requires a manual change by the user to set
> this up together with the snapshot (same as telling them to add <<none>>),
> which we would like to avoid.

Your -relabel.service's are generated and so can be restorecon options
there.

Fedora uses fixfiles -
https://github.com/SELinuxProject/selinux/blob/main/policycoreutils/scripts=
/fixfiles
- which detects ro filesystems and skip them.



> Is there a reason why these r-o subvolumes are not skipped by default?
> Could they be skipped without a problem and it is just missing the implem=
entation?
>
> Thanks :)
>
> Kind regards,
> Cathy
>
> --=20
> Cathy Hu <cahu@suse.de>
> SELinux Security Engineer
> GPG: 5873 CFD1 8C0E A6D4 9CBB F6C4 062A 1016 1505 A08A
>
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146
> 90461 N=C3=BCrnberg
>
> Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andrew McDonald, Werner Knoblich
> (HRB 36809, AG N=C3=BCrnberg)

