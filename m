Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA07353
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2002 17:19:41 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA20561
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2002 21:18:20 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id VAA20557 for <selinux@tycho.nsa.gov>; Mon, 6 May 2002 21:18:20 GMT
Date: Mon, 6 May 2002 17:19:08 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Debian User <rogelio@evoworks.evoserve.com>, <selinux@tycho.nsa.gov>
Subject: Re: context for /dev/.devfsd?
In-Reply-To: <20020504222752.C61EA35C4@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0205061716210.20696-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1254324197-1020719948=:20696"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1254324197-1020719948=:20696
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Sat, 4 May 2002, Russell Coker wrote:

> While playing around I added the following to devfs_contexts on a test
> machine:
> /.devfsd                system_u:object_r:devfs_control_t
>
> Then I discovered that /.devfsd is invalid syntax for policy.conf.
>
> Can this be fixed?

Patch attached, also committed to sourceforge CVS.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-1254324197-1020719948=:20696
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="policy_path.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0205061719080.20696@raven>
Content-Description: 
Content-Disposition: attachment; filename="policy_path.patch"

SW5kZXg6IG1vZHVsZS9jaGVja3BvbGljeS9wb2xpY3lfc2Nhbi5sDQo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2cy9sc20vc2VsaW51
eC9tb2R1bGUvY2hlY2twb2xpY3kvcG9saWN5X3NjYW4ubCx2DQpyZXRyaWV2
aW5nIHJldmlzaW9uIDEuNA0KcmV0cmlldmluZyByZXZpc2lvbiAxLjUNCmRp
ZmYgLXUgLXIxLjQgLXIxLjUNCi0tLSBtb2R1bGUvY2hlY2twb2xpY3kvcG9s
aWN5X3NjYW4ubAkyMDAxLzExLzA5IDIyOjM5OjUxCTEuNA0KKysrIG1vZHVs
ZS9jaGVja3BvbGljeS9wb2xpY3lfc2Nhbi5sCTIwMDIvMDUvMDYgMjE6MTA6
NTQJMS41DQpAQCAtMTAyLDcgKzEwMiw3IEBADQogVDEJCQkJeyByZXR1cm4o
VDEpOyB9DQogdDIgfA0KIFQyCQkJCXsgcmV0dXJuKFQyKTsgfQ0KLSIvIih7
bGV0dGVyfXx7ZGlnaXR9fF98Ii8iKSoJeyByZXR1cm4oUEFUSCk7IH0NCisi
LyIoe2xldHRlcn18e2RpZ2l0fXxffCIuInwiLyIpKgl7IHJldHVybihQQVRI
KTsgfQ0KIHtsZXR0ZXJ9KHtsZXR0ZXJ9fHtkaWdpdH18XykqCXsgcmV0dXJu
KElERU5USUZJRVIpOyB9DQoge2RpZ2l0fXtkaWdpdH0qICAgICAgICAgICAg
ICAgICB7IHJldHVybihOVU1CRVIpOyB9DQogI1teXG5dKiAgICAgICAgICAg
ICAgICAgICAgICAgICB7IC8qIGRlbGV0ZSBjb21tZW50cyAqLyB9DQo=
---559023410-1254324197-1020719948=:20696--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
