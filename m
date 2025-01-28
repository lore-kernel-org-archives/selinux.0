Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF9E1A9B3B
	for <selinux@vger.kernel.org>; Tue, 28 Jan 2025 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738071594; cv=none; b=jEKINkMaekt0dXn7v61cn9dP77jkm1a7TLV79Gfa+NY5Kl5rrNjQFuMDIMoKOlrQltOLn6oVpAD0a39PZsBiia0GuSFKsYCCVf1Vdc0fta+PN1MBhxkCvQQ6+7jSQDDVfIZpY1BlL4hptqZ7Uib4A2HlMeSI46KyuUwTByo2vyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738071594; c=relaxed/simple;
	bh=n47f2qrk3szvQqbPWEmm3BmCX24+ZwJ1xIBAzf0fKv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GqMR1GXvlxtazY+MuDKhrttDpK1AYMeVgMzqWOLZjbrFtuGilZSctV2+dSXz0BO7FvvU/z+RDz5w32LgH8xyfGJVpsAoS99aF7z+cOjq/kGSdzbyxgRmNSNMQnafQUUUP1qPK4OjyWctAq0AiS9KsEomtKYMO8ml0alo2Gkb3/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eTqKj23q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTqKj23q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738071591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=sZUqqUcXTLi9DF8UmCuEcsnKbp2jih4n47JODOQINJI=;
	b=eTqKj23qROVnWOzRV/RejKpQJF6KdvDtLZ50rrerU5sTZTh6EX9ygqXP6NNQ+9fq9FoO/3
	HEqBHhaCPPzM1bLPsSvyHqulk+zi+5kbM53aA7bBX8KpyAZ9t9td+oa7TUSa15oANk/a6J
	4vgQc35gH/xcNr9Us39bZxYSruLMqKc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648--tFWBygtOWONEcYNIVIkOA-1; Tue,
 28 Jan 2025 08:39:47 -0500
X-MC-Unique: -tFWBygtOWONEcYNIVIkOA-1
X-Mimecast-MFC-AGG-ID: -tFWBygtOWONEcYNIVIkOA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C84611801F1C;
	Tue, 28 Jan 2025 13:39:46 +0000 (UTC)
Received: from localhost (unknown [10.45.225.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B2AE30001BE;
	Tue, 28 Jan 2025 13:39:45 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Cc: 
Subject: Re: [RFC PATCH 0/2] Possible solution to possible regression
Date: Tue, 28 Jan 2025 14:39:44 +0100
Message-ID: <877c6f83bz.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

James Carter <jwcart2@gmail.com> writes:

> As reported by Petr Lautrbach (lautrbach@redhat.com), commit d96f27bf7cb9
> ("libsemanage: Preserve file context and ownership in policy store") can cause
> restorecon to use old data.
>
> Here is a possible fix. It seems to work.


Works for me. Thanks!

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

>
> James Carter (2):
>   libselinux: Close old selabel handle when setting a new one
>   libsemanage: Set new restorecon handle before doing restorecon
>
>  libselinux/src/selinux_restorecon.c | 4 ++++
>  libsemanage/src/semanage_store.c    | 5 +++++
>  2 files changed, 9 insertions(+)
>
> -- 
> 2.48.1

