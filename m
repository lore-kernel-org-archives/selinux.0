Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF81A683E
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108485; cv=none; b=DueloHHKYkZ98cYI61fVpAfdn+QdWmH8AY0eeKB2qV0JAdYULO5Z8538Jsl4gbumghxU5Q+CITHnft05CiLWSLQl281uqs6PlGbPxqnBuP6A8KkdaF8kHco58oFQNLV90A+T33HqOTPf3/9y9OsJNsRFKqnMJQa+szFdia2KX30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108485; c=relaxed/simple;
	bh=9ZRYpGRK5UcqD3yiCSX4nBikrl7UcyNG6jNTiHS6tGg=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rc0QNjCTYJ3Tu5dF7hWOsF7NEFdXP4zZ9WpUbpj1lz0xx/yHjW7Tj9VIq/eZXgnk9HwRoVLtoYxF/E8MHBrjNqbfWk5sTDl+lEUZnjwbMIQxF35oDvB1j48UBV0H9RJoWxdjObTRUdu6GtcyRJTUgh5+wR1BgN9eAAbz3VUwJzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJfxT1Ky; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJfxT1Ky"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781108482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=59mqItrudwbkcm00pn8Vwp50rD6EpNwvGmvuXo51tSc=;
	b=BJfxT1KyFLLXuAxWzXB6PF41OCUc/hhHtOa/C0pcUVjX6f29jAasXiJW1CSnz6iuiQ1J1a
	Pa8x2WWMmPI8XB1IRuqTB32O+wkk1NrIJnIUifmTFlcBIgIzVU7B6BgdYtmrUJmkTW8614
	PW+5Wi4xuccL2rcMFfBhWeBYy8ylXac=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-ZLBmdNZxOruU5mQnaZ457Q-1; Wed,
 10 Jun 2026 12:21:19 -0400
X-MC-Unique: ZLBmdNZxOruU5mQnaZ457Q-1
X-Mimecast-MFC-AGG-ID: ZLBmdNZxOruU5mQnaZ457Q_1781108478
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 512411977300;
	Wed, 10 Jun 2026 16:21:18 +0000 (UTC)
Received: from localhost (unknown [10.44.50.150])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D3BC7763;
	Wed, 10 Jun 2026 16:21:17 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Kalevi Kolttonen <kalevi@kolttonen.fi>, selinux@vger.kernel.org
Subject: Re: SELinux userspace build fails on Fedora 44
In-Reply-To: <aimHv-w8yri0aoB_@AA-94-54-42-0F-E2>
References: <aimHv-w8yri0aoB_@AA-94-54-42-0F-E2>
Date: Wed, 10 Jun 2026 18:21:16 +0200
Message-ID: <87eciemkn7.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Kalevi Kolttonen <kalevi@kolttonen.fi> writes:

> Hello!
>
> The instructions in README.md no longer work when
> building SELinux userspace on Fedora 44. It has
> something to do Python 3 as the error is:
>
> python3 -m build --no-isolation --wheel .
> /usr/sbin/python3: No module named build
> make[2]: *** [Makefile:17: python-build] Error 1
>
> Fedora 44 has:
>
> Name        : python3
> Version     : 3.14.5
> Release     : 1.fc44
>

Works for me:

$ rpm -q python3      
python3-3.14.5-1.fc44.x86_64

$ make DESTDIR=/home/plautrba/sw/selinux install install-pywrap

$ find /home/plautrba/sw/selinux/usr/lib64/python3.14/site-packages/
/home/plautrba/sw/selinux/usr/lib64/python3.14/site-packages/
/home/plautrba/sw/selinux/usr/lib64/python3.14/site-packages/selinux
/home/plautrba/sw/selinux/usr/lib64/python3.14/site-packages/selinux/_selinux.cpython-314-x86_64-linux-gnu.so
/home/plautrba/sw/selinux/usr/lib64/python3.14/site-packages/selinux/audit2why.cpython-314-x86_64-linux-gnu.so
/home/plautrba/sw/selinux/usr/lib64/python3.14/site-packages/selinux/__init__.py
/home/plautrba/sw/selinux/usr/lib64/python3.14/site-packages/selinux-3.11rc1.dist-info
/home/plautrba/sw/selinux/usr/lib64/python3.14/site-packages/selinux-3.11rc1.dist-info/METADATA
/home/plautrba/sw/selinux/usr/lib64/python3.14/site-packages/selinux-3.11rc1.dist-info/WHEEL
/home/plautrba/sw/selinux/usr/lib64/python3.14/site-packages/selinux-3.11rc1.dist-info/top_level.txt
/home/plautrba/sw/selinux/usr/lib64/python3.14/site-packages/selinux-3.11rc1.dist-info/INSTALLER
/home/plautrba/sw/selinux/usr/lib64/python3.14/site-packages/selinux-3.11rc1.dist-info/direct_url.json
/home/plautrba/sw/selinux/usr/lib64/python3.14/site-packages/selinux-3.11rc1.dist-info/REQUESTED
/home/plautrba/sw/selinux/usr/lib64/python3.14/site-packages/selinux-3.11rc1.dist-info/RECORD
/home/plautrba/sw/selinux/usr/lib64/python3.14/site-packages/_selinux.cpython-314-x86_64-linux-gnu.so
/home/plautrba/sw/selinux/usr/lib64/python3.14/site-packages/_semanage.cpython-314-x86_64-linux-gnu.so
/home/plautrba/sw/selinux/usr/lib64/python3.14/site-packages/semanage.py


> How we do fix this?
>

See the commit e11e59675f69:

Author: Petr Lautrbach <lautrbach@redhat.com>
Date:   Fri Jun 5 13:25:27 2026 +0200

    libselinux,python: Use system Python3 build module
...
--- a/README.md
+++ b/README.md
@@ -64,6 +64,7 @@ dnf install \
 
 # For Python and Ruby bindings
 dnf install \
+    python3-build \
     python3-devel \
     python3-pip \
     python3-setuptools \
@@ -97,6 +98,7 @@ apt-get install --no-install-recommends --no-install-suggests \
 
 # For Python and Ruby bindings
 apt-get install --no-install-recommends --no-install-suggests \
+    python3-build \
     python3-dev \
     python3-pip \
     python3-setuptools \

Petr

