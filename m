Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA00043
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 10:18:57 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA04801
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 15:17:35 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id PAA04797
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 15:17:33 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 0A50392443
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 02:18:52 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id E572365C
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 16:18:44 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: my latest efforts for dhcp client and server
Date: Thu, 21 Mar 2002 16:18:44 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_87XBU57HV2XBHUG79UHR"
Message-Id: <20020321151844.E572365C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_87XBU57HV2XBHUG79UHR
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

The file_contexts is below and the .te files are attached.
/var/lib/dhcp                   system_u:object_r:dhcp_state_t
/var/lib/dhcp/dhclient.*        system_u:object_r:dhcpc_state_t
/var/lib/dhcp/dhcpd.leases.*    system_u:object_r:dhcpd_state_t
/etc/dhcpc.*(|/.*)              system_u:object_r:etc_dhcpc_t
/etc/dhclient.conf              system_u:object_r:etc_dhcpc_t
/etc/dhclient-script            system_u:object_r:etc_dhcpc_t
/etc/dhcpd.conf                 system_u:object_r:etc_dhcpd_t
/sbin/dhcpcd                    system_u:object_r:dhcpc_exec_t
/sbin/dhclient.*                system_u:object_r:dhcpc_exec_t
/usr/sbin/dhcpd(|-.*)           system_u:object_r:dhcpd_exec_t

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--------------Boundary-00=_87XBU57HV2XBHUG79UHR
Content-Type: text/plain;
  charset="us-ascii";
  name="dhcpc.te"
Content-Transfer-Encoding: base64
Content-Description: dhcpc.te
Content-Disposition: attachment; filename="dhcpc.te"

IwojIEF1dGhvcnM6ICBXYXluZSBTYWxhbW9uIChOQUkgTGFicykgPHdzYWxhbW9uQHRpc2xhYnMu
Y29tPgojCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKIwojIFJ1bGVzIGZvciB0
aGUgZGhjcGNfdCBkb21haW4uCiMKIyBkaGNwY190IGlzIHRoZSBkb21haW4gZm9yIHRoZSBjbGll
bnQgc2lkZSBvZiBESENQLiBkaGNwY2QsIHRoZSBESENQIAojIG5ldHdvcmsgY29uZmlndXJhdG9y
IGRhZW1vbiBzdGFydGVkIGJ5IC9ldGMvc3lzY29uZmlnL25ldHdvcmstc2NyaXB0cyAKIyByYyBz
Y3JpcHRzLCBydW5zIGluIHRoaXMgZG9tYWluLgojIGRoY3BjX2V4ZWNfdCBpcyB0aGUgdHlwZSBv
ZiB0aGUgZGhjcGNkIGV4ZWN1dGFibGUuCiMgVGhlIGRoY3BjX3QgY2FuIGJlIHVzZWQgZm9yIG90
aGVyIERIQ1BDIHJlbGF0ZWQgZmlsZXMgYXMgd2VsbC4KIwp0eXBlIGRoY3BjX3QsIGRvbWFpbiwg
cHJpdmxvZzsKcm9sZSBzeXN0ZW1fciB0eXBlcyBkaGNwY190OwpldmVyeV9kb21haW4oZGhjcGNf
dCkKdHlwZSBkaGNwY19leGVjX3QsIGZpbGVfdHlwZSwgc3lzYWRtZmlsZSwgZXhlY190eXBlOwpk
b21haW5fYXV0b190cmFucyhpbml0cmNfdCwgZGhjcGNfZXhlY190LCBkaGNwY190KQp0eXBlX3Ry
YW5zaXRpb24gaW5pdF90IGRoY3BjX2V4ZWNfdDpwcm9jZXNzIGRoY3BjX3Q7CgojIFR5cGUgZm9y
IGZpbGVzIGNyZWF0ZWQgZHVyaW5nIGV4ZWN1dGlvbiBvZiBkaGNwY2QuCnR5cGUgZGhjcGNfdmFy
X3J1bl90LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGU7CnR5cGUgZGhjcGNfc3RhdGVfdCwgZmlsZV90
eXBlLCBzeXNhZG1maWxlOwp0eXBlIGV0Y19kaGNwY190LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGU7
CmZpbGVfdHlwZV9hdXRvX3RyYW5zKGRoY3BjX3QsIHZhcl9ydW5fdCwgZGhjcGNfdmFyX3J1bl90
KQoKIyBJbmhlcml0IGFuZCB1c2UgZGVzY3JpcHRvcnMgZnJvbSBpbml0LgphbGxvdyBkaGNwY190
IGluaXRfdDpmZCBpbmhlcml0X2ZkX3Blcm1zOwoKIyBVc2UgdGhlIG5ldHdvcmsuCmNhbl9uZXR3
b3JrKGRoY3BjX3QpCgojIFVzZSBjYXBhYmlsaXRpZXMKYWxsb3cgZGhjcGNfdCBkaGNwY190OmNh
cGFiaWxpdHkgeyBuZXRfYWRtaW4gbmV0X3JhdyB9OwoKIyBBbGxvdyByZWFkL3dyaXRlIHRvIC9l
dGMvcmVzb2x2LmNvbmYuIE5vdGUgdGhhdCBhbnkgZmlsZXMgaW4gL2V0YyAKIyBjcmVhdGVkIGJ5
IGRoY3BjZCB3aWxsIGJlIGxhYmVsbGVkIHJlc29sdl9jb25mX3QuIEFzIG9mIFJIIDcuMiwgbm8K
IyBvdGhlciBmaWxlcyBhcmUgYWNjZXNzZWQgaW4gdGhlIC9ldGMgZGlyLCBvbmx5IGluIC9ldGMv
ZGhjcGMgZGlyLgphbGxvdyBkaGNwY190IHJlc29sdl9jb25mX3Q6ZmlsZSByd19maWxlX3Blcm1z
OwpmaWxlX3R5cGVfYXV0b190cmFucyhkaGNwY190LCBldGNfdCwgcmVzb2x2X2NvbmZfdCkKCiMg
QWxsb3cgYWNjZXNzIHRvIHRoZSBkaGNwYyBmaWxlIHR5cGVzCmFsbG93IGRoY3BjX3QgZXRjX2Ro
Y3BjX3Q6ZmlsZSByd19maWxlX3Blcm1zOwphbGxvdyBkaGNwY190IGV0Y19kaGNwY190OmRpciBy
d19kaXJfcGVybXM7CmNhbl9leGVjKGRoY3BjX3QsIGV0Y19kaGNwY190KQoKIyBBbGxvdyBkaGNw
Y190IHRvIHVzZSBwYWNrZXQgc29ja2V0cwphbGxvdyBkaGNwY190IGRoY3BjX3Q6cGFja2V0X3Nv
Y2tldCBjcmVhdGVfc29ja2V0X3Blcm1zOwphbGxvdyBkaGNwY190IG5ldG1zZ19ldGgwX3Q6cGFj
a2V0X3NvY2tldCB7IHJlY3Zmcm9tIH07CgpjYW5fZXhlYyhkaGNwY190LCB7IGJpbl90IHNoZWxs
X2V4ZWNfdCB9KQo=

