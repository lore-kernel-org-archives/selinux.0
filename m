Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A5A134CF
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091914; cv=none; b=cUS3fWRxRZaJokS++jpM26TM6RlmK6bOJ4hpLrAGIW5uEe4dLLuKa5jEorso1oKJFRAtuZFTMEPCt8FRh036hNJUuVwgIUzJDLMlbLNnlVo9LZr/lX0rPpePfLO68hB7ovjjfT5TlCq1bh7IWOsZtPWkckAMuOXwTzF/KrXFMrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091914; c=relaxed/simple;
	bh=h0kodsZ1DMqXPPUDY9bGfeCR/OaEro4wMlbIdYE4XyA=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=Jz1P5PG3RCWWWdUewSNnMVV8Blk/PB9krLp1MZCNq0SPwE5QXg4C5hnrFwK5uZZ/Sjg4fJaDgUG2HkQrpjTnUk4QVHk3wGwniOseMCJW5TKXUuTEWtwsyN9YgXMZuqOlfbK8j4njFtrSr2kIJNN+QkLJ7nDvBvChTxl3okRCMsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LYtluk1r; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LYtluk1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Mime-Version:Message-ID:
	Content-Type; bh=h0kodsZ1DMqXPPUDY9bGfeCR/OaEro4wMlbIdYE4XyA=;
	b=LYtluk1raV3x4BV1UqMfTZb4o0nMbDby8oN8scf+S9niw420vMjvnvTDpb/dHN
	ivTQTP3W9iZQTosc6HVSCE9CVwOHDqxOElszkWPHIvchVBIr12H0w5X8zych45/R
	16TCVtpJ9lVSLdz8kzqMhMPvVlM3xtvMM7/ny1hzwPChs=
Received: from sf-c (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBXm31CD35oK2ITGQ--.10406S2;
	Mon, 21 Jul 2025 17:58:27 +0800 (CST)
Date: Mon, 21 Jul 2025 17:58:28 +0800
From: "robinshao007@163.com" <robinshao007@163.com>
To: "Rahul Sandhu" <nvraxn@gmail.com>
Cc: "Rahul Sandhu" <nvraxn@gmail.com>, 
	selinux <selinux@vger.kernel.org>
Subject: Re: Re: [PATCH] libselinux: fix parsing of the enforcing kernel cmdline parameter
References: <DBHMZH3GO5P1.3GWN2Q7JEO8YT@gmail.com>
X-Priority: 3
X-GUID: 3FEEE6E8-B86C-4AD5-BDEF-73ACFF190E26
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.398[cn]
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <202507211758278601601@163.com>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
X-CM-TRANSID:_____wBXm31CD35oK2ITGQ--.10406S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrAF13JF1fCr1xGw1kJFyDtrb_yoWxWrX_AF
	ykJFnF9w1kArZaka1fuF1xCanxXayfua40vrWUKr17ZryvyrsxXws5JF9xC34Dtr1fu3s8
	Zw18J34Svr1jgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRiZjjJUUUUU==
X-CM-SenderInfo: purex0pvkd0iiqx6il2tof0z/1tbiQwmRC2h+CMfA5QAAss

SGkgUmFodWzvvIwKCgpZb3UgYXJlIHJpZ2h0LiBUaGFua3MgZm9yIHlvdXIgaW5mb3JtYXRpb24u
CgoKUmVnYXJkcywKUm9iaW4KCgoKCgrCoAoKCgpGcm9tOsKgUmFodWwgU2FuZGh1CgoKCkRhdGU6
wqAyMDI1LTA3LTIxwqAxNzo0NwoKCgpUbzrCoHJvYmluc2hhbzAwN0AxNjMuY29tCgoKCkNDOsKg
bnZyYXhuQGdtYWlsLmNvbTsgc2VsaW51eEB2Z2VyLmtlcm5lbC5vcmcKCgoKU3ViamVjdDrCoFJl
OiBbUEFUQ0hdIGxpYnNlbGludXg6IGZpeCBwYXJzaW5nIG9mIHRoZSBlbmZvcmNpbmcga2VybmVs
IGNtZGxpbmUgcGFyYW1ldGVyCgoKCkhpIFJvYmluLAoKCgrCoAoKCgpZZXMsIHRoaXMgcGF0Y2gg
aXMgZm9yIGxpYnNlbGludXggKHNvIHBhcnQgb2YgU0VMaW51eCB1c2Vyc3BhY2UpLCBhbmQKCgoK
bm90IHRoZSBrZXJuZWwgc2lkZSBvZiB0aGluZ3MuIEFzIHBlciB0aGUgY29udHJpYnV0aW5nIGRv
Y3VtZW50IGluIHRoZQoKCgp1c2Vyc3BhY2UgcmVwb3NpdG9yeVsxXSwgcGF0Y2hlcyBmb3IgU0VM
aW51eCB1c2Vyc3BhY2UgYXJlIGFsc28gdG8gYmUKCgoKc2VudCB0byB0aGUgbWwuCgoKCsKgCgoK
ClsxXSBodHRwczovL2dpdGh1Yi5jb20vU0VMaW51eFByb2plY3Qvc2VsaW51eC9ibG9iL21haW4v
Q09OVFJJQlVUSU5HLm1kI2NvbnRyaWJ1dGluZy1jb2RlCgoKCsKgCgoKClJlZ2FyZHMsCgoKClJh
aHVsCgoK

