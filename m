Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D187424D59
	for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787754247; cv=none; b=fOaxfw0QcI9Pa9NlArsfL8Pf0Pt4/evzqzEL/iYS2OLEwjhOR0hdcTw44J4Pea1uWdHma/6cet6ITWct0aVfq3aHbkcUR9DlrgHZ/Is5pOsAr4RnRYMn9JmSOP7ApJKcUj0Qvz+7wMoJe2O2tuVzxPX7nMVftdz5H0FnMn/czRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787754247; c=relaxed/simple;
	bh=rtpPhLQ1mr3ZgbD5w4b420MP4pJsDBvLUsZFgYbApLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JF2yWaITG+FBIZBMKTZoyCzIrWYRxrKYXUgw5ZjIcb5PZcdrhTD48mMnw72gYFmxAy4lHV8dir+E99rfNBP9tPN/4kb9ddDJBfC9QNrrOhbv1bAjaH0cmoYQIX5Sl/l/MLKAVcN+5lAAb9T+g+cNlZyvNLQds8y15ct+f2oCXgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rYKmjG0I; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYKmjG0I"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-90cc372d6b2so8872186d6.3
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 07:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787754237; x=1788359037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QvwoZrY2i4Lfk4tJiQZMwQSogjUSEaLkLwGkMvl+aSg=;
        b=rYKmjG0I2dS301Q1j9+cIPDVY+NswXFHL4tCS9/ChCC8vH3i7EbGHvlsZC7h7/1EQp
         MhghB7ScILaJfMge8Rz44+58F/jS8WWq6Q+cBDBzb/kYUsNa1d2O/M0jrD1hrHELXnbM
         0ztq6xDWvmv3rhiVc63NGLbUsl781CClVihKGZmhtPtHVhzISnxUnxsNyE0u4q0HLyam
         bniIzWhWj9Cnq3G/c6t36PBXUF/MPUNqQgRiEnwgprm95HOZ7JaQ69ZdoohNGlGG3uPt
         too30SFp+SlwJ3r7Ip/ZEf8pcik9qFfAnJhH2wr6twwT5o98tllM2ElXdcKMqrxQ4cFL
         XPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787754237; x=1788359037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QvwoZrY2i4Lfk4tJiQZMwQSogjUSEaLkLwGkMvl+aSg=;
        b=WQfMHsBcbOmVEm7+Q0kP7q5QKr6B+4KLbAs5wLfPMe1u8ZT68zKUHDNNIb6rBZkNv6
         oeXEE8ND2qSTtmMMdJH7LXjm2ctlwkDuKNlnijgEt1+XCQJQmcuGaxi7Mt8SLVw2hwqH
         6JMdYhdFSLpuIj0J1ZWJlk4aVNogmFTl/uy4ktrRwrZ9PIQvOx6R5iBJrIQ2vrF17Pty
         f0uxKlBH+Fo7k4xyzQEEQ3+MdXphiVcSP5La04fx3H9Mi6y54JzU1EuStpEt7X3dkuiU
         HJoD2uXk1ZnYkZ1y1P1E+UlA0bhr3EMfZ/rxxj21ND1FymaqYdsv3G4k5Nn83wvuPdMk
         bR9Q==
X-Gm-Message-State: AFuF++m88q3ZCWAbWKoRXlVJrqWQkBmpQDN6ydXR8UcKciR9wdnXsTgC
	gEqZFxiSFI4NixHzQMwiTjMGsVlBR84ehz9uPc5HXPkZ2nryKr9nbSL452LnJg==
X-Gm-Gg: AR+sD11fMIy2NcEddImD0ANdGZhx7HmhjUvseGpWksUyxFpAlf+9T/dui7OxLu7YklM
	BaAvYT/Jl06Md4YExjedTO4EBwrB21LwcfTaB7cDh6nhWPeR6sXmk9jqIbN6Uvj6vyGxrEhWuT5
	pM1WaGyWMEBByBJh+dee6lB43zUjWHRbbFSPALvjxRVJAHtIJcnIf8qw+6KFdPRFLERgnP3s9CN
	sViS9xHaTJmG/fFp4GC6LUg7cisATo+W55PcWK+FubqVK8V4nBn6RPIOGSc0S1jjB93zApBM5Vb
	SFhyznsM2y/Zl44tKdK3rSlYWDi4QuRFesSwFNS1ES4A+RvTjBV3UqcZHIKuzCn+v0hK3gNftxl
	n6wk0GnQIzapzzVv1Va/08TxAHaEWqVQEodLDFZDGC82ye4MDMSA1vD/PPwehLyN7c9yuGL/YIO
	EKzyNJqUCJqI55bTowA3QF1rJL5VMVQYAW/TuxIJwD0DtQuN5Edua7QVpX/SHs/4M4YXCYCn8eJ
	k9wtsDAXSk30EeogLtwkXmOY5JpHDJPR2bAad+YDMAbc0tx+nLOo17MfX5TcBq/
X-Received: by 2002:a05:6214:3199:b0:908:951f:415 with SMTP id 6a1803df08f44-90cc78ad65emr84303256d6.13.1787754215458;
        Wed, 26 Aug 2026 07:23:35 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc652722csm26402726d6.36.2026.08.26.07.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 07:23:34 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] python/sepolicy: escape literal paths written to generated .fc files
Date: Wed, 26 Aug 2026 10:23:22 -0400
Message-ID: <20260826142323.2504-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sepolicy generate generates .fc files with user-supplied literal paths
substituted directly into the path spec field. Path specs are regexes
so a user-supplied path containing any regex characters would be
incorrectly matched. Escape any regex characters before substitution.
Use str.replace() instead of re.sub() so that any escape backslashes
are not re-interpreted.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 python/sepolicy/sepolicy/generate.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
index f88d6852..78ba3f13 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -1092,12 +1092,12 @@ allow %s_t %s_t:%s_socket name_%s;
                 t1 = re.sub("TEMPLATETYPE", self.name, self.files[i][2].fc_sock_file)
             else:
                 t1 = re.sub("TEMPLATETYPE", self.name, self.files[i][2].fc_file)
-            t2 = re.sub("FILENAME", i, t1)
+            t2 = t1.replace("FILENAME", re.escape(i))
             fclist.append(re.sub("FILETYPE", self.files[i][0], t2))
 
         for i in self.dirs.keys():
             t1 = re.sub("TEMPLATETYPE", self.name, self.dirs[i][2].fc_dir)
-            t2 = re.sub("FILENAME", i, t1)
+            t2 = t1.replace("FILENAME", re.escape(i))
             fclist.append(re.sub("FILETYPE", self.dirs[i][0], t2))
 
         if self.type in USERS + [SANDBOX]:
@@ -1108,11 +1108,11 @@ allow %s_t %s_t:%s_socket name_%s;
             raise ValueError(_("You must enter the executable path for your confined process"))
 
         if self.program:
-            t1 = re.sub("EXECUTABLE", self.program, executable.fc_program)
+            t1 = executable.fc_program.replace("EXECUTABLE", re.escape(self.program))
             fclist.append(re.sub("TEMPLATETYPE", self.name, t1))
 
         if self.initscript != "":
-            t1 = re.sub("EXECUTABLE", self.initscript, executable.fc_initscript)
+            t1 = executable.fc_initscript.replace("EXECUTABLE", re.escape(self.initscript))
             fclist.append(re.sub("TEMPLATETYPE", self.name, t1))
 
         fclist.sort()
-- 
2.55.0

