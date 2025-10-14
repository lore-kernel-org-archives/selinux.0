Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983EC2BAF9
	for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 04:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760415212; cv=none; b=O8AsYF31I4m1AvXoT8WkcMSa1E5IiKT8TzhJj8b22ZxPliNq7dlN23JbY1AvD1Rj4+B3eRr8LYEe1IdZcGWHjy2DQodPWH0pf+TL1Efrke9aPFWDEqhbPZugottXJpwCybCL/P0EqapdZQjQpd002YcgOBm+iLNs6+D+ZXPty5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760415212; c=relaxed/simple;
	bh=BD5BG+J+Iv4x7sZ0ZYEcFMBWcl3it+BMD+XKSw/pSfI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To; b=e/mwUzQ0kPdRj5IJbMC0i0Hz7QfDxpRXlBjtcsFjW1+jNIVuzIGRu2LN+jF/6seOM7FsvKZQw1x/DH8Ef0ndSeJwKDVeQPdpxLSBspWxmF30B8zaSIGnORl08iuiU7jXL9fwzysJYRSvrWVj7xi5RmYHPXzQvr4u397o706V6O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PS4C6Vik; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PS4C6Vik"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b403bb7843eso1045708866b.3
        for <selinux@vger.kernel.org>; Mon, 13 Oct 2025 21:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760415209; x=1761020009; darn=vger.kernel.org;
        h=to:from:subject:message-id:date:content-transfer-encoding
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hba2QyDVHqDSBRvj8xwSi+VE5t8MeaaCWOLmMRvl0zc=;
        b=PS4C6Vikur9AT0MgjXScRUiCr/jabdrXMZp32JXqVuWEH/PeVu3liXyG00wHnoXofE
         VRuppITXkHDEFWWJa1wZ50GDcmF5dcODf5spSpTPY4hI2COSFbEPYXO07FRtyPM8qOfh
         do4fgdMjKTFKhUfRKGbP3t4m0IlbfgGfY8Zt0T0weO/gl33DxkHSyy1gvBurCfOo1om/
         aaKCEnxx+3SFBQoL9SQI3668QSo/iT1m5MWHOThTZAofat66Zr8FZb9tqPSDh13/+gfF
         iZ4K82U80v3B5HnodxW0DAKC4hFk44XFUACp7VhgrrgIHok6f18AwN/ZXp2tIL9GUhLn
         Rfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760415209; x=1761020009;
        h=to:from:subject:message-id:date:content-transfer-encoding
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hba2QyDVHqDSBRvj8xwSi+VE5t8MeaaCWOLmMRvl0zc=;
        b=pOEl/9K3tA64o0TREQZ1sEcx2nSyZjJCfRz94TN3mvOmRNKBOTTNmBk14m3+rtfKgJ
         M+3JuVImj0OBJDyioGY8a0ld2FamO+aUt8GcXLwnnluQggUlM3AiAQS2QB3m9Oc+8PkF
         XCT6v2purTt3xlAxgxpBEAutiUvIip7dlV+JAs2FPuIhBcEreLqbuHMkGFFk+LePrxYI
         nJ9PHbg/defHCE2IMlcbp5pSFxMs6hcCDC9iltVJ/uLHbqniJ2sA4pyG1AdvbIoSDy8z
         jpVMajsR6wr1p6or9rRmT6J3Pq+FrNf1ksTc00PEolUGUiIj22bw5rQEq9QK/V/qhgIe
         G9Qg==
X-Gm-Message-State: AOJu0YxQG6xIiVkIgF2F+s223SwLVPXYlO56xCEOHtcrqzpjaT2E67Mt
	krgX0JF3vX8+9ddqRfbMjpfEu+WUNRD8hQpcxfIb2QVXgEbkrIbouU9DS/5How==
X-Gm-Gg: ASbGncvERN1l4qdf4IibJ69tdtKaZc7Jhvj9go7BnMpnkKG35TlqAjjhyoWSwP+azFh
	bvY280Lh8Q8ozo2vCTEMPLXtrdEiH1Gj4T/5+NvtnfpQKFsbkV7YeYWwIetulkzxYa73xNZ9udo
	6/UP3DKqBWl4eBQFUZwjyJFZ61sKnqsOCdC6aLa5YwcNXb6QABlijBMxQkSViU0Xr5uN0mdndVa
	2dL9Gr198c1gN67ANNRrjHOFMgBlzcshHv+NlXlzM+vRyMkmaEyUkapNyevuO6TJ4dy3wG5FeRl
	j78vBiga3yIcZmgLPa93OUDmKdZm2sinU+GD/XpPX7DfnAFLZdMYRAJlFCzGTN/sj6W/t7k6ZdP
	VTbPoLOUqZTUsTkF/aRcetRvE4zNXDG+5SwPN8Mkd4eYnIA==
X-Google-Smtp-Source: AGHT+IEL8BQ8mt956tpXTgg5lKS5oaNvkAom//l2ECSPwFoKh2ht/Fs1pG8zP9O0oIMmmJ7PgtMAtQ==
X-Received: by 2002:a17:907:c28:b0:b46:3f98:6ba5 with SMTP id a640c23a62f3a-b50aa48e3a6mr2730354066b.11.1760415208807;
        Mon, 13 Oct 2025 21:13:28 -0700 (PDT)
Received: from localhost ([2a0a:ef40:89b:b900:2e0:4cff:feb0:4e4d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cad86csm1036789866b.17.2025.10.13.21.13.28
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 21:13:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Oct 2025 05:13:28 +0100
Message-Id: <DDHR3Y151ZWK.3DNFX6HD9BW9N@gmail.com>
Subject: confusion regarding the setcap permission
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <selinux@vger.kernel.org>
X-Mailer: aerc 0.20.1

Hi,

I'm looking at the class process' permission setcap, and I'm a bit
confused as to what it actually grants. The SELinux Notebook describes
setcap as follows:
> Set Linux capabilities of process.
However I'm not really sure what's going on here:
1. What syscall is actually used to set capabilities of a process?
2. What processes is it allowed to set? Assuming that the process is
   started with dac_override (granted both on its executable file and
   the SELinux domain it runs in), would setcap allow it to only set
   dac_override? Would it allow it to set other permissions?

Thanks,
Rahul
