Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB8KLKRb019012
	for <selinux@tycho.nsa.gov>; Mon, 8 Dec 2003 15:21:20 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB8KLJRV028434
	for <selinux@tycho.nsa.gov>; Mon, 8 Dec 2003 20:21:19 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
        by jazzband.ncsc.mil  with ESMTP id hB8KLIta028430 for <selinux@tycho.nsa.gov>; Mon, 8 Dec 2003 20:21:18 GMT
Subject: Re: policy problem with nfs mounting
From: Chris PeBenito <pebenito@gentoo.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
   Jim Carter <jwcart2@epoch.ncsc.mil>
In-Reply-To: <1070909315.7949.40.camel@moss-spartans.epoch.ncsc.mil>
References: <1070904612.15475.7.camel@chris.pebenito.net>
	 <1070909315.7949.40.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-UBswV6c1DHZGwHSvThFq"
Message-Id: <1070914878.16071.10.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Mon, 08 Dec 2003 14:21:18 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-UBswV6c1DHZGwHSvThFq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Well I made a mistake on this; I wouldn't have seen this had I not
missed merging in the two rules at the bottom of mount.te to allow
mounting of unlabeled fs's.  But since it looks like these other
interfaces are going to be worked on soon, I put in a rpc_pipefs_t
anyway, see attached patch.

On Mon, 2003-12-08 at 12:48, Stephen Smalley wrote:
> On Mon, 2003-12-08 at 12:30, Chris PeBenito wrote:
> > I was merging in the 1.4 policy changes into the Gentoo policy, when I
> > experienced some odd nfs breakage.  NFS wouldn't mount on my 2.6 machine
> > (cant try on 2.4, since its PPC):
> I'd expect that you would want a different type for rpc_pipefs, as you
> likely want to control access to this userland/kernel interface
> differently than to the files on the NFS filesystem.  It may even be
> desirable to support finer-grained labeling for rpc_pipefs, to support
> least privilege for userspace access to it, but we haven't looked into
> that yet.
-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-UBswV6c1DHZGwHSvThFq
Content-Disposition: attachment; filename=rpc_pipefs.diff
Content-Type: text/x-patch; name=rpc_pipefs.diff; charset=iso-8859-1
Content-Transfer-Encoding: base64

ZGlmZiAtdXJOIHBvbGljeS0xLjQub3JpZy9kb21haW5zL3Byb2dyYW0vbW91bnQudGUgcG9saWN5
LTEuNC9kb21haW5zL3Byb2dyYW0vbW91bnQudGUNCi0tLSBwb2xpY3ktMS40Lm9yaWcvZG9tYWlu
cy9wcm9ncmFtL21vdW50LnRlCTIwMDMtMTEtMjYgMTA6MzE6MjAuMDAwMDAwMDAwIC0wNjAwDQor
KysgcG9saWN5LTEuNC9kb21haW5zL3Byb2dyYW0vbW91bnQudGUJMjAwMy0xMi0wOCAxNDoxNzo1
MS4wMDAwMDAwMDAgLTA2MDANCkBAIC01NSw2ICs1NSw3IEBADQogY2FuX3VkcF9zZW5kKG1vdW50
X3QsIHBvcnRtYXBfdCkNCiBjYW5fdWRwX3NlbmQocG9ydG1hcF90LCBtb3VudF90KQ0KIGFsbG93
IG1vdW50X3QgcmVzb2x2X2NvbmZfdDpmaWxlIHsgZ2V0YXR0ciByZWFkIH07DQorYWxsb3cgbW91
bnRfdCBycGNfcGlwZWZzX3Q6ZGlyIHNlYXJjaDsNCiAnKQ0KIA0KIGFsbG93IG1vdW50X3QgdW5s
YWJlbGVkX3Q6ZmlsZXN5c3RlbSB7IG1vdW50IHVubW91bnQgfTsNCmRpZmYgLXVyTiBwb2xpY3kt
MS40Lm9yaWcvZ2VuZnNfY29udGV4dHMgcG9saWN5LTEuNC9nZW5mc19jb250ZXh0cw0KLS0tIHBv
bGljeS0xLjQub3JpZy9nZW5mc19jb250ZXh0cwkyMDAzLTExLTI2IDEwOjMxOjIwLjAwMDAwMDAw
MCAtMDYwMA0KKysrIHBvbGljeS0xLjQvZ2VuZnNfY29udGV4dHMJMjAwMy0xMi0wOCAxMzo1Nzoz
NC4wMDAwMDAwMDAgLTA2MDANCkBAIC04NCwzICs4NCw0IEBADQogZ2VuZnNjb24gYmRldiAvIHN5
c3RlbV91Om9iamVjdF9yOmJkZXZfdA0KIGdlbmZzY29uIHVzYmZzIC8gc3lzdGVtX3U6b2JqZWN0
X3I6dXNiZnNfdA0KIGdlbmZzY29uIG5mc2QgLyBzeXN0ZW1fdTpvYmplY3RfcjpuZnNkX2ZzX3QN
CitnZW5mc2NvbiBycGNfcGlwZWZzIC8gc3lzdGVtX3U6b2JqZWN0X3I6cnBjX3BpcGVmc190DQpk
aWZmIC11ck4gcG9saWN5LTEuNC5vcmlnL3R5cGVzL2ZpbGUudGUgcG9saWN5LTEuNC90eXBlcy9m
aWxlLnRlDQotLS0gcG9saWN5LTEuNC5vcmlnL3R5cGVzL2ZpbGUudGUJMjAwMy0xMS0yMCAxNTow
MzozNS4wMDAwMDAwMDAgLTA2MDANCisrKyBwb2xpY3ktMS40L3R5cGVzL2ZpbGUudGUJMjAwMy0x
Mi0wOCAxMzo1ODozNC4wMDAwMDAwMDAgLTA2MDANCkBAIC0zMSw2ICszMSw3IEBADQogdHlwZSBi
ZGV2X3QsIGZzX3R5cGU7DQogdHlwZSB1c2Jmc190LCBmc190eXBlOw0KIHR5cGUgbmZzZF9mc190
LCBmc190eXBlOw0KK3R5cGUgcnBjX3BpcGVmc190LCBmc190eXBlOw0KIA0KICMNCiAjIGZpbGVf
dCBpcyB0aGUgZGVmYXVsdCB0eXBlIG9mIGFuIHVubGFiZWxlZA0K

--=-UBswV6c1DHZGwHSvThFq--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
