Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA16222
	for <selinux@tycho.nsa.gov>; Tue, 14 May 2002 15:00:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA03224
	for <selinux@tycho.nsa.gov>; Tue, 14 May 2002 18:59:03 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id SAA03220 for <selinux@tycho.nsa.gov>; Tue, 14 May 2002 18:59:03 GMT
Date: Tue, 14 May 2002 14:59:37 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: run_init and chdir()
In-Reply-To: <20020507121156.390C36C13@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0205141459050.25712-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-630072926-1021402777=:25712"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-630072926-1021402777=:25712
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Tue, 7 May 2002, Russell Coker wrote:

> Would it make sense to have run_init do "chdir /" before executing it's
> program?
>
> It's annoying when you accidentally execute a daemon with a current directory
> that it can't read...

Patch attached, and committed to the sourceforge CVS tree.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-630072926-1021402777=:25712
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="run_init.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0205141459370.25712@raven>
Content-Description: 
Content-Disposition: attachment; filename="run_init.patch"

SW5kZXg6IHV0aWxzL3J1bl9pbml0L3J1bl9pbml0LmMNCj09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0NClJDUyBmaWxlOiAvY3Zzcm9vdC9zZWxpbnV4L25zYS9z
ZWxpbnV4L3V0aWxzL3J1bl9pbml0L3J1bl9pbml0LmMsdg0KcmV0cmlldmlu
ZyByZXZpc2lvbiAxLjEuMS4yDQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMw0K
ZGlmZiAtdSAtcjEuMS4xLjIgLXIxLjMNCi0tLSB1dGlscy9ydW5faW5pdC9y
dW5faW5pdC5jCTMgTWF5IDIwMDIgMTI6Mjg6MTIgLTAwMDAJMS4xLjEuMg0K
KysrIHV0aWxzL3J1bl9pbml0L3J1bl9pbml0LmMJMTQgTWF5IDIwMDIgMTg6
NTQ6MjUgLTAwMDAJMS4zDQpAQCAtMzgxLDYgKzM4MSwxMSBAQA0KICAgICog
U3RlcCA0OiBSdW4gdGhlIGNvbW1hbmQgaW4gdGhlIGNvcnJlY3QgY29udGV4
dC4NCiAgICAqLw0KIA0KKyAgaWYgKGNoZGlyKCIvIikpIHsNCisJICBwZXJy
b3IoImNoZGlyIik7DQorCSAgZXhpdCgtMSk7DQorICB9DQorDQogICBpZiAo
IGV4ZWN2cF9zZWN1cmUoYXJndlsxXSwgc2lkLCBhcmd2ICsgMSkgKSB7DQog
ICAgIHBlcnJvcigiZXhlY3ZwX3NlY3VyZSIpOw0KICAgICBleGl0KC0xKTsN
Cg==
---559023410-630072926-1021402777=:25712--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
