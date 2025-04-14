Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF3927C873
	for <selinux@vger.kernel.org>; Mon, 14 Apr 2025 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628015; cv=none; b=Sk3sIg+0CXHTXLeUw50Sa/V/xCeejYJO7kWWJArH1W1fTivLr5f0/2ubXQnt64jXeqZXY84ws1R/FRofrXYWWEg+U6bsjF2+KOtMLbfP7YpK7Ylh7QO0+udwlm1Rsg+G5c1bznYFb17oIzznFaIOhBQmA+wN3sLj3bIPxO3zANk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628015; c=relaxed/simple;
	bh=i8UFVfLVecE/OkBEcbn7OeI+IvLd733RRqhhh0d5tg0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=luOwrBBZZphR/A6oIa6I88R+4iU2YEJ6DXuvCpyYscymHymBvvdN8Yy34fprQIGNFTItrXr4J/3o1PdjLb++WL5dDELQXjxq14OVCod+gcbcrSO1ufSxTaDSaz4GjduI5paUjIZ//m1NUTRBmp2WbwyRvMlOccObmx9o24NNWXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PZxsY7YV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZxsY7YV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744628012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QssDdryN4XzwB2ObD+whRE7b65oyqcuIi20l20iYWjQ=;
	b=PZxsY7YV2h0i9bN6jvd5S3nb5OhzPPaNdc+q+FE0/tBXqb2ov2p/QWxDJZtpNLEvUWrzlr
	7z2mV6khYMyMGfbKyGyXH1NfiaaMvN/hW84tck7KYloSZGJ10NNyT+VzmnY6NNmWLayLM+
	tLXj8N2f8LM0Yf1Gy37XETp51l78zH0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-cVwuT7DeOzOyZug-7a61QA-1; Mon, 14 Apr 2025 06:53:27 -0400
X-MC-Unique: cVwuT7DeOzOyZug-7a61QA-1
X-Mimecast-MFC-AGG-ID: cVwuT7DeOzOyZug-7a61QA_1744628006
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff798e8c93so3822389a91.2
        for <selinux@vger.kernel.org>; Mon, 14 Apr 2025 03:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744628006; x=1745232806;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QssDdryN4XzwB2ObD+whRE7b65oyqcuIi20l20iYWjQ=;
        b=P1yrMs4XXZqJyqV4+j7C87ieHX9Mhg94Vw2p4JPRqo37fTgznsqhiMkChJWjaKFeKY
         rAFdMfLUmT8teT/Pd7h32tsYudbfru/iUmkOhJZdfJoHLa9635c566i0YYSwz5cx6AYQ
         pB3mYxctkBNDQKAnXDwlrB3aubX8D1VIfvqVOU0DW29FHpnh6NRAdc8+dSMgH1Y6olS+
         z3AeeJ1gIU+7rhUOkX23+xPFQgc+Q61tH1zA6sgVCC5ob2sOckQzeCWVPOwGYCm0WnIP
         7GAPyMCKfCFnYwcU/oIqcNIqTNfPUQ2SJ68orE2fFpfZJWSfV38tuyx0FEVUjDflVu/Z
         C9vQ==
X-Gm-Message-State: AOJu0Yx9Q8AcGnYuI/kIprBBKLLitoClF/P+2wDVp6AlVIzprl3VXRB+
	oojaYGquNJTU4zNd7rKHDocavbWqRpe/UdoJUlVWL+seFUEoVvxqiX+RmJQ7Ij7sWAoh4iUb8J2
	eGTOCjYwcx0S0gvnBwydIvERSZq7vvRe58KYZqqHNouB2o27QnIfUCqpS+qWVPQKmdYjVmJKeq1
	JWnLhsFiZq6yLkdVl1PrbcpCVYGf55iAEgReCzjCGJ
X-Gm-Gg: ASbGncv00QwHc509xpvGBCKWS5dID+Zp1HTcANUfP/6oepHrH6mt0BPxHEaA943mdNe
	Ivn00ihELYtQ/4cCzi11pzlENPo6kec9kSl1IqvtL9fYO+XIiJ8XtxNjVnh+276YL/gSB2s0lHN
	Lk22dPqcHJSn1pv/Fz33NhyikYVA==
X-Received: by 2002:a17:90a:d00c:b0:2ff:570d:88c5 with SMTP id 98e67ed59e1d1-3082377bf6emr17374458a91.9.1744628005670;
        Mon, 14 Apr 2025 03:53:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1RQ4lutpYCn+Kaq6I6KhtiVojLcDa95CbKbGEjQZmsp7rcx8Um4wnI+nq8RtXvDW862mAFQnIMpcjZ2unsv8=
X-Received: by 2002:a17:90a:d00c:b0:2ff:570d:88c5 with SMTP id
 98e67ed59e1d1-3082377bf6emr17374447a91.9.1744628005214; Mon, 14 Apr 2025
 03:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 14 Apr 2025 12:53:13 +0200
