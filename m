Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFC92DC792
	for <selinux@vger.kernel.org>; Thu, 11 Sep 2025 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757616528; cv=none; b=KDsWhCQAw12He2uxyrZZFoO9fjPvypsLG7mC8dKo5l2s/+NN55kU+8Tajsl96V9EFV0NB+H0xE+YlsdK52NJUlLzdmlwwr55dezSphL0dY7xJlTAt2fcQIXcKlUAY5b5l5a5ZLwmT5/nRBHklmB4y9FcLCHpjJgNKdyn02tOaCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757616528; c=relaxed/simple;
	bh=bHiVerPGCekTzieW8mUvK9CAvoF4D0xki8bVu1IkM/k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FHHnDh3b646EoqLd21QWYuHtm3jzn+AoXkbInSMCY+M7NpqzqCYVd42eZMrxV2YgsReNkBss/3U6jyHyYKsrb1UA8gJ4skquDmlLKWjLr/ryus6zwWkb+kFr3j526Y66jOimeT1/c1koK9qsE2hTCjI1p0qs8EgNXSM4PYZXLJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UE4HKJVs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UE4HKJVs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757616525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GicTzaKdK1pTr0Ef9rc1n+zf6Gpcy2L+el57nuJCU6Q=;
	b=UE4HKJVsfne9pRlrT2r4PUhY2UwZBydzJpurRF1/BOlNjBYc63QBR1G3mw1vBf9iEWSShR
	avsIQZg7svLNvkrWQA8T7rWzH8nrcaC81B/oL8QmraLyPKaUH+rkMoM8i52sgAV9W2aLho
	mck8W9ZzUBxph0e0LL230Ut7Uzahuy0=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-buBDssNCM1SQDRp0DsbaFg-1; Thu, 11 Sep 2025 14:48:43 -0400
X-MC-Unique: buBDssNCM1SQDRp0DsbaFg-1
X-Mimecast-MFC-AGG-ID: buBDssNCM1SQDRp0DsbaFg_1757616523
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-6051e1b5833so628336d50.0
        for <selinux@vger.kernel.org>; Thu, 11 Sep 2025 11:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757616523; x=1758221323;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GicTzaKdK1pTr0Ef9rc1n+zf6Gpcy2L+el57nuJCU6Q=;
        b=TriPl78rl5GeBAY9CIe/dFeuYxzFidm/nN+pl4ho+NlRgRFBpk3LpJa8asjjs5aKIE
         Xp5G8mx9dkyZIBo9q0eZzs/gTARdp2WoPmrE0pbf3/8QRWwkzsQDNkdQEqn3vT7BAKVT
         00sd/qG6XcvuQMySJUf2h4IpeLMf4PNncMTtx973m0L8UxWEEHlsCHQm7ayIu3Dz2kZm
         WnJLMUmBvtjO0bAdqOn4C3z745uUc8r8Rw88oKQcLeC+a0IYNIDPRysqpkAWBV58hKOQ
         JfCPOj3NVcuesKKOmre7ez2qbnLNGbkQi4knBRR9UoCpI6Y0GRcEN9wt8m4xUUI+aiWd
         FyTQ==
X-Gm-Message-State: AOJu0YxUHi+XopvmEDMwxcQCzUSBgSR3QeqO5V3SJYQ6yvA2jEYgDyEA
	DwHD1lHCwm+K0GE5ctFdtLZGl7MT6n5WRkeMlTPDBAxnMyCE3WN/l8WtdKpF3DYxEfUNlGoHxyE
	OxbDQSmt8g+L/g1iBvEcB26XIeZkqwy/KBCNpf3c3+DwRExVm/II4pomhs8ePnqRJc73w2v2yFy
	JRj0zlPlK/IJKOcJf3reXyOuPLWB7OKpVbXneDeqe81JaH
X-Gm-Gg: ASbGncudbSWbbq9wD0lq6JXu5OUNXyRhG4Od2nRZfczmvod9NPm/81quVxYOfr5ZgVQ
	+kdaLYgtctRj2/wIcs2WZUZM4C1wNHvnuseVvOu3bKR9ADpeK7G1Gc0T0DwwRloCS0g30/0/J96
	lDdJC3cy89B2Api3VA5dVa3aqRQtFR+hszItQ/lYFI0Az1boCGite3IA==
X-Received: by 2002:a53:b192:0:b0:600:df03:32d2 with SMTP id 956f58d0204a3-6272269c061mr394386d50.24.1757616522832;
        Thu, 11 Sep 2025 11:48:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ0ubvasAnWUgY+IZKIX5MD4oqAHoS09m0PRySCxPKuKr26mXC5Z7Lgme4VKW5oFUR4fi7OX/BVkQWLlm1KBQ=
X-Received: by 2002:a53:b192:0:b0:600:df03:32d2 with SMTP id
 956f58d0204a3-6272269c061mr394373d50.24.1757616522380; Thu, 11 Sep 2025
 11:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pranav Lawate <plawate@redhat.com>
