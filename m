Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9A0AOWt029922
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 20:10:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9A0ANUb015517
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 00:10:23 GMT
Received: from nsa.hitachi-sk.co.jp (nsa.hitachi-sk.co.jp [202.232.217.2])
        by jazzband.ncsc.mil  with ESMTP id h9A0ALhX015507 for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 00:10:22 GMT
Date: Fri, 10 Oct 2003 09:08:46 +0900
From: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
To: Justin Smith <jsmith@drexel.edu>
Cc: ynakam@ori.hitachi-sk.co.jp, selinux@tycho.nsa.gov
Subject: Re: newrules.pl -o option
Message-Id: <20031010090846.5bdaf336.ynakam@ori.hitachi-sk.co.jp>
In-Reply-To: <1065723279.53567.0.camel@vorpal.mcs.drexel.edu>
References: <200310090124.AA01358@ilios104.ori.hitachi-sk.co.jp>
	<1065723279.53567.0.camel@vorpal.mcs.drexel.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__10_Oct_2003_09:08:46_+0900_082c2e20"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Multipart_Fri__10_Oct_2003_09:08:46_+0900_082c2e20
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 09 Oct 2003 14:14:40 -0400
Justin Smith <jsmith@drexel.edu> wrote:
> On Wed, 2003-10-08 at 21:24, Yuichi Nakamura wrote:
> > The usage of newrules.pl 's -o option is "-o  append output to <outputfile>".
> > "-o" means "append", but <outputfile> is overwritten.
> > Is the following patch correct ? 
....
> It looks good to me.

Thank you.
I'm also writing patch for newrules.pl.
Now, newrules.pl reads all input logs.
However, sometimes it is not convenient.
For example,
after we add new policies by newrules.pl and "load_policy" command,
the logs before using load_policy command may not be necessary.

I added new option "-l" to newrules.pl.
By "-l" option,logs only after last apperence of "load_policy"(avc:.*granted.*{.*load_policy.*}) are inputted.
The new option is very convenient for me.
Please consider applying this patch.

-----------
Yuichi Nakamura

--Multipart_Fri__10_Oct_2003_09:08:46_+0900_082c2e20
Content-Type: application/octet-stream;
 name="newrules.pl.patch"
Content-Disposition: attachment;
 filename="newrules.pl.patch"
Content-Transfer-Encoding: base64