X-Gm-Features: ATxdqUH0l3nfdPAcTuR_HE3HJVDFxQf3jn1qi3rAw2RBx76Mc5KftSBiTI7qpGU
Message-ID: <CAFqZXNtqPBMGUL8kvYoW2VzdrmcY1cx1+NL+LmOs0oxjfG5csA@mail.gmail.com>
Subject: NFS/SELinux regression caused by commit fc2a169c56de ("sunrpc: clean
 cache_detail immediately when flush is written frequently")
To: SElinux list <selinux@vger.kernel.org>, linux-nfs <linux-nfs@vger.kernel.org>
Cc: Li Lingfeng <lilingfeng3@huawei.com>, Chuck Lever <chuck.lever@oracle.com>
Content-Type: multipart/mixed; boundary="00000000000084531d0632badcb5"

--00000000000084531d0632badcb5
Content-Type: text/plain; charset="UTF-8"

Hello,

I noticed that the selinux-testsuite
(https://github.com/SELinuxProject/selinux-testsuite) nfs_filesystem
test recently started to spuriously fail on latest mainline-based
kernels (the root directory didn't have the expected SELinux label
after a specific sequence of exports/unexports + mounts/unmounts).

I bisected (and revert-tested) the regression to:

    commit fc2a169c56de0860ea7599ea6f67ad5fc451bde1
    Author: Li Lingfeng <lilingfeng3@huawei.com>
    Date:   Fri Dec 27 16:33:53 2024 +0800

       sunrpc: clean cache_detail immediately when flush is written frequently

It's not immediately obvious to me what the bug is, so I'm posting
this to relevant people/lists in the hope they can debug and fix this
better than I could.

I'm attaching a simplified reproducer. Note that it only tries 50
iterations, but sometimes that's not enough to trigger the bug. It
requires a system with SELinux enabled and probably a policy that is
close enough to Fedora's. I tested it on Fedora Rawhide, but it should
probably also work on other SELinux-enabled distros that use the
upstream refpolicy.

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

--00000000000084531d0632badcb5
Content-Type: application/x-shellscript; 
	name="reproduce_nfs_mount_regression.sh"
Content-Disposition: attachment; 
	filename="reproduce_nfs_mount_regression.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_m9gxjwo00>
X-Attachment-Id: f_m9gxjwo00

IyEvYmluL2Jhc2gKCnNldCAtZQoKc3lzdGVtY3RsIHN0YXJ0IG5mcy1zZXJ2ZXIKCmZvciAoKCBp
ID0gMDsgaSA8IDUwOyBpKysgKSk7IGRvCiAgICBleHBvcnRmcyAtbyBydyxub19yb290X3NxdWFz
aCxzZWN1cml0eV9sYWJlbCBsb2NhbGhvc3Q6L3ZhcgogICAgbW91bnQgLXQgbmZzIC1vIG5mc3Zl
cnM9NC4yLHByb3RvPXRjcCxjbGllbnRhZGRyPTEyNy4wLjAuMSxhZGRyPTEyNy4wLjAuMSxjb250
ZXh0PXN5c3RlbV91Om9iamVjdF9yOmV0Y190OnMwIGxvY2FsaG9zdDovdmFyL2xpYiAvbW50CiAg
ICBzZWNvbiAtdCAtZiAvbW50CiAgICB1bW91bnQgL21udAoKICAgIGV4cG9ydGZzIC11IGxvY2Fs
aG9zdDovdmFyCiAgICBleHBvcnRmcyAtbyBydyxub19yb290X3NxdWFzaCBsb2NhbGhvc3Q6L3Zh
cgoKICAgIG1vdW50IC10IG5mcyAtbyBuZnN2ZXJzPTQuMixwcm90bz10Y3AsY2xpZW50YWRkcj0x
MjcuMC4wLjEsYWRkcj0xMjcuMC4wLjEsY29udGV4dD1zeXN0ZW1fdTpvYmplY3RfcjpldGNfdDpz
MCBsb2NhbGhvc3Q6L3Zhci9saWIgL21udAogICAgc2Vjb24gLXQgLWYgL21udAogICAgdW1vdW50
IC9tbnQKCiAgICBtb3VudCAtdCBuZnMgLW8gbmZzdmVycz00LjIscHJvdG89dGNwLGNsaWVudGFk
ZHI9MTI3LjAuMC4xLGFkZHI9MTI3LjAuMC4xIGxvY2FsaG9zdDovdmFyL2xpYiAvbW50CiAgICBz
ZWNvbiAtdCAtZiAvbW50CiAgICBsYWJlbD0iJChzZWNvbiAtdCAtZiAvbW50KSIKICAgIHVtb3Vu
dCAvbW50CgogICAgZXhwb3J0ZnMgLXUgbG9jYWxob3N0Oi92YXIKCiAgICBbICIkbGFiZWwiID0g
Im5mc190IiBdIHx8IGV4aXQgMQpkb25lCmV4aXQgMAo=
--00000000000084531d0632badcb5--