Date: Fri, 12 Sep 2025 00:18:05 +0530
X-Gm-Features: Ac12FXyajCzPFhrCL3YmvdNMI15A44ydndopMBvpSddBAe-Ra7VDuXLlNtTUzoI
Message-ID: <CAJp=TCGK-KUja2M9kxt5_SXC8P2=WSxN_-VjFJa96Luc2JSmCA@mail.gmail.com>
Subject: [PATCH] semanage man pages: Add examples for -r RANGE flag usage
To: selinux@vger.kernel.org
Cc: Pranav Lawate <pran.lawate@gmail.com>, Vit Mojzis <vmojzis@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hello,
 This patch adds missing examples to the semanage-port and
semanage-fcontext man pages showing the correct usage of the -r RANGE
flag for MLS/MCS systems. Currently, users who try to use the -r flag
without proper examples often encounter unclear error messages when
they provide invalid range formats.

For example, Here is a command with wrong range string value:
~~~
# semanage fcontext -a -t admin_home_t -r s0.c0 /root/test
libsepol.mls_from_string: invalid MLS context s0.c0 (No such file or directory).
libsepol.mls_from_string: could not construct mls context structure
(No such file or directory).
libsepol.context_from_record: could not create context structure
(Invalid argument).
libsemanage.validate_handler: invalid context
system_u:object_r:admin_home_t:s0.c0 specified for /root/test [all
files] (Invalid argument).
libsemanage.dbase_llist_iterate: could not iterate over records
(Invalid argument).
OSError: Invalid argument
~~~
Similarly for port
~~~
# semanage port -a -t http_port_t -p tcp -r s0.c0 8888
libsepol.mls_from_string: invalid MLS context s0.c0 (No such file or directory).
libsepol.mls_from_string: could not construct mls context structure
(No such file or directory).
libsepol.context_from_record: could not create context structure
(Invalid argument).
libsepol.port_from_record: could not create port structure for range
8888:8888 (tcp) (Invalid argument).
libsepol.sepol_port_modify: could not load port range 8888 - 8888
(tcp) (Invalid argument).
libsemanage.dbase_policydb_modify: could not modify record value
(Invalid argument).
libsemanage.semanage_base_merge_components: could not merge local
modifications into policy (Invalid argument).
OSError: Invalid argument
~~~

My main motive is to come up with a logic to handle this error better
but before undertaking that big of a change I wanted to push a small
improvement to the code and so I have added correct example strings of
MLS range into man pages for semanage-fcontext and semanage-port which
I have tested to work properly on my RHEL 9.5 VM.

This is my first contribution to the SELinux project.

  The added examples demonstrate:
  - Correct MLS range format: s0:c0.c255
  - Complete command syntax with the -r flag for both port and
fcontext operations
  - Clear indication that this is for MLS/MCS systems only
  - Practical use cases (HTTPS port and secure directory)

  This should help users avoid common mistakes with range formatting
and reduce support requests related to unclear error messages.

  Signed-off-by: Pranav Lawate <pran.lawate@gmail.com>
  ---
   python/semanage/semanage-fcontext.8 | 4 ++++
   python/semanage/semanage-port.8     | 2 ++
   2 files changed, 6 insertions(+)

  diff --git a/python/semanage/semanage-fcontext.8
b/python/semanage/semanage-fcontext.8
  index 3a96c62f..3e7a1d8b 100644
  --- a/python/semanage/semanage-fcontext.8
  +++ b/python/semanage/semanage-fcontext.8
  @@ -100,6 +100,10 @@ execute the following commands.
   # semanage fcontext \-a \-e /home /disk6/home
   # restorecon \-R \-v /disk6

  +Add file-context with MLS range s0:c0.c255 for /secure directory
(MLS/MCS systems only)
  +# semanage fcontext \-a \-t admin_home_t \-r s0:c0.c255 "/secure(/.*)?"
  +# restorecon \-R \-v /secure
  +
   .SH "SEE ALSO"
   .BR selinux (8),
   .BR semanage (8),
  diff --git a/python/semanage/semanage-port.8 b/python/semanage/semanage-port.8
  index c6048660..217fa398 100644
  --- a/python/semanage/semanage-port.8
  +++ b/python/semanage/semanage-port.8
  @@ -61,6 +61,8 @@ Allow Apache to listen on tcp port 81 (i.e. assign
tcp port 81 label http_port_t
   # semanage port \-a \-t http_port_t \-p tcp 81
   Allow sshd to listen on tcp port 8991 (i.e. assign tcp port 8991
label ssh_port_t, which sshd is
  allowed to listen on)
   # semanage port \-a \-t ssh_port_t \-p tcp 8991
  +Allow Apache to listen on tcp port 443 with MLS range s0:c0.c255
(MLS/MCS systems only)
  +# semanage port \-a \-t http_port_t \-p tcp \-r s0:c0.c255 443

   .SH "SEE ALSO"
   .BR selinux (8),
  --

Looking forward to your positive response.

Regards,
Pranav Lawate
Software Maintenance Engineer, RHCE
Red Hat India Pvt. Ltd.
plawate@redhat.com IRC: Pranav
@RedHat   Red Hat  Red Hat

