Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9B8LUWt008599
	for <selinux@tycho.nsa.gov>; Sat, 11 Oct 2003 04:21:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9B8LTUb010201
	for <selinux@tycho.nsa.gov>; Sat, 11 Oct 2003 08:21:29 GMT
Received: from nsa.hitachi-sk.co.jp (nsa.hitachi-sk.co.jp [202.232.217.2])
        by jazzband.ncsc.mil  with ESMTP id h9B8LRhX010198 for <selinux@tycho.nsa.gov>; Sat, 11 Oct 2003 08:21:28 GMT
Date: Sat, 11 Oct 2003 17:19:50 +0900
From: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
To: selinux@tycho.nsa.gov
Cc: ynakam@ori.hitachi-sk.co.jp, russell@coker.com.au
Subject: newrules.pl's -l option patch (Was: Re: newrules.pl -o option)
Message-Id: <20031011171950.7f8bfa33.ynakam@ori.hitachi-sk.co.jp>
In-Reply-To: <20031010190749.51bbd908.ynakam@ori.hitachi-sk.co.jp>
References: <200310090124.AA01358@ilios104.ori.hitachi-sk.co.jp>
	<1065723279.53567.0.camel@vorpal.mcs.drexel.edu>
	<20031010090846.5bdaf336.ynakam@ori.hitachi-sk.co.jp>
	<200310101641.00039.russell@coker.com.au>
	<20031010190749.51bbd908.ynakam@ori.hitachi-sk.co.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__11_Oct_2003_17_19_50_+0900_LWThFltPsL_Wrlui"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Multipart=_Sat__11_Oct_2003_17_19_50_+0900_LWThFltPsL_Wrlui
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Oct 2003 19:07:49 +0900
Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp> wrote:
> I have fixed it. Temporary file has been removed.
> This is a new patch. 

The previous version had bug when input is stdin.
Russell found it and fixed. I would like to thank him.
This is a fixed version of -l option patch.
Please merge this.

---------
Yuichi Nakamura


--Multipart=_Sat__11_Oct_2003_17_19_50_+0900_LWThFltPsL_Wrlui
Content-Type: application/octet-stream;
 name="newrules.pl.patch"
Content-Disposition: attachment;
 filename="newrules.pl.patch"
Content-Transfer-Encoding: base64

