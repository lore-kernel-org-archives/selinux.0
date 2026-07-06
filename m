Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AD52DECA1
	for <selinux@vger.kernel.org>; Mon,  6 Jul 2026 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348339; cv=none; b=m9Y1lwkDZWWBGr8vBjAMXthhOgfyScI6izrL9L++bSmI83Ddn66KATdEsmvhyaX9RYobZ0TiiZcm+keQ4VRaYjwyAScCxH1O0orO77eBujLNVxY7bKJNiwO2nuq1DxxHGhuq341O3dpCunvU1OhD0ETI5YzOT9zp3qMZUCuM7SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348339; c=relaxed/simple;
	bh=Jv94jM1UU9/8fWWSrptqRmUp1ufak0RvhwmrIMlfYE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qrYWAb+QfUL3IbDP3qQH0aWlYmrvnTBvf+0qqTHjk3Ttg4GNhz43jXub1txPvyhC2vGyFpIjDjolnq+Y9xs1wemRNA+j+uH/ZozRqAfYsoh5dWwz0OAMNSdDMYoGHfYjGIOeXOB7c+rXirMZuHqa1GXLhhooZgTjIHBVoolhDWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAITokTN; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAITokTN"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c22c61795so19119411cf.0
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2026 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783348337; x=1783953137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tQdI8rSWYtt+Re63xpJN8gOurZLYFvKN/YcEq0krbL0=;
        b=MAITokTNbTRYHPeKCCVz8NdU4Z+k8IFH5uSw0TwLEOaJpxmhEYPFe5VfjvlLP0rmPx
         MgqwJSKvSXxoABbxUYYgkTTRzVU6pLli4+bpR4uT54ifyjkDqn1WfxqBzg+TcnA0QFJ0
         zPiQPtIkaqsI5RBt5iSSQCAhEnwoizKWYf3s188jDzJUp2oK3XKxw1T6MwpOmDKjm9qg
         VLrUe1IKyBkQU0IRGZWDANau/LjtpG5k3py2xwzEOZR/f9uz/6LHvXztlzpKR5zVPpH2
         J1+mJFh4inSQZ3RGeZluNK0crvDyvAKDgdTcF98th8KXOwz/0PEaRWHYEBlMN+ldAebq
         /JGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348337; x=1783953137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQdI8rSWYtt+Re63xpJN8gOurZLYFvKN/YcEq0krbL0=;
        b=Ys4Xm6uw9W5tZE+ssNuRsVg0sqL6qcDH5+vOGv06fUmCvDSs6lLo8j+WPTeBkaFbMU
         heoxKA5i4+E6i9TLJ4jLb3hyKq/TO3tI2YvMVOISJZfvvoYSz6FWVcTD7VDPyOBNLLDq
         aXxOCIA+0swSC65tqhyiPiRMKZ1VR1X/QAU6b74ErZx792zme4A0b3W0nzZAcw36+SwN
         oWFQUtZ3Nek6whMkFlcDWmsGELcNC1EZ9q0hpMsPkDvTEJbcS9uEyD09hSYi7POeKeOV
         7HYdqkOjvNHOl8vSQiHXBLelaFGGWAmSY3uUDOIvJ2wfQL+huEuWB5K7sSpm/mPZ3fNI
         4cAg==
X-Gm-Message-State: AOJu0YxlpPqz1wPxV6mEx3kQqm/29jon3FswOozZL/y3AhKBhrE5Vopn
	fKo/eyhrx+jGyCrmqcTmNU9Fxe4Uncdrs9KJAGGjsJ9w/b+jL3ZYsluoHCihFw==
X-Gm-Gg: AfdE7cnuxGI83ZmuDfBACqh6lFlV2FOeDo6ZiGFhzqn0808Ws/tQGS5ZVwWpusKIpjD
	cA/mRPwAj6mIYU/wuYSUNhtseM9I5DrlbDF232KJiWT68u1ClqRzpIZdMsSLN7aOVjA7ZvmkcBF
	6sZ2tKhCbQqvfKUYPAhYRM7VGHPE5GCmUaUyBfBVcXStl6eZXhl8AYXANrfq7CTIbl3G+Ij1AC0
	+oxrW2jh7ZWs+oAlTht55JVwzhtWzKpr93kxTvnr01GX8SSd0vDs9CqlKzYxxH7KtaHfcVoEWd7
	Vqpuhc7vtaH72AexkCp4yTZj9VOqS48AQpH9tRwA1LnWHGdagZtmi75jZ7B8Dc0hXErmRzFA/UZ
	MRkpu/YkHSxr3n5clzDdxH1JlAY2yZume/g2B+klznpKOzNcMzvH2psBrAl+BJdMR3d/ptldb2d
	koSWRfvTTo8nSApuMW1k+cxAmicJMyUlO5AnS5ENLXYpvCPGhlLnyCtUAKXcBjtTE72fLB2jrrF
	YUndGdQrteq8PyG
X-Received: by 2002:ac8:7e8e:0:b0:51a:8c9b:649f with SMTP id d75a77b69052e-51c74880ccbmr8899471cf.67.1783348333374;
        Mon, 06 Jul 2026 07:32:13 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41ab77e7sm92790761cf.3.2026.07.06.07.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:32:13 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 0/5] Make selinux_check_access() thread-safe
Date: Mon,  6 Jul 2026 10:31:50 -0400
Message-ID: <20260706143155.36629-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series tries to address the same thread-safety issues for
selinux_check_access(3) previously raised in 2021 by the
following mailing list links and GitHub issues/pull requests:

[1] https://github.com/SELinuxProject/selinux/issues/287
[2] https://lore.kernel.org/selinux/CAJsHiNx1E7x1jaBkS0i4L1nBWXp8YXLHRWcCaDaH4LOn=zm+Zw@mail.gmail.com/
[3] https://github.com/SELinuxProject/selinux/issues/335
[4] https://github.com/SELinuxProject/selinux/pull/336
[5] https://lore.kernel.org/selinux/20220120073329.15234-1-purushottamchoudhary29@gmail.com/

v3 adds two further patches to the series to address a residual
race condition for permission names across a policy reload and
to update the man pages to reflect the new thread safety guarantees.

Stephen Smalley (5):
  libselinux: avc: use pthread mutexes by default when no lock callbacks
    set
  libselinux: stringrep: serialize access to the discover_class_cache
  libselinux: sestatus: serialize selinux status updates
  libselinux: stringrep: snapshot perm names in security_av_string()
  libselinux: update man pages for new thread safety guarantees

 libselinux/man/man3/avc_add_callback.3        |  12 +-
 libselinux/man/man3/avc_init.3                |  15 +-
 libselinux/man/man3/avc_netlink_loop.3        |  14 ++
 libselinux/man/man3/avc_open.3                |  20 +++
 .../man/man3/security_class_to_string.3       |  10 ++
 libselinux/man/man3/security_compute_av.3     |  20 ++-
 libselinux/man/man3/selinux_set_callback.3    |  29 ++++
 libselinux/man/man3/selinux_status_open.3     |  22 ++-
 libselinux/src/avc_internal.h                 |  19 ++-
 libselinux/src/sestatus.c                     |  49 +++++--
 libselinux/src/stringrep.c                    | 136 ++++++++++++------
 11 files changed, 283 insertions(+), 63 deletions(-)

-- 
2.54.0

