Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882D01DB55A
	for <selinux@vger.kernel.org>; Wed,  4 Sep 2024 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462829; cv=none; b=ktOYyG8RMIw2EcRSruqSn0OkRiXlgPGRfKFlJRQNBni3wcU9T2Oz30aBK8zWOF/j2VklDZKSMv8T1F0fMzrAVU00GPQd4GeZJ3AkMoNegaJ7ARCvMydUXS9T6+ZaK5P0oZ4JmoVT4WKpyR7Ru5XcqUn6LMmjlVn4bTxoDxO/QB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462829; c=relaxed/simple;
	bh=Ab69YG/Ribq51EmgsO0AfqFFKSTbz1Ufs2VGWQl257s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=O/vRoEZbG1AxTNDMrt3oH3JecBOLcd2HpMMQkTX2YxhGA3uGstL4g3oWCqSrJp2COj0TQQZKPp4Wt3JaYTw8GhxvOuzR2YtQLBSAJIlfjjNsROYIvS2IJ+q1xZ0ZLkRrGFnbnKxTKy4cwEKUuQa2eq3qzQQzic5d0FJEMGILDiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dVIxhD2Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVIxhD2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725462826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Ab69YG/Ribq51EmgsO0AfqFFKSTbz1Ufs2VGWQl257s=;
	b=dVIxhD2YF/BlOfs14mr56ZCibKmBaxI6n499mzTurRUUp1c6kgMjuKHLR+UwFP0tPx0jHX
	dzs4leNRi6gB8jufjiAmcKog4bDeMc/XGEkNYXccIgVBR298lmpQPNansW5WsAiWFV58gO
	nsIKctpGc5JKBSS2Nmq2XmzBDoiAQ2U=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-ez1eqooHMiOaStj64hUzeg-1; Wed, 04 Sep 2024 11:13:45 -0400
X-MC-Unique: ez1eqooHMiOaStj64hUzeg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7cbe272efa6so1103425a12.3
        for <selinux@vger.kernel.org>; Wed, 04 Sep 2024 08:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462824; x=1726067624;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ab69YG/Ribq51EmgsO0AfqFFKSTbz1Ufs2VGWQl257s=;
        b=ThcaAEpWRfq4tveWRdBwokWWiQiHm+KnUNXegfbtsSvKSZt+QrYIedlJ8ceL5tPW9M
         tj25IsMfmlEAJrqUHdzBh9IYrE05UVzoeAhoYI0/0M6QB5dFSLSH88W42JIrdS6zBSYb
         jMX3JsbNe0TUVp2rZH1No67pMDPeoZaQXhIbHl1kE1T275B6Z//kA5llhMj2LcYlYYV4
         GuSQgXIJ2CPDMmptyRI74TbPXTTR16NLWKxu9Wh6BSAkS1fEV+/kDxmylk9StQ7/PoL0
         lPHPsAaEZLj72lZtqbCdgPLxvoId13UgCrKYxt3KNOz8ikYLX9G96Fxter0o+NpGn0uQ
         wwrQ==
X-Gm-Message-State: AOJu0YyvBq1EWcdmm04N2iGNV7wJFm06b1rFuThtL08KiNBlRqbzXTXt
	yEsz+DGSsYyuGHcKg29vdzyzx4RcZGPYdFQVccuUF27buNo1on/9AU8VZdAcVoYjQ6G7TQ+DJzU
	tBf70Usu+Dzc3AUvFJqlGv7M33p23YisrzeYdQF6GtUJyOnivCF7skkLDaQfDJq8C+R30EbYOo0
	6IYIkc4fWzUiEdSLUstQLUMhgf6KmC6fKctWttVpXi
X-Received: by 2002:a17:90a:8c91:b0:2d3:da6d:8330 with SMTP id 98e67ed59e1d1-2d85617bab4mr23900506a91.4.1725462823863;
        Wed, 04 Sep 2024 08:13:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQN+sIeNGMISdOCUicsy7BI04u9rAeKEjiavo9HklAxAYm6wbw3vH9hbkGarLGPAROwupRbBcxqoXuoiwgzS4=
X-Received: by 2002:a17:90a:8c91:b0:2d3:da6d:8330 with SMTP id
 98e67ed59e1d1-2d85617bab4mr23900482a91.4.1725462823546; Wed, 04 Sep 2024
 08:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 4 Sep 2024 17:13:31 +0200
Message-ID: <CAFqZXNv7T8Tv_9AYX2xC_tJ9x10qPoPFQsQPBUDOuphUfUFPiQ@mail.gmail.com>
Subject: selinux-testsuite / NFS symlink issue
To: SElinux list <selinux@vger.kernel.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

While playing with migrating selinux-testsuite CI to Testing Farm
(more on that later) I encountered a problem when running the NFS
tests: When you create a symlink to the testsuite directory, cd inside
that symlink, and run ./tools/nfs.sh, the nfs_filesystem/test fails.
In fact, I also get some strange failures in unix_socket/test in the
general testsuite run over NFS, but only when I run this scenario
manually, not when running through the TMT tool (which also runs the
tests inside a symlink to the testsuite directory, but only fails on
the nfs_filesystem/test).

Feel free to investigate if interested, for now I will leave the NFS
tests out of the CI, as it's not clear if the issues are in the
testsuite or the kernel (or both) and I don't want to add workarounds
blindly.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

