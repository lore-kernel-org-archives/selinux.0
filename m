Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C22214205
	for <selinux@vger.kernel.org>; Wed, 22 Jan 2025 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737561515; cv=none; b=Yte2Q8UCDVX48totNTEwzbqL7SkvTFS30iq99cIsSerSbZWn5DPnbhTkV+imU6TT/4LgBkMc8rux5UAay06yJBfKySz5MtHEdRjKODi9xa0cxw1Zi1+2koSsZGD5/3pEFGFhnfZ7ZQ7FoQ5FxK8fMnw7GkOKDwPIXWqaTrQPwEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737561515; c=relaxed/simple;
	bh=J3X+AB5XYOqZAO0uKbFEkeNbEQjKxX6cC3T8BAD4wP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mcLjvBUSF6GWradYLw9VvJZ9ec2an9beYJQy9euMLTEj3th37XBfJd+24h+SjVo5JOwTiqz2aTTaN6LKyVoxO8XC14zQUcDDKrPk9DzDkq6+9Clwp4avo1ViFi/4XCz4wKXD0p7scjFfxAoQjO5p0dOlYOtGCfSVtjokus9msz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbUrYBNv; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbUrYBNv"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467918c360aso75750791cf.0
        for <selinux@vger.kernel.org>; Wed, 22 Jan 2025 07:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737561513; x=1738166313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cdTBZmdoUJ+tyHjznKzd8jpDjouMYxMvU8h9g+KxTkU=;
        b=FbUrYBNvszhVd5ABQ5hTRI3fN9muNgC6FOJacCNK72hX0T708j8wYRilHR+2cP1TWF
         LtloNEaZfijlVHLEpFdz1rxiPH+7FsypKxJVoFqGPci2Giz+T1bpgPIgaPSFANes4m8v
         U3M36fjYIB3pHg3da2WtkzgjeXbDW174XibxYbXdxvNjcuOgi3aHGeitEF7leQXtk1DK
         EdSGpjmxT7IjvCwlKlpgqCA/xewTqKE9zFhoNQI4fpWif016Z319efTvKflNjRqB9wIJ
         ymexryaSnZhroz3xRYAGTPLCPjJguiWqVetksarUAq1515Bc0O6g4GNnJjWCLtmXrbSS
         DKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737561513; x=1738166313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdTBZmdoUJ+tyHjznKzd8jpDjouMYxMvU8h9g+KxTkU=;
        b=bhF/DCbmncDSrGzXnyNqmy33zBue7kTKTil9ROgl/fPBjOUIBqDAnLU35M8WFjFfmx
         wprvrCoZB/RFIVO5Y1LDIGFLAis5GtmiiHncabf9zKppBxd+P3bXP8/AQohzz2S8u7tC
         jPTPZC87CQvuYdhWVLo/9FPu+kDpX+VFmPtV1J7cm5oCYXBgqhKGhRipZl6aCW5LLq/n
         rnY5H7dN01s5xIQxjImm3cEu/d7zjYznIYjkfayyzC81c9yBtvBIt+ag6ly7YzMyBbE4
         o4qmXCCRAhSsCvDpp6V+2JKXhVTmL6Vrwb1wByx/rzSGBCn8Ikb++Lcnnq4bwi8PVGPO
         CO5g==
X-Gm-Message-State: AOJu0YzXPOyPP8ZDkN5GinJAiklxH3sQ1bXVNhHn0Kp6UG9nUUtshJie
	qfewLUaddRWypMS1LbNiNrRe95t4CrSDIzk2Zc/LiTuRkNljZ1auh/iOiA==
X-Gm-Gg: ASbGncurCi5u6FYfb+vQ8HEz1Z9iMY5PKW9t9aAyLZjisaAeQgy1lhAUHOiWSVCDswo
	f79eVoFxXdyHSZz8dk1Xn+zmYo1edNvKQr9hHRjfQXrsa5JhJrcVTk1z7DP9N9Jqb4ttmPa/9u4
	K6qgyf/rPQq8ajvLl3Y4wPq7NgVoU7kXaVJaqdIsAcLfFsEbZRCJpi5TjX1E3rGXSmeIMkWUtkZ
	Q87/7IqD3trDl+zcuH6Z3mGL7wIetCz0MGBDNrz6AMddjT78w3yfhyWcwk4+Cl3dy64RR2JR/HA
	6uFRXN/LNGWs1Ix3K8xpHQGIIpc=
X-Google-Smtp-Source: AGHT+IGOYiz5uNu23Ofzn+u+60GdxJdXzZN2JDf2tTmIJwRQLPGKw98QPxCgnJzPiQiA22RVvaTdbg==
X-Received: by 2002:a05:622a:354:b0:467:6e45:2177 with SMTP id d75a77b69052e-46e12a3f3efmr323584201cf.12.1737561513053;
        Wed, 22 Jan 2025 07:58:33 -0800 (PST)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e258c82a6sm45631041cf.59.2025.01.22.07.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 07:58:32 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: lautrbach@redhat.com,
	James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 0/2] Possible solution to possible regression
Date: Wed, 22 Jan 2025 10:58:26 -0500
Message-ID: <20250122155828.151233-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported by Petr Lautrbach (lautrbach@redhat.com), commit d96f27bf7cb9
("libsemanage: Preserve file context and ownership in policy store") can cause
restorecon to use old data.

Here is a possible fix. It seems to work.

James Carter (2):
  libselinux: Close old selabel handle when setting a new one
  libsemanage: Set new restorecon handle before doing restorecon

 libselinux/src/selinux_restorecon.c | 4 ++++
 libsemanage/src/semanage_store.c    | 5 +++++
 2 files changed, 9 insertions(+)

-- 
2.48.1

