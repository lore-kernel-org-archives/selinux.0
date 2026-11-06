Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980815;
	b=jVN6Ej5JP4y1TPlh9vZE09JVYZfG9bOgOjhN7QbgS9o3kBVllMPjVxuKXitse26t4Dbf
	 KaC01rKJ6evru4lWXSxYSSuEwHpB/FUkot3U7o/WzqbzFRsbrpHjCSCF3I01K0plnVcIu
	 2xHKF5JU+xmKhmUF9teb6Zg0za+p8FDEYkGaeSBiuszfGP+pDAhKwYuhv3GCURmGpxaDY
	 Xb7myjwYv9XikqkdYRyyXDHnjQCPullFUnQlr3VVQ5pj9GvEpN39MArwbyQrlS5LwQp0C
	 dPhOMzZHk1SAGT6lOQ2Hwy7c55eta4gN9f2Ja3z+cvdeKy53H07K3Zl0dgI5/iYJDjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jR4ZmiYLIJLxFyZAopP3hHYvfvA4gAbcRJ0cvpceOt8=;
	b=uJM5aAhr97X3WzQc2LrQi0UiakcWcuVLrjcS5lL0maijOZzCGvoh46fPe5yS9CgPtaRF
	 oqvN3g8a7KR9OcHIdakrVp82G+0pEWzaB+3YO8RWEH3Z3yaXE6byYgomQ2mEnZaqz6Mvr
	 5vnI7HsVxCOo5lVMUF7joUdP6vZKyoYWZM0sJI0DH5w+GxPhI1HxvFjHJ25wgZxUcqOJM
	 LpuRU83AvK5ASOm7pl4w8fPcXAg1HOgitnB+SXo7Rk/qGjzf4S4yimb8U2/ezKKsgMEOm
	 0naIWiYZtBbyp0+Jd3pvalisvn1N6Sq2hRMWkDzPe+7hrVk3WwHXSmzli6/TkVn/sMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cb6Yzoqi;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAA3606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 16:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDAA3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cb6Yzoqi
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5366463571cso8737291cf.3
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 08:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793980814; x=1794585614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jR4ZmiYLIJLxFyZAopP3hHYvfvA4gAbcRJ0cvpceOt8=;
        b=cb6YzoqiO5nsts6zTDfaLk7NqtvdTvktkvQkgBk1ksK/3+ZOFeFSXae9wnUYuBYM/6
         uHtK5PpztVxQxoTeoxTGZUJJ9ZyqL7solHHjVqgsQVHR5VAh5GiyUstuaHFzPLxEerjp
         y+JGn3SIJolYKQnogbvUfext1LzjhcV+ow70qTIIKj2PP4ar/SgGW9BoJxlfU+1mJ5Kl
         xiyr9Bc5CYNpNiFrXHxIuoX1+ZhJfUxLI12eQNvN9Xkok5Mhha8QnBzT/xLLOJMf56Wn
         Vgv3u9AL4ggztRC0bJF0ZRyJZqN64L0vp/M/BJxJGgiBZHTHY4pC6hl3DG/paL12Gom+
         mUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793980814; x=1794585614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jR4ZmiYLIJLxFyZAopP3hHYvfvA4gAbcRJ0cvpceOt8=;
        b=ajkJ/xCWzSaIoXup1G9qr8zGllYJMtpSmGQ3uEjhMAADnVityHLfwTYT4rPPQIYkGO
         eqXRpyqoioUBSBLSWWf1P7BKd9rV3peT/Gat+InYoZfmmnMCIVqj26IZD1f+3ZraD8fF
         01cL7p/TxMMiinwmiwv1ilauRdRYWQIJplWYz7svtXy99e2x49S637d3q2EFD3T1kO6C
         w4/w96h5v63OoJaYH1KCrXZocECY7WCEylNlsmoIsvxkDanKT5WMdxSEYH2N/P9mA3no
         Zo7rQ6rv8FrLbG98yvyPrNYnZFeQKxxlSLuYCEVa03/GnFAj8kFXsP+QnOI7yRAKNUTO
         DhAw==
X-Gm-Message-State: APuU4Z9Pg5az0vuL4u+6fKo0P/hCENfQosq6LOtC2ayNB1vrDpRciRJY
	ZiMk5caPiJ+gD/0zWJr/jVvlQ1KV2oIFGjOt7Ra0IFa2T+wC5gBkIhSTtpRGegRQ
