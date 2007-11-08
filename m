Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA8ENIb8032465
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2007 09:23:18 -0500
Received: from mail.asahi-net.or.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA8EMvrT012166
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2007 14:23:03 GMT
Message-ID: <47331BAB.8040107@kaigai.gr.jp>
Date: Thu, 08 Nov 2007 23:22:35 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, cpebenito@tresys.com,
        selinux@tycho.nsa.gov
Subject: Re: security context for SPD entries of labeled IPsec
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com>
In-Reply-To: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com>
Content-Type: multipart/mixed;
 boundary="------------070204080009070102050308"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070204080009070102050308
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi, Venkat

Thanks for your suggestion.

I got a success to set up labeled ipsec connection with modified
reference policy, as follows:

----------------------------------------------------------------
[kaigai@fedora8 ~]$ psql -q -h 192.168.1.10 postgres
Password:
postgres=# SELECT sepgsql_getcon();
                 sepgsql_getcon
-------------------------------------------------
 root:system_r:unconfined_t:SystemLow-SystemHigh
(1 row)

postgres=#

[kaigai@fedora8 ~]$ runcon -l s0 psql -q -h 192.168.1.10 postgres
Password:
postgres=# SELECT sepgsql_getcon();
       sepgsql_getcon
----------------------------
 root:system_r:unconfined_t
(1 row)

postgres=#
----------------------------------------------------------------

The attached patch provides two new interfaces to access the default
context of SPD entries (ipsec_spd_t), and enables unconfined domains
to set up SPD entries with the default context.
In addition, any unconfined domain, user domain and daemon domain
got being possible to communicate others via labeled ipsec.

Please review it,

Thanks,

Venkat Yekkirala wrote:
> <snip>
>>> There are 2 aspects:
>>>
>>> 1. IPsec policy matching discussed above:
>>>    allow domain-that-should-use-labeled-ipsec 
>> ipsec_spd_t:association { polmatch };
>>> 2. Use of IPsec associations themselves:
>>>
>>>    For sending:
>>>    allow 
>> domain-that-should-use-labeled-ipsec-to-label-its-packets 
>> self:association { sendto };
>>>    For receiving:
>>>    allow domain-that-should-received-from-peer  peer-domain 
>> self:association { recvfrom };
>>
>> When we consider the case unconfined_t process tries to 
>> communicate with a postgresql_t
>> process running on another host via labeled IPsec, the 
>> following policy will be needed.
>>
>> 1.  allow unconfined_t ipsec_spd_t : association { polmatch };
> 
> Also, allow postgresql_t ipsec_spd_t : association { polmatch };
> since the incoming packet labeled postgresql_t should be checked
> against IPsec policy (SPD) rule labeled with ipsec_spd_t.
> 
>> 2s. allow unconfined_t self : association { sendto };
> 
> OK.
> 
>> 2r. allow postgresql_t unconfined_t : association { recvfrom };
> 
> This should actually be:
> 
> allow unconfined_t postgresql_t : association { recvfrom };
> 
> since it would be the unconfined_t socket that would be receiving
> a packet using the postgresql_t association.
> 
>> Is it correct?
>>
> <snip>
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>


--------------070204080009070102050308
Content-Type: text/plain;
 name="refpolicy-labeled-ipsec.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="refpolicy-labeled-ipsec.patch"

