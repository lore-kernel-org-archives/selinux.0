Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA02288
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 12:15:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA29416
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 16:13:03 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id QAA29412 for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 16:13:03 GMT
Date: Fri, 27 Sep 2002 12:14:21 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: losing type information under high load
In-Reply-To: <200209271419.46189.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0209271156480.9356-300000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1804928587-1033143261=:9356"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1804928587-1033143261=:9356
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Fri, 27 Sep 2002, Russell Coker wrote:

> I have two machines running ReiserFS for /var/cache/squid where files
> occasionally get changed to type system_u:object_r:file_t for no good reason.
>
> This has happened for the last few kernel patches, with kernel 2.4.18 and
> 2.4.19, and is not related to power failures or crashes.

Or switching back and forth between a SELinux kernel and a non-SELinux
kernel?  That could cause the file to be re-created while running a
non-SELinux kernel, leaving it with an unspecified PSID.

Unless ReiserFS is dynamically remapping inode numbers (which would be
very bad for the SELinux persistent label mapping), I don't know why you
would see this behavior.  My impression from earlier discussions on this
list was that ReiserFS currently satisfies the requirement for persistent
and unique inode numbers, but may cease to satisfy that requirement in
the future.  At that point, I would expect ReiserFS to natively support
extended attribute-like functionality so that SELinux can defer file
label management to it.

The only case where SELinux resets an inode to the default file PSID is
when the inode is deleted (the final iput with a hard link count of zero).
This isn't strictly necessary, since the inode will be reassigned a PSID
when it is next allocated for a new file, but is good form.  The
first attached patch disables this code; you can try this patch if you
like with ReiserFS to see if it makes any difference.

> However this raises another issue.  In the default policy we allow almost
> everything read access to file_t directories, sym-links, and files.  So any
> situation that results in a file changing to the default type (EG a power
> failure at an inconveniant time) may make a file world-readable!!!
>
> Is there any reason for not restricting file_t to the administrator only?

Not anymore.  The second attached patch removes general read access to
file_t, although further testing and review is recommended.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




---559023410-1804928587-1033143261=:9356
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="dontclear.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0209271214210.9356@raven>
Content-Description: 
Content-Disposition: attachment; filename="dontclear.patch"

SW5kZXg6IGxzbS0yLjQvc2VjdXJpdHkvc2VsaW51eC9ob29rcy5jDQo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2c3Jvb3Qvc2VsaW51
eC9uc2EvbHNtLTIuNC9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMsdg0KcmV0
cmlldmluZyByZXZpc2lvbiAxLjIxDQpkaWZmIC11IC1yMS4yMSBob29rcy5j
DQotLS0gbHNtLTIuNC9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMJMjUgU2Vw
IDIwMDIgMTQ6NTQ6MjQgLTAwMDAJMS4yMQ0KKysrIGxzbS0yLjQvc2VjdXJp
dHkvc2VsaW51eC9ob29rcy5jCTI3IFNlcCAyMDAyIDE1OjU1OjU5IC0wMDAw
DQpAQCAtMjI1NSwxNyArMjI1NSw3IEBADQogDQogc3RhdGljIHZvaWQgc2Vs
aW51eF9pbm9kZV9kZWxldGUoc3RydWN0IGlub2RlICppbm9kZSkNCiB7DQot
CXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBpbm9kZS0+aV9zYjsgDQotCWlm
IChzYikgew0KLQkJc3RydWN0IHN1cGVyYmxvY2tfc2VjdXJpdHlfc3RydWN0
ICpzYnNlYyA9IHNiLT5zX3NlY3VyaXR5Ow0KLQ0KLQkJaWYgKCFzYnNlYyB8
fCBzYnNlYy0+bWFnaWMgIT0gU0VMSU5VWF9NQUdJQyB8fCANCi0JCSAgICAh
c2JzZWMtPmluaXRpYWxpemVkKQ0KLQkJCXJldHVybjsNCi0NCi0JCWlmIChz
YnNlYy0+dXNlc19wc2lkcykNCi0JCQljbGVhcl9wc2lkKGlub2RlKTsNCi0J
fQ0KKwlyZXR1cm47DQogfQ0KIA0KIA0K
---559023410-1804928587-1033143261=:9356
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="file_t.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0209271214211.9356@raven>
Content-Description: 
Content-Disposition: attachment; filename="file_t.patch"

