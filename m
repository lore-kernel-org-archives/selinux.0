Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792781928;
	b=KuBOATdKBe6R1eo9GFUg/HSvGEIf2oVHIBqikRxh/3U8xjCkgab5UxtJXJ+UUUaGiReX
	 PwExVVspKf0ZI1F8vtMwH41tdVjo+tEtj2JQXb1AIKIVpgB0Kmw///eYepfk2h2WXDIzO
	 n9PzeycaszGY6LhFFgibC4r94wPYnxIhPrFKQpPJmLTUcZvSISFOTth+xQ+aBVp077qGu
	 Tg0eD131SL148CKJoP3rODsDe3i9qlJfzz2TegMKzkAg0QK3Ep4rTWodDYm6xDLclv6NV
	 o+EngbdRpdcKBIkpDin2h1FsuKShKGmQFZLdUN/oo3HfpQhOab+Lub688npV3SzBH8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792781928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/bodC4UszzUP1CbKtAzkt6I/fPbuB6lRA8PNuh6qsp8=;
	b=FHfz0xF/RdF/wI+kNkUTlWBW/W+fj73J24r5cFa7b2mBEntjPW7gqHKJyfut6rrMOmtm
	 G9B1v+Vz4/5UNC1y4Gm3UrZaOr5uX6iW/EgQgBOG/hsmsYN/4Z6W3oAbkRX1vhMP6Aoau
	 xVAy8bwPz1f9n7zufReKmqv1wB1LiKqVAsFuwW6yoUEsCkvkYSaPmacdS91WqBFDoh0Aq
	 5O+TPepLQslJG/OrRBlc4nlPxfs2AjJ92TfBRcgkn6zH4c9nzJduBEkP/MvDutpOTnvEd
	 pF7unYBjZ59bSLU9+be29Cc4zR/lLn1UwvuKq3ydQStGA7jCnaflK2ta5vKUPy606Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hvsEnXWw;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53807606A32A
	for <selinux@vger.kernel.org>; Fri, 23 Oct 2026 18:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53807606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hvsEnXWw
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93ead211f14so120752585a.1
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2026 11:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792781927; x=1793386727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/bodC4UszzUP1CbKtAzkt6I/fPbuB6lRA8PNuh6qsp8=;
        b=hvsEnXWwy96bsQMS3isMqz1T6AANRipdplqeC8ox8tEoaY2DYrQ9xFrKF19GDKIuft
         ovfMAvtTeEzNSedeYmt5NW1knxrNs+1geGF1us5ElPsPA4+BHSS/dbdlZvd7w5DuPm9G
         RRuEwyKTdQMlynThpOa3zYNnD0jz1JVT/C2d+7VSyfPkACGXjMNvV+Cej2hymaIzHhPc
         RKgAHUuLChXvfsFGoq4TgsGjTJgl928+awSldVvrQ3gK6K8bLjgoZTDhCJK/vsJLKSGN
         GYa2FKGi00unO97mJ5ehK5ZquLhJwnBHONHM07nAafsPKyQfImj4OWt4bv81stQvPRm6
         JsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792781927; x=1793386727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/bodC4UszzUP1CbKtAzkt6I/fPbuB6lRA8PNuh6qsp8=;
        b=H5PC39VE0PVYSyEJrpYMM7xqzlgptQPMIU8fQKnyH0GkmlBFooA0DcIbZANCjXGoio
         mWYaVbGElzxyTsJHFJZcVSldAHpx19dPRw1ELC4USIkWsQ+lG+bF9FaX4ellGiEf+4aR
         35J5mu13Fdynd39xqGCDvbVCiqWO4ZTwM8zMAUMOFl3ZvDFhnGl5b0Nrd+twxoHe1D1+
         wGNmwYecIMuH7S8eMsvmRbpfqk+RFsWMqNAalOqv+fxvliLTm0C7xpGWoXiL5asSB9a+
         FLvN6RK+N2dNXzj/Uy7VlyftV2wU7jYYqtDSP42CKtRoe9YFloo5SWFw5ujPbEj14Kvs
         bq2Q==
X-Gm-Message-State: AFq9FYJIGVGvSzJHThhuSOMjxbjUBEUWcELy8UXJBFXSip279c7/ubKI
	Y7t7S/oLav/7vC/33eeUtBFWdU4Gebp0zYR1N3c+2rG0SfxGrJqATJf7HuFj6y0K
