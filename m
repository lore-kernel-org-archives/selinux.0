Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA27533
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 12:01:53 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA24611
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 16:00:09 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id QAA24607 for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 16:00:08 GMT
Date: Fri, 16 Aug 2002 12:01:14 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: what is "null" access?
In-Reply-To: <20020805145309.096EC2CA8@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208161158390.29385-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1841205112-1029513674=:29385"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1841205112-1029513674=:29385
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Mon, 5 Aug 2002, Russell Coker wrote:

> Aug ?5 10:58:57 ns kernel: avc: ?denied ?null for ?pid=30897
> exe=/usr/sbin/apache IPCID=0 scontext=system_u:system_r:httpd_t
> tcontext=system_u:system_r:httpd_t tclass=shm
> Aug ?5 10:58:57 ns kernel: avc: ?denied ?null for ?pid=30897
> exe=/usr/sbin/apache IPCID=0 scontext=system_u:system_r:httpd_t
> tcontext=system_u:system_r:httpd_t tclass=shm
>
> The above messages are appearing on a system running a version of SE Linux
> that's not the latest (running the original 2002.07.03 release).
>
> Bug?

The attached patch (also committed to sourceforge CVS) should fix this
bug.  To apply, save to ~/ipc.patch, cd lsm-2.4 && patch -p1 <
~/ipc.patch.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-1841205112-1029513674=:29385
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ipc.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0208161201140.29385@raven>
Content-Description: 
Content-Disposition: attachment; filename="ipc.patch"

SW5kZXg6IGxzbS0yLjQvc2VjdXJpdHkvc2VsaW51eC9ob29rcy5jDQo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2c3Jvb3Qvc2VsaW51
eC9uc2EvbHNtLTIuNC9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMsdg0KcmV0
cmlldmluZyByZXZpc2lvbiAxLjE1DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEu
MTYNCmRpZmYgLXUgLXIxLjE1IC1yMS4xNg0KLS0tIGxzbS0yLjQvc2VjdXJp
dHkvc2VsaW51eC9ob29rcy5jCTI2IEp1bCAyMDAyIDE0OjMwOjU4IC0wMDAw
CTEuMTUNCisrKyBsc20tMi40L3NlY3VyaXR5L3NlbGludXgvaG9va3MuYwkx
NiBBdWcgMjAwMiAxNDo0Mzo0OSAtMDAwMAkxLjE2DQpAQCAtNDQ4Nyw2ICs0
NDg3LDkgQEANCiAJaWYgKGZsYWcgJiBTX0lXVUdPKQ0KIAkJYXYgfD0gSVBD
X19VTklYX1dSSVRFOw0KIA0KKwlpZiAoYXYgPT0gMCkNCisJCXJldHVybiAw
Ow0KKw0KIAlyZXR1cm4gaXBjX2hhc19wZXJtKGlwY3AsIDAgLyogWFhYICov
LCBzY2xhc3MsIGF2KTsNCiB9DQogDQo=
---559023410-1841205112-1029513674=:29385--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
