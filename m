Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AE642E01D
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778682665; cv=none; b=uSbrMPgcgnxdsb5ApBS1UZo/dhGYoyBAcVGZeklpqS9THZWidmBYY3QMx9P3ywxaPKLrR+1OuRHkC+RwgMI38yj2ASWBSutJHRd+5TKJTlFMSPrIOgNhykkrhJKUYL+z2dbTZu1IJesV9Rmc40BoKgJpWvwilQTejJ290YdawN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778682665; c=relaxed/simple;
	bh=UepWhQN9QHxncJS7TS0JOKychaA0cPdcyUHDijxrHro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kg8yGf3h4JgGUxzFMIV7bwsUISV/YTKLdSSoRS0dOw8UITzOrg5S6EO2UX7uSWRETLiW0YRqSRhSJ8hpdS4vzf9sg20yE7tjeIZXeYbn9q9lJdmR57cevcW+iHFCSoiu3N9uaUct+Cz2iMHlHMYzE0RJIEs7oJaXg7ToMapXOlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NV3wBGGT; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NV3wBGGT"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-90cbb2b50ccso156229785a.0
        for <selinux@vger.kernel.org>; Wed, 13 May 2026 07:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778682662; x=1779287462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLGHKy7skLg2cNprmDZfJnK5d5tEbaGTeDN24RdpUbk=;
        b=NV3wBGGTZNQ/jHC1MAF/BP3GPzTNgOL8E0I6Bg1PFXLVsYDFi9kVwUCiWpzVFTb/UA
         cPmXK8uLAl0qZsfyvTJQt/DQjT3acSligRAB8WB4HdIFiaCB8MCxiz+loBgx7/0bG8US
         zAk8BHOAnOz4xjTGGwCJSfQZoGP/0HdXzl1Kqcj8wm2i8HxpDfO0d4hnOlUwtbqHf2vy
         6M7yg6NakwAJY1sgpVB2TUDFffLMmByuYEqC7senqYSr5vxq+tEvGcE5SNH8TVJeiJRc
         eyHT5RdzpUQWTLq/n6GiIE7J0h2i1+hqqZhzHncv1tw4/2NjgW1INdZqkqC9ih0e04mB
         NVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778682662; x=1779287462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLGHKy7skLg2cNprmDZfJnK5d5tEbaGTeDN24RdpUbk=;
        b=APoJQ46uLEv1NrDZp1J9KD7g+4ohSESp3mmH+WMPJIrwV45IZqmP3z9xkCwnJeuuC2
         P3hjK6Yr2PHH/J4miuaJD35EKIGx1mtAtv31ODoxLC4ARNdzeI7OYEg6xDzkV1mJYUlN
         Kzo47JxKPjs0Lji6TDRCOK/iTGufwdIDKAgwaL0w4Q5s1ktJAC5DClJmHD1ElGt7BhdJ
         uuptH1cfBl+fifAZ9ZAEsgsre+ViEHm5pWePoK9izN2Zjib7Kx5E8aOctdl2kg01cuLk
         qlePLIErR7/Q/dwrMwvSFb5o53Xisg/Lg3Qu2hOxRkDYfRWz0Alh4I4/B7PTcj/9/PAE
         z4kQ==
X-Gm-Message-State: AOJu0Yx2ihgZfDRUV+iWN3N5NxeqK06hIytRovUngcUU2GFXzVvvV/AW
	WUTOUPHZacDzuQpPuxVpbtnCNpt/aB9wNUFMHfPlWPOoN0vN5nj+HaIuRkusPA==
X-Gm-Gg: Acq92OE+4aIcVyizj/gP/sikGExcQMOns0zYQ971mXszWXM5vyYFJHj6lqNNy6KR9fS
	5o2C7UQpt4t4VA9tGuMBX9TC3/x6hoNF48OL5I0mGy9E1p3sxtAJYyvwSVpvshCwZRybthc76cv
	FgInFQxdivf1pINCzgaFC2uhq+RibTHgjFYPZPvqm3Vb5eM5L4kuniFofb5dSpGRQFvwxAs8WY2
	NkNNC4pK/5jazHndcpdPm5+w5/4DRDSeuh46Owz4LX6aVDk+1HCLS7lKrvx9TZpES8PLSEES9HR
	wXwe+t7j+X6SXdUxscsXdkculR7G1f+l5dMeC+GsXVprwRsUTASoV8qLr9NIz/VHD0MQezRv4ti
	wd83dwguCRdGOnYGpT1VlyXzLUKLpSs2P7p1oHLzDXj82AxAp9G5Mwu8SP9EeuQsSuDWBRihm4h
	iKrM+mQY54h3i3O9xqbvM/PZf01q0EeIPcM5YsrkK4t2+yNICAOHmmCn6Xgh/Wn2o7Atu/KnuAk
	bt+vNUasQCEki0k/UaGgy7Mdp4=
X-Received: by 2002:a05:6214:29ca:b0:8ae:5fcc:ebb5 with SMTP id 6a1803df08f44-8c7bd2cf093mr53574596d6.47.1778682637693;
        Wed, 13 May 2026 07:30:37 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3a43665fsm154030286d6.20.2026.05.13.07.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 07:30:36 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] sandbox/seunshare: verify RUNTIME_DIR before use
Date: Wed, 13 May 2026 10:30:20 -0400
Message-ID: <20260513143020.39094-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RUNTIME_DIR can be inherited from XDG_RUNTIME_DIR or set to a default
path. Regardless, we should verify it the same way as the other
user-supplied directories before first use.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 945a3b21..89180d0a 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -964,6 +964,15 @@ int main(int argc, char **argv) {
 			}
 		}
 
+		if (runuserdir_s) {
+			struct stat sb;
+
+			if (verify_directory(RUNTIME_DIR, NULL, &sb) < 0 ||
+				check_owner_uid(uid, RUNTIME_DIR, &sb) < 0)
+				goto childerr;
+
+		}
+
 		if ((XDG_SESSION_TYPE = getenv("XDG_SESSION_TYPE")) != NULL) {
 			if ((XDG_SESSION_TYPE = strdup(XDG_SESSION_TYPE)) == NULL) {
 				perror(_("Out of memory"));
-- 
2.53.0

