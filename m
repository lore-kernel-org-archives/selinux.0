Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B651241124
	for <selinux@vger.kernel.org>; Mon, 17 Mar 2025 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221778; cv=none; b=ULyPfGVx1PhZ9iiaEc0BJKxVIHdWV82eYGehqF/TYnfXOznXR71tfRtI6cO1dfa/GDtTgUjwfHvC3Dw+9hQXP9Pnt/MkxLgOqbkrMr/bTYhKG4KRvlaoNc5tmdfY4tA/gJiq1h/gWlTXlqZBZSS8IIXVb0YVn+78HsWB3Ztpz+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221778; c=relaxed/simple;
	bh=yFC8OuDfkqLcTQbN5bLkkArptMJo49PXzG7n3lFsPZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cBxipEtYV35Eh9MSgsJirqNGZxb+IjciptnRQFVUW1uZiAJ2fvlmZk3SIUZ2hELPAvvwX1vkEqBZNj3FoKtIzYBJVqGyOUWzJLLMo6/jyX0lh+CIAoj0C9XcgesLCKejQAcq/acmyLwa9VjtvW6mktF+/N5Ez1qWIEtsKzqFPvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWR/VACp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWR/VACp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742221775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JoeZUKWe3ZECOeHcg85QmqkYKIAUZYtTCBttDCpUdwc=;
	b=LWR/VACpRAnHiKOVrUHz4SqfC5LKDSIa/UT27Ui/nWXE8ioTBNOLxdq7+FQBqVFqZlcar4
	eqL/v2TNxY9lxtcM4AMZxekNtpv1TWN9Dv2VEBg3dZuMr4fp2qqoDYI9T0h9fM8+BeRlaN
	adzmLESWwe3ZbqDtcQL5A5AYOY/bYmI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-rw_EZx8yMrqAci93N-pz3w-1; Mon,
 17 Mar 2025 10:29:30 -0400
X-MC-Unique: rw_EZx8yMrqAci93N-pz3w-1
X-Mimecast-MFC-AGG-ID: rw_EZx8yMrqAci93N-pz3w_1742221769
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3BD011955DBD;
	Mon, 17 Mar 2025 14:29:29 +0000 (UTC)
Received: from localhost (unknown [10.45.224.166])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9AA1E1956095;
	Mon, 17 Mar 2025 14:29:28 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Cathy Hu <cahu@suse.de>, selinux@vger.kernel.org
Cc: fvogt@suse.com, selinux@suse.de
Subject: Re: Question regarding restorecon and btrfs read-only snapshots
In-Reply-To: <98f87fd6-6d3e-4539-ad8f-1a0dc09aa890@suse.de>
References: <98f87fd6-6d3e-4539-ad8f-1a0dc09aa890@suse.de>
Date: Mon, 17 Mar 2025 15:29:27 +0100
Message-ID: <87senb7mt4.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Cathy Hu <cahu@suse.de> writes:

> Hi all,
>
> I have a question regarding restorecon and btrfs read-only snapshot handl=
ing.
>
> restorecon is failing with "restorecon: Could not set context for <path>:=
  Read-only file system"
> and return code 255 on btrfs read-only snapshots.
>
> Currently we are setting <<none>> for those read-only btrfs snapshots in =
the selinux policy, as
> we use restorecon in our autorelabelling [0] during boot and restorecon w=
ould fail with code 255 otherwise.
> We do not want to ignore non-zero return codes, since issues might be ove=
rlooked.
>
> However, this is also not optimal as we have to write every possible path=
 into the policy or asking
> users to set the <<none>> tag manually.
>
> I was wondering if there was interest/plans in implementing to skip read-=
only btrfs subvolumes in restorecon
> entirely or provide a different return code other than the catchall LABEL=
_FILE_KIND_INVALID?
> Or is there another way that we did not see?
>
> For more context, this is the bug on our side: https://bugzilla.suse.com/=
show_bug.cgi?id=3D1232226
> There was also some comments about possible implementation, see comment 1=
 in the bug.

You could use `-e <directory>` to exclude read only subdirectories.

Petr

>
> Thanks :)
>
> Kind regards,
>
> Cathy
>
> [0] https://github.com/openSUSE/microos-tools/blob/master/selinux/selinux=
-autorelabel-generator
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

