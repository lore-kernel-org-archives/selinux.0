Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9AA9tWt001859
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 06:09:55 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9AA9sUb028363
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 10:09:54 GMT
Received: from nsa.hitachi-sk.co.jp (nsa.hitachi-sk.co.jp [202.232.217.2])
        by jazzband.ncsc.mil  with ESMTP id h9AA9qhX028359 for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 10:09:53 GMT
Date: Fri, 10 Oct 2003 19:07:49 +0900
From: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
To: russell@coker.com.au
Cc: ynakam@ori.hitachi-sk.co.jp, selinux@tycho.nsa.gov
Subject: Re: newrules.pl -o option
Message-Id: <20031010190749.51bbd908.ynakam@ori.hitachi-sk.co.jp>
In-Reply-To: <200310101641.00039.russell@coker.com.au>
References: <200310090124.AA01358@ilios104.ori.hitachi-sk.co.jp>
	<1065723279.53567.0.camel@vorpal.mcs.drexel.edu>
	<20031010090846.5bdaf336.ynakam@ori.hitachi-sk.co.jp>
	<200310101641.00039.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__10_Oct_2003_19:07:49_+0900_082ee9b0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Multipart_Fri__10_Oct_2003_19:07:49_+0900_082ee9b0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Oct 2003 16:41:00 +1000
Russell Coker <russell@coker.com.au> wrote:
> On Fri, 10 Oct 2003 10:08, Yuichi Nakamura wrote:
> > I added new option "-l" to newrules.pl.
> This new option is a great feature and will save a lot of people a lot of 
> time.
> However there is one minor problem, you use a fixed name for a temporary file 
> under /tmp, which is a bad idea for several reasons.
> Please make a new version which does not use a temporary file (sorting through 
> it in an array should be easy enough) and I will gladly merge it.

Thank you for your interest.
I have fixed it. Temporary file has been removed.
This is a new patch. 

-----------
Yuichi Nakamura

--Multipart_Fri__10_Oct_2003_19:07:49_+0900_082ee9b0
Content-Type: application/octet-stream;
 name="newrules.pl.patch"
Content-Disposition: attachment;
 filename="newrules.pl.patch"
Content-Transfer-Encoding: base64

