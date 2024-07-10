Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D83192B9D
	for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618357; cv=none; b=I6pLQRk1SfYLJniebg47YcCH0JFtWU7RVd5GxQSexjiowSWxyvLXr8wjnlU+29fLeZSyXMfSsg7XKJbDqtCBo/OrJ92v7IbKlgWwVDlPyXY+5cxfnjIpCdl4jLPFSR3M0+LBHenYzTm5aTOMjSuZfPV1ajwTVpwWrRqt2Oq2lR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618357; c=relaxed/simple;
	bh=wqC97oVOvlJl/ZubxUHrL6ipupG4EEG7UGjQXSPT9eQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=on5BqdLHA/Ye2ueakOzm4WrExJl1/Xs98FQlv52wsUdj+n0+RJwVwxqungYjSmWhneqlkB4S3wFyTPSJUvhaOvpF5tOeHwmar7bTPKBWECk1tUoIiGusJiEOFSLKgvlL+tNuNoZ5q4OjzuZmI7e4ZE7CoH0kUoR1PXEN8M3JKFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ACM8bOXK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACM8bOXK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720618354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wqC97oVOvlJl/ZubxUHrL6ipupG4EEG7UGjQXSPT9eQ=;
	b=ACM8bOXKwYXwpYZg0stLdhTfeoucRJi3V1oILfJ1xI3PjZbl3IA+3M1Hc9/YbcMHC25Yi5
	9c7BYwgjQY1lYecbObnrQfrbcjFkC6d2tAX2KQnJjXgaupUCTULDcnivNkKNuqq8g69Fjw
	ZdiAF0s9OxbKlD82YvejGRt2RhkGd4A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-Y-ZQd5woOVCjHHDGNLV91Q-1; Wed,
 10 Jul 2024 09:32:32 -0400
X-MC-Unique: Y-ZQd5woOVCjHHDGNLV91Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29FD119560B5
	for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 13:32:32 +0000 (UTC)
Received: from localhost (unknown [10.45.225.200])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 643101955E85
	for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 13:32:31 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: In permissive setting labels that are not in host policy when
 running unprivileged fails with EINVAL
Date: Wed, 10 Jul 2024 15:32:24 +0200
Message-ID: <87v81d74pj.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hello,

this is originally reported at
https://github.com/SELinuxProject/selinux/issues/437

There a question why kernel blocks changing SELinux label to some
unknown label and requires CAP_MAC_ADMIN even in permissive mode?

Reproducer:

$ id -u
1000

$ getenforce=20
Permissive

$ chcon -t bin_t /var/lib/mock/fedora-rawhide-x86_64/root/usr/lib/systemd/s=
ystem-generators/systemd-ssh-generator

$ chcon -t selinux_unknown_type_t /var/lib/mock/fedora-rawhide-x86_64/root/=
usr/lib/systemd/system-generators/systemd-ssh-generator
chcon: failed to change context of '/var/lib/mock/fedora-rawhide-x86_64/roo=
t/usr/lib/systemd/system-generators/systemd-ssh-generator' to =E2=80=98syst=
em_u:object_r:selinux_unknown_type_t:s0=E2=80=99: Invalid argument


Quotes from the issue:

This is happening on a system with SELinux in permissive mode. Applying
your suggestion does not change the result. I assume this is gated
behind CAP_MAC_ADMIN for unprivileged users. Is there any way to make
this work without needing root privileges?

Hmm so the kernel blocks unknown labels unless the user has
CAP_MAC_ADMIN in the initial user namespace. I'm assuming this is for a
good reason and it would be unsafe to allow any user to do this so I
don't think there's anything that can be done here

One thing that's not clear to me, why is an unprivileged user allowed to
write labels known by the host but not labels that are not known to the
host? What specifically is unsafe about unknown labels that's not an
issue with known labels?

Petr

