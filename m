Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7880F10F9;
	Sat, 15 Mar 2025 06:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742019142; cv=none; b=HZmk4rQIHFkVYCGsgasKxCQnoA2zVhn3wQ31dCl8euaievOZCeMOS+b6JqP23e9lvOlK48GUmXG2YFC9NpoCebPINyTkY0t6M7+EOcdtXbB+LevjV9ryZnKW27yO+XU9DtXX+5BqKrsLw8iQB5OUEKED/1Gma6VpAKdErqPwMHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742019142; c=relaxed/simple;
	bh=685XdThuWSpH7Qcd4HYHNcBPYlZrmCB0071uw//M3O4=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=NhpUue2kWa/4PKWT+xX/cRaegBNHEQo8TxKRI1KJr6+IPIPS6NSba64ywZotiMPG2Ztb6MgIdUVj92Wla7LSTMCmPO7XaTuIL7a5l9vHquzVEdwyUyzYocovpVeXq3zPCoOGhNIUE77ey7uCXVVIdnifypYxKqcYoVjwF74nw+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZF9qv5s4hz8R03d;
	Sat, 15 Mar 2025 14:12:11 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 52F6C7vd009399;
	Sat, 15 Mar 2025 14:12:07 +0800 (+08)
	(envelope-from xie.ludan@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 15 Mar 2025 14:12:09 +0800 (CST)
Date: Sat, 15 Mar 2025 14:12:09 +0800 (CST)
X-Zmail-TransId: 2afb67d51a3913e-5bf3e
X-Mailer: Zmail v1.0
Message-ID: <20250315141209936kL2XHnj3IaE2dYcjQZlnV@zte.com.cn>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xie.ludan@zte.com.cn>
To: <paul@paul-moore.com>
Cc: <stephen.smalley.work@gmail.com>, <omosnace@redhat.com>,
        <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHNlbGludXg6ICBhdmM6IHVzZSBzeXNmc19lbWl0KCkgaW5zdGVhZCBvZiBzY25wcmludGYoKQ==?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl1.zte.com.cn 52F6C7vd009399
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D51A3B.000/4ZF9qv5s4hz8R03d



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbTogWGllTHVkYW4gPHhpZS5sdWRhbkB6dGUuY29tLmNuPg0KDQpGb2xsb3cgdGhlIGFkdmlj
ZSBpbiBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3N5c2ZzLnJzdDoNCnNob3coKSBzaG91bGQg
b25seSB1c2Ugc3lzZnNfZW1pdCgpIG9yIHN5c2ZzX2VtaXRfYXQoKSB3aGVuIGZvcm1hdHRpbmcN
CnRoZSB2YWx1ZSB0byBiZSByZXR1cm5lZCB0byB1c2VyIHNwYWNlLg0KDQpTaWduZWQtb2ZmLWJ5
OiBYaWVMdWRhbiA8eGllLmx1ZGFuQHp0ZS5jb20uY24+DQotLS0NCiBzZWN1cml0eS9zZWxpbnV4
L2F2Yy5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KDQpkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvc2VsaW51eC9hdmMuYyBiL3NlY3VyaXR5L3Nl
bGludXgvYXZjLmMNCmluZGV4IDRiNDgzN2EyMDIyNS4uMDA3YmQ5NDk3NWMwIDEwMDY0NA0KLS0t
IGEvc2VjdXJpdHkvc2VsaW51eC9hdmMuYw0KKysrIGIvc2VjdXJpdHkvc2VsaW51eC9hdmMuYw0K
QEAgLTE2NCw3ICsxNjQsNyBAQCBpbnQgYXZjX2dldF9oYXNoX3N0YXRzKGNoYXIgKnBhZ2UpDQog
DQogCXJjdV9yZWFkX3VubG9jaygpOw0KIA0KLQlyZXR1cm4gc2NucHJpbnRmKHBhZ2UsIFBBR0Vf
U0laRSwgImVudHJpZXM6ICVkXG5idWNrZXRzIHVzZWQ6ICVkLyVkXG4iDQorCXJldHVybiBzeXNm
c19lbWl0KHBhZ2UsICJlbnRyaWVzOiAlZFxuYnVja2V0cyB1c2VkOiAlZC8lZFxuIg0KIAkJCSAi
bG9uZ2VzdCBjaGFpbjogJWRcbiIsDQogCQkJIGF0b21pY19yZWFkKCZzZWxpbnV4X2F2Yy5hdmNf
Y2FjaGUuYWN0aXZlX25vZGVzKSwNCiAJCQkgc2xvdHNfdXNlZCwgQVZDX0NBQ0hFX1NMT1RTLCBt
YXhfY2hhaW5fbGVuKTsNCi0tIA0KMi4yNS4x


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTogQXJp
YWwsIEhlbHZldGljYSwgJnF1b3Q7TWljcm9zb2Z0IFlhaGVpJnF1b3Q7LCBzYW5zLXNlcmlmOyBi
YWNrZ3JvdW5kLWNvbG9yOiByZ2IoMjU1LCAyNTUsIDI1NSk7Ij5Gcm9tOiBYaWVMdWRhbiAmbHQ7
eGllLmx1ZGFuQHp0ZS5jb20uY24mZ3Q7PC9zcGFuPjwvcD48cD48YnI+PC9wPjxwPkZvbGxvdyB0
aGUgYWR2aWNlIGluIERvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvc3lzZnMucnN0OjwvcD48cD5z
aG93KCkgc2hvdWxkIG9ubHkgdXNlIHN5c2ZzX2VtaXQoKSBvciBzeXNmc19lbWl0X2F0KCkgd2hl
biBmb3JtYXR0aW5nPC9wPjxwPnRoZSB2YWx1ZSB0byBiZSByZXR1cm5lZCB0byB1c2VyIHNwYWNl
LjwvcD48cD48YnI+PC9wPjxwPlNpZ25lZC1vZmYtYnk6IFhpZUx1ZGFuICZsdDt4aWUubHVkYW5A
enRlLmNvbS5jbiZndDs8L3A+PHA+LS0tPC9wPjxwPiZuYnNwO3NlY3VyaXR5L3NlbGludXgvYXZj
LmMgfCAyICstPC9wPjxwPiZuYnNwOzEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKTwvcD48cD48YnI+PC9wPjxwPmRpZmYgLS1naXQgYS9zZWN1cml0eS9zZWxpbnV4
L2F2Yy5jIGIvc2VjdXJpdHkvc2VsaW51eC9hdmMuYzwvcD48cD5pbmRleCA0YjQ4MzdhMjAyMjUu
LjAwN2JkOTQ5NzVjMCAxMDA2NDQ8L3A+PHA+LS0tIGEvc2VjdXJpdHkvc2VsaW51eC9hdmMuYzwv
cD48cD4rKysgYi9zZWN1cml0eS9zZWxpbnV4L2F2Yy5jPC9wPjxwPkBAIC0xNjQsNyArMTY0LDcg
QEAgaW50IGF2Y19nZXRfaGFzaF9zdGF0cyhjaGFyICpwYWdlKTwvcD48cD4mbmJzcDs8L3A+PHA+
Jm5ic3A7PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yY3VfcmVhZF91bmxv
Y2soKTs8L3A+PHA+Jm5ic3A7PC9wPjxwPi08c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPnJldHVybiBzY25wcmludGYocGFnZSwgUEFHRV9TSVpFLCAiZW50cmllczogJWRcbmJ1
Y2tldHMgdXNlZDogJWQvJWRcbiI8L3A+PHA+KzxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+cmV0dXJuIHN5c2ZzX2VtaXQocGFnZSwgImVudHJpZXM6ICVkXG5idWNrZXRzIHVz
ZWQ6ICVkLyVkXG4iPC9wPjxwPiZuYnNwOzxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgkJ
CTwvc3Bhbj4gImxvbmdlc3QgY2hhaW46ICVkXG4iLDwvcD48cD4mbmJzcDs8c3BhbiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JCQk8L3NwYW4+IGF0b21pY19yZWFkKCZhbXA7c2VsaW51eF9hdmMu
YXZjX2NhY2hlLmFjdGl2ZV9ub2RlcyksPC9wPjxwPiZuYnNwOzxzcGFuIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgkJCTwvc3Bhbj4gc2xvdHNfdXNlZCwgQVZDX0NBQ0hFX1NMT1RTLCBtYXhfY2hh
aW5fbGVuKTs8L3A+PHA+LS0mbmJzcDs8L3A+PHA+Mi4yNS4xPC9wPjxwIHN0eWxlPSJmb250LXNp
emU6MTRweDtmb250LWZhbWlseTrlvq7ova/pm4Xpu5EsTWljcm9zb2Z0IFlhSGVpOyI+PGJyPjwv
cD48cCBzdHlsZT0iZm9udC1zaXplOjE0cHg7Zm9udC1mYW1pbHk65b6u6L2v6ZuF6buRLE1pY3Jv
c29mdCBZYUhlaTsiPjxicj48L3A+PHAgc3R5bGU9ImZvbnQtc2l6ZToxNHB4O2ZvbnQtZmFtaWx5
OuW+rui9r+mbhem7kSxNaWNyb3NvZnQgWWFIZWk7Ij48YnI+PC9wPjxwIHN0eWxlPSJmb250LXNp
emU6MTRweDtmb250LWZhbWlseTrlvq7ova/pm4Xpu5EsTWljcm9zb2Z0IFlhSGVpOyI+PGJyPjwv
cD48L2Rpdj4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

