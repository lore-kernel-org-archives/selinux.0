Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA20944
	for <selinux@tycho.nsa.gov>; Sun, 16 Jun 2002 11:52:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA06336
	for <selinux@tycho.nsa.gov>; Sun, 16 Jun 2002 15:52:32 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id PAA06332
	for <selinux@tycho.nsa.gov>; Sun, 16 Jun 2002 15:52:31 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id ED52092461
	for <selinux@tycho.nsa.gov>; Mon, 17 Jun 2002 01:52:47 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id EE597141A
	for <selinux@tycho.nsa.gov>; Sun, 16 Jun 2002 17:52:27 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: oops
Date: Sun, 16 Jun 2002 17:52:27 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_FR2TWB07VZYQ3L9FDH3U"
Message-Id: <20020616155227.EE597141A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_FR2TWB07VZYQ3L9FDH3U
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I've attached the ksymoops outfrom after an Oops running 2.4.18 with LSM 
patches on a Qube (with the cobalt kernel patch I derived).

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--------------Boundary-00=_FR2TWB07VZYQ3L9FDH3U
Content-Type: text/plain;
  charset="us-ascii";
  name="out"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="out"

a3N5bW9vcHMgMi40LjUgb24gaTU4NiAyLjQuMTgtY29iYWx0LWxzbS4gIE9wdGlvbnMgdXNlZApV
bmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVh
bCBhZGRyZXNzIDAwMDAwNDA0CmMwMTc4Y2ExCipwZGUgPSAwMDAwMDAwMApPb3BzOiAwMDAwCkNQ
VTogICAgMApFSVA6ICAgIDAwMTA6WzxjMDE3OGNhMT5dICAgIE5vdCB0YWludGVkClVzaW5nIGRl
ZmF1bHRzIGZyb20ga3N5bW9vcHMgLXQgZWxmMzItaTM4NiAtYSBpMzg2CkVGTEFHUzogMDAwMTAy
MDYKZWF4OiBjMTJkNWEyMCAgIGVieDogMDAwMDA0MDAgICBlY3g6IDAwMDAwMDA0ICAgZWR4OiAw
MDAwMDAwYQplc2k6IDAwMDAwMDBlICAgZWRpOiBjN2UzNjU4MCAgIGVicDogYzU5ZmRlNjAgICBl
c3A6IGM1OWZkZGY4CmRzOiAwMDE4ICAgZXM6IDAwMTggICBzczogMDAxOApQcm9jZXNzIGxvYWRf
cG9saWN5IChwaWQ6IDcyOCwgc3RhY2twYWdlPWM1OWZkMDAwKQpTdGFjazogYzU5ZmRlNjAgYzU5
ZmRlNDAgYzAyNDk4NjggYzU5ZmRlNjAgYzU5ZmRmNDggYzAxN2M5MDEgYzdlMzY1ODAgYzAxN2M2
MTQgCiAgICAgICBjNTlmZGU2MCBjNjljZTQ0MCAwMDAwMDAwMCBjNTlmZTFjMCAwMDAwMDAwNCBj
MDI5ZmYxMCBjNTlmZGU2MCAwMDAwMDAxMiAKICAgICAgIGMwMjg3OTAwIDAwMDAwMDA1IGMxMjc3
YzAwIDAwMDAwMDAwIDAwMDAwMDAxIGMxMmE4MjgwIGM1OWZjMDAwIGM1OWZkZjY0IApDYWxsIFRy
YWNlOiBbPGMwMTdjOTAxPl0gWzxjMDE3YzYxND5dIFs8YzAxNmQyZjk+XSBbPGMwMTJiMjZkPl0g
WzxjMDE3ZDdhMz5dIAogICBbPGMwMTdkN2ZlPl0gWzxjMDExZWE3OD5dIFs8YzAxNzdkNWI+XSBb
PGMwMTA2YzY0Pl0gWzxjMDEwNmI1Mz5dIApDb2RlOiBmZiA3MyAwNCBmZiAzMyA4YiA1NCAyNCAy
NCBmZiBkMiA4MyBjNCAwYyA4NSBjMCA3NSAwZiA4YiA1YiAKCgo+PkVJUDsgYzAxNzhjYTEgPGhh
c2h0YWJfbWFwKzMxLzU4PiAgIDw9PT09PQoKPj5lYXg7IGMxMmQ1YTIwIDxfZW5kKzEwMjE3ZjQv
ODU2NmRkND4KPj5lZGk7IGM3ZTM2NTgwIDxfZW5kKzdiODIzNTQvODU2NmRkND4KPj5lYnA7IGM1
OWZkZTYwIDxfZW5kKzU3NDljMzQvODU2NmRkND4KPj5lc3A7IGM1OWZkZGY4IDxfZW5kKzU3NDli
Y2MvODU2NmRkND4KClRyYWNlOyBjMDE3YzkwMSA8c2VjdXJpdHlfbG9hZF9wb2xpY3krYzUvMjE4
PgpUcmFjZTsgYzAxN2M2MTQgPHZhbGlkYXRlX2NsYXNzKzAvYjQ+ClRyYWNlOyBjMDE2ZDJmOSA8
dGFza19oYXNfc2VjdXJpdHkrZDEvMTYwPgpUcmFjZTsgYzAxMmIyNmQgPGRlbnRyeV9vcGVuK2Ux
LzE4ND4KVHJhY2U7IGMwMTdkN2EzIDxzeXNfc2VjdXJpdHlfbG9hZF9wb2xpY3krMTFmLzFhND4K
VHJhY2U7IGMwMTdkN2ZlIDxzeXNfc2VjdXJpdHlfbG9hZF9wb2xpY3krMTdhLzFhND4KVHJhY2U7
IGMwMTFlYTc4IDxkb19tdW5tYXArMjJjLzIzYz4KVHJhY2U7IGMwMTc3ZDViIDxzeXNfc2VjdXJp
dHlfc2VsaW51eCtlMy80MTU+ClRyYWNlOyBjMDEwNmM2NCA8ZXJyb3JfY29kZSszNC80MD4KVHJh
Y2U7IGMwMTA2YjUzIDxzeXN0ZW1fY2FsbCszMy80MD4KCkNvZGU7ICBjMDE3OGNhMSA8aGFzaHRh
Yl9tYXArMzEvNTg+CjAwMDAwMDAwIDxfRUlQPjoKQ29kZTsgIGMwMTc4Y2ExIDxoYXNodGFiX21h
cCszMS81OD4gICA8PT09PT0KICAgMDogICBmZiA3MyAwNCAgICAgICAgICAgICAgICAgIHB1c2hs
ICAweDQoJWVieCkgICA8PT09PT0KQ29kZTsgIGMwMTc4Y2E0IDxoYXNodGFiX21hcCszNC81OD4K
ICAgMzogICBmZiAzMyAgICAgICAgICAgICAgICAgICAgIHB1c2hsICAoJWVieCkKQ29kZTsgIGMw
MTc4Y2E2IDxoYXNodGFiX21hcCszNi81OD4KICAgNTogICA4YiA1NCAyNCAyNCAgICAgICAgICAg
ICAgIG1vdiAgICAweDI0KCVlc3AsMSksJWVkeApDb2RlOyAgYzAxNzhjYWEgPGhhc2h0YWJfbWFw
KzNhLzU4PgogICA5OiAgIGZmIGQyICAgICAgICAgICAgICAgICAgICAgY2FsbCAgIColZWR4CkNv
ZGU7ICBjMDE3OGNhYyA8aGFzaHRhYl9tYXArM2MvNTg+CiAgIGI6ICAgODMgYzQgMGMgICAgICAg
ICAgICAgICAgICBhZGQgICAgJDB4YywlZXNwCkNvZGU7ICBjMDE3OGNhZiA8aGFzaHRhYl9tYXAr
M2YvNTg+CiAgIGU6ICAgODUgYzAgICAgICAgICAgICAgICAgICAgICB0ZXN0ICAgJWVheCwlZWF4
CkNvZGU7ICBjMDE3OGNiMSA8aGFzaHRhYl9tYXArNDEvNTg+CiAgMTA6ICAgNzUgMGYgICAgICAg
ICAgICAgICAgICAgICBqbmUgICAgMjEgPF9FSVArMHgyMT4gYzAxNzhjYzIgPGhhc2h0YWJfbWFw
KzUyLzU4PgpDb2RlOyAgYzAxNzhjYjMgPGhhc2h0YWJfbWFwKzQzLzU4PgogIDEyOiAgIDhiIDVi
IDAwICAgICAgICAgICAgICAgICAgbW92ICAgIDB4MCglZWJ4KSwlZWJ4CgoKMSB3YXJuaW5nIGlz
c3VlZC4gIFJlc3VsdHMgbWF5IG5vdCBiZSByZWxpYWJsZS4K

--------------Boundary-00=_FR2TWB07VZYQ3L9FDH3U--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
