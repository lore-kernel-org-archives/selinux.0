Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA05128
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 08:50:47 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0MDoaI13139
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 13:50:36 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id h0MDoZf13135 for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 13:50:35 GMT
Date: Wed, 22 Jan 2003 08:49:28 -0500 (EST)
From: Wayne Salamon <wsalamon@tislabs.com>
To: Tom <tom@lemuria.org>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Apache/mysql policy status ?
In-Reply-To: <20030121232022.D24908@lemuria.org>
Message-ID: <Pine.LNX.4.33.0301220841170.23864-200000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="554330684-1371807110-1043243368=:23864"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--554330684-1371807110-1043243368=:23864
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 21 Jan 2003, Tom wrote:

>
>
> Then again, I was just starting on a total rewrite anyway. I have some
> interesting things that I've done for virtual hosting right now, and
> I've always wanted to seperate stuff further (e.g. the CGI and suexec
> rules).
>

  Tom, I've attached a diff file that brings your patch from October up to
date with the current CVS tree. But are you working on a new version of
the apache policy, or should this patch be applied?

  Note that I've added back in the admin TTY rule/comments that were
eliminated after your first patch. Is this access still needed for Apache
2.0?

Thanks,

 --
Wayne Salamon
wsalamon@tislabs.com

--554330684-1371807110-1043243368=:23864
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="apache.te.newdiff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0301220849280.23864@vox.gw.tislabs.com>
Content-Description: 
Content-Disposition: attachment; filename="apache.te.newdiff"