X-Gm-Gg: AYBFou0u+n92sHE+ltq3pQXaXawXLR/A09FpzlYn/bjcvG7y7pLnL3LJpE9bDgekNPq
	yVQ6fGuLqMsAJZg4dzcAEHjW2L4A1yRRmGlq3VLZf/S3SezEFNzG10hfkkRKxdl/7hI0Fvw2B9T
	L+ttfBPq9u5jmRH8Nt7d98zruz6tvIJ1/e4qner9uLi/y2M/dV/5B0k8UckRww7gN/Bd/rnAsug
	Xq2yRYWQlgJiHIWAGvPpVsZWpz+lS/5Fvtdprto2KYtG/ky5WtdkqOo58xCxrFVyGVaLFSmpoCV
	DSJGOf7h2wt64azxeTipmzGtlZwaA0PNwTAQNjr/mAUG+X5WHy4J2AAZBshjiPC/g8847CVASrj
	9b7b3SUC7TpVG7Lf7ptgzfJpcjEMCaTGYqYR8Pm+/JSIM6kc9xiHbqW6VvD/WFVRMLHndxyK8Eb
	zgNEoeUYk3Ezq2zyaTWstf/5/7ZQ7SGUyAYlMrNefenLM/sypgfk1KwVpGms1Ob+weEU5b7KRwk
	3JA6eCNWRmMtgM0Me3XJgAUNEb9yFuPvY6oqdJ14fAEFk7LBFrxJQ+qSb5yCsYV6RcDLJw9I/zk
	e1F13HS6r2hws2HO2YOkPihk4w0iOBLGmnMfRxZMVvfg1+yBsAIILCvNT2nE8QWE1Kl35lR4kMM
	SaGi6skLZ1QcSFEddLxLs3I8+WPTs6dTS4zUk72Nfuws7LLMkU3cjkmOExBwk61E=
X-Received: by 2002:a05:620a:a090:b0:93e:5ff9:a8f4 with SMTP id af79cd13be357-940ef67c34emr1249085a.0.1792781927126;
        Fri, 23 Oct 2026 11:58:47 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940479fbea6sm89867885a.20.2026.10.23.11.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:58:46 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cathy.hu@suse.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage: report commit flag-file errors after user updates
Date: Fri, 23 Oct 2026 14:58:32 -0400
Message-ID: <20261023185832.62289-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A successful flush of a modified user join sets retval to zero early
in direct_commit(). The subsequent dontaudit and tunables flag-file
create, close, and remove error paths jump to cleanup without
resetting retval. Commit can therefore report success and discard the
temporary transaction even though the requested changes were never
installed.

Set retval to -1 on each flag-file failure exit. This also lets the
existing cleanup path set commit_err and preserve failed transaction
state consistently with other commit errors.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/direct_api.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index db74fe93..61650f9a 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1393,16 +1393,19 @@ static int semanage_direct_commit(semanage_handle_t *sh)
 			if (fclose(touch) != 0 && errno != EINTR) {
 				ERR(sh,
 				    "Error attempting to create disable_dontaudit flag.");
+				retval = -1;
 				goto cleanup;
 			}
 		} else {
 			ERR(sh,
 			    "Error attempting to create disable_dontaudit flag.");
+			retval = -1;
 			goto cleanup;
 		}
 	} else {
 		if (remove(path) == -1 && errno != ENOENT) {
 			ERR(sh, "Error removing the disable_dontaudit flag.");
+			retval = -1;
 			goto cleanup;
 		}
 	}
@@ -1427,16 +1430,19 @@ static int semanage_direct_commit(semanage_handle_t *sh)
 			if (fclose(touch) != 0 && errno != EINTR) {
 				ERR(sh,
 				    "Error attempting to create preserve_tunable flag.");
+				retval = -1;
 				goto cleanup;
 			}
 		} else {
 			ERR(sh,
 			    "Error attempting to create preserve_tunable flag.");
+			retval = -1;
 			goto cleanup;
 		}
 	} else {
 		if (remove(path) == -1 && errno != ENOENT) {
 			ERR(sh, "Error removing the preserve_tunables flag.");
+			retval = -1;
 			goto cleanup;
 		}
 	}
-- 
2.56.0

