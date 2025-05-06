Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98121DDE9
	for <selinux@vger.kernel.org>; Tue,  6 May 2025 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746533902; cv=none; b=ocEPZf7Tfhp9CifA51mk8qVUwKkHlqRqU9G+ikMe6T+AvAcpUQK0BWM+EJBAxcuG0G7yHelL6JARyAV43JR80oIA6h3TSXvq/5rZz+hQA+tMcsZUObB4zubFvfVMOQ4ClIrcErXcQ1ziYA/luqBrmhzfftIG5oSVRjwzNCwjtdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746533902; c=relaxed/simple;
	bh=v4rVuA5hj2FbFmWd851pt/te0fH2cp1ZbWfzvWih8Bk=;
	h=From:To:Subject:References:Date:Message-ID:MIME-Version:
	 Content-Type; b=bsMQrXcPkt8Vu+W9rIEFOqqjovQ500drex/HRxDNQi+psu8Vd61vQPkhzopIAeAthW+kag7ssZuzKqga/P/Z6uKA0dVeRXVEIBhg/rb5okg0rqwO+uHOSSZs3V+7QgufaTW99UsOguwJVhR+UFVNL4FaDBnr8oBcy2KNb+M/RH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vs955ARl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vs955ARl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746533898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=v4rVuA5hj2FbFmWd851pt/te0fH2cp1ZbWfzvWih8Bk=;
	b=Vs955ARl6o22e+/vSAnpgBOwDw2GF8zMSm0W6Kt2qo8yQQvjFXpG9t85cQsdjhz16/RWYT
	cjZ6928rkUqr+fFzCSgQaSWN6TstSsMWfZi/MLUWaFjBYHmO9zq68zsN4tPlVivbim5UiB
	XE7W2qgKkp3KmQ2TZqrTTZvZG3YaYG0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-4GIlQsQINYWM1EX_kLMGwg-1; Tue,
 06 May 2025 08:18:17 -0400
X-MC-Unique: 4GIlQsQINYWM1EX_kLMGwg-1
X-Mimecast-MFC-AGG-ID: 4GIlQsQINYWM1EX_kLMGwg_1746533896
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD39A1955D63
	for <selinux@vger.kernel.org>; Tue,  6 May 2025 12:18:16 +0000 (UTC)
Received: from localhost (unknown [10.45.226.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2791E30001A2
	for <selinux@vger.kernel.org>; Tue,  6 May 2025 12:18:15 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: [SELinuxProject/selinux] The SIGBUS signal is triggered because the
 status page is incorrectly written. (Issue #475)
References: <SELinuxProject/selinux/issues/475@github.com>
Date: Tue, 06 May 2025 14:18:14 +0200
Message-ID: <87bjs60w6x.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


biubiuzy created an issue (SELinuxProject/selinux#475) - https://github.com/SELinuxProject/selinux/issues/475

selinux_status_open() open the kernel status page and mmap it with
read-only mode, If the file is truncated(i.e echo 1 > /sys/fs/selinux/status), this causes subsequent calls to selinux_status_* interfaces to trigger the sigbus signal.
See also https://github.com/systemd/systemd/issues/37349