SW5kZXg6IHJlZnBvbGljeS9wb2xpY3kvbW9kdWxlcy9zeXN0ZW0vaXBzZWMuaWYKPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQotLS0gcmVmcG9saWN5L3BvbGljeS9tb2R1bGVzL3N5c3RlbS9pcHNlYy5pZgko
cmV2aXNpb24gMjQ4MykKKysrIHJlZnBvbGljeS9wb2xpY3kvbW9kdWxlcy9zeXN0ZW0vaXBz
ZWMuaWYJKHdvcmtpbmcgY29weSkKQEAgLTExNCw2ICsxMTQsNDMgQEAKIAogIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwogIyMgPHN1bW1hcnk+CisjIyAgICAg
IEFsbG93IHRvIGNvbW11bmljYXRlIGFub3RoZXIgcGVlciB2aWEgbGFiZWxlZCBJUHNlYy4K
KyMjIDwvc3VtbWFyeT4KKyMjIDxwYXJhbSBuYW1lPSJkb21haW4iPgorIyMgICAgICA8c3Vt
bWFyeT4KKyMjICAgICAgVGhlIHR5cGUgb2YgdGhlIHByb2Nlc3MgcGVyZm9ybWluZyB0aGlz
IGFjdGlvbi4KKyMjICAgICAgPC9zdW1tYXJ5PgorIyMgPC9wYXJhbT4KKyMKK2ludGVyZmFj
ZShgaXBzZWNfZGVmYXVsdF9zZW5kcmVjdicsYAorCWdlbl9yZXF1aXJlKGAKKwkJdHlwZSBp
cHNlY19zcGRfdDsKKwknKQorCisJYWxsb3cgJDEgaXBzZWNfc3BkX3QgOiBhc3NvY2lhdGlv
biB7IHBvbG1hdGNoIH07CisJZG9tYWluX2lwc2VjX2xhYmVscygkMSkKKycpCisKKyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKKyMjIDxzdW1tYXJ5PgorIyMg
ICAgICBBbGxvdyB0byBzZXQgYW4gZGVmYXVsdCBzZWN1cml0eSBjb250ZXh0IG9mIElQc2Vj
IFBvbGljeS4KKyMjIDwvc3VtbWFyeT4KKyMjIDxwYXJhbSBuYW1lPSJkb21haW4iPgorIyMg
ICAgICA8c3VtbWFyeT4KKyMjICAgICAgVGhlIHR5cGUgb2YgdGhlIHByb2Nlc3MgcGVyZm9y
bWluZyB0aGlzIGFjdGlvbi4KKyMjICAgICAgPC9zdW1tYXJ5PgorIyMgPC9wYXJhbT4KKyMK
K2ludGVyZmFjZShgaXBzZWNfZGVmYXVsdF9zZXRjb250ZXh0JyxgCisJZ2VuX3JlcXVpcmUo
YAorCQl0eXBlIGlwc2VjX3NwZF90OworCScpCisKKwlhbGxvdyAkMSBpcHNlY19zcGRfdCA6
IGFzc29jaWF0aW9uIHsgc2V0Y29udGV4dCB9OworJykKKworIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIworIyMgPHN1bW1hcnk+CiAjIwlFeGVjdXRlIHJhY29v
biBpbiB0aGUgcmFjb29uIGRvbWFpbi4KICMjIDwvc3VtbWFyeT4KICMjIDxwYXJhbSBuYW1l
PSJkb21haW4iPgpJbmRleDogcmVmcG9saWN5L3BvbGljeS9tb2R1bGVzL3N5c3RlbS91c2Vy
ZG9tYWluLmlmCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIHJlZnBvbGljeS9wb2xpY3kvbW9kdWxlcy9z
eXN0ZW0vdXNlcmRvbWFpbi5pZgkocmV2aXNpb24gMjQ4MykKKysrIHJlZnBvbGljeS9wb2xp
Y3kvbW9kdWxlcy9zeXN0ZW0vdXNlcmRvbWFpbi5pZgkod29ya2luZyBjb3B5KQpAQCAtNTQ3
LDYgKzU0NywxMCBAQAogCWNvcmVuZXRfdWRwX3NlbmRyZWN2X2FsbF9wb3J0cygkMV90KQog
CWNvcmVuZXRfdGNwX2Nvbm5lY3RfYWxsX3BvcnRzKCQxX3QpCiAJY29yZW5ldF9zZW5kcmVj
dl9hbGxfY2xpZW50X3BhY2tldHMoJDFfdCkKKworCW9wdGlvbmFsX3BvbGljeShgCisJCWlw
c2VjX2RlZmF1bHRfc2VuZHJlY3YoJDFfdCkKKwknKQogJykKIAogIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCkluZGV4OiByZWZwb2xpY3kvcG9saWN5L21vZHVs
ZXMvc3lzdGVtL2luaXQuaWYKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gcmVmcG9saWN5L3BvbGljeS9t
b2R1bGVzL3N5c3RlbS9pbml0LmlmCShyZXZpc2lvbiAyNDgzKQorKysgcmVmcG9saWN5L3Bv
bGljeS9tb2R1bGVzL3N5c3RlbS9pbml0LmlmCSh3b3JraW5nIGNvcHkpCkBAIC0xMzQsNiAr
MTM0LDEwIEBACiAJJykKIAogCW9wdGlvbmFsX3BvbGljeShgCisJCWlwc2VjX2RlZmF1bHRf
c2VuZHJlY3YoJDEpCisJJykKKworCW9wdGlvbmFsX3BvbGljeShgCiAJCW5zY2Rfc29ja2V0
X3VzZSgkMSkKIAknKQogJykKSW5kZXg6IHJlZnBvbGljeS9wb2xpY3kvbW9kdWxlcy9zeXN0
ZW0vdW5jb25maW5lZC5pZgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSByZWZwb2xpY3kvcG9saWN5L21v
ZHVsZXMvc3lzdGVtL3VuY29uZmluZWQuaWYJKHJldmlzaW9uIDI0ODMpCisrKyByZWZwb2xp
Y3kvcG9saWN5L21vZHVsZXMvc3lzdGVtL3VuY29uZmluZWQuaWYJKHdvcmtpbmcgY29weSkK
QEAgLTczLDYgKzczLDExIEBACiAJJykKIAogCW9wdGlvbmFsX3BvbGljeShgCisJCWlwc2Vj
X2RlZmF1bHRfc2V0Y29udGV4dCgkMSkKKwkJaXBzZWNfZGVmYXVsdF9zZW5kcmVjdigkMSkK
KwknKQorCisJb3B0aW9uYWxfcG9saWN5KGAKIAkJIyB0aGlzIGlzIHRvIGhhbmRsZSBleGVj
bW9kIG9uIHNoYXJlZAogCQkjIGxpYnMgd2l0aCB0ZXh0IHJlbG9jYXRpb25zCiAJCWxpYnNf
dXNlX3NoYXJlZF9saWJzKCQxKQpJbmRleDogcmVmcG9saWN5L3BvbGljeS9tb2R1bGVzL3N5
c3RlbS9pcHNlYy50ZQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSByZWZwb2xpY3kvcG9saWN5L21vZHVs
ZXMvc3lzdGVtL2lwc2VjLnRlCShyZXZpc2lvbiAyNDgzKQorKysgcmVmcG9saWN5L3BvbGlj
eS9tb2R1bGVzL3N5c3RlbS9pcHNlYy50ZQkod29ya2luZyBjb3B5KQpAQCAtNiw2ICs2LDkg
QEAKICMgRGVjbGFyYXRpb25zCiAjCiAKKyMgRGVmYXVsdCB0eXBlIGZvciBJUFNFQyBTUEQg
ZW50cmllcwordHlwZSBpcHNlY19zcGRfdDsKKwogdHlwZSBpcHNlY190OwogdHlwZSBpcHNl
Y19leGVjX3Q7CiBpbml0X2RhZW1vbl9kb21haW4oaXBzZWNfdCxpcHNlY19leGVjX3QpCkBA
IC0xOSw5ICsyMiw2IEBACiB0eXBlIGlwc2VjX2tleV9maWxlX3Q7CiBmaWxlc190eXBlKGlw
c2VjX2tleV9maWxlX3QpCiAKLSMgRGVmYXVsdCB0eXBlIGZvciBJUFNFQyBTUEQgZW50cmll
cwotdHlwZSBpcHNlY19zcGRfdDsKLQogIyB0eXBlIGZvciBydW50aW1lIGZpbGVzLCBpbmNs
dWRpbmcgcGx1dG8uY3RsCiB0eXBlIGlwc2VjX3Zhcl9ydW5fdDsKIGZpbGVzX3BpZF9maWxl
KGlwc2VjX3Zhcl9ydW5fdCkKQEAgLTI5Nyw3ICsyOTcsNyBAQAogcmVhZF9maWxlc19wYXR0
ZXJuKHJhY29vbl90LGlwc2VjX2tleV9maWxlX3QsaXBzZWNfa2V5X2ZpbGVfdCkKIHJlYWRf
bG5rX2ZpbGVzX3BhdHRlcm4ocmFjb29uX3QsaXBzZWNfa2V5X2ZpbGVfdCxpcHNlY19rZXlf
ZmlsZV90KQogCi1hbGxvdyByYWNvb25fdCBpcHNlY19zcGRfdDphc3NvY2lhdGlvbiBzZXRj
b250ZXh0OworaXBzZWNfZGVmYXVsdF9zZXRjb250ZXh0KHJhY29vbl90KQogCiBrZXJuZWxf
cmVhZF9uZXR3b3JrX3N0YXRlKHJhY29vbl90KQogCkBAIC0zMzksNyArMzM5LDcgQEAKIHJl
YWRfbG5rX2ZpbGVzX3BhdHRlcm4oc2V0a2V5X3QsaXBzZWNfY29uZl9maWxlX3QsaXBzZWNf
Y29uZl9maWxlX3QpCiAKICMgYWxsb3cgc2V0a2V5IHRvIHNldCB0aGUgY29udGV4dCBmb3Ig
aXBzZWMgU0FzIGFuZCBwb2xpY3kuCi1hbGxvdyBzZXRrZXlfdCBpcHNlY19zcGRfdDphc3Nv
Y2lhdGlvbiBzZXRjb250ZXh0OworaXBzZWNfZGVmYXVsdF9zZXRjb250ZXh0KHNldGtleV90
KQogCiAjIGFsbG93IHNldGtleSB1dGlsaXR5IHRvIHNldCBjb250ZXh0cyBvbiBTQSdzIGFu
ZCBwb2xpY3kKIGRvbWFpbl9pcHNlY19zZXRjb250ZXh0X2FsbF9kb21haW5zKHNldGtleV90
KQo=
--------------070204080009070102050308--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
