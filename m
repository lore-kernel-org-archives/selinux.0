Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA16140
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 15:20:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA04423
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 19:18:44 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id TAA04419 for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 19:18:43 GMT
Date: Wed, 23 Oct 2002 15:20:18 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: ssh policy
In-Reply-To: <200210232052.16261.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210231518090.25774-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1804928587-1035400818=:25774"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1804928587-1035400818=:25774
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Wed, 23 Oct 2002, Russell Coker wrote:

> # Proxy openlogging.
> allow $1_ssh_t http_cache_port_t:tcp_socket name_bind;
>
> The above has just appeared in the new policy.  I suggest that it be in the
> policy commented out at the most.
>
> This allows any ssh user (IE any user) to potentially subvert the web cache if
> they can cause it to crash.
>
> I don't think I'll include this in my policy tree.

Ok, removed.  Patch attached and committed to the updated sf CVS tree.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-1804928587-1035400818=:25774
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sshpolicy.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0210231520180.25774@raven>
Content-Description: 
Content-Disposition: attachment; filename="sshpolicy.patch"

SW5kZXg6IHNlbGludXgvcG9saWN5L21hY3Jvcy9wcm9ncmFtL3NzaF9tYWNy
b3MudGUNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NClJDUyBmaWxlOiAvY3Zz
cm9vdC9zZWxpbnV4L25zYS9zZWxpbnV4L3BvbGljeS9tYWNyb3MvcHJvZ3Jh
bS9zc2hfbWFjcm9zLnRlLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS44DQpk
aWZmIC11IC1yMS44IHNzaF9tYWNyb3MudGUNCi0tLSBzZWxpbnV4L3BvbGlj
eS9tYWNyb3MvcHJvZ3JhbS9zc2hfbWFjcm9zLnRlCTIzIE9jdCAyMDAyIDE4
OjIzOjE2IC0wMDAwCTEuOA0KKysrIHNlbGludXgvcG9saWN5L21hY3Jvcy9w
cm9ncmFtL3NzaF9tYWNyb3MudGUJMjMgT2N0IDIwMDIgMTk6MTc6MjYgLTAw
MDANCkBAIC0yMiw5ICsyMiw2IEBADQogIyBEZXJpdmVkIGRvbWFpbiBiYXNl
ZCBvbiB0aGUgY2FsbGluZyB1c2VyIGRvbWFpbiBhbmQgdGhlIHByb2dyYW0u
DQogdHlwZSAkMV9zc2hfdCwgZG9tYWluLCBwcml2bG9nOw0KIA0KLSMgUHJv
eHkgb3BlbmxvZ2dpbmcuDQotYWxsb3cgJDFfc3NoX3QgaHR0cF9jYWNoZV9w
b3J0X3Q6dGNwX3NvY2tldCBuYW1lX2JpbmQ7DQotDQogIyBUcmFuc2l0aW9u
IGZyb20gdGhlIHVzZXIgZG9tYWluIHRvIHRoZSBkZXJpdmVkIGRvbWFpbi4N
CiBkb21haW5fYXV0b190cmFucygkMV90LCBzc2hfZXhlY190LCAkMV9zc2hf
dCkNCiANCg==
---559023410-1804928587-1035400818=:25774--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
