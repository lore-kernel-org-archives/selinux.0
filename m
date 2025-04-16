Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C13433FD
	for <selinux@vger.kernel.org>; Wed, 16 Apr 2025 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744833706; cv=none; b=jU/+9f7CT5qSWfuQ1xpXe9GvHvUScyNAHYt3B3Jg8gYmB1UODEp5IJ8j2N2XM5B+QS1z4dWePrOrOtWd8wgi1lUlSk9GiLebhnqvUe5vS6+caulivqLXq2SCZmyIplgn7Fj+DAse2hwY5L6ys08eFH+vzsvKfNoKo9S3WyaabOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744833706; c=relaxed/simple;
	bh=UeIp39lnGGy3PM0neyjy6EPxnHWQ5iprmq5BpUHrKlk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VGQqm1WlD1n6Kmqq7rx4rSpjK3Ts0R/imRLHJCILrhkOOUFdBepp5b3EhtSNsR1gOr29Ncs/1D5tUy/A434G774Bvt6i6T/ii9kaK+ouMs9fCaYNvhjB5wFQOBGrmGF1gEFtyHtCwkAVL4RJHnovviYHU5mhMiY47SSltKZUfeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0wh+G5g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0wh+G5g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744833703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=Tji+YUIAV1W20PjNlT05QaXrVH2JLrjRzrm+ST7ewrE=;
	b=F0wh+G5gC1Gp923r+lNRVleKBHf1qmocwE/jBMWIV11BhVUesrmOBU7pJXvdVqEqs2tHGy
	mgnP5t8zkvvPmcJXUKKqaa4Id3HlUKAEFA4Ml/gRRuSIdM4cXYRERWtE8C+3vSWB62LACY
	TPJoOLuBD35cEIkDVUvwGUp3rkSZfAU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-UAVB_jbSNryplhCgAuCxlw-1; Wed,
 16 Apr 2025 16:01:39 -0400
X-MC-Unique: UAVB_jbSNryplhCgAuCxlw-1
X-Mimecast-MFC-AGG-ID: UAVB_jbSNryplhCgAuCxlw_1744833698
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C37B41800ECC;
	Wed, 16 Apr 2025 20:01:37 +0000 (UTC)
Received: from localhost (unknown [10.45.225.67])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 369F318001D7;
	Wed, 16 Apr 2025 20:01:36 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org, Christian =?utf-8?Q?G=C3=B6ttsche?=
 <cgzones@googlemail.com>
Subject: Regression in selabel_lookup after "rework selabel_file database"
Date: Wed, 16 Apr 2025 22:01:35 +0200
Message-ID: <878qnzzxi8.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi,

we have a report [1] that in specific cases local fcontext modifications
are not considered or correctly resolved in `selabel_lookup`:

    [root@default-0 selinux]# matchpathcon /usr/bin/cloud-init
    /usr/bin/cloud-init     system_u:object_r:cloud_init_exec_t:s0
    [root@default-0 selinux]# semanage fcontext -a -t bin_t /usr/bin/cloud-init
    [root@default-0 selinux]# semanage fcontext -l -C
    SELinux fcontext                                   type               Context
    
    /usr/bin/cloud-init                                all files          system_u:object_r:bin_t:s0 
    [root@default-0 selinux]# matchpathcon /usr/bin/cloud-init
    /usr/bin/cloud-init     system_u:object_r:cloud_init_exec_t:s0


The bad commit seems to be 92306daf5219e73f6 ("libselinux: rework selabel_file(5) database")

Please take a look.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=2360183

Thanks,

Petr