X-Gm-Gg: AYBFou10rXn+hhuUtsLjCygfXNzcAM9e0s0/f+v/OBWmM/fjyWgngmQHwdYvR5Q+p01
	dRxF0PYyAocxiocz1kTGOa+vcrokVmmIrjwX+xe7WTP8LuI7EypswVVSk8lELIagqEHDQnME7Zc
	cYxP83QBQTMx0Uu1mGVK4iuGwGvwc7ZVTM4oA/mD/vBu/UV504X0VQWduJWQ5X92iEGdFDKfvIU
	mDkaWkHThuu1Lzmk5u3dYjcvyfgsuc62Py9/isOF+ayCUOPVew6iuy2dLsuhcnQt8ux1en6O9ro
	CDsH+QdAthydAXsWhxG5S8R9RMpx0jE9dlHYa5BrsLIdEuz3zz9MsJbcj0Fe+wWwLUP9Gtfa1cn
	zAgA/xlqczu+PbTtD3FbxsjMr7iGctPqaREo1MrnLg7cPDASw1dXfVOl9+OLUSOH4gZcg+7CnFR
	PhxxSBzlxcnUbUZUi2SJi9tmYcp6FckxcySRfzr7kD+85E/3+zupf254oeHqrew7kqR0i23AJY/
	VRvCUW1tLgqontJFo1FlFSjZZ7d4Wpdy8O6SWBfi5UBcN4Eev9EHaQFFA0fsEFaEGiXfMOadHfF
	Mli/Tu2s6tMuI+EYLZI+GjWo3BBsGdVYHeYdqliyYhjJp44Gr8Y5eBtKS/VgjWN5NEOXK5OKMMc
	PzhFNnNca/+0oAjKkQqH9LcDx3HzdHe0Up/fMApaGircyIqID2Cr0rfdKgj0IyEneFxDWTe+Y1q
	111yuSiOtvU6Z4PUWpb6oClJR3/oNWGspjfRNVR0R5jgikE9hoYqDVHNKyPMXPPoCXmbnFuD6jj
	Q==
X-Received: by 2002:a05:622a:1b1e:b0:536:92a8:aa99 with SMTP id d75a77b69052e-54e1607aeb7mr43075931cf.71.1793980813709;
        Fri, 06 Nov 2026 08:00:13 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e231d0710sm23900371cf.2.2026.11.06.08.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:00:13 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Asif Nadaf <postasif@protonmail.com>
Subject: [PATCH 2/2] semanage: raise a clean error on unterminated quote in import data
Date: Fri,  6 Nov 2026 10:59:55 -0500
Message-ID: <20261106155955.199062-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106155955.199062-1-stephen.smalley.work@gmail.com>
References: <20261106155955.199062-1-stephen.smalley.work@gmail.com>
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

From: Asif Nadaf <postasif@protonmail.com>

mkargv(), the tokenizer used by `semanage import` to split each input
line into argv-style tokens, throws an uncaught IndexError when a line
has an unterminated quote (odd count of " or ' with no closing token
before end of line). importHelper() only catches ValueError/IOError/
KeyboardInterrupt, and the top-level do_parser() wrapper catches
BrokenPipeError/OSError/KeyboardInterrupt/ValueError/KeyError/
RuntimeError -- IndexError is in neither, so a `semanage import` run
against a file containing such a line dies with a raw Python traceback
instead of the usual one-line error message.

The existing design already aborts the whole import on any malformed
line with a clean error, so this only changes the failure mode for one
specific kind of malformed line from a clean message to a traceback.

After each "scan forward to find the closing quote" loop, check whether
the loop ran out of input and raise a clean ValueError instead of
falling through to the out-of-bounds index.

Signed-off-by: Asif Nadaf <postasif@protonmail.com>
---
 python/semanage/semanage | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index 09bfc806..57e5c346 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -809,6 +809,8 @@ def mkargv(line):
             while i < len(l) and dquote not in l[i]:
                 quote.append(l[i])
                 i = i + 1
+            if i == len(l):
+                raise ValueError(_("Unterminated quote in import data: %s") % line)
             quote.append(l[i].strip(dquote))
             ret.append(" ".join(quote))
             i = i + 1
@@ -826,6 +828,8 @@ def mkargv(line):
                 quote.append(l[i])
                 i = i + 1
 
+            if i == len(l):
+                raise ValueError(_("Unterminated quote in import data: %s") % line)
             quote.append(l[i].strip(squote))
             ret.append(" ".join(quote))
             i = i + 1
-- 
2.56.0

