Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6T9mtHa020388
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2003 05:48:56 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6T9msDW005622
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2003 09:48:54 GMT
Received: from nsa.hitachi-sk.co.jp (nsa.hitachi-sk.co.jp [202.232.217.2])
        by jazzband.ncsc.mil  with ESMTP id h6T9mqeN005613 for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2003 09:48:53 GMT
Received: from vsa.hitachi-sk.co.jp ([133.108.250.41])
	by nsa.hitachi-sk.co.jp (8.11.6/3.7W) with ESMTP id h6T9mek14522
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2003 18:48:40 +0900
Received: from gwa.hitachi-sk.co.jp (localhost [127.0.0.1])
	by vsa.hitachi-sk.co.jp (8.9.3+3.2W/3.7W) with ESMTP id SAA27149
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2003 18:48:39 +0900 (JST)
Received: (from root@localhost)
	by gwa.hitachi-sk.co.jp (8.11.6+Sun/3.7W) id h6T9mau10470
	for selinux@tycho.nsa.gov; Tue, 29 Jul 2003 18:48:37 +0900 (JST)
Received: from ori.hitachi-sk.co.jp (ori.ori.hitachi-sk.co.jp [133.108.2.2])
	by dns1.hitachi-sk.co.jp (8.11.6/3.7W) with ESMTP id h6T9mZ919444
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2003 18:48:35 +0900
Date: Tue, 29 Jul 2003 18:49:53 +0900
From: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
To: selinux@tycho.nsa.gov
Cc: ynakam@ori.hitachi-sk.co.jp
Subject: macro about network
Message-Id: <20030729184953.31a3b3fb.ynakam@ori.hitachi-sk.co.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__29_Jul_2003_18:49:53_+0900_08259420"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Multipart_Tue__29_Jul_2003_18:49:53_+0900_08259420
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


In "can_network" macro,
"allow $1 netmsg_type:tcp_socket { connectto acceptfrom };"
exists.

I think in some case "connectto" permission is not neccesary.

For example,
If worm like Slammer appeared for Apache,
"connectto" permission might be used by worm 
and Apache might used to send packet flood to other sites.

So,I would like to suggest three macros as attached to this mail.
tcp_accept_only(domain)
tcp_connect_netmsg(domain,netmsg)
can_network_except_tcp(domain)

"tcp_accept_only" macro allows domain only TCP connection from network interface,
but domain can not initiate TCP connection.

"tcp_connect_netmsg" macro is used to initiate TCP connection 
to limited network initerface.

"can_network_except_tcp" macro is used to use network generally except TCP.

Example:
tcp_accept_only(httpd_t)
tcp_connect_netmsg(httpd_t,netmsg_lo_t)
can_network_except_tcp(httpd_t)
--->"httpd_t" can initiate TCP connection only to network interface "lo",
and can use UDP socket.

I think it is useful if there are more fine grained macros(macros to control access to NICs,nodes).

--------------------
Yuichi Nakamura
Research&Development Department
Hitachi Software Engineering Co.,Ltd.
ynakam@ori.hitachi-sk.co.jp
http://www.selinux.hitachi-sk.co.jp/en/(SELinux Policy Editor)















--Multipart_Tue__29_Jul_2003_18:49:53_+0900_08259420
Content-Type: application/octet-stream;
 name="acceptonly_macro.te"
Content-Disposition: attachment;
 filename="acceptonly_macro.te"
Content-Transfer-Encoding: base64

