Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i98JDErT024682
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 15:13:14 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i98JBsBm020440
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 19:12:05 GMT
Subject: Re: More SELinux fixes.
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
   Steve Smalley <sds@epoch.ncsc.mil>
In-Reply-To: <200410082341.32225.russell@coker.com.au>
References: <4165B9AA.8090803@redhat.com>
	 <200410082341.32225.russell@coker.com.au>
Content-Type: multipart/mixed; boundary="=-epfGNmiwkxMEbj+MwzTp"
Message-Id: <1097262719.13326.81.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 08 Oct 2004 15:11:59 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-epfGNmiwkxMEbj+MwzTp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

For now, I have removed the spaces, but it seems awfully brittle if
there are problems depending on the presence or lack of spaces.

I tried it with the quotes around the udp in the inetd_child calls and
in inetd_macros.te and there was no difference between the two
policy.conf files.  Attached is the patch to add quotes.

Should we go with the quotes?  Or is there a reason not to?

On Fri, 2004-10-08 at 09:41, Russell Coker wrote:
> On Fri, 8 Oct 2004 07:48, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > Please eliminate space before "udp" in inetd_child calls.  This will not
> > work correctly with the space.
> 
> In what way doesn't it work correctly?
> 
> I just did a quick test and diff didn't report any difference in the result 
> when I added a space.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--=-epfGNmiwkxMEbj+MwzTp
Content-Disposition: attachment; filename=inetd_child.diff
Content-Type: text/x-patch; name=inetd_child.diff; charset=UTF-8
Content-Transfer-Encoding: base64

SW5kZXg6IGRvbWFpbnMvcHJvZ3JhbS91bnVzZWQvY29tc2F0LnRlDQo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1Mg
ZmlsZTogL25mc2hvbWUvcGFsL0NWUy9zZWxpbnV4LXVzci9wb2xpY3kvZG9tYWlucy9wcm9ncmFt
L3VudXNlZC9jb21zYXQudGUsdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjQNCmRpZmYgLXUgLXIx
LjQgY29tc2F0LnRlDQotLS0gZG9tYWlucy9wcm9ncmFtL3VudXNlZC9jb21zYXQudGUJOCBPY3Qg
MjAwNCAxNzo1Njo0NCAtMDAwMAkxLjQNCisrKyBkb21haW5zL3Byb2dyYW0vdW51c2VkL2NvbXNh
dC50ZQk4IE9jdCAyMDA0IDE4OjE0OjU1IC0wMDAwDQpAQCAtMTEsNyArMTEsNyBAQA0KICMgY29t
c2F0X2V4ZWNfdCBpcyB0aGUgdHlwZSBvZiB0aGUgY29tc2F0IGV4ZWN1dGFibGUuDQogIw0KIA0K
LWluZXRkX2NoaWxkX2RvbWFpbihjb21zYXQsdWRwKQ0KK2luZXRkX2NoaWxkX2RvbWFpbihjb21z
YXQsIGB1ZHAnKQ0KIGFsbG93IGNvbXNhdF90IGluaXRyY192YXJfcnVuX3Q6ZmlsZSByX2ZpbGVf
cGVybXM7DQogZG9udGF1ZGl0IGNvbXNhdF90IGluaXRyY192YXJfcnVuX3Q6ZmlsZSB3cml0ZTsN
CiBhbGxvdyBjb21zYXRfdCBtYWlsX3Nwb29sX3Q6ZGlyIHJfZGlyX3Blcm1zOw0KSW5kZXg6IGRv
bWFpbnMvcHJvZ3JhbS91bnVzZWQva3RhbGtkLnRlDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL25m
c2hvbWUvcGFsL0NWUy9zZWxpbnV4LXVzci9wb2xpY3kvZG9tYWlucy9wcm9ncmFtL3VudXNlZC9r
dGFsa2QudGUsdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjQNCmRpZmYgLXUgLXIxLjQga3RhbGtk
LnRlDQotLS0gZG9tYWlucy9wcm9ncmFtL3VudXNlZC9rdGFsa2QudGUJOCBPY3QgMjAwNCAxNzo1
Njo0NSAtMDAwMAkxLjQNCisrKyBkb21haW5zL3Byb2dyYW0vdW51c2VkL2t0YWxrZC50ZQk4IE9j
dCAyMDA0IDE4OjE1OjM2IC0wMDAwDQpAQCAtMTAsNCArMTAsNCBAQA0KICMga3RhbGtkX2V4ZWNf
dCBpcyB0aGUgdHlwZSBvZiB0aGUga3RhbGtkIGV4ZWN1dGFibGUuDQogIw0KIA0KLWluZXRkX2No
aWxkX2RvbWFpbihrdGFsa2QsdWRwKQ0KK2luZXRkX2NoaWxkX2RvbWFpbihrdGFsa2QsIGB1ZHAn
KQ0KSW5kZXg6IG1hY3Jvcy9wcm9ncmFtL2luZXRkX21hY3Jvcy50ZQ0KPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNT
IGZpbGU6IC9uZnNob21lL3BhbC9DVlMvc2VsaW51eC11c3IvcG9saWN5L21hY3Jvcy9wcm9ncmFt
L2luZXRkX21hY3Jvcy50ZSx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNA0KZGlmZiAtdSAtcjEu
NCBpbmV0ZF9tYWNyb3MudGUNCi0tLSBtYWNyb3MvcHJvZ3JhbS9pbmV0ZF9tYWNyb3MudGUJOCBP
Y3QgMjAwNCAxNzo1Njo0NiAtMDAwMAkxLjQNCisrKyBtYWNyb3MvcHJvZ3JhbS9pbmV0ZF9tYWNy
b3MudGUJOCBPY3QgMjAwNCAxODo0Nzo0NSAtMDAwMA0KQEAgLTU0LDExICs1NCwxMSBAQA0KIGFs
bG93IGluZXRkX3QgJDFfcG9ydF90OnRjcF9zb2NrZXQgeyBuYW1lX2JpbmQgfTsNCiBhbGxvdyAk
MV90IGluZXRkX3Q6dGNwX3NvY2tldCByd19zdHJlYW1fc29ja2V0X3Blcm1zOw0KICcpDQotaWZl
bHNlKCQyLCB0Y3AsIGANCitpZmVsc2UoJDIsIGB0Y3AnLCBgDQogYWxsb3cgaW5ldGRfdCAkMV9w
b3J0X3Q6dGNwX3NvY2tldCB7IG5hbWVfYmluZCB9Ow0KIGFsbG93ICQxX3QgaW5ldGRfdDp0Y3Bf
c29ja2V0IHJ3X3N0cmVhbV9zb2NrZXRfcGVybXM7DQogJykNCi1pZmVsc2UoJDIsIHVkcCwgYA0K
K2lmZWxzZSgkMiwgYHVkcCcsIGANCiBhbGxvdyBpbmV0ZF90ICQxX3BvcnRfdDp1ZHBfc29ja2V0
IHsgbmFtZV9iaW5kIH07DQogYWxsb3cgJDFfdCBpbmV0ZF90OnVkcF9zb2NrZXQgcndfc29ja2V0
X3Blcm1zOw0KICcpDQo=

--=-epfGNmiwkxMEbj+MwzTp--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
