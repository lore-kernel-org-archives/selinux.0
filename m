Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C474334D91F
	for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081037; cv=none; b=sPPS0qYm/JU7HgJaDmiy/h1inKgraTqlFDpVmuAjwuYv4OrPtvYBdpLtcUAZxKEgxFOUQNTlYrJNBPCBcmkGESJcAxGRX6+3Fsh88RqgkwwpLY01w4oAeANRh+rato7+sz6zWrxj8aF7XNfNv0ReASUs3kkMyqOfdtaArb++zic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081037; c=relaxed/simple;
	bh=9HMY0+IHxCfsCFBkJyy1XXn2SWo//VXx7kSK4s6oWic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jbHnh02vv1DPaYzsZFztIPeK6zC90wjVxfl2vD78yG9svaZzYbJOGGdALUYn+HjentFO5AnQIqMlySM9onPRNryNXCJC48wAkCfk5kYsQOCDXQEOD0qcEDeRKr0x9Gyr9D23zZK5pwWtIw9CyNUogR2038hGcmiC1aVf0BVUfNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npQIIaDY; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npQIIaDY"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c1372f84dso1371601cf.2
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 12:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787081035; x=1787685835; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aAcLZmGaR7r/xIkeqkTnzoyNkJUobR+lxn+xvbNUeEU=;
        b=npQIIaDYxyj2+5qdAkBVcHNCB16TuD0ydBseghLoS/jBLhR+1Libu72O1mAL/JWaq/
         vfhAeM+NPfKBbiYIj9in/OfSwpeYMppVfc4XRX+CpDvER6rC0J+NHcMjmtsuv9H9xBQ9
         +GLNuqsNML+P+Xt3r0mNt1B5efS7OXQ16OevAvvKjc6v/8IAVM+iEa0bLxA+GKkAk+ZZ
         uqvfY9brC8IsJH03LNsRvfOdJO5iZGGlxpXp1acH2l6YbnuJJ2JzADryWI1gtGYSUoAP
         duqwjswE9ji53vlnvDRCH8zSEzyDiXXE/T5nBpA6IdFnfWnlih4MYaGuH9FObCSeLHti
         5tcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787081035; x=1787685835;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aAcLZmGaR7r/xIkeqkTnzoyNkJUobR+lxn+xvbNUeEU=;
        b=gZHQeu7tdoZBKoqJ8HPqH/CRntv6h20iSPTj3ZYQ6JyFQmOWxtsD6qyAMq+Ti2HMJK
         gHnvAfqbDU6r2+5VPYwu+JXdeiAwx7IyuEqx1aAu+nOXry7XalEpBtZL8WlQfEnIPbXt
         zq5IE2loN1557c6SLX4ZT5cBwml6w5BflIIey5fnYtWLy2XxkLNTy0PNYrvSwPT52j97
         I7DLJWKJvdykEZXjyPTu6K6d3LmHl70/K/aT3NulCw4xa54T6FR9IutN39Cx0hcZ9PcE
         LKGVa8EJ/m8IIkzWxzS/dfEVxd5iDR7xowcoSJLkyJnz5qEjTq/IKDmM0EvAh3KaKGFc
         Op5g==
X-Gm-Message-State: AOJu0Yx7JGHsTfWNpIf91ENgibMxcabWEyWnDKS3FXuM82o1mP9LaheX
	LMUeYgIugTtDUQQ6AhyJezIX5xqcZ3eFOa/napupRccpxHC2iOd64PCke70sFA==
X-Gm-Gg: AR+sD118CYtdqjB76+fqpIj3Mpi7efHMcZiJMKJlTIPy253nUujt+LbzaR0EvxIdVK0
	IUOdlVSAfF7Z4B7xh69eZ0jQS9Ln4s5a+Z2hcjqEDVH0ve8IIVPyT7zIhuSdGLu1u2NUlsjwGn5
	EWgkfC2RbXz01DYcyNal1kBD6qXPe1CJdl5je2Rc33fu5MsdyV/vTPPrBrmgBJorrGTcvYdSGzL
	CPgVAbYccp6trXAmWxUGP5MBawXcgIAqzDDtSUn5PN5A/Osm9ZLcOY001hm99AWynFYXmTtuo5G
	7MSX8+6Dgmg8Zq6pIbVIzMJfJuOpfT5P01FiERJZ4VToXeNihopRHDRWsl6kH/DQ6zWNw9lnDnQ
	MRXIGI6nLJk4BevlWulQqfHn1+iSJlykHHooDtjHhvm+tcLx4IuqADom5d7cm7x7pComrD0MkZB
	WEGvr0wy0CHOp5lWeYpMHAEO6oUxZC7gMxm+7Au+T2t3yC1+rdj1Y5YnD1pRUS8rHuFj0vnA==
