Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA19150
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 08:22:24 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA08688
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 12:21:49 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA08684
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 12:21:49 GMT
Date: Mon, 8 Jul 2002 08:22:12 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Debian User <rogelio@evoworks.evoserve.com>
cc: <selinux@tycho.nsa.gov>
Subject: [patch] Re: problem with "-" in libraries
In-Reply-To: <20020706040722.CF93D814D2@coffeesaur2.evoserve.com>
Message-ID: <Pine.GSO.4.33.0207080820340.19100-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1254324197-1026130932=:19100"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1254324197-1026130932=:19100
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Sat, 6 Jul 2002, Debian User wrote:

> Im developing a policy for a cramfs based selinux system. I cant specify the
> contexts for libraries with a "-" in the names like "libpthread-0.9.11.so".
> Checkpolicy does not accept such names int genfs_contexts. I am trying to work
> around this by recompiling everything using modified library names. Can the
> checkpolicy compiler be modified to accept this names?

The attached patch fixes the checkpolicy scanner to accept "-" in path
tokens.  This patch has also been committed to the sourceforge CVS tree.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-1254324197-1026130932=:19100
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="pathdash.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0207080822120.19100@raven>
Content-Description: 
Content-Disposition: attachment; filename="pathdash.patch"

SW5kZXg6IG1vZHVsZS9jaGVja3BvbGljeS9wb2xpY3lfc2Nhbi5sDQo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2c3Jvb3Qvc2VsaW51
eC9uc2Evc2VsaW51eC9tb2R1bGUvY2hlY2twb2xpY3kvcG9saWN5X3NjYW4u
bCx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNQ0KZGlmZiAtdSAtcjEuNSBw
b2xpY3lfc2Nhbi5sDQotLS0gbW9kdWxlL2NoZWNrcG9saWN5L3BvbGljeV9z
Y2FuLmwJMyBKdWwgMjAwMiAyMDozOTo0NyAtMDAwMAkxLjUNCisrKyBtb2R1
bGUvY2hlY2twb2xpY3kvcG9saWN5X3NjYW4ubAk4IEp1bCAyMDAyIDEyOjE3
OjE2IC0wMDAwDQpAQCAtMTMwLDcgKzEzMCw3IEBADQogVDEJCQkJeyByZXR1
cm4oVDEpOyB9DQogdDIgfA0KIFQyCQkJCXsgcmV0dXJuKFQyKTsgfQ0KLSIv
Iih7bGV0dGVyfXx7ZGlnaXR9fF98Ii4ifCIvIikqCXsgcmV0dXJuKFBBVEgp
OyB9DQorIi8iKHtsZXR0ZXJ9fHtkaWdpdH18X3wiLiJ8Ii0ifCIvIikqCXsg
cmV0dXJuKFBBVEgpOyB9DQoge2xldHRlcn0oe2xldHRlcn18e2RpZ2l0fXxf
KSoJeyByZXR1cm4oSURFTlRJRklFUik7IH0NCiB7ZGlnaXR9e2RpZ2l0fSog
ICAgICAgICAgICAgICAgIHsgcmV0dXJuKE5VTUJFUik7IH0NCiAjW15cbl0q
ICAgICAgICAgICAgICAgICAgICAgICAgIHsgLyogZGVsZXRlIGNvbW1lbnRz
ICovIH0NCg==
---559023410-1254324197-1026130932=:19100--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
