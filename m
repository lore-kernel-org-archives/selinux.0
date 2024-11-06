Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9CB20127C
	for <selinux@vger.kernel.org>; Wed,  6 Nov 2024 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907903; cv=none; b=CHWSqQP0E3kqjmIZkGOV7a4WQcZAn9wl7OOlhEm1epyDtJHpHXD/9l4ogTmqxrdZrdlkbDovB4QklV5eJNpM4+v9dpxPEhrXDVfn5NYnXaDPLE4WRnmn7+tBl/UEmQZUu7cc1e6Md2Pxv0eO9QoHDne9pn8VcMmYZRVN/kQkJ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907903; c=relaxed/simple;
	bh=1uu4m2ywXgq958pPygnKQlP7VuiyYMoInx/IpCiB1dk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=k+qbe6+OmdtGRfGKJwdOXKKHCvu1EFypek04Gs+Rr1tCfU3/4IVqppvVxXpuBkPYPtgbxiwEEGP4FrUoUnFYl/+dHqQxf7Kz8uM66ymPd3C0+3qlLzJwl25D/v1NcLqsrDxaPOHfO7b3EMSGHaF+qoorrA4tjh6ZHewqsU3xTSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inY9eO6T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inY9eO6T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730907900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=faITsyx5ljc5s5oX8szJkJ+k3Mwyopwo+qORGVmm03w=;
	b=inY9eO6TeHmy5GwzD60fJup8Cr1HrwDpE3W+9/HpnJGaSgUXp7QSNQB7xqhnYwJE/VTgEW
	Ihr/DgaodS2BxBuu7ZxMjqfT5CZGb5YtSThcZOoJcLhIWMF5qy1DoamvjBB9y0YKrTaWv9
	uUk5cnG5jvpltKxifVZORgVHpfRxWCw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-22J2B3ADM56ssw54ALF7iA-1; Wed, 06 Nov 2024 10:44:58 -0500
X-MC-Unique: 22J2B3ADM56ssw54ALF7iA-1
X-Mimecast-MFC-AGG-ID: 22J2B3ADM56ssw54ALF7iA
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539fb5677c9so7160908e87.0
        for <selinux@vger.kernel.org>; Wed, 06 Nov 2024 07:44:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730907897; x=1731512697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=faITsyx5ljc5s5oX8szJkJ+k3Mwyopwo+qORGVmm03w=;
        b=kf5XB9BWQAcyIaohN4FX16/VdCtyUXE2vLoB78dEtfHkYG84VBlddSZmKTJTlKKNyV
         ESaJbvNLpq9F0M5Yk9ZmGX7T2kRJQaTp5EvhxkOF4NiQq7HoMqneLTe5G/aP/aPHXyx7
         dHLZMIpcHeq8aPqYpJIrBF7SVBINWBgnArY7EpBDdt0ws6VMMK/gL4odogf4Uttm7Ti6
         yT5cHcpgoktTlh7fNlnctujzOgHhCX0UOb7Ew4viAHHxAJfhh1kPDO/TlWiT5AmnK5ox
         EJy/zeKByv9iyMi5P2byOklB8M8kdgqwDNH+zgsyw9UszRvhCrWmlkZVJXGg8qgrb3Yd
         Y9QQ==
X-Gm-Message-State: AOJu0YwN83D/RyMqPNSM7HlBtuYZfQdlrUU6xLAcixlchL/tGHjzvlru
	NR6xB3czJCHp7rahqRa+IjY38iVDhflF5XqHsdDThqIYut5rOdUblp0NHGgkFU4TZUvMYUx3tNn
	zReGZHz4VV/sJLAXQtO0ww5PFTSbfGSxLP9tX5REKwm8EwgKvyB1C1xVh4iyVRajyCvQskKMMe3
	ctx3tHgAJ9IWw9Hf1WuheBgSH7c9LlUJmm0RSQI1w=
X-Received: by 2002:a05:6512:687:b0:536:581c:9d9f with SMTP id 2adb3069b0e04-53b348d6ademr20311703e87.24.1730907896740;
        Wed, 06 Nov 2024 07:44:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHICSmFFEEpphQW09yrPnNQTNqI5yMAYzzMNzlJ9V8jFleV6JvwjRdOCRGe+hmFtzYKQ7Z7OA==
X-Received: by 2002:a05:6512:687:b0:536:581c:9d9f with SMTP id 2adb3069b0e04-53b348d6ademr20311684e87.24.1730907896144;
        Wed, 06 Nov 2024 07:44:56 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb18148fasm292113566b.200.2024.11.06.07.44.54
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:44:55 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite] policy/test_sctp.te: add missing corenet_inout_generic_if() calls
Date: Wed,  6 Nov 2024 16:44:54 +0100
Message-ID: <20241106154454.1703327-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are only needed when peer labeling is enabled, which is normally
true only in some parts of the testsuite, but nothing prevents it from
being enabled the whole time (either by configuration or policy
capability), so better add the missing rules.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_sctp.te | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/policy/test_sctp.te b/policy/test_sctp.te
index 8db84a3..fb057b9 100644
--- a/policy/test_sctp.te
+++ b/policy/test_sctp.te
@@ -122,6 +122,7 @@ typeattribute test_sctp_connectx_t sctpsocketdomain;
 allow test_sctp_connectx_t self:sctp_socket create_stream_socket_perms;
 corenet_sctp_bind_all_nodes(test_sctp_connectx_t)
 corenet_inout_generic_node(test_sctp_connectx_t)
+corenet_inout_generic_if(test_sctp_connectx_t)
 
 #
 ############################# Deny Connectx #################################
@@ -132,6 +133,7 @@ typeattribute test_sctp_deny_connectx_t sctpsocketdomain;
 allow test_sctp_deny_connectx_t self:sctp_socket { create listen accept bind ioctl read getattr write getopt setopt };
 corenet_sctp_bind_all_nodes(test_sctp_deny_connectx_t)
 corenet_inout_generic_node(test_sctp_deny_connectx_t)
+corenet_inout_generic_if(test_sctp_deny_connectx_t)
 
 #
 ############################## Bindx #####################################
@@ -142,6 +144,7 @@ typeattribute test_sctp_bindx_t sctpsocketdomain;
 allow test_sctp_bindx_t self:sctp_socket create_stream_socket_perms;
 corenet_sctp_bind_all_nodes(test_sctp_bindx_t)
 corenet_inout_generic_node(test_sctp_bindx_t)
+corenet_inout_generic_if(test_sctp_bindx_t)
 
 #
 ############################## Deny Bindx ###################################
@@ -152,6 +155,7 @@ typeattribute test_sctp_deny_bindx_t sctpsocketdomain;
 allow test_sctp_deny_bindx_t self:sctp_socket { create ioctl read getattr write getopt setopt };
 corenet_sctp_bind_all_nodes(test_sctp_deny_bindx_t)
 corenet_inout_generic_node(test_sctp_deny_bindx_t)
+corenet_inout_generic_if(test_sctp_deny_bindx_t)
 
 #
 ############################# ASCONF Server ##############################
@@ -162,6 +166,7 @@ typeattribute sctp_asconf_params_server_t sctpsocketdomain;
 allow sctp_asconf_params_server_t self:sctp_socket { create listen bind ioctl read getattr write getopt setopt };
 corenet_sctp_bind_all_nodes(sctp_asconf_params_server_t)
 corenet_inout_generic_node(sctp_asconf_params_server_t)
+corenet_inout_generic_if(sctp_asconf_params_server_t)
 
 #
 ############################# ASCONF Client ##############################
-- 
2.47.0