LS0tIGFwYWNoZS50ZS5vcmlnCUZyaSBKYW4gIDMgMTM6Mjg6MjQgMjAwMw0K
KysrIGFwYWNoZS50ZQlXZWQgSmFuIDIyIDA5OjE4OjM0IDIwMDMNCkBAIC01
NSw5ICs1NSw2IEBADQogZG9tYWluX2F1dG9fdHJhbnMoaW5pdHJjX3QsIGh0
dHBkX2V4ZWNfdCwgaHR0cGRfdCkNCiB0eXBlX3RyYW5zaXRpb24gaW5pdF90
IGh0dHBkX2V4ZWNfdDpwcm9jZXNzIGh0dHBkX3Q7DQogDQotIyBmb3IgcGhw
DQotdG1wX2RvbWFpbihodHRwZCkNCi0NCiAjDQogIyBBIHR5cGUgZm9yIGZp
bGVzIGluIC92YXIvcnVuIHNwZWNpZmljIHRvIGh0dHBkDQogIw0KQEAgLTM2
NSw2ICszNjIsMTYgQEANCiBhbGxvdyBodHRwZF90IGh0dHBkX3VzZXJfc2Ny
aXB0X3J3X3Q6ZmlsZSByX2ZpbGVfcGVybXM7DQogYWxsb3cgaHR0cGRfdCBo
dHRwZF91c2VyX3NjcmlwdF9yd190OmRpciByX2Rpcl9wZXJtczsNCiANCisj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQorIyBX
aGVuIHRoZSBhZG1pbiBzdGFydHMgdGhlIHNlcnZlciwgdGhlIHNlcnZlciB3
YW50cyB0byBhY2Vzcw0KKyMgdGhlIFRUWSBvciBQVFkgYXNzb2NpYXRlZCB3
aXRoIHRoZSBzZXNzaW9uLiBUaGlzIGlzIHZlcnkgYmFkDQorIyBiZWhhdmlv
dXIgYXMgaXQgYWxsb3dzIHRoZSBzZXJ2ZXIgYWNjZXNzIHRvIHRoZSBzeXNh
ZG1fciBUVFlzDQorIyBhbmQgUFRZcywgYnV0IGFwYWNoZTIgZG9lc24ndCB3
b3JrIHdpdGhvdXQuDQorIyBJZiB5b3UgcnVuIGFwYWNoZSAxLngueCwgdHJ5
IGRpc2FibGluZyB0aGlzLiBGb3IgYXBhY2hlMiwNCisjIHRoaXMgaXMgY3Vy
cmVudGx5IHRoZSBvbmx5IHNvbHV0aW9uLg0KKyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQorYWxsb3cgaHR0
cGRfdCBhZG1pbl90dHlfdHlwZTpjaHJfZmlsZSB7IHJlYWQgd3JpdGUgfTsN
CisNCiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMNCiAjIEFsbG93IGh0
dHBkIHRvIHJlY2VpdmUgbWVzc2FnZXMgZnJvbSB0aGUgbmV0d29yayBjYXJk
DQogIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIw0K
QEAgLTM3Niw4ICszODMsNyBAQA0KIGFsbG93IGh0dHBkX3QgaG9tZV9yb290
X3Q6ZGlyIHsgZ2V0YXR0ciBzZWFyY2ggfTsNCiBhbGxvdyBodHRwZF90IHVz
ZXJfaG9tZV9kaXJfdHlwZTpkaXIgeyBnZXRhdHRyIHNlYXJjaCB9Ow0KIGFs
bG93IGh0dHBkX3QgdXNlcl9ob21lX3R5cGU6ZGlyIHsgZ2V0YXR0ciBzZWFy
Y2ggcmVhZCB9Ow0KLSMgbmVlZCBpb2N0bCBmb3IgcGhwMw0KLWFsbG93IGh0
dHBkX3QgdXNlcl9ob21lX3R5cGU6eyBmaWxlIGxua19maWxlIH0geyBnZXRh
dHRyIHJlYWQgaW9jdGwgfTsNCithbGxvdyBodHRwZF90IHVzZXJfaG9tZV90
eXBlOnsgZmlsZSBsbmtfZmlsZSB9IHsgZ2V0YXR0ciByZWFkIH07DQogZG9u
dGF1ZGl0IGh0dHBkX3Qgc3lzYWRtX2hvbWVfZGlyX3Q6ZGlyIHsgZ2V0YXR0
ciBzZWFyY2ggfTsNCiANCiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjDQpAQCAtNDc4LDMgKzQ4NCw0MCBAQA0KICMgVW5jb21tZW50IHRoZSBm
b2xsb3dpbmcgbGluZSB0byBlbmFibGU6DQogI2Nhbl9leGVjKGh0dHBkX3Qs
IHNoZWxsX2V4ZWNfdCkNCiANCisjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIw0KKyMNCisjIFBIUCBEaXJlY3Rp
dmVzDQorIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMNCisNCit0eXBlIGh0dHBkX3BocF9leGVjX3QsIGZpbGVf
dHlwZSwgZXhlY190eXBlOw0KK3R5cGUgaHR0cGRfcGhwX3QsIGRvbWFpbjsN
CisNCisjIFRyYW5zaXRpb24gZnJvbSB0aGUgdXNlciBkb21haW4gdG8gdGhp
cyBkb21haW4uDQorZG9tYWluX2F1dG9fdHJhbnMoaHR0cGRfdCwgaHR0cGRf
cGhwX2V4ZWNfdCwgaHR0cGRfcGhwX3QpDQorDQorIyBUaGUgdXNlciByb2xl
IGlzIGF1dGhvcml6ZWQgZm9yIHRoaXMgZG9tYWluLg0KK3JvbGUgc3lzdGVt
X3IgdHlwZXMgaHR0cGRfcGhwX3Q7DQorDQorZ2VuZXJhbF9kb21haW5fYWNj
ZXNzKGh0dHBkX3BocF90KQ0KK2dlbmVyYWxfZmlsZV9yZWFkX2FjY2Vzcyho
dHRwZF9waHBfdCkNCit1c2VzX3NobGliKGh0dHBkX3BocF90KQ0KK2Nhbl9l
eGVjKGh0dHBkX3BocF90LCBsaWJfdCkNCisNCisjIGFsbG93IHBocCB0byBy
ZWFkIGFuZCBhcHBlbmQgdG8gYXBhY2hlIGxvZ2ZpbGVzDQorYWxsb3cgaHR0
cGRfcGhwX3QgaHR0cGRfbG9nX2ZpbGVzX3Q6ZmlsZSByYV9maWxlX3Blcm1z
Ow0KKw0KKyMgYWNjZXNzIHRvIC90bXANCit0eXBlIGh0dHBkX3BocF90bXBf
dCwgZmlsZV90eXBlLCBzeXNhZG1maWxlLCB0bXBmaWxlOw0KK2ZpbGVfdHlw
ZV9hdXRvX3RyYW5zKGh0dHBkX3BocF90LCB0bXBfdCwgaHR0cGRfcGhwX3Rt
cF90KQ0KKw0KKyMgaWdub3JlIHRoZXNlIHRoaW5ncywgUEhQIHNlZW1zIHRv
IHdvcmsgZmluZSB3aXRob3V0DQorZG9udGF1ZGl0IGh0dHBkX3BocF90IGh0
dHBkX3N5c19zY3JpcHRfdDpkaXIgeyBzZWFyY2ggfTsNCisNCisNCisjIGNv
bm5lY3QgdG8gbXlzcWwNCitpZmRlZihgbXlzcWxkLnRlJywgYA0KK2Nhbl91
bml4X2Nvbm5lY3QoaHR0cGRfcGhwX3QsIG15c3FsZF90KQ0KK2FsbG93IGh0
dHBkX3BocF90IHZhcl9ydW5fbXlzcWxkX3Q6ZGlyIHsgc2VhcmNoIH07DQor
YWxsb3cgaHR0cGRfcGhwX3QgdmFyX3J1bl9teXNxbGRfdDpzb2NrX2ZpbGUg
eyB3cml0ZSB9Ow0KKycpDQorDQo=
--554330684-1371807110-1043243368=:23864--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
