Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA08338
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2001 12:08:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA29279
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2001 16:06:45 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA29275
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2001 16:06:45 GMT
Date: Fri, 24 Aug 2001 12:07:47 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: Selinux lsm and Free Swan
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A1015241C4@csoc-mail-box.csoconline.com>
Message-ID: <Pine.SOL.3.95.1010824112248.1386C-300000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-684387517-998669267=:1386"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-684387517-998669267=:1386
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Fri, 24 Aug 2001, Westerman, Mark wrote:

> Well I have downloaded the new version and I am Trying to intergrate
> freeswan-1.91 into the kernel.
>
> selinux_sock_rcv_skb no net device

We haven't tried integrating FreeSWAN with LSM/SELinux yet, so
I'm not sure what precisely is happening here.  Try applying
the first attached patch to lsm/net/ipv4/tcp_ipv4.c and see
if you still have the same problem.  The first patch reverses the
order in which the sock_rcv_skb LSM hook and the ipsec_sk_policy
function are called).  If that doesn't help, then reverse that
patch and apply the second attached patch to 
selinux/module/selinux_plug/hooks.c.  The second patch simply
changes selinux_sock_rcv_skb to return success even when
the skb->dev is NULL, so it may cause a bypass of some of
the SELinux network access controls.  Let us know how
things work out.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com










---559023410-684387517-998669267=:1386
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="tcp_ipv4.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.3.95.1010824120747.1386E@clipper.gw.tislabs.com>
Content-Description: tcp_ipv4.patch

SW5kZXg6IG5ldC9pcHY0L3RjcF9pcHY0LmMNCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NClJDUyBmaWxlOiAvY3ZzL2xzbS9sc20vbmV0L2lwdjQvdGNwX2lw
djQuYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMg0KZGlmZiAtdSAtcjEu
MiB0Y3BfaXB2NC5jDQotLS0gbmV0L2lwdjQvdGNwX2lwdjQuYwkyMDAxLzA4
LzA5IDE1OjEzOjM3CTEuMg0KKysrIG5ldC9pcHY0L3RjcF9pcHY0LmMJMjAw
MS8wOC8yNCAxNTo1MzozNw0KQEAgLTE2MzUsMTAgKzE2MzUsMTAgQEANCiAJ
CWdvdG8gbm9fdGNwX3NvY2tldDsNCiANCiBwcm9jZXNzOg0KLQlpZighaXBz
ZWNfc2tfcG9saWN5KHNrLHNrYikpDQorCWlmIChzZWN1cml0eV9vcHMtPnNv
Y2tldF9vcHMtPnNvY2tfcmN2X3NrYihzaywgc2tiKSkNCiAJCWdvdG8gZGlz
Y2FyZF9hbmRfcmVsc2U7DQogDQotCWlmIChzZWN1cml0eV9vcHMtPnNvY2tl
dF9vcHMtPnNvY2tfcmN2X3NrYihzaywgc2tiKSkNCisJaWYoIWlwc2VjX3Nr
X3BvbGljeShzayxza2IpKQ0KIAkJZ290byBkaXNjYXJkX2FuZF9yZWxzZTsN
CiANCiAJaWYgKHNrLT5zdGF0ZSA9PSBUQ1BfVElNRV9XQUlUKQ0K
---559023410-684387517-998669267=:1386
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="hooks.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.3.95.1010824120747.1386F@clipper.gw.tislabs.com>
Content-Description: hooks.patch

SW5kZXg6IG1vZHVsZS9zZWxpbnV4X3BsdWcvaG9va3MuYw0KPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQ0KUkNTIGZpbGU6IC9jdnMvbHNtL3NlbGludXgvbW9k
dWxlL3NlbGludXhfcGx1Zy9ob29rcy5jLHYNCnJldHJpZXZpbmcgcmV2aXNp
b24gMS4xMDgNCmRpZmYgLXUgLXIxLjEwOCBob29rcy5jDQotLS0gbW9kdWxl
L3NlbGludXhfcGx1Zy9ob29rcy5jCTIwMDEvMDgvMjIgMTk6MjQ6MDgJMS4x
MDgNCisrKyBtb2R1bGUvc2VsaW51eF9wbHVnL2hvb2tzLmMJMjAwMS8wOC8y
NCAxNTo0MjozMw0KQEAgLTMxNTgsOCArMzE1OCw3IEBADQogDQogCWRldiA9
IHNrYi0+ZGV2Ow0KIAlpZiAoIWRldikgew0KLQkJcHJpbnRrKCJzZWxpbnV4
X3NvY2tfcmN2X3NrYjogIG5vIG5ldCBkZXZpY2UhXG4iKTsNCi0JCXJldHVy
biAtRUFDQ0VTOw0KKwkJcmV0dXJuIDA7DQogCX0NCiAJZXJyID0gbmV0ZGV2
X3ByZWNvbmRpdGlvbihkZXYpOw0KIAlpZiAoZXJyIDw9IDApIA0K
---559023410-684387517-998669267=:1386--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
