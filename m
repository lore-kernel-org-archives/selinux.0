Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA22581
	for <selinux@tycho.nsa.gov>; Tue, 26 Mar 2002 13:44:19 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA11663
	for <selinux@tycho.nsa.gov>; Tue, 26 Mar 2002 18:43:15 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id SAA11659 for <selinux@tycho.nsa.gov>; Tue, 26 Mar 2002 18:43:14 GMT
Date: Tue, 26 Mar 2002 13:44:03 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: bug in checkpolicy
In-Reply-To: <20020324161458.1BD6427D13@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203261343250.28659-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1483920592-1017168243=:28659"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1483920592-1017168243=:28659
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Sun, 24 Mar 2002, Russell Coker wrote:

> The warnings about assertions given by checkpolicy seem slightly inaccurate.
> I think that the following shows what's going wrong.
>
> /usr/bin/checkpolicy -o policy policy.conf
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> ''''''security:  6 users, 5 roles, 454 types
> security:  29 classes, 50164 rules
> assertion on line 90811 violated by allow ldconfig_exec_t shlib_t:dir {
> add_name remove_name };
> make: *** [policy] Error 1
> root@lyta:/etc/selinux# grep allow.ldconfig_exec policy.conf
> root@lyta:/etc/selinux# grep allow.ldconfig_t.shlib policy.conf
> allow ldconfig_t shlib_t:{ file lnk_file sock_file fifo_file } { create ioctl
> read getattr access lock poll write setattr append link unlink rename };
> allow ldconfig_t shlib_t:dir { create read getattr access poll setattr link
> unlink rename search add_name remove_name reparent write rmdir };
> root@lyta:/etc/selinux#

Patch attached.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-1483920592-1017168243=:28659
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="checkpolicy.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0203261344030.28659@raven>
Content-Description: 
Content-Disposition: attachment; filename="checkpolicy.patch"

SW5kZXg6IG1vZHVsZS9jaGVja3BvbGljeS9jaGVja3BvbGljeS5jDQo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2cy9sc20vc2VsaW51
eC9tb2R1bGUvY2hlY2twb2xpY3kvY2hlY2twb2xpY3kuYyx2DQpyZXRyaWV2
aW5nIHJldmlzaW9uIDEuNw0KcmV0cmlldmluZyByZXZpc2lvbiAxLjgNCmRp
ZmYgLXUgLXIxLjcgLXIxLjgNCi0tLSBtb2R1bGUvY2hlY2twb2xpY3kvY2hl
Y2twb2xpY3kuYwkyMDAyLzAzLzAxIDIwOjM5OjMzCTEuNw0KKysrIG1vZHVs
ZS9jaGVja3BvbGljeS9jaGVja3BvbGljeS5jCTIwMDIvMDMvMjUgMTg6MTY6
MTQJMS44DQpAQCAtMjU0LDcgKzI1NCw3IEBADQogDQogCQlpZiAoKGF2ZGF0
dW1wLT5zcGVjaWZpZWQgJiBBVlRBQl9BTExPV0VEKSAmJg0KIAkJICAgIChh
dnRhYl9hbGxvd2VkKGF2ZGF0dW1wKSAmIGF2cFtrXSkpIHsNCi0JCQlmcHJp
bnRmKHN0ZGVyciwgImFzc2VydGlvbiBvbiBsaW5lICVsZCB2aW9sYXRlZCBi
eSBhbGxvdyAlcyAlczolcyB7JXMgfTtcbiIsIGxpbmUsIHBvbGljeWRiLnBf
dHlwZV92YWxfdG9fbmFtZVtzdHlwZSsxXSwgcG9saWN5ZGIucF90eXBlX3Zh
bF90b19uYW1lW3R0eXBlKzFdLCBwb2xpY3lkYi5wX2NsYXNzX3ZhbF90b19u
YW1lW2tdLCANCisJCQlmcHJpbnRmKHN0ZGVyciwgImFzc2VydGlvbiBvbiBs
aW5lICVsZCB2aW9sYXRlZCBieSBhbGxvdyAlcyAlczolcyB7JXMgfTtcbiIs
IGxpbmUsIHBvbGljeWRiLnBfdHlwZV92YWxfdG9fbmFtZVtzdHlwZV0sIHBv
bGljeWRiLnBfdHlwZV92YWxfdG9fbmFtZVt0dHlwZV0sIHBvbGljeWRiLnBf
Y2xhc3NfdmFsX3RvX25hbWVba10sIA0KIAkJCQlhdl90b19zdHJpbmcoaysx
LA0KIAkJCQkJICAgICBhdnRhYl9hbGxvd2VkKGF2ZGF0dW1wKSAmIGF2cFtr
XSkpOw0KIAkJCXBvbGljeWRiX2Vycm9ycysrOw0K
---559023410-1483920592-1017168243=:28659--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
