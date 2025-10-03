Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B442712E1E9
	for <selinux@vger.kernel.org>; Fri,  3 Oct 2025 19:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759518301; cv=none; b=dMUW7ymkNVMcTb63HS19gPe8gNss/Nu/9zUK9XVXbjy0+1yOlD37as7Q8PlYd2MRzoB/HAOnIwqbBmYtBUGNrBp5TH/sVKtJVjamrgsgEOkyDPA+KkgkOXqh4u2dPRjEDX9Z2qogEkjYKYHtYaSe5/gmAXLelH8+4hzKNCsV4+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759518301; c=relaxed/simple;
	bh=Mndpk3/LhTYHetEVI+OFLxD4/5O4zuFOILyZCtj1rAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C8CiQbsMrCkK7SS/1TozCnALiinNPQue3GB/WBXAfgA1tCqQA/Xy2Rc3KdgY36cNwllfX2feh1/wucofDJ4CmpVf6sXKsiWnMDhghza/TC22CljY5xsuoF5w8KvIkb60460uzBQxZv3sUjw1PMvUVaB8JoXWAXZlcsA1BaHSZpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y88sF+rV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y88sF+rV"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee12807d97so2114103f8f.0
        for <selinux@vger.kernel.org>; Fri, 03 Oct 2025 12:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759518294; x=1760123094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lXPKrMjzomUtVsNlZbBqRRFmZ+s/rVGqZ+wPhVvxzDY=;
        b=Y88sF+rVsbo3DWijhm5rdv4KXX+JcDMMkac3OZr6cQqFE0T+CA6kDaNjCAYJYARp0Q
         eOMIPp8PQ9VAGXVeItTCOzrxDY8QtnPCCYoxlSHxsS1xFeKBzYSgJ/cPSr6BN+bDNq9Z
         842at4h/rBKUT0rxC2HZ+oUBcj+e2TX4grl32o7puTXAoTAF+IeUBjjFC3q3g+HGDK5J
         rkpAIh/13+34se7AHStQklqiIg4d83hZRvHa3CAn+W7a7vbZHCLWUYMaAuepEsymKBPz
         pEzJ54n98ZV47K/Ga+w4CUTDaVgHgXrCwIhzewjWS8G2K1e9Kz52Lxqk1wSw9AP/v89P
         oZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759518294; x=1760123094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXPKrMjzomUtVsNlZbBqRRFmZ+s/rVGqZ+wPhVvxzDY=;
        b=ONT78ipB76U4mjwpok3ponOYbUOMjufW4uOVl8YsKdNWuwxQwUa/bqbMvPYI3r+lkQ
         GN+5+auA0jt+9EklnweuIn8W7NJjefyPf7U/lwMwmp2V8I4YSLVnV3CPXXwI7+xLc1XW
         2f2RkRYUoj2OAQRCez083ypc0sGlo3CFLTB+CMvWM7UDqr5Gz2n+mWAEVnrEjkZ/WaRU
         lQjh/am3ZvoG6lEIr6j2W20hvU+x7vEoDgM40tqKs2cPQuK/8ITI5EZO+0MSb2usWqiT
         HxtF0+VGY57kmu7+abvcf+KFMScupOx5Yjp88SKx58gpUMqkXa8Qa29SSnvxANdegIrH
         Lp8Q==
X-Gm-Message-State: AOJu0Yx6J4PXIImklGFEKbrqOVGnb7GFU5uCh5+ipy9xORnz5//0zUN3
	iYjkbckQ6aLvnvYUb7Sm6wu/ouZQG1M/F1/nt/bCj290QMSi9N1GkWJyrhndsg==
X-Gm-Gg: ASbGncvbHImK0TjS2y0VcYY0UndZedi3RfePMCj5DqAoPiD6JjQ0oA+c4zSHCdxMnni
	z9sopVk6hGVkFw8WnpV16krgVTAqycK777IOGHJrs2TEKdY0j46fteP+4guxMU3ITlvajhIhp95
	9Ex309Ng7LuTQNB8wM/E4cttman+Wyb16RblUisbUMlfwgvyy0wdETfIVwOuys1wbjUsHyWAC2C
	C2ZDwtk6Zl7/Zu4OFL7lscLXwLKtJsTX4mlegjz1LTHKbQ/0pwcEP9xaIWEJ3We2zKYK+Ah78qi
	Gu6CBetL5enOSChU8L6pl/H75mih13oARU0z02kss8OYkRi3B86Xk2BtuIcA6aMonwOQbOlObuA
	MpMYRNK8zHwh5U/0ypvEgUc4u2cZqpOk=
X-Google-Smtp-Source: AGHT+IGnOfG9v/IudaLdI8rJIMcIEUU0K1EVQDoJr+Jmpnld5SgHxXLcTpRMMnFYc14kbwoqPG5jUA==
X-Received: by 2002:a05:6000:1889:b0:3e9:d54:19a0 with SMTP id ffacd0b85a97d-425671c1674mr2604419f8f.57.1759518293605;
        Fri, 03 Oct 2025 12:04:53 -0700 (PDT)
Received: from sierra ([81.79.59.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f0853sm9302176f8f.50.2025.10.03.12.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 12:04:53 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>
Subject: [PATCH] docs: fix context_*_range (3) return value documentation
Date: Fri,  3 Oct 2025 20:04:34 +0100
Message-ID: <20251003190434.432154-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The context_*_range () family of functions return less than zero on
failure[1][2].

[1] https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/context.c#L184
[2] https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/context.c#L190

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 libselinux/man/man3/context_new.3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/man/man3/context_new.3 b/libselinux/man/man3/context_new.3
index 3dabac3d..04522366 100644
--- a/libselinux/man/man3/context_new.3
+++ b/libselinux/man/man3/context_new.3
@@ -71,7 +71,7 @@ set a context component.
 .SH "RETURN VALUE"
 On failure
 .BR context_*_set ()
-functions return non-zero and 0 on success.
+functions return non-zero on failure and 0 on success.
 
 The other functions return NULL on failure and non-NULL on success.
 
-- 
2.50.1

