Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA14656
	for <selinux@tycho.nsa.gov>; Sun, 25 Nov 2001 09:07:31 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA05742
	for <selinux@tycho.nsa.gov>; Sun, 25 Nov 2001 14:07:09 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA05738
	for <selinux@tycho.nsa.gov>; Sun, 25 Nov 2001 14:07:05 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id ABB58925F6
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2001 01:07:22 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 8B92A768
	for <selinux@tycho.nsa.gov>; Sun, 25 Nov 2001 15:07:09 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: Re: Configure.help
Date: Sun, 25 Nov 2001 15:07:09 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_XJ0DKMGQGAE805KN8XUS"
Message-Id: <20011125140709.8B92A768@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_XJ0DKMGQGAE805KN8XUS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Sun, 25 Nov 2001 14:55, Russell Coker wrote:
> Here's a little snippet for Configure.help.  Could it (or something more
> detailed) be included in the next release?

Sorry, my previous message had a version with overly long lines.

I have attached a patch against the kernel source tree which has good line 
lengths.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--------------Boundary-00=_XJ0DKMGQGAE805KN8XUS
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="diff"

ZGlmZiAtcnVOIGxpbnV4L0RvY3VtZW50YXRpb24vQ29uZmlndXJlLmhlbHAgbGludXgtcGF0Y2hl
ZC9Eb2N1bWVudGF0aW9uL0NvbmZpZ3VyZS5oZWxwCi0tLSBsaW51eC9Eb2N1bWVudGF0aW9uL0Nv
bmZpZ3VyZS5oZWxwCVN1biBOb3YgMjUgMTQ6NDg6MDYgMjAwMQorKysgbGludXgtcGF0Y2hlZC9E
b2N1bWVudGF0aW9uL0NvbmZpZ3VyZS5oZWxwCVN1biBOb3YgMjUgMTU6MDA6NDYgMjAwMQpAQCAt
MTkxOTcsNiArMTkxOTcsMjIgQEAKICAgVG8gdXNlIHRoaXMgb3B0aW9uLCB5b3UgaGF2ZSB0byBj
aGVjayB0aGF0IHRoZSAiL3Byb2MgZmlsZSBzeXN0ZW0KICAgc3VwcG9ydCIgKENPTkZJR19QUk9D
X0ZTKSBpcyBlbmFibGVkLCB0b28uCiAKK05TQSBTRUxpbnV4IFN1cHBvcnQKK0NPTkZJR19TRUNV
UklUWV9TRUxJTlVYCisgIFRoaXMgZW5hYmxlcyBzdXBwb3J0IGZvciB0aGUgU2VjdXJpdHkgRW5o
YW5jZWQgTGludXggKFNFLUxpbnV4KSBjb2RlCisgIGRldmVsb3BlZCBieSB0aGUgTlNBLiAgVGhp
cyBhZGRzIG1hbmRhdG9yeSBhY2Nlc3MgY29udHJvbCwgc3VwcG9ydAorICBmb3Igcm9sZS1iYXNl
ZCBhY2Nlc3MgY29udHJvbCwgYW5kIG11Y2ggZmluZXIgZ3JhaW5lZCBjb250cm9sIG92ZXIKKyAg
bW9zdCBzZWN1cml0eSByZWxhdGVkIGFzcGVjdHMgb2YgdGhlIHN5c3RlbS4KKworTlNBIFNFTGlu
dXggRGV2ZWxvcG1lbnQgTW9kdWxlCitDT05GSUdfU0VDVVJJVFlfU0VMSU5VWF9ERVZFTE9QCisg
IEFkZHMgZXh0cmEgZGVidWdnaW5nIGNvZGUgZm9yIFNFLUxpbnV4IGRldmVsb3BlcnMuICBZb3Ug
cHJvYmFibHkKKyAgZG8gbm90IG5lZWQgdGhpcy4KKworTlNBIFNFTGludXggTUxTIHBvbGljeQor
Q09ORklHX1NFQ1VSSVRZX1NFTElOVVhfTUxTCisgIE11bHRpLUxldmVsIFNlY3VyaXR5LiAgCisK
IENhcGFiaWxpdGllcyBTdXBwb3J0CiBDT05GSUdfU0VDVVJJVFlfQ0FQQUJJTElUSUVTCiAgIFRo
aXMgZW5hYmxlcyB0aGUgImRlZmF1bHQiIExpbnV4IGNhcGFiaWxpdGllcyBmdW5jdGlvbmFsaXR5
Lgo=

--------------Boundary-00=_XJ0DKMGQGAE805KN8XUS--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