SW5kZXg6IHNlbGludXgvcG9saWN5L2RvbWFpbnMvcHJvZ3JhbS9hcGFjaGUu
dGUNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0NClJDUyBmaWxlOiAvY3ZzL2xz
bS9zZWxpbnV4L3BvbGljeS9kb21haW5zL3Byb2dyYW0vYXBhY2hlLnRlLHYN
CnJldHJpZXZpbmcgcmV2aXNpb24gMS4xNA0KZGlmZiAtdSAtcjEuMTQgYXBh
Y2hlLnRlDQotLS0gc2VsaW51eC9wb2xpY3kvZG9tYWlucy9wcm9ncmFtL2Fw
YWNoZS50ZQkyMDAyLzA5LzI3IDE0OjQwOjQ2CTEuMTQNCisrKyBzZWxpbnV4
L3BvbGljeS9kb21haW5zL3Byb2dyYW0vYXBhY2hlLnRlCTIwMDIvMDkvMjcg
MTY6MTA6MDcNCkBAIC0yMDIsMTMgKzIwMiwxMSBAQA0KICMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIw0KIGFsbG93IGh0dHBkX3VzZXJfc2NyaXB0X3By
b2Nlc3NfdCBpbml0cmNfdDpmZCB7dXNlfTsNCiBhbGxvdyBodHRwZF91c2Vy
X3NjcmlwdF9wcm9jZXNzX3QgaW5pdF90OmZkIHt1c2V9Ow0KLWFsbG93IGh0
dHBkX3VzZXJfc2NyaXB0X3Byb2Nlc3NfdCBmaWxlX3Q6ZGlyIHJfZGlyX3Bl
cm1zOw0KIA0KIGFsbG93IGh0dHBkX3VzZXJfc2NyaXB0X3Byb2Nlc3NfdCBy
YW5kb21fZGV2aWNlX3Q6Y2hyX2ZpbGUgcl9maWxlX3Blcm1zOw0KIA0KIGFs
bG93IGh0dHBkX3N5c19zY3JpcHRfcHJvY2Vzc190IGluaXRyY190OmZkIHt1
c2V9Ow0KIGFsbG93IGh0dHBkX3N5c19zY3JpcHRfcHJvY2Vzc190IGluaXRf
dDpmZCB7dXNlfTsNCi1hbGxvdyBodHRwZF9zeXNfc2NyaXB0X3Byb2Nlc3Nf
dCBmaWxlX3Q6ZGlyIHJfZGlyX3Blcm1zOw0KIA0KIGFsbG93IGh0dHBkX3N5
c19zY3JpcHRfcHJvY2Vzc190IHJhbmRvbV9kZXZpY2VfdDpjaHJfZmlsZSBy
X2ZpbGVfcGVybXM7DQogDQpJbmRleDogc2VsaW51eC9wb2xpY3kvZG9tYWlu
cy9wcm9ncmFtL2luaXRyYy50ZQ0KPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
UkNTIGZpbGU6IC9jdnMvbHNtL3NlbGludXgvcG9saWN5L2RvbWFpbnMvcHJv
Z3JhbS9pbml0cmMudGUsdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjE3DQpk
aWZmIC11IC1yMS4xNyBpbml0cmMudGUNCi0tLSBzZWxpbnV4L3BvbGljeS9k
b21haW5zL3Byb2dyYW0vaW5pdHJjLnRlCTIwMDIvMDkvMjcgMTQ6NDA6NDYJ
MS4xNw0KKysrIHNlbGludXgvcG9saWN5L2RvbWFpbnMvcHJvZ3JhbS9pbml0
cmMudGUJMjAwMi8wOS8yNyAxNjoxMDowNw0KQEAgLTc2LDcgKzc2LDcgQEAN
CiANCiAjIE1vdW50IGFuZCB1bm1vdW50IGZpbGUgc3lzdGVtcy4NCiBhbGxv
dyBpbml0cmNfdCBmc190eXBlOmZpbGVzeXN0ZW0gbW91bnRfZnNfcGVybXM7
DQotYWxsb3cgaW5pdHJjX3QgZmlsZV90OmRpciBtb3VudG9uOw0KK2FsbG93
IGluaXRyY190IGZpbGVfdDpkaXIgeyByZWFkIHNlYXJjaCBnZXRhdHRyIG1v
dW50b24gfTsNCiANCiAjIENyZWF0ZSBydW50aW1lIGZpbGVzIGluIC9ldGMs
IGUuZy4gL2V0Yy9tdGFiLCAvZXRjL0hPU1ROQU1FLg0KIGZpbGVfdHlwZV9h
dXRvX3RyYW5zKGluaXRyY190LCBldGNfdCwgZXRjX3J1bnRpbWVfdCkNCklu
ZGV4OiBzZWxpbnV4L3BvbGljeS9tYWNyb3MvZ2xvYmFsX21hY3Jvcy50ZQ0K
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KUkNTIGZpbGU6IC9jdnMvbHNtL3Nl
bGludXgvcG9saWN5L21hY3Jvcy9nbG9iYWxfbWFjcm9zLnRlLHYNCnJldHJp
ZXZpbmcgcmV2aXNpb24gMS4yNg0KZGlmZiAtdSAtcjEuMjYgZ2xvYmFsX21h
Y3Jvcy50ZQ0KLS0tIHNlbGludXgvcG9saWN5L21hY3Jvcy9nbG9iYWxfbWFj
cm9zLnRlCTIwMDIvMDkvMjcgMTQ6NDA6NDYJMS4yNg0KKysrIHNlbGludXgv
cG9saWN5L21hY3Jvcy9nbG9iYWxfbWFjcm9zLnRlCTIwMDIvMDkvMjcgMTY6
MTA6MDcNCkBAIC02NzcsMTAgKzY3Nyw2IEBADQogYWxsb3cgJDEgcmVhZGFi
bGVfdDpkaXIgcl9kaXJfcGVybXM7DQogYWxsb3cgJDEgcmVhZGFibGVfdDpu
b3RkZXZmaWxlX2NsYXNzX3NldCByX2ZpbGVfcGVybXM7DQogDQotIyBSZWFk
IGRpcmVjdG9yaWVzIGFuZCBmaWxlcyB3aXRoIHRoZSBkZWZhdWx0IGZpbGUg
dHlwZSAoZmlsZV90KS4NCi1hbGxvdyAkMSBmaWxlX3Q6ZGlyIHJfZGlyX3Bl
cm1zOw0KLWFsbG93ICQxIGZpbGVfdDp7IGZpbGUgbG5rX2ZpbGUgfSByX2Zp
bGVfcGVybXM7DQotDQogIyBTdGF0IC8uLi5zZWN1cml0eSBhbmQgbG9zdCtm
b3VuZC4NCiBhbGxvdyAkMSBmaWxlX2xhYmVsc190OmRpciBnZXRhdHRyOw0K
IGFsbG93ICQxIGxvc3RfZm91bmRfdDpkaXIgZ2V0YXR0cjsNCg==
---559023410-1804928587-1033143261=:9356--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
