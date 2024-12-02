Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002681FBE9B
	for <selinux@vger.kernel.org>; Mon,  2 Dec 2024 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133563; cv=none; b=ep6a6DtDGzMBAOalEvhlXjCjyvqoQgWpTYVU64Mv2+WUymvLEbLF8iuGbVxPtXLQJb+nsOBKAbUsFGH0/8o6T86wT/UOBQoAmVtQVaoC3bYg3vriFY8blC6WKtLgDzrnw2DB8EPpuWect09W9O4pQIgfN6DxBBPalxw43YzXbHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133563; c=relaxed/simple;
	bh=cCXwF4EDdoRKbJ/lz5vV88zzdU/jjtACN0yjA2LFizE=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=sAZlSkaxz4v/jEl+wC+CKj1dLFnVA47MOPjcNEwpXMrQWs8dKTxERV199iR7Nvf9MBjx8WJifVkoJL15LXzh4o0pYEYmDLQLdXTTJayMsEucCpbISzWvggtGOWwVb/2dAY6lVcOeZL6OVOPfNoCgMXZ0nnMn/gv2mLlnknB9Q4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=cAUC+fM3 reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="cAUC+fM3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=xZpLQ8cbZOFV3zEev7BCXEOXNDcwDgjylZI0P7dcVoc=; b=c
	AUC+fM37LaswI7reaKj/1m4qt7SwhMyQHT8AjHEqpLgfInmozoC1/HBX1tPvtmAR
	2xlPW++2YSRUDkNBWXGIOXk0ryGdQbhJn5znxFl1/s9bcG73XzFYGLtU9H5uCjN8
	A38Go7oNHqeYw4G5RGu7ddS9mIBqV3FEbBPt6qklwE=
Received: from hejing194$163.com ( [240e:46c:8800:d09d:8193:1e83:307d:6402]
 ) by ajax-webmail-wmsvr-40-136 (Coremail) ; Mon, 2 Dec 2024 17:59:06 +0800
 (CST)
Date: Mon, 2 Dec 2024 17:59:06 +0800 (CST)
From: "Jing He" <hejing194@163.com>
To: selinux@vger.kernel.org
Subject: Suggestion on the Man Page of setenforce
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
X-CM-CTRLMSGS: FDTTvXBsdXM9MTczMzEzMzU0NjE2MV9hNjFjYzY4NTkyYmM5MzJjYjVlNmMyY
 mY4ZTFhYzJkMw==
X-NTES-SC: AL_Qu2YAf2YvE0v4CWYYekXk0oRhe08WMe4uPgj3oNeOJ80sSbB+xk7cnB5Blbo1cOFBSqSvxeZVwJQ7uVTRplRdoas/K+e8EX8dKXkz2w/Yksa
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <735f46f6.aef7.19386cf340d.Coremail.hejing194@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iCgvCgD3n8rqhE1nUVU1AA--.20383W
X-CM-SenderInfo: pkhmx0bjrzkqqrwthudrp/1tbiqRGp42dNTnfskQAGsa
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

RGVhciBTRUxpbnV4IGNvbnRyaWJ1dG9ycywKCgoKTWF5IEkgc3VnZ2VzdCB3ZSBlbGFib3JhdGUg
bW9yZSBvbiB0aGUgbWFuIHBhZ2Ugb2Ygc2V0ZW5mb3JjZSBjb21tYW5kIC0twqBodHRwczovL2dp
dGh1Yi5jb20vU0VMaW51eFByb2plY3Qvc2VsaW51eC9ibG9iL21haW4vbGlic2VsaW51eC9tYW4v
bWFuOC9zZXRlbmZvcmNlLjggPyBUbyBjbGFyaWZ5IHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gY2hh
bmdpbmcgU0VMaW51eCBtb2RlIHVzaW5nIHNldGVuZm9yY2UgY29tbWFuZCBhbmQgY2hhbmdpbmcg
aXQgaW4gL2V0Yy9TRUxpbnV4L2NvbmZpZyBmaWxlLgoKCkN1cnJlbnRseSBzb21lIHBlb3BsZSBz
YXkgaWYgdXNpbmcgc2V0ZW5mb3JjZSBjb21tYW5kLCBTRUxpbnV4IGNhbiBiZSBkaXNhYmxlZCAv
IGVuYWJsZWQgaW1tZWRpYXRlbHkgd2l0aG91dCByZWJvb3QgKGh0dHBzOi8vc2VydmVyZmF1bHQu
Y29tL3F1ZXN0aW9ucy8xMDQyNDIwL3NlbGludXgtd2hhdC1hcmUtdGhlLWRpZmZlcmVuY2VzLWJl
dHdlZW4tc2V0ZW5mb3JjZS0wLXRvLXBlcm1hbmVudC1zZWxpbnV4KSwgd2hpbGUgc29tZSBvdGhl
cnMgKGh0dHBzOi8vd2lraS5nZW50b28ub3JnL3dpa2kvU0VMaW51eC9UdXRvcmlhbHMvUGVybWlz
c2l2ZV92ZXJzdXNfZW5mb3JjaW5nKcKgc2F5IGl0IGFsc28gbmVlZCB0byB0YWtlIGVmZmVjdGl2
ZSBhZnRlciB0aGUgcmVib290LsKgCgoKVGhhbmtzIQ==
