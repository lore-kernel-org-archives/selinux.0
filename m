Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358133845DD
	for <selinux@vger.kernel.org>; Tue,  5 May 2026 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985414; cv=none; b=O6DqTzI2iyus/uoqoCfi5vBkWjDMjXREASzoZwP5jm7bvEVlxypoGJ7HFNSjyrD1wmOuU5WHEed8vE2V8yA56Ngwg96jS3NodJ5qxgL6BgukfZrrW43gD+sKKqOPObMQMtcjapkJqOU0EzTvqMG1vhRrCGlnQ2RZSOM9EfQUPuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985414; c=relaxed/simple;
	bh=71gHqf0DOL7GfCamd+JTDr8jyXx4/Uh6fSkEnfQwITk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thpUBw463EabntjxHJOjpMKSWjC+EYVCIcwQ1wazteKOeq+mRKRl4ZKsAjAoTDxgfgSOdV0m9/MvYEdkeBVZVS+HrIwjmfgnb6cAp7L2O2w/mQhjDu0EPt9gpq8f6uBqNlUUi4w9cb46lBmbal5SjCWmKDXKzWiI7P3ET8zRE1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLKW92N7; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLKW92N7"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8b81586dff3so33549236d6.1
        for <selinux@vger.kernel.org>; Tue, 05 May 2026 05:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777985411; x=1778590211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MyHRZ8WQsP4uaxna0Hq/raMw1qtszqE7nQNmO2OEiXA=;
        b=bLKW92N7l8AZ+SXY3RNNX38QRtQOCyojSPqufRLo24Qm6Rf9D5QQLAY5g/usvSefla
         qVs30DiiCSxTbENHC96NK/clRfD9at/cNB0LGDGzIHcFo7kLr6E+R6GNssiyodtFh8bF
         gvyA6voqk22Xz3vReaGwnryfCX3yjVjJJh8M+tN5m6eKE3Y+AG5oTkZCMWs3hM+sLaxM
         TUU9S1Fso7DYXxeUga5c+0bULrQ3bF3nuXiMHaEJfmdrOYK+AgJYIGp6x9yf8fc76j/I
         4OVvaGkH94B/WaynwBTj2XAVkbLTadV1f2qaC4sCbPZ6oktemZJ0UAqq0c3hvTAGDhdx
         kroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777985411; x=1778590211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyHRZ8WQsP4uaxna0Hq/raMw1qtszqE7nQNmO2OEiXA=;
        b=FXUPxRIfsWyE3Z66LUTSeDvUFaPVFDwkV+fG752TRVNXQGvulsqZAco34dxoSlUjv2
         5QU5NiksZx65Lk3w1wW358CEAim4CaFxDIZOYUAf3k7Ox2GyA66RCVEZ5Yle0pYGEc0A
         W/x5SMzAVN8SAsrYvMRaR6pO/tqNlpy3jJrmMo6pq65/Y6yWkoYGlxk9bJ7eS6Kg1yXV
         8zyFDRL3VjGCB7K42etHQc9nUbwiXwOhIdsHQ9Mu/5qAXnt9UUddUyi222ShvXu25QiM
         WfV1itInXt7uPYqxM9QJKqam+P6P04axiirHQz6UUiYAKU3ayx0OdavkPgdsCIK1hb4P
         RCJw==
X-Gm-Message-State: AOJu0YyMWwxlBWp8TT5Gbga1fX4QkZPK8Fw02FU7qvXrjfhGi19EkhPc
	kasr+BfJqlzq3ELogjCnlVAFnluG2sIGsDThSQ9ygZH6m+FGQ1oQOiUWTMilEg==
X-Gm-Gg: AeBDieskpLlJWg/z2CKPfApQmUOp21gg8D0bri7jbQNsLCIaj0ULfMy1Vh++ACXUJJv
	Jv20BHQGFZrvohBVLH01rcptMfsma7wxrqaOcKIA8ByXORwOf6H7wdLH+9+S3KFR4HXoDbcIT8I
	7W6OUJx/OBYrrWss6guLc0m86hTmDx/WHYmTTa9jzJCoVucWdbborRFJOF9q8n+UZeBjyC/24ak
	emPWuB8ipHedM1O1HujXolzQtGeOCc7TJXgfZpO6TBmRtwg24iLSEme5Q0LbDxOD3c2UbCSsoiD
	GTPYTU7l4pmJg1xnkhNyQvrupb176F9lxA8cOoRt3FGcigelfkITpRXtptt2FreXZNClkBkrUpg
	f8CN/F0NI3uAQ+YXCFOqNUoohO9VyeRy2K1/sV6i94MHyGeDHOZ9RlcxlQEZZB5SszOymFUlFVI
	LfqT+XUpzT61MG5GQj6QKflne6DbxCgggE9T7ylznoWlYcUJ6nPieWy2WLijie9RA3NNGK80idn
	l1S88Yyr9BQxBiCnjf6EGAAa1UOa6OwJgwcTbdZMxVwiyybY9ZeEfKPh1qieFUaLA==
X-Received: by 2002:a05:6214:da4:b0:8ac:b264:65ed with SMTP id 6a1803df08f44-8bad9f47b79mr45081746d6.6.1777985410455;
        Tue, 05 May 2026 05:50:10 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d831651sm145437216d6.47.2026.05.05.05.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:50:09 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 0/3] selinux: prune deprecated interfaces
Date: Tue,  5 May 2026 08:49:47 -0400
Message-ID: <20260505124949.2541-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series prunes deprecated selinuxfs interfaces, reducing them
to a pr_err_once() and to providing a trivial non-error return
to avoid breaking userspace.

Stephen Smalley (3):
  selinux: prune /sys/fs/selinux/checkreqprot
  selinux: prune /sys/fs/selinux/disable
  selinux: prune /sys/fs/selinux/user

 .../{obsolete => removed}/sysfs-selinux-user  |   0
 security/selinux/include/security.h           |   2 -
 security/selinux/selinuxfs.c                  | 151 +++---------------
 security/selinux/ss/services.c                | 125 ---------------
 4 files changed, 19 insertions(+), 259 deletions(-)
 rename Documentation/ABI/{obsolete => removed}/sysfs-selinux-user (100%)

-- 
2.54.0

