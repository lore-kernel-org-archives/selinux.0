Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA17047
	for <selinux@tycho.nsa.gov>; Mon, 7 May 2001 14:21:54 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA24840
	for <selinux@tycho.nsa.gov>; Mon, 7 May 2001 18:21:53 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id SAA24836
	for <selinux@tycho.nsa.gov>; Mon, 7 May 2001 18:21:53 GMT
Date: Mon, 7 May 2001 14:20:32 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Yanni Kouskoulas <Yanni.Kouskoulas@jhuapl.edu>
cc: selinux@tycho.nsa.gov
Subject: Re: installation problems with checkpolicy
In-Reply-To: <Pine.LNX.4.21.0105021025380.8009-100000@kouskya1.jhuapl.edu>
Message-ID: <Pine.SOL.3.95.1010507141837.20044c-200000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-838545539-989259632=:20044"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-838545539-989259632=:20044
Content-Type: TEXT/PLAIN; charset=US-ASCII


There is a bug in the checkpolicy program.  Please apply
the enclosed patch to your kernel-2.4/security/policy_parse.y
file and rebuild your checkpolicy program.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com

On Wed, 2 May 2001, Yanni Kouskoulas wrote:

> Yesterday, I tried to install selinux on the x86 box I have at work. This
> machine normally runs linux with the 2.4.2 kernel.
> 
> I am new to selinux, so from the download page, I got "Everything in one
> large file" I followed the documentation in the installation guide: the
> kernel compiled with some warnings, build-apps and install-apps seemed to
> work fine. When I type "make initinstall" (of if I try to use
> ./tools/build-kernel) make dies when it tries to execute checkpolicy with
> the following errors:
> 
> ---------------------------------------------------
> ../kernel/security/checkpolicy -o initpolicy initpolicy.conf
> ../kernel/security/checkpolicy:  loading policy configuration from 
> initpolicy.conf
> 
> error in the statement ending on line 1686 (token ';'): unknown class 
> capability used in rule
> 
> ../kernel/security/checkpolicy:  error(s) encountered while parsing 
> configuration
> ---------------------------------------------------
> 
> It doesn't like the keyword "capability". Line 1686 is part of the list of
> atd_t domain rules:
> 
> allow atd_t atd_t:capability { setgid setuid };
> 
> However, I don't completely understand all the configuration files, and
> have only begun to read through the document titled "A Security Policy
> Configuration for the Security-Enhanced Linux."
> 
> Is there something else I need to install? Some other docs I should read?
> Any helpful suggestions for getting this initially set up?
> Thanks.
> 
> -Yanni

---559023410-838545539-989259632=:20044
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.3.95.1010507142032.20044d@clipper.gw.tislabs.com>
Content-Description: 

LS0tIHBvbGljeV9wYXJzZS55Lm9sZAlNb24gTWF5ICA3IDE0OjE1OjU1IDIw
MDENCisrKyBwb2xpY3lfcGFyc2UueQlNb24gTWF5ICA3IDE0OjE2OjAwIDIw
MDENCkBAIC0xNzc1LDcgKzE3NzUsNiBAQA0KIHsNCiAJY2hhciAqaWQ7DQog
CWNsYXNzX2RhdHVtX3QgKmNsYWRhdHVtOw0KLQl0eXBlX2RhdHVtX3QgKmRh
dHVtOw0KIAlwZXJtX2RhdHVtX3QgKnBlcmRhdHVtOw0KIAllYml0bWFwX3Qg
c3R5cGVzLCB0dHlwZXMsIHRjbGFzc2VzOw0KIAlhY2Nlc3NfdmVjdG9yX3Qg
KmF2cDsNCkBAIC0xODE0LDcgKzE4MTMsNyBAQA0KIAloaWNsYXNzID0gMDsN
CiAJd2hpbGUgKChpZCA9IHF1ZXVlX3JlbW92ZShpZF9xdWV1ZSkpKSB7DQog
CQljbGFkYXR1bSA9IGhhc2h0YWJfc2VhcmNoKHBvbGljeWRicC0+cF9jbGFz
c2VzLnRhYmxlLCBpZCk7DQotCQlpZiAoIWRhdHVtKSB7DQorCQlpZiAoIWNs
YWRhdHVtKSB7DQogCQkJc3ByaW50ZihlcnJvcm1zZywgInVua25vd24gY2xh
c3MgJXMgdXNlZCBpbiBydWxlIiwgaWQpOw0KIAkJCXl5ZXJyb3IoZXJyb3Jt
c2cpOw0KIAkJCWdvdG8gYmFkOw0KQEAgLTIwOTEsNyArMjA5MCw2IEBADQog
CQlpZiAocmV0KSB7DQogCQkJeXllcnJvcigiaGFzaCB0YWJsZSBvdmVyZmxv
dyIpOw0KIAkJCWZyZWUocm9sZSk7DQotCQkJZnJlZShpZCk7DQogCQkJZnJl
ZShyb2xlX2lkKTsNCiAJCQlyZXR1cm4gLTE7DQogCQl9DQo=
---559023410-838545539-989259632=:20044--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