LS0tIHNlbGludXhfMTAwMS9zZWxpbnV4LXVzci9wb2xpY3kvbmV3cnVsZXMucGwJMjAwMy0wOS0x
NSAyMzowMzo1OC4wMDAwMDAwMDAgKzA5MDAKKysrIG5ld3J1bGVzLnBsCTIwMDMtMTAtMTAgMTc6
Mjg6MzguMDAwMDAwMDAwICswOTAwCkBAIC0xNywxMyArMTcsMTcgQEAKICMgICAgYWxvbmcgd2l0
aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUKICMgICAg
Rm91bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEg
ICAgIAogIyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwMjExMS0xMzA3
ICBVU0EKKyMgICAgMjAwMyBPY3QgMTE6IEFkZCAtbCBvcHRpb24gYnkgWXVpY2hpIE5ha2FtdXJh
KHluYWthbUB1c2Vycy5zb3VyY2Vmb3JnZS5qcCkKIAogCiskbG9hZF9wb2xpY3lfcGF0dGVybj0i
YXZjOi4qZ3JhbnRlZC4qey4qbG9hZF9wb2xpY3kuKn0iOworCiB3aGlsZSAoJG9wdCA9IHNoaWZ0
IEBBUkdWKSB7CiAgICAgICAgIGlmICgkb3B0IGVxICItZCIpIHsgJHJlYWRfZG1lc2crKzsgfQog
ICAgICAgICBlbHNpZiAoJG9wdCBlcSAiLXYiKSB7ICR2ZXJib3NlKys7IH0KICAgICAgICAgZWxz
aWYgKCRvcHQgZXEgIi1pIikgeyAkaW5wdXQgPSBzaGlmdCBAQVJHVjsgfQogICAgICAgICBlbHNp
ZiAoJG9wdCBlcSAiLW8iKSB7ICRvdXRwdXQ9IHNoaWZ0IEBBUkdWOyB9CisJZWxzaWYgKCRvcHQg
ZXEgIi1sIikgeyAkbG9hZF9wb2xpY3krKzsgfQogCWVsc2lmICgkb3B0IGVxICItLWhlbHAiKSB7
ICZwcmludFVzYWdlOyB9CiAJCWVsc2UgIHsgcHJpbnQgInVua25vd24gb3B0aW9uLCAnJG9wdCdc
blxuIjsgJnByaW50VXNhZ2U7IH0KIH0KQEAgLTM3LDExICs0MSwzMSBAQAogZWxzaWYgKCRpbnB1
dCkgICB7IG9wZW4gKElOLCAiJGlucHV0Iik7ICAgICAgfQogZWxzZSAgICAgICAgICAgICB7IG9w
ZW4gKElOLCAiLSIpOyAgICAgICAgICAgfSAgIyBTVERJTgogCi1pZiAoJG91dHB1dCkgICAgIHsg
b3BlbiAoT1VULCAiPiRvdXRwdXQiKTsgICB9CitpZiAoJG91dHB1dCkgICAgIHsgb3BlbiAoT1VU
LCAiPj4kb3V0cHV0Iik7ICAgfQogZWxzZSAgICAgICAgICAgICB7IG9wZW4gKE9VVCwgIj4tIik7
ICAgICAgICAgfSAgIyBTVERPVVQKIAoraWYoJGxvYWRfcG9saWN5KXsgI2ZpbmQgdGhlIGxpbmVu
dW0gb2YgbGFzdCAibG9hZF9wb2xpY3kiCisgICAgJGxpbmVfbnVtPTA7CisgICAgd2hpbGUgKCRs
aW5lID0gPElOPikgeworCSRsaW5lX251bSsrOworCWlmKCRsaW5lPX4vJGxvYWRfcG9saWN5X3Bh
dHRlcm4vKSB7CisJICAgICAkbGFzdF9sb2FkPSRsaW5lX251bTsKKwl9CisJaWYoJHJlYWRfZG1l
c2cpIHsKKwkgICAgcHVzaCBAZG1lc2dfYnVmLCRsaW5lOworCX0KKyAgICB9CisgICAgc2VlayhJ
TiwwLDApOworfQogCi13aGlsZSAoJGxpbmUgPSA8SU4+KSB7CiskbGluZV9udW09MDsKK3doaWxl
ICgkbGluZT0mcmVhZE5ld2xpbmUpIHsKKyAgICBpZigkbG9hZF9wb2xpY3kpeworCSRsaW5lX251
bSsrOworCWlmKCRsaW5lX251bTwkbGFzdF9sb2FkKXsKKwkgICAgbmV4dDsKKwl9CisgICAgfQog
ICAgIG5leHQgdW5sZXNzICgkbGluZSA9fiBtL2F2YzpccypkZW5pZWRccypceygoXHd8XHMpKilc
fS8pOwogICAgIEB0eXBlcz1zcGxpdCAvXCAvLCRsaW5lOwogICAgICRpbmZvPSIiOwpAQCAtMTIx
LDEwICsxNDUsMjAgQEAKIAogZXhpdDsKIAorc3ViIHJlYWROZXdsaW5lIHsKKyAgICBpZigkcmVh
ZF9kbWVzZyYmJGxvYWRfcG9saWN5KXsKKwkkbmV3bGluZT1zaGlmdCBAZG1lc2dfYnVmOworICAg
IH1lbHNleworCSRuZXdsaW5lPTxJTj47CisgICAgfQorICAgIHJldHVybiAkbmV3bGluZTsKK30K
Kwogc3ViIHByaW50VXNhZ2UgewotCXByaW50ICJuZXdydWxlcyBbLWRdIFstdl0gWy1pIDxpbnB1
dGZpbGU+IF0gWy1vIDxvdXRwdXRmaWxlPl0KKwlwcmludCAibmV3cnVsZXMgWy1kXSBbLXZdIFst
bF0gWy1pIDxpbnB1dGZpbGU+IF0gWy1vIDxvdXRwdXRmaWxlPl0KICAgICAgICAgLWQgICAgICBy
ZWFkIGlucHV0IGZyb20gb3V0cHV0IG9mIC9iaW4vZG1lc2cKICAgICAgICAgLXYgICAgICB2ZXJi
b3NlIG91dHB1dAorICAgICAgICAtbCAgICAgIHJlYWQgaW5wdXQgb25seSBhZnRlciBsYXN0IFwi
bG9hZF9wb2xpY3lcIgogICAgICAgICAtaSAgICAgIHJlYWQgaW5wdXQgZnJvbSA8aW5wdXRmaWxl
PgogICAgICAgICAtbyAgICAgIGFwcGVuZCBvdXRwdXQgdG8gPG91dHB1dGZpbGU+XG4iOwogCWV4
aXQ7Cg==

--Multipart_Fri__10_Oct_2003_19:07:49_+0900_082ee9b0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