--------------Boundary-00=_87XBU57HV2XBHUG79UHR
Content-Type: text/plain;
  charset="us-ascii";
  name="dhcpd.te"
Content-Transfer-Encoding: base64
Content-Description: dhcpd.te
Content-Disposition: attachment; filename="dhcpd.te"

IwojIEF1dGhvcnM6IFJ1c3NlbGwgQ29rZXIgPHJ1c3NlbGxAY29rZXIuY29tLmF1PiAKIyBiYXNl
ZCBvbiB0aGUgZGhjcGNfdCBwb2xpY3kgZnJvbToKIyAgICAgICAgICBXYXluZSBTYWxhbW9uIChO
QUkgTGFicykgPHdzYWxhbW9uQHRpc2xhYnMuY29tPgojCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMKIwojIFJ1bGVzIGZvciB0aGUgZGhjcGRfdCBkb21haW4uCiMKIyBkaGNwZF90
IGlzIHRoZSBkb21haW4gZm9yIHRoZSBzZXJ2ZXIgc2lkZSBvZiBESENQLiBkaGNwZCwgdGhlIERI
Q1AgCiMgc2VydmVyIGRhZW1vbiByYyBzY3JpcHRzLCBydW5zIGluIHRoaXMgZG9tYWluLgojIGRo
Y3BkX2V4ZWNfdCBpcyB0aGUgdHlwZSBvZiB0aGUgZGhjcGRkIGV4ZWN1dGFibGUuCiMgVGhlIGRo
Y3BkX3QgY2FuIGJlIHVzZWQgZm9yIG90aGVyIERIQ1BDIHJlbGF0ZWQgZmlsZXMgYXMgd2VsbC4K
Iwp0eXBlIGRoY3BkX3QsIGRvbWFpbiwgcHJpdmxvZzsKdHlwZSBkaGNwZF9leGVjX3QsIGZpbGVf
dHlwZSwgc3lzYWRtZmlsZSwgZXhlY190eXBlOwoKcm9sZSBzeXN0ZW1fciB0eXBlcyBkaGNwZF90
OwoKIyBUeXBlIGZvciBmaWxlcyBjcmVhdGVkIGR1cmluZyBleGVjdXRpb24gb2YgZGhjcGRkLgp0
eXBlIGRoY3BkX3Zhcl9ydW5fdCwgZmlsZV90eXBlLCBzeXNhZG1maWxlOwp0eXBlIGV0Y19kaGNw
ZF90LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGU7CmZpbGVfdHlwZV9hdXRvX3RyYW5zKGRoY3BkX3Qs
IHZhcl9ydW5fdCwgZGhjcGRfdmFyX3J1bl90KQphbGxvdyBkaGNwZF90IHsgdmFyX3QgdmFyX2xp
Yl90IH06ZGlyIHJfZGlyX3Blcm1zOwoKIyBJbmhlcml0IGFuZCB1c2UgZGVzY3JpcHRvcnMgZnJv
bSBpbml0LCBhbmQgc2VuZCBTSUdDSExELgphbGxvdyBkaGNwZF90IGluaXRfdDpmZCBpbmhlcml0
X2ZkX3Blcm1zOwphbGxvdyBkaGNwZF90IGluaXRfdDpwcm9jZXNzIHNpZ2NobGQ7CgojIFVzZSB0
aGUgbmV0d29yay4KY2FuX25ldHdvcmsoZGhjcGRfdCkKYWxsb3cgZGhjcGRfdCBkaGNwZF90OnVu
aXhfZGdyYW1fc29ja2V0IGNyZWF0ZV9zb2NrZXRfcGVybXM7CgojIFVzZSBjYXBhYmlsaXRpZXMK
YWxsb3cgZGhjcGRfdCBkaGNwZF90OmNhcGFiaWxpdHkgeyBuZXRfcmF3IG5ldF9iaW5kX3NlcnZp
Y2UgfTsKCiMgQWxsb3cgYWNjZXNzIHRvIHRoZSBkaGNwZCBmaWxlIHR5cGVzCnR5cGUgZGhjcF9z
dGF0ZV90LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGU7CnR5cGUgZGhjcGRfc3RhdGVfdCwgZmlsZV90
eXBlLCBzeXNhZG1maWxlOwphbGxvdyBkaGNwZF90IGV0Y19kaGNwZF90OmZpbGUgcl9maWxlX3Bl
cm1zOwpmaWxlX3R5cGVfYXV0b190cmFucyhkaGNwZF90LCBkaGNwX3N0YXRlX3QsIGRoY3BkX3N0
YXRlX3QpCgojIEFsbG93IGRoY3BkX3QgcHJvZ3JhbXMgdG8gZXhlY3V0ZSB0aGVtc2VsdmVzIGFu
ZCBiaW5fdCAodW5hbWUgZXRjKQpjYW5fZXhlYyhkaGNwZF90LCB7IGRoY3BkX2V4ZWNfdCBiaW5f
dCB9KQoKIyBBbGxvdyBkaGNwZF90IHRvIHVzZSBwYWNrZXQgc29ja2V0cwphbGxvdyBkaGNwZF90
IGRoY3BkX3Q6cGFja2V0X3NvY2tldCBjcmVhdGVfc29ja2V0X3Blcm1zOwphbGxvdyBkaGNwZF90
IGRoY3BkX3Q6cmF3aXBfc29ja2V0IGNyZWF0ZV9zb2NrZXRfcGVybXM7CmFsbG93IGRoY3BkX3Qg
bmV0bXNnX2V0aDBfdDpwYWNrZXRfc29ja2V0IHsgcmVjdmZyb20gfTsKYWxsb3cgZGhjcGRfdCBu
ZXRtc2dfZXRoMF90OnBhY2tldF9zb2NrZXQgeyByZWN2ZnJvbSB9OwoKIyBhbGxvdyB0byBydW4g
dXRpbGl0aWVzIGFuZCBzY3JpcHRzCmFsbG93IGRoY3BkX3QgeyBsZF9zb190IGJpbl90IHNiaW5f
dCB9OmRpciByX2Rpcl9wZXJtczsKYWxsb3cgZGhjcGRfdCB7IGxkX3NvX3QgYmluX3Qgc2Jpbl90
IH06eyBmaWxlIGxua19maWxlIH0gcnhfZmlsZV9wZXJtczsKYWxsb3cgZGhjcGRfdCBkaGNwZF90
OmZpZm9fZmlsZSB7IHJlYWQgd3JpdGUgZ2V0YXR0ciB9OwphbGxvdyBkaGNwZF90IGRoY3BkX3Q6
cHJvY2VzcyB7IHNpZ2NobGQgZm9yayB9OwoKIyBhbGxvdyByZWFkaW5nIC9wcm9jCmFsbG93IGRo
Y3BkX3QgcHJvY190OmRpciByX2Rpcl9wZXJtczsKYWxsb3cgZGhjcGRfdCBwcm9jX3Q6eyBmaWxl
IGxua19maWxlIH0gcl9maWxlX3Blcm1zOwoKZG9tYWluX2F1dG9fdHJhbnMoaW5pdHJjX3QsIGRo
Y3BkX2V4ZWNfdCwgZGhjcGRfdCkKCg==

--------------Boundary-00=_87XBU57HV2XBHUG79UHR--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