X-Received: by 2002:a05:622a:261b:b0:52d:9c11:8938 with SMTP id d75a77b69052e-52dd32a8cd6mr3940961cf.29.1787081034361;
        Tue, 18 Aug 2026 12:23:54 -0700 (PDT)
Received: from z840.flat.mawenzy.com ([2603:6000:acf0:3410::10d7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52db62175b1sm48784351cf.19.2026.08.18.12.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:23:53 -0700 (PDT)
From: jboero <boeroboy@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	cgzones@googlemail.com,
	Johnny Boero <boeroboy@gmail.com>
Subject: [PATCH v1 0/3] setfiles: control relabeling parallelism from the environment
Date: Tue, 18 Aug 2026 14:23:30 -0500
Message-ID: <20260818192340.119297-1-boeroboy@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Johnny Boero <boeroboy@gmail.com>

Hi,

This is the patch for the RFE at
https://github.com/SELinuxProject/selinux/issues/489, where a package
upgrade on an 88 core machine spent hours in restorecon with 87 cores
idle.  Stephen Smalley and Christian Göttsche both indicated on the
issue that switching the default thread count to 0 would be acceptable;
patch 2 does that, and patch 3 adds the environment variable the RFE
originally asked for.

Patches 2 and 3 are independent and either can be taken without the
other.

Patch 1 is a small fix noticed while touching the same code: "-T -1" is
currently accepted by strtoull(3) and wraps around to SIZE_MAX threads
instead of producing a usage error.

Patch 2 changes the setfiles(8)/restorecon(8) default from 1 thread to 0,
i.e. one thread per available CPU core.  Only the tools change; the
selinux_restorecon_parallel(3) default is untouched, so library callers
are unaffected.

Patch 3 adds RESTORECON_THREADS, with the same meaning as -T, which takes
precedence.  The motivation is reach: relabeling is driven from package
scriptlets and init scripts that a user cannot edit.  On the Fedora 44
system used for testing, 10 installed packages run restorecon from their
scriptlets and none of them pass -T, so the environment is the only way
to influence them without patching every spec file in the distribution.
An invalid value warns and is ignored rather than being fatal, since the
variable is inherited by every child process.

Measured with a dry run relabel of /usr/share (~588k files) on an 88 core
system:

  -T 1 / RESTORECON_THREADS=1   ~24s, 99% CPU
  default after this series     ~16s, ~1000% CPU

The speedup here is bounded by the directory walk and the syscall mix of
a dry run; a real relabel that writes contexts benefits more.

Two things I would like feedback on:

- Whether RESTORECON_THREADS is the right name, given the same binary is
  also setfiles(8).
- Whether an invalid value should warn and continue, as it does here, or
  be fatal.

Note that this series does not reach libsemanage, which calls
selinux_restorecon(3) single threaded on the policy store, or rpm's
selinux plugin, which labels each file inline with lsetfilecon(3) and
never goes through restorecon at all.  Both looked out of scope here.

Johnny Boero (3):
  policycoreutils/setfiles: reject invalid -T arguments
  policycoreutils/setfiles: use all CPU cores by default
  policycoreutils/setfiles: honor RESTORECON_THREADS

 policycoreutils/setfiles/restorecon.8 | 19 +++++++++--
 policycoreutils/setfiles/setfiles.8   | 20 +++++++++--
 policycoreutils/setfiles/setfiles.c   | 48 ++++++++++++++++++++++++---
 3 files changed, 79 insertions(+), 8 deletions(-)

-- 
2.55.0

