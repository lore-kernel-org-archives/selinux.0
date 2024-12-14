Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB2613AA2A
	for <selinux@vger.kernel.org>; Sat, 14 Dec 2024 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734210509; cv=none; b=fYy9hJuS++HKkAdZ32K3HGRkVbR01OUQOt0wvd1+fTgI0zDBzTgn8wRRhUppJkHixGwQCjVfYxWbeG7hdQ04sJ/R2RHNmQjAcN6OeqSH9vwp5CbWHOsCFyjLVUgOHdifONa8PwnMthkzP5mcR9OVZPmTomKWosvB7OnxwO9T3+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734210509; c=relaxed/simple;
	bh=pSasa4Z/EMgBx2yj8XWroJ8IbqLfmTemT58gWOYUjEk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ZmVv9yQJl42ph5d1OLdZufKN8CWYI71TJtNb35dtlP/fLGW5TYejvxkF4i497692RNWLRTsD9ovG/j9tQ1MTIdqGVVOwN+Iviq2nIW33KsN8lQdR2Dg5YisfqH7my3AZi2ovwkcr8/C+MkNRgnEDh4nfBNdMRjRmTql6JLOlK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-73-oSBGEs7GN0yjU65DchMHVg-1; Sat, 14 Dec 2024 21:08:18 +0000
X-MC-Unique: oSBGEs7GN0yjU65DchMHVg-1
X-Mimecast-MFC-AGG-ID: oSBGEs7GN0yjU65DchMHVg
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 14 Dec
 2024 21:07:20 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 14 Dec 2024 21:07:20 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Paul Moore' <paul@paul-moore.com>,
	=?utf-8?B?Q2hyaXN0aWFuIEfDtnR0c2NoZQ==?= <cgoettsche@seltendoof.de>, "Linus
 Torvalds" <torvalds@linux-foundation.org>
CC: =?utf-8?B?Q2hyaXN0aWFuIEfDtnR0c2NoZQ==?= <cgzones@googlemail.com>,
	"Stephen Smalley" <stephen.smalley.work@gmail.com>, Ondrej Mosnacek
	<omosnace@redhat.com>, Nathan Chancellor <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, "selinux@vger.kernel.org"
	<selinux@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH] selinux: use native iterator types
Thread-Topic: [PATCH] selinux: use native iterator types
Thread-Index: AQHbTABPeXe5tbZR/Uu2GVc6bedDr7LmQAyg
Date: Sat, 14 Dec 2024 21:07:20 +0000
Message-ID: <f7bfbf89d2ac4b929637bbb25f749c96@AcuMS.aculab.com>
References: <20241125110646.50799-1-cgoettsche@seltendoof.de>
 <e43da8418fc54a5eba7cdbb594b24bb9@paul-moore.com>
In-Reply-To: <e43da8418fc54a5eba7cdbb594b24bb9@paul-moore.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HxA9t6LPSSTqR4g9cdOY7_qNP4XNW2ZTKLG5xkBqif0_1734210497
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogUGF1bCBNb29yZQ0KPiBTZW50OiAxMSBEZWNlbWJlciAyMDI0IDE4OjU0DQo+IA0KPiBP
biBOb3YgMjUsIDIwMjQgPT9VVEYtOD9xP0NocmlzdGlhbj0yMEc9QzM9QjZ0dHNjaGU/PSA8Y2dv
ZXR0c2NoZUBzZWx0ZW5kb29mLmRlPiB3cm90ZToNCj4gPg0KPiA+IFVzZSB0eXBlcyBmb3IgaXRl
cmF0b3JzIGVxdWFsIHRvIHRoZSB0eXBlIG9mIHRoZSB0byBiZSBjb21wYXJlZCB2YWx1ZXMuDQo+
ID4NCj4gPiBSZXBvcnRlZCBieSBjbGFuZzoNCj4gPg0KPiA+ICAgICBzZWN1cml0eS9zZWxpbnV4
L3NzL3NpZHRhYi5jOjEyNjoyOiB3YXJuaW5nOiBjb21wYXJpc29uIG9mIGludGVnZXJzIG9mIGRp
ZmZlcmVudCBzaWduczogJ2ludCcNCj4gYW5kICd1bnNpZ25lZCBsb25nJyBbLVdzaWduLWNvbXBh
cmVdDQo+ID4gICAgICAgMTI2IHwgICAgICAgICBoYXNoX2Zvcl9lYWNoX3JjdShzaWR0YWItPmNv
bnRleHRfdG9fc2lkLCBpLCBlbnRyeSwgbGlzdCkgew0KPiA+ICAgICAgICAgICB8ICAgICAgICAg
Xn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
DQo+ID4gICAgIC4vaW5jbHVkZS9saW51eC9oYXNodGFibGUuaDoxMzk6NTE6IG5vdGU6IGV4cGFu
ZGVkIGZyb20gbWFjcm8gJ2hhc2hfZm9yX2VhY2hfcmN1Jw0KPiA+ICAgICAgIDEzOSB8ICAgICAg
ICAgZm9yICgoYmt0KSA9IDAsIG9iaiA9IE5VTEw7IG9iaiA9PSBOVUxMICYmIChia3QpIDwgSEFT
SF9TSVpFKG5hbWUpO1wNCj4gPiAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfn5+ICBeIH5+fn5+fn5+fn5+fn5+fg0KPiA+DQo+
ID4gICAgIHNlY3VyaXR5L3NlbGludXgvc2VsaW51eGZzLmM6MTUyMDoyMzogd2FybmluZzogY29t
cGFyaXNvbiBvZiBpbnRlZ2VycyBvZiBkaWZmZXJlbnQgc2lnbnM6ICdpbnQnDQo+IGFuZCAndW5z
aWduZWQgaW50JyBbLVdzaWduLWNvbXBhcmVdDQo+ID4gICAgICAxNTIwIHwgICAgICAgICBmb3Ig
KGNwdSA9ICppZHg7IGNwdSA8IG5yX2NwdV9pZHM7ICsrY3B1KSB7DQo+ID4gICAgICAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgIH5+fiBeIH5+fn5+fn5+fn4NCj4gPg0KPiA+ICAgICBz
ZWN1cml0eS9zZWxpbnV4L2hvb2tzLmM6NDEyOjE2OiB3YXJuaW5nOiBjb21wYXJpc29uIG9mIGlu
dGVnZXJzIG9mIGRpZmZlcmVudCBzaWduczogJ2ludCcgYW5kDQo+ICd1bnNpZ25lZCBsb25nJyBb
LVdzaWduLWNvbXBhcmVdDQo+ID4gICAgICAgNDEyIHwgICAgICAgICBmb3IgKGkgPSAwOyBpIDwg
QVJSQVlfU0laRSh0b2tlbnMpOyBpKyspIHsNCj4gPiAgICAgICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgIH4gXiB+fn5+fn5+fn5+fn5+fn5+fn4NCg0KSXNuJ3QgdGhpcyBhbiBleGFtcGxlIG9m
IHdoeSAtV3NpZ24tY29tcGFyZSBpcyBlbnRpcmVseSBzdHVwaWQgYW5kIGlzbid0IGVuYWJsZWQN
CmluIHRoZSBub3JtYWwga2VybmVsIGJ1aWxkPw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