LS0tIG5ld3J1bGVzLnBsCTIwMDMtMDktMTUgMjM6MDM6NTguMDAwMDAwMDAwICswOTAwCisrKyAv
aG9tZS95bmFrYW0vbmV3cnVsZXMucGwJMjAwMy0xMC0xMSAxNTo0NjowNy4wMDAwMDAwMDAgKzA5
MDAKQEAgLTE3LDEzICsxNywxNyBAQAogIyAgICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYg
bm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQogIyAgICBGb3VuZGF0aW9uLCBJbmMuLCA1
OSBUZW1wbGUgUGxhY2UsIFN1aXRlIDMzMCwgQm9zdG9uLCBNQSAgICAgCiAjICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAyMTExLTEzMDcgIFVTQQorIyAgICAyMDAzIE9j
dCAxMTogQWRkIC1sIG9wdGlvbiBieSBZdWljaGkgTmFrYW11cmEoeW5ha2FtQHVzZXJzLnNvdXJj
ZWZvcmdlLmpwKQogCiAKKyRsb2FkX3BvbGljeV9wYXR0ZXJuPSJhdmM6LipncmFudGVkLip7Lips
b2FkX3BvbGljeS4qfSI7CisKIHdoaWxlICgkb3B0ID0gc2hpZnQgQEFSR1YpIHsKICAgICAgICAg
aWYgKCRvcHQgZXEgIi1kIikgeyAkcmVhZF9kbWVzZysrOyB9CiAgICAgICAgIGVsc2lmICgkb3B0
IGVxICItdiIpIHsgJHZlcmJvc2UrKzsgfQogICAgICAgICBlbHNpZiAoJG9wdCBlcSAiLWkiKSB7
ICRpbnB1dCA9IHNoaWZ0IEBBUkdWOyB9CiAgICAgICAgIGVsc2lmICgkb3B0IGVxICItbyIpIHsg
JG91dHB1dD0gc2hpZnQgQEFSR1Y7IH0KKwllbHNpZiAoJG9wdCBlcSAiLWwiKSB7ICRsb2FkX3Bv
bGljeSsrOyB9CiAJZWxzaWYgKCRvcHQgZXEgIi0taGVscCIpIHsgJnByaW50VXNhZ2U7IH0KIAkJ
ZWxzZSAgeyBwcmludCAidW5rbm93biBvcHRpb24sICckb3B0J1xuXG4iOyAmcHJpbnRVc2FnZTsg
fQogfQpAQCAtMzcsMTEgKzQxLDIzIEBACiBlbHNpZiAoJGlucHV0KSAgIHsgb3BlbiAoSU4sICIk
aW5wdXQiKTsgICAgICB9CiBlbHNlICAgICAgICAgICAgIHsgb3BlbiAoSU4sICItIik7ICAgICAg
ICAgICB9ICAjIFNURElOCiAKLWlmICgkb3V0cHV0KSAgICAgeyBvcGVuIChPVVQsICI+JG91dHB1
dCIpOyAgIH0KK2lmICgkb3V0cHV0KSAgICAgeyBvcGVuIChPVVQsICI+PiRvdXRwdXQiKTsgICB9
CiBlbHNlICAgICAgICAgICAgIHsgb3BlbiAoT1VULCAiPi0iKTsgICAgICAgICB9ICAjIFNURE9V
VAogCitpZigkbG9hZF9wb2xpY3kpeyAjc3RvcmUgbG9ncyBhZnRlciBsYXN0ICJsb2FkX3BvbGlj
eSIgaW4gQGxvZ19idWYKKyAgICB3aGlsZSAoJGxpbmUgPSA8SU4+KSB7CisJaWYoJGxpbmU9fi8k
bG9hZF9wb2xpY3lfcGF0dGVybi8pIHsKKwkgICAgICNzdG9yZWQgbG9ncyBhcmUgdW5uZWNlc3Nh
cnkKKwkgICAgIHVuZGVmIEBsb2dfYnVmOworCX0KKwllbHNlCisJeworCSAgICBwdXNoIEBsb2df
YnVmLCRsaW5lOworCX0KKyAgICB9Cit9CiAKLXdoaWxlICgkbGluZSA9IDxJTj4pIHsKK3doaWxl
ICgkbGluZT0mcmVhZE5ld2xpbmUpIHsKICAgICBuZXh0IHVubGVzcyAoJGxpbmUgPX4gbS9hdmM6
XHMqZGVuaWVkXHMqXHsoKFx3fFxzKSopXH0vKTsKICAgICBAdHlwZXM9c3BsaXQgL1wgLywkbGlu
ZTsKICAgICAkaW5mbz0iIjsKQEAgLTEyMSwxMSArMTM3LDIyIEBACiAKIGV4aXQ7CiAKK3N1YiBy
ZWFkTmV3bGluZSB7CisgICAgaWYoJGxvYWRfcG9saWN5KXsKKwkkbmV3bGluZT1zaGlmdCBAbG9n
X2J1ZjsKKyAgICB9ZWxzZXsKKwkkbmV3bGluZT08SU4+OworICAgIH0KKyAgICByZXR1cm4gJG5l
d2xpbmU7Cit9CisKIHN1YiBwcmludFVzYWdlIHsKLQlwcmludCAibmV3cnVsZXMgWy1kXSBbLXZd
IFstaSA8aW5wdXRmaWxlPiBdIFstbyA8b3V0cHV0ZmlsZT5dCisJcHJpbnQgIm5ld3J1bGVzIFst
ZF0gWy12XSBbLWxdIFstaSA8aW5wdXRmaWxlPiBdIFstbyA8b3V0cHV0ZmlsZT5dCiAgICAgICAg
IC1kICAgICAgcmVhZCBpbnB1dCBmcm9tIG91dHB1dCBvZiAvYmluL2RtZXNnCiAgICAgICAgIC12
ICAgICAgdmVyYm9zZSBvdXRwdXQKKyAgICAgICAgLWwgICAgICByZWFkIGlucHV0IG9ubHkgYWZ0
ZXIgbGFzdCBcImxvYWRfcG9saWN5XCIKICAgICAgICAgLWkgICAgICByZWFkIGlucHV0IGZyb20g
PGlucHV0ZmlsZT4KICAgICAgICAgLW8gICAgICBhcHBlbmQgb3V0cHV0IHRvIDxvdXRwdXRmaWxl
PlxuIjsKIAlleGl0OwogfQorCg==

--Multipart=_Sat__11_Oct_2003_17_19_50_+0900_LWThFltPsL_Wrlui--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
