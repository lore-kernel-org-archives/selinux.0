Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA07369
	for <selinux@tycho.nsa.gov>; Sun, 17 Mar 2002 20:40:53 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id BAA05310
	for <selinux@tycho.nsa.gov>; Mon, 18 Mar 2002 01:39:34 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id BAA05306
	for <selinux@tycho.nsa.gov>; Mon, 18 Mar 2002 01:39:31 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id CD18792443
	for <selinux@tycho.nsa.gov>; Mon, 18 Mar 2002 12:40:38 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 5017422BAE
	for <selinux@tycho.nsa.gov>; Mon, 18 Mar 2002 02:40:27 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: header file issues with 2002031409
Date: Mon, 18 Mar 2002 02:40:26 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_EBB58281A1PPET8ARUO7"
Message-Id: <20020318014027.5017422BAE@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_EBB58281A1PPET8ARUO7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I have attached a patch that fixes a couple of header file problems.

Firstly "new" is a key word in C++ and using it in a C program is generally 
not a good idea.  It's especially bad when you accidentally put your compiler 
into C++ mode and get strange errors.

One thing that you might consider is putting the following in the header 
files:
#ifdef __cplusplus
extern "C" {
#endif

If the above is put before the declarations of functions and the following is 
put afterwards then anyone can just include the headers in their C or C++ 
programs without any problem.

#ifdef __cplusplus
extern "C" {
#endif


The next thing is that I had problems with proc_secure.h being included 
multiple times in one of my programs (and as it was being included by other 
headers avoiding this was more pain than it was worth).

Would it be possible to put header file protection like this around all the 
headers?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--------------Boundary-00=_EBB58281A1PPET8ARUO7
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="diff"

LS0tIHNlbGludXgtc21hbGwtMjAwMjAzMTQwOS5vcmlnL2xpYnNlY3VyZS9zcmMvZ2V0X3VzZXJf
c2lkLmMKKysrIHNlbGludXgtc21hbGwtMjAwMjAzMTQwOS9saWJzZWN1cmUvc3JjL2dldF91c2Vy
X3NpZC5jCkBAIC03MzMsNyArNzMzLDcgQEAKICAqLwogaW50IHBhcnRzX3RvX3NlY3VyaXR5X2Nv
bnRleHQgKGNvbnN0IGNoYXIqIHVzZXIsIGNvbnN0IGNoYXIqIHJvbGUsIAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIqIHR5cGUsCi0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY29uc3QgY2hhciogbGV2ZWwsIHNlY3VyaXR5X2NvbnRleHRfdCogbmV3KQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIqIGxldmVsLCBzZWN1cml0
eV9jb250ZXh0X3QqIE5ldykKIHsKICAgICBpbnQgdXNlcmxlbiwgICAvKiB0aGUgbGVuZ3RoIG9m
IHRoZSB1c2VyIGZpZWxkICAgICAgICAgICAqLwogICAgICAgICByb2xlbGVuLCAgIC8qIHRoZSBs
ZW5ndGggb2YgdGhlIHJvbGUgZmllbGQgICAgICAgICAgICovCkBAIC03NjYsMjYgKzc2NiwyNiBA
QAogI2VuZGlmCiAKICAgICAvKiBNYWxsb2Mgc3BhY2UgZm9yIHRoZSBuZXcgc2VjdXJpdHkgY29u
dGV4dCAqLwotICAgICgqbmV3KSA9IChzZWN1cml0eV9jb250ZXh0X3QpbWFsbG9jIChzaXplb2Yo
Y2hhcikgKiBuZXdsZW4pOwotICAgIGlmICgoKm5ldykgPT0gTlVMTCkKKyAgICAoKk5ldykgPSAo
c2VjdXJpdHlfY29udGV4dF90KW1hbGxvYyAoc2l6ZW9mKGNoYXIpICogbmV3bGVuKTsKKyAgICBp
ZiAoKCpOZXcpID09IE5VTEwpCiAgICAgewogICAgICAgICBmcHJpbnRmIChzdGRlcnIsICJVbmFi
bGUgdG8gbWFsbG9jXG4iKTsKICAgICAgICAgcmV0dXJuIDA7CiAgICAgfQogCiAgICAgLyogY29w
eSB0aGUgcGFydHMgaW50byB0aGUgbmV3IHNlY3VyaXR5IGNvbnRleHQgd2l0aCA6J3Mgc2VwYXJh
dGluZyB0aGVtICovCi0gICAgc3RybmNweSAoKCpuZXcpLCB1c2VyLCB1c2VybGVuKTsKLSAgICAo
Km5ldylbdXNlcmxlbl0gPSAnOic7Ci0gICAgc3RybmNweSAoJigqbmV3KVt1c2VybGVuKzFdLCBy
b2xlLCByb2xlbGVuKTsKLSAgICAoKm5ldylbdXNlcmxlbityb2xlbGVuKzFdID0gJzonOwotICAg
IHN0cm5jcHkgKCYoKm5ldylbdXNlcmxlbityb2xlbGVuKzJdLCB0eXBlLCB0eXBlbGVuKTsKKyAg
ICBzdHJuY3B5ICgoKk5ldyksIHVzZXIsIHVzZXJsZW4pOworICAgICgqTmV3KVt1c2VybGVuXSA9
ICc6JzsKKyAgICBzdHJuY3B5ICgmKCpOZXcpW3VzZXJsZW4rMV0sIHJvbGUsIHJvbGVsZW4pOwor
ICAgICgqTmV3KVt1c2VybGVuK3JvbGVsZW4rMV0gPSAnOic7CisgICAgc3RybmNweSAoJigqTmV3
KVt1c2VybGVuK3JvbGVsZW4rMl0sIHR5cGUsIHR5cGVsZW4pOwogCiAjaWZkZWYgQ09ORklHX0ZM
QVNLX01MUwotICAgICgqbmV3KVt1c2VybGVuK3JvbGVsZW4rdHlwZWxlbisyXSA9ICc6JzsKLSAg
ICBzdHJuY3B5ICgmKCpuZXcpW3VzZXJsZW4rcm9sZWxlbit0eXBlbGVuKzNdLCBsZXZlbCwgbGV2
ZWxsZW4pOwotICAgICgqbmV3KVt1c2VybGVuK3JvbGVsZW4rdHlwZWxlbitsZXZlbGxlbiszXSA9
ICdcMCc7CisgICAgKCpOZXcpW3VzZXJsZW4rcm9sZWxlbit0eXBlbGVuKzJdID0gJzonOworICAg
IHN0cm5jcHkgKCYoKk5ldylbdXNlcmxlbityb2xlbGVuK3R5cGVsZW4rM10sIGxldmVsLCBsZXZl
bGxlbik7CisgICAgKCpOZXcpW3VzZXJsZW4rcm9sZWxlbit0eXBlbGVuK2xldmVsbGVuKzNdID0g
J1wwJzsKICNlbHNlCi0gICAgKCpuZXcpW3VzZXJsZW4rcm9sZWxlbit0eXBlbGVuKzJdID0gJ1ww
JzsKKyAgICAoKk5ldylbdXNlcmxlbityb2xlbGVuK3R5cGVsZW4rMl0gPSAnXDAnOwogI2VuZGlm
CiAKICAgICAvKiBJZiB3ZSd2ZSBtYWRlIGl0IHRoaXMgZmFyLCB3ZSdyZSBzdWNjZXNzZnVsICov
Ci0tLSBzZWxpbnV4LXNtYWxsLTIwMDIwMzE0MDkub3JpZy9saWJzZWN1cmUvaW5jbHVkZS9wcm9j
X3NlY3VyZS5oCisrKyBzZWxpbnV4LXNtYWxsLTIwMDIwMzE0MDkvbGlic2VjdXJlL2luY2x1ZGUv
cHJvY19zZWN1cmUuaApAQCAtMSwzICsxLDYgQEAKKyNpZm5kZWYgUFJPQ19TRUNVUkVfSAorI2Rl
ZmluZSBQUk9DX1NFQ1VSRV9ICisKICNpbmNsdWRlIDx1bmlzdGQuaD4KICNpbmNsdWRlIDxsaW51
eC9mbGFzay9mbGFzay5oPgogCkBAIC0zMCw0ICszMyw0IEBACiAJCQkgICBzZWN1cml0eV9pZF90
IHNpZCwgCiAJCQkgICBjaGFyICpjb25zdCBhcmd2W10pOwogCi0KKyNlbmRpZgotLS0gc2VsaW51
eC1zbWFsbC0yMDAyMDMxNDA5Lm9yaWcvbGlic2VjdXJlL2luY2x1ZGUvZ2V0X3VzZXJfc2lkLmgK
KysrIHNlbGludXgtc21hbGwtMjAwMjAzMTQwOS9saWJzZWN1cmUvaW5jbHVkZS9nZXRfdXNlcl9z
aWQuaApAQCAtNTMsNSArNTMsNSBAQAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNo
YXIqKiByb2xlLCBjaGFyKiogdHlwZSwgY2hhcioqIGRvbWFpbik7CiBpbnQgcGFydHNfdG9fc2Vj
dXJpdHlfY29udGV4dCAoY29uc3QgY2hhciogdXNlciwgY29uc3QgY2hhciogcm9sZSwgCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciogdHlwZSwKLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyKiBkb21haW4sIHNlY3VyaXR5X2NvbnRleHRf
dCogbmV3KTsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyKiBkb21h
aW4sIHNlY3VyaXR5X2NvbnRleHRfdCogTmV3KTsKICNlbmRpZiAgLyogaWZuZGVmIF9HRVRfVVNF
Ul9TSURfSF8gKi8K

--------------Boundary-00=_EBB58281A1PPET8ARUO7--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
