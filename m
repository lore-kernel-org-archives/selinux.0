Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA12507
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 10:57:00 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA10080
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 14:55:31 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA10076
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 14:55:30 GMT
Received: from localhost (sds@localhost)
	by raven.gw.tislabs.com (8.11.6/8.11.6) with ESMTP id g8PEuD020858
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 10:56:13 -0400 (EDT)
Date: Wed, 25 Sep 2002 10:56:13 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: Re: [patch] Fix bug in pivot_root handling
In-Reply-To: <Pine.GSO.4.33.0209241408520.23277-200000@raven>
Message-ID: <Pine.GSO.4.33.0209251054390.19511-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-684387517-1032965773=:19511"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-684387517-1032965773=:19511
Content-Type: TEXT/PLAIN; charset=US-ASCII


The attached patch, also committed to the sourceforge CVS tree, addresses
a problem in the prior pivot_root patch that was dependent on certain
behavior from the /linuxrc script.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com

On Tue, 24 Sep 2002, Stephen Smalley wrote:

> Due to a change in the initialization code in 2.4.19, the SELinux handling
> of the pivot_root mechanism for initrds is broken.  The attached patch,
> also committed to the sourceforge CVS tree, fixes this bug and cleans up
> the SELinux code based on the changes in 2.4.19.  As of 2.4.19, it should
> not be necessary to place a policy on an initrd at all, only on the real
> root filesystem.

---559023410-684387517-1032965773=:19511
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="pivotroot2.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0209251056130.19511@raven>
Content-Description: 
Content-Disposition: attachment; filename="pivotroot2.patch"

SW5kZXg6IGxzbS0yLjQvc2VjdXJpdHkvc2VsaW51eC9ob29rcy5jDQo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2c3Jvb3Qvc2VsaW51
eC9uc2EvbHNtLTIuNC9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMsdg0KcmV0
cmlldmluZyByZXZpc2lvbiAxLjIwDQpkaWZmIC11IC1yMS4yMCBob29rcy5j
DQotLS0gbHNtLTIuNC9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMJMjQgU2Vw
IDIwMDIgMjA6MDc6NDYgLTAwMDAJMS4yMA0KKysrIGxzbS0yLjQvc2VjdXJp
dHkvc2VsaW51eC9ob29rcy5jCTI1IFNlcCAyMDAyIDExOjM5OjU2IC0wMDAw
DQpAQCAtMjA4Miw2ICsyMDgyLDcgQEANCiANCiBzdGF0aWMgdm9pZCBzZWxp
bnV4X3Bvc3RfcGl2b3Ryb290IChzdHJ1Y3QgbmFtZWlkYXRhICpvbGRfbmQs
IHN0cnVjdCBuYW1laWRhdGEgKm5ld19uZCkNCiB7DQorCXNlbGludXhfcG9z
dF9tb3VudHJvb3QoKTsNCiAJcmV0dXJuOw0KIH0NCiANCg==
---559023410-684387517-1032965773=:19511--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