LS0tIHNlbGludXhfMTAwMS9zZWxpbnV4LXVzci9wb2xpY3kvbmV3cnVsZXMucGwJMjAwMy0wOS0x
NSAyMzowMzo1OC4wMDAwMDAwMDAgKzA5MDAKKysrIG5ld3J1bGVzLnBsCTIwMDMtMTAtMTAgMDg6
Mzg6MDEuMDAwMDAwMDAwICswOTAwCkBAIC0xNywxMyArMTcsMTkgQEAKICMgICAgYWxvbmcgd2l0
aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUKICMgICAg
Rm91bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEg
ICAgIAogIyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwMjExMS0xMzA3
ICBVU0EKKyMgICAgMjAwMyBTZXAgMzA6IEFkZCAtbCBvcHRpb24gYnkgWXVpY2hpIE5ha2FtdXJh
KHluYWthbUB1c2Vycy5zb3VyY2Vmb3JnZS5qcCkKIAogCisKKyRsb2FkX3BvbGljeV9wYXR0ZXJu
PSJhdmM6LipncmFudGVkLip7Lipsb2FkX3BvbGljeS4qfSI7CiskdG1wZmlsZT0iL3RtcC9uZXdy
dWxlcy50bXAiOworCiB3aGlsZSAoJG9wdCA9IHNoaWZ0IEBBUkdWKSB7CiAgICAgICAgIGlmICgk
b3B0IGVxICItZCIpIHsgJHJlYWRfZG1lc2crKzsgfQogICAgICAgICBlbHNpZiAoJG9wdCBlcSAi
LXYiKSB7ICR2ZXJib3NlKys7IH0KICAgICAgICAgZWxzaWYgKCRvcHQgZXEgIi1pIikgeyAkaW5w
dXQgPSBzaGlmdCBAQVJHVjsgfQogICAgICAgICBlbHNpZiAoJG9wdCBlcSAiLW8iKSB7ICRvdXRw
dXQ9IHNoaWZ0IEBBUkdWOyB9CisJZWxzaWYgKCRvcHQgZXEgIi1sIikgeyAkbG9hZF9wb2xpY3kr
KzsgIH0KIAllbHNpZiAoJG9wdCBlcSAiLS1oZWxwIikgeyAmcHJpbnRVc2FnZTsgfQogCQllbHNl
ICB7IHByaW50ICJ1bmtub3duIG9wdGlvbiwgJyRvcHQnXG5cbiI7ICZwcmludFVzYWdlOyB9CiB9
CkBAIC0zNywxMSArNDMsMzcgQEAKIGVsc2lmICgkaW5wdXQpICAgeyBvcGVuIChJTiwgIiRpbnB1
dCIpOyAgICAgIH0KIGVsc2UgICAgICAgICAgICAgeyBvcGVuIChJTiwgIi0iKTsgICAgICAgICAg
IH0gICMgU1RESU4KIAotaWYgKCRvdXRwdXQpICAgICB7IG9wZW4gKE9VVCwgIj4kb3V0cHV0Iik7
ICAgfQoraWYgKCRvdXRwdXQpICAgICB7IG9wZW4gKE9VVCwgIj4+JG91dHB1dCIpOyAgIH0KIGVs
c2UgICAgICAgICAgICAgeyBvcGVuIChPVVQsICI+LSIpOyAgICAgICAgIH0gICMgU1RET1VUCiAK
K2lmKCRsb2FkX3BvbGljeSl7ICNmaW5kIHRoZSBsaW5lbnVtIG9mIGxhc3QgImxvYWRfcG9saWN5
IgorICAgIGlmKCRyZWFkX2RtZXNnKXsKKwlvcGVuKFRNUCwiPiR0bXBmaWxlIik7CisgICAgfQor
ICAgICRsaW5lX251bT0wOworICAgIHdoaWxlICgkbGluZSA9IDxJTj4pIHsKKwkkbGluZV9udW0r
KzsKKwlpZigkbGluZT1+LyRsb2FkX3BvbGljeV9wYXR0ZXJuLyl7CisJICAgICAkbGFzdF9sb2Fk
PSRsaW5lX251bTsKKwl9CisJcHJpbnQgVE1QICRsaW5lOworICAgIH0KKyAgICBpZigkcmVhZF9k
bWVzZyl7CisJY2xvc2UoVE1QKTsKKwljbG9zZShJTik7CisJb3BlbihJTiwkdG1wZmlsZSk7Cisg
ICAgfQorICAgIHNlZWsoSU4sMCwwKTsKK30KIAorJGxpbmVfbnVtPTA7CiB3aGlsZSAoJGxpbmUg
PSA8SU4+KSB7CisgICAgaWYoJGxvYWRfcG9saWN5KXsKKwkkbGluZV9udW0rKzsKKwlpZigkbGlu
ZV9udW08JGxhc3RfbG9hZCl7CisJICAgIG5leHQ7CisJfQorICAgIH0KICAgICBuZXh0IHVubGVz
cyAoJGxpbmUgPX4gbS9hdmM6XHMqZGVuaWVkXHMqXHsoKFx3fFxzKSopXH0vKTsKICAgICBAdHlw
ZXM9c3BsaXQgL1wgLywkbGluZTsKICAgICAkaW5mbz0iIjsKQEAgLTExOSwxMyArMTUxLDE5IEBA
CiAgICAgcHJpbnQgT1VUICIkb2NjdXJ7JGt9XG4iIGlmICgkdmVyYm9zZSk7CiB9CiAKK2lmKCAt
ZSAkdG1wZmlsZSl7CisgICAgdW5saW5rKCR0bXBmaWxlKTsKK30KKwogZXhpdDsKIAogc3ViIHBy
aW50VXNhZ2UgewogCXByaW50ICJuZXdydWxlcyBbLWRdIFstdl0gWy1pIDxpbnB1dGZpbGU+IF0g
Wy1vIDxvdXRwdXRmaWxlPl0KICAgICAgICAgLWQgICAgICByZWFkIGlucHV0IGZyb20gb3V0cHV0
IG9mIC9iaW4vZG1lc2cKICAgICAgICAgLXYgICAgICB2ZXJib3NlIG91dHB1dAorICAgICAgICAt
bCAgICAgIHJlYWQgaW5wdXQgb25seSBhZnRlciBsYXN0IFwibG9hZF9wb2xpY3lcIgogICAgICAg
ICAtaSAgICAgIHJlYWQgaW5wdXQgZnJvbSA8aW5wdXRmaWxlPgogICAgICAgICAtbyAgICAgIGFw
cGVuZCBvdXRwdXQgdG8gPG91dHB1dGZpbGU+XG4iOwogCWV4aXQ7CiB9CisK

--Multipart_Fri__10_Oct_2003_09:08:46_+0900_082c2e20--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
