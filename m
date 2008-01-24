Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0OJdjmY014586
	for <selinux@tycho.nsa.gov>; Thu, 24 Jan 2008 14:39:45 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m0OJdgoD010468
	for <selinux@tycho.nsa.gov>; Thu, 24 Jan 2008 19:39:43 GMT
Subject: [patch] fixfiles -C: relabel all file contexts that have changed
From: Marshall Miller <mmiller@tresys.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-wgZq2wkqVgwLf0B3wlss"
Date: Thu, 24 Jan 2008 14:39:40 -0500
Message-Id: <1201203580.4502.56.camel@hostmachine.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-wgZq2wkqVgwLf0B3wlss
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This fixes the situation where one path is a substring of another path, but not a prefix.  For example, if /lib and /var/lib have both changed in the file_contexts file, then /var/lib would not be selected for relabel even though it should.



Marshall Miller


--=-wgZq2wkqVgwLf0B3wlss
Content-Disposition: attachment; filename=fixfiles_dash_C.patch
Content-Type: text/x-patch; name=fixfiles_dash_C.patch; charset=UTF-8
Content-Transfer-Encoding: base64

SW5kZXg6IHBvbGljeWNvcmV1dGlscy9zY3JpcHRzL2ZpeGZpbGVzDQo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQotLS0g
cG9saWN5Y29yZXV0aWxzL3NjcmlwdHMvZml4ZmlsZXMJKHJldmlzaW9uIDI3NDgpDQorKysgcG9s
aWN5Y29yZXV0aWxzL3NjcmlwdHMvZml4ZmlsZXMJKHdvcmtpbmcgY29weSkNCkBAIC04NCw3ICs4
NCw3IEBADQogCSAgICBkbyBpZiAhIGVjaG8gIiRwYXR0ZXJuIiB8IGdyZXAgLXEgLWYgJHtURU1Q
RklMRX0gMj4vZGV2L251bGw7IHRoZW4gXA0KICAgICAgICAgICAgICAgICAgIGVjaG8gIiRwYXR0
ZXJuIjsgXA0KICAgICAgICAgICAgICAgICAgIGNhc2UgIiRwYXR0ZXJuIiBpbiAqIioiKSBcDQot
CSAgICAgICAgICAgICAgIGVjaG8gIiRwYXR0ZXJuIiB8IHNlZCAncyxcKiQsLGcnID4+ICR7VEVN
UEZJTEV9OzsgIA0KKwkgICAgICAgICAgICAgICBlY2hvICIkcGF0dGVybiIgfCBzZWQgLWUgJ3Ms
XixeLCcgLWUgJ3MsXCokLCxnJyA+PiAke1RFTVBGSUxFfTs7ICANCiAgICAgICAgICAgICAgICAg
ICBlc2FjOyBcDQogICAgICAgICAgICAgICAgZmk7IFwNCiAgICAgICAgICAgICBkb25lIHwgXA0K



--=-wgZq2wkqVgwLf0B3wlss--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