IyMjIyMjIyMjIyMjIwojIHRjcF9hY2NlcHRfb25seShkb21haW4pCiMgUGVybWlzc2lvbnMgdG8g
YWNjZXB0IFRDUCBjb25uZWN0aW9uLgojIGRvbWFpbiBjYW4gbm90IGluaXRpYXRlIFRDUCBjb25u
ZWN0aW9uCiMgU3Vic2V0IG9mICJjYW5fbmV0d29yayIgbWFjcm8uCiMgVGhpcyB3aWxsIGJlIHVz
ZWZ1bCB0byBwcmV2ZW50IGF0dGFjayBsaWtlIFNsYW1tZXIgd29ybS4KZGVmaW5lKGB0Y3BfYWNj
ZXB0X29ubHknLGAKIyBBbGxvdyB0aGUgZG9tYWluIHRvIGNyZWF0ZSBUQ1Agc29ja2V0cy4KIyBP
dGhlciBraW5kcyBvZiBzb2NrZXRzIG11c3QgYmUgc2VwYXJhdGVseSBhdXRob3JpemVkIGZvciB1
c2UuCmFsbG93ICQxIHNlbGY6dGNwX3NvY2tldCBjcmVhdGVfc3RyZWFtX3NvY2tldF9wZXJtczsK
CiMgQWxsb3cgdGhlIGRvbWFpbiB0byBzZW5kIHVzaW5nIGFueSBuZXR3b3JrIGludGVyZmFjZS4K
IyBuZXRpZl90eXBlIGlzIGEgdHlwZSBhdHRyaWJ1dGUgZm9yIGFsbCBuZXR3b3JrIGludGVyZmFj
ZSB0eXBlcy4KYWxsb3cgJDEgbmV0aWZfdHlwZTpuZXRpZiB7IHRjcF9zZW5kIH07CgojCiMgQWxs
b3cgdGNwIHBhY2tldHMgc2VudCBieSB0aGUgZG9tYWluIHRvIGJlIHJlY2VpdmVkIG9uIGFueSBu
ZXR3b3JrIGludGVyZmFjZS4KYWxsb3cgJDEgbmV0aWZfdHlwZTpuZXRpZiB7IHRjcF9yZWN2IH07
CgojIEFsbG93IHRoZSBkb21haW4gdG8gcmVjZWl2ZSB0Y3AgcGFja2V0cyBmcm9tIGFueSBuZXR3
b3JrIGludGVyZmFjZS4KIyBuZXRtc2dfdHlwZSBpcyBhIHR5cGUgYXR0cmlidXRlIGZvciBhbGwg
ZGVmYXVsdCBtZXNzYWdlIHR5cGVzLgphbGxvdyAkMSBuZXRtc2dfdHlwZTp7IHRjcF9zb2NrZXQg
fSByZWN2ZnJvbTsKCiMgQWxsb3cgdGhlIGRvbWFpbiB0byBpbml0aWF0ZSBvciBhY2NlcHQgVENQ
IGNvbm5lY3Rpb25zIAojIG9uIGFueSBuZXR3b3JrIGludGVyZmFjZS4KYWxsb3cgJDEgbmV0bXNn
X3R5cGU6dGNwX3NvY2tldCB7IGFjY2VwdGZyb20gfTsKCiMgUmVjZWl2ZSByZXNldHMgZnJvbSB0
aGUgVENQIHJlc2V0IHNvY2tldC4KIyBUaGUgVENQIHJlc2V0IHNvY2tldCBpcyBsYWJlbGVkIHdp
dGggdGhlIHRjcF9zb2NrZXRfdCB0eXBlLgojCmFsbG93ICQxIHRjcF9zb2NrZXRfdDp0Y3Bfc29j
a2V0IHJlY3Zmcm9tOwpkb250YXVkaXQgJDEgdGNwX3NvY2tldF90OnRjcF9zb2NrZXQgY29ubmVj
dHRvOwoKCiMgQWxsb3cgdGhlIGRvbWFpbiB0byBzZW5kIHRvIGFueSBub2RlLgojIG5vZGVfdHlw
ZSBpcyBhIHR5cGUgYXR0cmlidXRlIGZvciBhbGwgbm9kZSB0eXBlcy4KYWxsb3cgJDEgbm9kZV90
eXBlOm5vZGUgeyB0Y3Bfc2VuZCB9OwoKCiMgQWxsb3cgcGFja2V0cyBzZW50IGJ5IHRoZSBkb21h
aW4gdG8gYmUgcmVjZWl2ZWQgZnJvbSBhbnkgbm9kZS4KYWxsb3cgJDEgbm9kZV90eXBlOm5vZGUg
eyB0Y3BfcmVjdiB9OwoKIyBCaW5kIHRvIHRoZSBkZWZhdWx0IHBvcnQgdHlwZS4KIyBPdGhlciBw
b3J0IHR5cGVzIG11c3QgYmUgc2VwYXJhdGVseSBhdXRob3JpemVkLgphbGxvdyAkMSBwb3J0X3Q6
dGNwX3NvY2tldCBuYW1lX2JpbmQ7CicpCgoKIyMjIyMjIyMjIyMjCiN0Y3BfY29ubmVjdF9uZXRt
c2coZG9tYWluLG5ldG1zZykKI1RoaXMgaXMgdXNlZCB3aXRoICJ0Y3BfYWNjZXB0X29ubHkiIG1h
Y3JvLgojSWYgeW91IHdhbnQgdG8gYWxsb3cgZG9tYWluIGNvbm5lY3QgdG8gb25seSAiZXRoMCIu
CiN0aGVuICwgdXNlICJ0Y3BfY29ubmVjdF9uZXRtc2coPHlvdXIgZG9tYWluIG5hbWU+LG5ldG1z
Z19ldGgwX3QpOwpkZWZpbmUoYHRjcF9jb25uZWN0X25ldG1zZycsYAojIEFsbG93IHRoZSBkb21h
aW4gdG8gaW5pdGlhdGUgb3IgYWNjZXB0IFRDUCBjb25uZWN0aW9ucyAKIyBvbiBhbnkgbmV0d29y
ayBpbnRlcmZhY2UuCmFsbG93ICQxICQyOnRjcF9zb2NrZXQgeyBjb25uZWN0dG8gfTsKJykKCgoj
IyMjIyMjIyMjCiNjYW5fdWRwX25ldHdvcmtfZXhjZXB0X3RjcChkb21haW4pCiNQZXJtaXNzaW9u
cyBmb3IgYWNjZXNzaW5nIHRoZSBuZXR3b3JrIGV4Y2VwdCBmb3IgVENQLgpkZWZpbmUoYGNhbl9u
ZXR3b3JrX2V4Y2VwdF90Y3AnLGAKIwojIEFsbG93IHRoZSBkb21haW4gdG8gY3JlYXRlIGFuZCB1
c2UgVURQIHNvY2tldHMuCiMgT3RoZXIga2luZHMgb2Ygc29ja2V0cyBtdXN0IGJlIHNlcGFyYXRl
bHkgYXV0aG9yaXplZCBmb3IgdXNlLgphbGxvdyAkMSBzZWxmOnVkcF9zb2NrZXQgY3JlYXRlX3Nv
Y2tldF9wZXJtczsKCiMgQWxsb3cgdGhlIGRvbWFpbiB0byBzZW5kIFVEUCBwYWNrZXRzLgojIFNp
bmNlIHRoZSBkZXN0aW5hdGlvbiBzb2NrZXRzIHR5cGUgaXMgdW5rbm93biwgdGhlIGdlbmVyaWMK
IyBhbnlfc29ja2V0X3QgdHlwZSBpcyB1c2VkIGFzIGEgcGxhY2Vob2xkZXIuCgphbGxvdyAkMSBh
bnlfc29ja2V0X3Q6dWRwX3NvY2tldCBzZW5kdG87CgojCiMgQWxsb3cgdGhlIGRvbWFpbiB0byBz
ZW5kIHVzaW5nIGFueSBuZXR3b3JrIGludGVyZmFjZS4KIyBuZXRpZl90eXBlIGlzIGEgdHlwZSBh
dHRyaWJ1dGUgZm9yIGFsbCBuZXR3b3JrIGludGVyZmFjZSB0eXBlcy4KIwphbGxvdyAkMSBuZXRp
Zl90eXBlOm5ldGlmIHsgdWRwX3NlbmQgcmF3aXBfc2VuZCB9OwoKIwojIEFsbG93IHBhY2tldHMg
c2VudCBieSB0aGUgZG9tYWluIHRvIGJlIHJlY2VpdmVkIG9uIGFueSBuZXR3b3JrIGludGVyZmFj
ZS4KYWxsb3cgJDEgbmV0aWZfdHlwZTpuZXRpZiB7IHVkcF9yZWN2IHJhd2lwX3JlY3YgfTsKCiMK
IyBBbGxvdyB0aGUgZG9tYWluIHRvIHJlY2VpdmUgcGFja2V0cyBmcm9tIGFueSBuZXR3b3JrIGlu
dGVyZmFjZS4KIyBuZXRtc2dfdHlwZSBpcyBhIHR5cGUgYXR0cmlidXRlIGZvciBhbGwgZGVmYXVs
dCBtZXNzYWdlIHR5cGVzLgojCmFsbG93ICQxIG5ldG1zZ190eXBlOnsgdWRwX3NvY2tldCAgcmF3
aXBfc29ja2V0IH0gcmVjdmZyb207CgojIEFsbG93IHRoZSBkb21haW4gdG8gc2VuZCB0byBhbnkg
bm9kZS4KIyBub2RlX3R5cGUgaXMgYSB0eXBlIGF0dHJpYnV0ZSBmb3IgYWxsIG5vZGUgdHlwZXMu
CiMKYWxsb3cgJDEgbm9kZV90eXBlOm5vZGUgeyB1ZHBfc2VuZCByYXdpcF9zZW5kIH07CgojCiMg
QWxsb3cgcGFja2V0cyBzZW50IGJ5IHRoZSBkb21haW4gdG8gYmUgcmVjZWl2ZWQgZnJvbSBhbnkg
bm9kZS4KIwphbGxvdyAkMSBub2RlX3R5cGU6bm9kZSB7IHVkcF9yZWN2IHJhd2lwX3JlY3YgfTsK
CiMKIyBBbGxvdyB0aGUgZG9tYWluIHRvIHNlbmQgTkZTIGNsaWVudCByZXF1ZXN0cyB2aWEgdGhl
IHNvY2tldAojIGNyZWF0ZWQgYnkgbW91bnQuCiMKYWxsb3cgJDEgbW91bnRfdDp1ZHBfc29ja2V0
IHJ3X3NvY2tldF9wZXJtczsKCiMKIyBCaW5kIHRvIHRoZSBkZWZhdWx0IHBvcnQgdHlwZS4KIyBP
dGhlciBwb3J0IHR5cGVzIG11c3QgYmUgc2VwYXJhdGVseSBhdXRob3JpemVkLgojCmFsbG93ICQx
IHBvcnRfdDp1ZHBfc29ja2V0IG5hbWVfYmluZDsKJykKCg==

--Multipart_Tue__29_Jul_2003_18:49:53_+0900_08259420--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
