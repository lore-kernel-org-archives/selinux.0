Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA06610
	for <selinux@tycho.nsa.gov>; Thu, 16 May 2002 13:00:08 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA00921
	for <selinux@tycho.nsa.gov>; Thu, 16 May 2002 16:58:51 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id QAA00915 for <selinux@tycho.nsa.gov>; Thu, 16 May 2002 16:58:50 GMT
Date: Thu, 16 May 2002 12:59:28 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carsten.grohmann@dr-baldeweg.de>
cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: enforcing mode
In-Reply-To: <3CC95420.E87F2FFE@dr-baldeweg.de>
Message-ID: <Pine.GSO.4.33.0205161251010.29714-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-959030623-1021568368=:29714"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-959030623-1021568368=:29714
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Fri, 26 Apr 2002, Carsten Grohmann wrote:

> this time I use SELinux and after each start it is run in the permissive
> mode. After each start I change manual to the enforcing mode. It is
> possible to start automatic in the enforcing Mode? Or need I a script to
> do this?

The attached patch (also committed to sourceforge CVS) allows enforcing
mode to be selected at boot time (if built-in) or module insertion time if
SELinux was built with the development option.  Use "enforcing=1" on the
kernel command line to start in enforcing mode.  Of course, you can also
build SELinux without the development option to cause it to always operate
in enforcing mode.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-959030623-1021568368=:29714
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="enforcing.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0205161259280.29714@raven>
Content-Description: 
Content-Disposition: attachment; filename="enforcing.patch"

SW5kZXg6IHNlY3VyaXR5L3NlbGludXgvaG9va3MuYw0KPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQ0KUkNTIGZpbGU6IC9jdnNyb290L3NlbGludXgvbnNhL2xz
bS0yLjQvc2VjdXJpdHkvc2VsaW51eC9ob29rcy5jLHYNCnJldHJpZXZpbmcg
cmV2aXNpb24gMS43DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuOA0KZGlmZiAt
dSAtcjEuNyAtcjEuOA0KLS0tIHNlY3VyaXR5L3NlbGludXgvaG9va3MuYwkz
IE1heSAyMDAyIDEzOjI2OjQ0IC0wMDAwCTEuNw0KKysrIHNlY3VyaXR5L3Nl
bGludXgvaG9va3MuYwkxNiBNYXkgMjAwMiAxNjo1MTo1MCAtMDAwMAkxLjgN
CkBAIC01MTAwLDYgKzUxMDAsMjMgQEANCiANCiBzdGF0aWMgbG9uZyAoKm9y
aWdfc3lzY2FsbCkodm9pZCk7DQogDQorI2lmZGVmIENPTkZJR19TRUNVUklU
WV9TRUxJTlVYX0RFVkVMT1ANCitzdGF0aWMgaW50IGVuZm9yY2luZyA9IDA7
DQorDQorI2lmZGVmIE1PRFVMRQ0KK01PRFVMRV9QQVJNKGVuZm9yY2luZywg
ImkiKTsNCitNT0RVTEVfUEFSTV9ERVNDKGVuZm9yY2luZywgIlNFTGludXg6
ICBTdGFydCBpbiBlbmZvcmNpbmcgbW9kZSIpOw0KKyNlbHNlDQorc3RhdGlj
IGludCBfX2luaXQgZW5mb3JjaW5nX3NldHVwKGNoYXIgKnN0cikNCit7DQor
CWVuZm9yY2luZyA9IHNpbXBsZV9zdHJ0b2woc3RyLE5VTEwsMCk7DQorCXJl
dHVybiAxOw0KK30NCitfX3NldHVwKCJlbmZvcmNpbmc9IiwgZW5mb3JjaW5n
X3NldHVwKTsNCisjZW5kaWYNCisNCisjZW5kaWYNCisNCiBzdGF0aWMgaW50
IF9faW5pdCBzZWxpbnV4X3BsdWdfaW5pdCAodm9pZCkNCiB7DQogCWludCBy
YyA9IDA7DQpAQCAtNTE0Myw2ICs1MTYwLDE2IEBADQogCX0NCiANCiAJcHJp
bnRrIChLRVJOX0lORk8gIlNFTGludXg6ICBtb2R1bGUgaW5zZXJ0ZWRcbiIp
Ow0KKw0KKyNpZmRlZiBDT05GSUdfU0VDVVJJVFlfU0VMSU5VWF9ERVZFTE9Q
DQorCWlmIChlbmZvcmNpbmcpIHsNCisJCXByaW50ayhLRVJOX0lORk8gIlNF
TGludXg6ICBTdGFydGluZyBpbiBlbmZvcmNpbmcgbW9kZVxuIik7DQorCQlh
dmNfZGVidWdfYWx3YXlzX2FsbG93ID0gMDsNCisJfSBlbHNlIHsNCisJCXBy
aW50ayhLRVJOX0lORk8gIlNFTGludXg6ICBTdGFydGluZyBpbiBwZXJtaXNz
aXZlIG1vZGVcbiIpOw0KKwkJYXZjX2RlYnVnX2Fsd2F5c19hbGxvdyA9IDE7
DQorCX0NCisjZW5kaWYNCiANCiAJcmV0dXJuIHJjOw0KIH0NCg==
---559023410-959030623-1021568368=:29714--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
