Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4562576DB5
	for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="go+CLw7B"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-67f95350508so498936d6.0
        for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 14:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703197562; x=1703802362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8WW6bMlQIZfCFe3cnRe202NOW1+Cjb+AxQIMOKQ8k6s=;
        b=go+CLw7BQXv5K1WuGnU5XQxYyLkP/tLXXW7+qKo8i0wgOiDwxOHZrbYf/kh5YS0s/I
         mZYDfEX37bItsvwltnGlCmFXLnOtC2WaI4zNVIx12jm7Qjwmule/fr0Vzjy/rw+WwFa+
         uPQK1VjkBEgrhQTrgrfq+71Lx0ZBx4Ow6Cn4MhAogJVOBozUmDQtXgBvFSS7XaGSS63f
         K45s8zaSkVUEIBN9qr6XROINqOF/yowgFDqiF+tYza+iaODiVjc66snafp7qjb9M9x/G
         vG2xbki8N81PCQwzUkQ8pgVVntJT5yr1GW10ih3wwLcJFsgfltO+i0jon41hE8j9SPg8
         wFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703197562; x=1703802362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WW6bMlQIZfCFe3cnRe202NOW1+Cjb+AxQIMOKQ8k6s=;
        b=YmzfT/hkU/7ajY2yuYyba3oFH2c+DfZ+NnkcD/PNCexcJ3pWMSD44ZoawFdnmPBiPh
         pPda5S6aJ4BnskvpfYkS4ThtiY51znTBMD8MB/EzExDkjMDubbUQPV7XFdiAT7r31D2Z
         FiG0F0xAVC0la6+YGAl7mxF5nKbIUNf9oKQoXVQ9fuOIeS2rlnKoaD24fSK7Gqu11Ywk
         n2Ory3cfyjMA2uyot2aE7Zg1yN/qz+UnM20dIBTqaPqpGADaoH4GnRdIwCCq+0b2vTuk
         HQku9fyttALLSa9aY6MMhKK5Zlif7CnNYoezQMeoNxfPoHEcVfWd5mybsBOfkxhNxQLg
         lEHw==
X-Gm-Message-State: AOJu0YzGrxL1MuFq5Yw1gldsZ4HgA0vntxqmWACQW+L7zIpRTBLasZX+
	opJ0f/uKuZCtZg/Zq7tzPrJt9IdUbFI/qJGlD+KCmkZPCA==
X-Google-Smtp-Source: AGHT+IGbeHfyYledDBejWorAJp/NWeKbAeiYdemW4POVhk9BJg2EA+636CV53/AaLGzVwT8amjiolQ==
X-Received: by 2002:a05:6214:3010:b0:67e:ece5:5037 with SMTP id ke16-20020a056214301000b0067eece55037mr536582qvb.64.1703197561923;
        Thu, 21 Dec 2023 14:26:01 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id c2-20020a0ce7c2000000b0067f2d12353bsm910027qvo.78.2023.12.21.14.26.01
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 14:26:01 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: SELinux style fixes
Date: Thu, 21 Dec 2023 17:18:43 -0500
Message-ID: <20231221222342.334026-17-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset applies the Linux kernel coding style to the
security/selinux/include directory with the eventual goal of cleaning
up all of the SELinux code so that we can start to introduce automated
patch validation and testing.

