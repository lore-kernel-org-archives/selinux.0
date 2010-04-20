Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3KHRkeG007996
	for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2010 13:27:46 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3KHRE4x010192
	for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2010 17:27:14 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3) with ESMTP id o3KHTgBS027949
	for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2010 13:29:42 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3/Submit) id o3KHTga8027947
	for selinux@tycho.nsa.gov; Tue, 20 Apr 2010 13:29:42 -0400
Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3KEbmIv028020
	for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2010 10:37:48 -0400
Received: from mail-yx0-f182.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3KEbFYa016866
	for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2010 14:37:15 GMT
Received: by yxe12 with SMTP id 12so3337040yxe.32
        for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2010 07:37:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <t2s10143821004190853r1a114b33q7c9416e43b8b5433@mail.gmail.com>
References: <4BCC69C0.5040502@redhat.com>
	 <t2s10143821004190853r1a114b33q7c9416e43b8b5433@mail.gmail.com>
Date: Tue, 20 Apr 2010 10:37:46 -0400
Message-ID: <l2s10143821004200737t683832efu28214c95b3e156c@mail.gmail.com>
Subject: Re: refpolicy is missing on lots of hits with audit2allow -R.
From: Karl MacMillan <kmacmillan@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>, SELinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Content-Type: multipart/mixed; boundary=0016361e839a6863ec0484ac0524
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016361e839a6863ec0484ac0524
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Apr 19, 2010 at 11:53 AM, Karl MacMillan
<karlwmacmillan@gmail.com> wrote:
> On Mon, Apr 19, 2010 at 10:33 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>>
>> If you look at the interface userdom_read_home_certs.
>>
>> [InterfaceVector userdom_read_home_certs $1:source ]
>> $1,home_cert_t,file,read,lock,getattr,open,ioctl
>> $1,home_cert_t,dir,ioctl,search,read,lock,open,getattr
>> $1,home_cert_t,lnk_file,read,getattr
>> $1,home_root_t,dir,getattr,open,search
>> $1,home_root_t,lnk_file,read,getattr
>> $1,user_home_dir_t,dir,getattr,open,search
>> $1,user_home_dir_t,lnk_file,read,getattr
>>
>> A domain that is allowed to search the homedir is always going to
>> generate an AVC that is a long way off.
>>
>
> Seems to me that the problem is that the read / getattr on
> user_home_dir_t directories and files is adding too much distance.
>

I looked at this a bit more - there are a few interesting issues:

1. The open permissions have not been added to the perm_map file
(patch attached to fix that). When there is no perm map then we weight
the permission at 5 and assume read and write. Since we heavily
penalize providing a write interface for a read access request, this
causes the return of a large distance (as I believe that it should).
I'd like to find a long term home for the perm map file that increases
it's likelihood of being updated with new permissions (Chris - what do
you think of including this with reference policy?).

2. As I mentioned, the weighting on things like reading a symlink or
directory contents is fairly high. For this use I don't think that's
appropriate - the attached perm map patch also reduces these pretty
drastically.

3. The bulk of the rest of the distance comes from the unrelated
type/object access. We get access to 4 type/object class pairs that
aren't requested. Unfortunately there is no tracking of the notion of
related access or scaling of the type penalty based upon how minor the
related access is. Perhaps we should scale the type penalty with the
permission weighting?

4. The final issue is that this interface is a bit broad for the
requested access - requesting getattr for the cert files and getting
read is a pretty significant bump. Once you resolve the perm_map issue
then the distance is just over the threshold - which is about where I
was aiming with this algorithm (go me). Now, the reality is likely
that a read would come right after this getattr - if that had have
been in the audit log all would be fine. Having said that, I'm not
against making the threshold a little higher to return these (another
patch attached).

Long term, I wonder if we should return interfaces above the threshold
but commented out with a note explaining that the interface, while
providing the requested access, is potentially dangerously broad. Dan,
any chance you want to add that feature?

Karl

>> I thing we should either remove the bastards and just add all as childs,
>> or recode it like the attachment.
>>
>
> I'm against removing the threshold altogether - if we do that then
> we'll get a match for almost everything including completely wrong
> interfaces. Can we start with tweaking either the perm weights or the
> distance calculation? For example, what happens when you drop the
> weight for dir read down to 5 or 1 and similar for lnk_file (they are
> both 10 right now)? After that we might need to tweak the threshold.
>
> Also - I've been hacking on a patch to add in attribute access to the
> interface vectors. Any idea how much help we would get from that?
>
> Karl
>
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v2.0.14 (GNU/Linux)
>> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>>
>> iEYEARECAAYFAkvMacAACgkQrlYvE4MpobNeAgCfcoVssEQJ8mfZT/aBvAt0z7+3
>> CoMAnR1bOcXk7x/jIZ+0i2Kc/faUJAVk
>> =Uuf7
>> -----END PGP SIGNATURE-----
>>
>

--0016361e839a6863ec0484ac0524
Content-Type: application/octet-stream;
	name="0001-Update-perm-map-with-open-permissions.patch"
Content-Disposition: attachment;
	filename="0001-Update-perm-map-with-open-permissions.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g88tk2290

RnJvbSA4M2IyMmNmZGMwMTA3M2EzNzhmYzlkNTA4NzU1NzVkMjUyYjk1MDAzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8ODNiMjJjZmRjMDEwNzNhMzc4ZmM5ZDUwODc1NTc1
ZDI1MmI5NTAwMy4xMjcxNzI0MjA5LmdpdC5rbWFjbWlsbGFuQHRyZXN5cy5jb20+CkZyb206IEth
cmwgTWFjTWlsbGFuIDxrbWFjbWlsbGFuQHRyZXN5cy5jb20+CkRhdGU6IE1vbiwgMTkgQXByIDIw
MTAgMjA6MDk6NDEgLTA0MDAKU3ViamVjdDogW1BBVENIIDEvMl0gVXBkYXRlIHBlcm0gbWFwIHdp
dGggb3BlbiBwZXJtaXNzaW9ucy4KCi0tLQogc2Vwb2xnZW4vc3JjL3NoYXJlL3Blcm1fbWFwIHwg
ICA1MSArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZXMg
Y2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
c2Vwb2xnZW4vc3JjL3NoYXJlL3Blcm1fbWFwIGIvc2Vwb2xnZW4vc3JjL3NoYXJlL3Blcm1fbWFw
CmluZGV4IGViMmUyM2IuLmNhNGZhNGQgMTAwNjQ0Ci0tLSBhL3NlcG9sZ2VuL3NyYy9zaGFyZS9w
ZXJtX21hcAorKysgYi9zZXBvbGdlbi9zcmMvc2hhcmUvcGVybV9tYXAKQEAgLTEyNCw3ICsxMjQs
NyBAQCBjbGFzcyBmaWxlc3lzdGVtIDEwCiAgICAgICAgICAgcXVvdGFtb2QgICAgIHcgICAgICAg
ICAgIDEKICAgICAgICAgICBxdW90YWdldCAgICAgciAgICAgICAgICAgMQogCi1jbGFzcyBmaWxl
IDIwCitjbGFzcyBmaWxlIDIxCiAgIGV4ZWN1dGVfbm9fdHJhbnMgICAgIHIgICAgICAgICAgIDEK
ICAgICAgICAgZW50cnlwb2ludCAgICAgciAgICAgICAgICAgMQogICAgICAgICAgICBleGVjbW9k
ICAgICBuICAgICAgICAgICAxCkBAIC0xNDEsNDggKzE0MSw1MCBAQCBjbGFzcyBmaWxlIDIwCiAg
ICAgICAgICAgICB1bmxpbmsgICAgIHcgICAgICAgICAgIDEKICAgICAgICAgICAgICAgbGluayAg
ICAgdyAgICAgICAgICAgMQogICAgICAgICAgICAgcmVuYW1lICAgICB3ICAgICAgICAgICA1Ci0g
ICAgICAgICAgIGV4ZWN1dGUgICAgIHIgICAgICAgICAgIDEwMAorICAgICAgICAgICBleGVjdXRl
ICAgICByICAgICAgICAgICAxMAogICAgICAgICAgICAgc3dhcG9uICAgICBiICAgICAgICAgICAx
CiAgICAgICAgICAgIHF1b3Rhb24gICAgIGIgICAgICAgICAgIDEKICAgICAgICAgICAgbW91bnRv
biAgICAgYiAgICAgICAgICAgMQorCSAgICAgIG9wZW4gICAgIHIJICAgMQogCi1jbGFzcyBkaXIg
MjIKLSAgICAgICAgICBhZGRfbmFtZSAgICAgdyAgICAgICAgICAgNQorY2xhc3MgZGlyIDIzCisg
ICAgICAgICAgYWRkX25hbWUgICAgIHcgICAgICAgICAgIDEKICAgICAgICByZW1vdmVfbmFtZSAg
ICAgdyAgICAgICAgICAgMQogICAgICAgICAgIHJlcGFyZW50ICAgICB3ICAgICAgICAgICAxCiAg
ICAgICAgICAgICBzZWFyY2ggICAgIHIgICAgICAgICAgIDEKICAgICAgICAgICAgICBybWRpciAg
ICAgYiAgICAgICAgICAgMQogICAgICAgICAgICAgIGlvY3RsICAgICBuICAgICAgICAgICAxCi0g
ICAgICAgICAgICAgIHJlYWQgICAgIHIgICAgICAgICAgMTAKLSAgICAgICAgICAgICB3cml0ZSAg
ICAgdyAgICAgICAgICAxMAorICAgICAgICAgICAgICByZWFkICAgICByICAgICAgICAgICAxCisg
ICAgICAgICAgICAgd3JpdGUgICAgIHcgICAgICAgICAgIDEKICAgICAgICAgICAgIGNyZWF0ZSAg
ICAgdyAgICAgICAgICAgMQotICAgICAgICAgICBnZXRhdHRyICAgICByICAgICAgICAgICA3Ci0g
ICAgICAgICAgIHNldGF0dHIgICAgIHcgICAgICAgICAgIDcKKyAgICAgICAgICAgZ2V0YXR0ciAg
ICAgciAgICAgICAgICAgMQorICAgICAgICAgICBzZXRhdHRyICAgICB3ICAgICAgICAgICAxCiAg
ICAgICAgICAgICAgIGxvY2sgICAgIG4gICAgICAgICAgIDEKLSAgICAgICByZWxhYmVsZnJvbSAg
ICAgciAgICAgICAgICAgMTAKLSAgICAgICAgIHJlbGFiZWx0byAgICAgdyAgICAgICAgICAgMTAK
KyAgICAgICByZWxhYmVsZnJvbSAgICAgciAgICAgICAgICAgMQorICAgICAgICAgcmVsYWJlbHRv
ICAgICB3ICAgICAgICAgICAxCiAgICAgICAgICAgICBhcHBlbmQgICAgIHcgICAgICAgICAgIDEK
ICAgICAgICAgICAgIHVubGluayAgICAgdyAgICAgICAgICAgMQogICAgICAgICAgICAgICBsaW5r
ICAgICB3ICAgICAgICAgICAxCi0gICAgICAgICAgICByZW5hbWUgICAgIHcgICAgICAgICAgIDUK
KyAgICAgICAgICAgIHJlbmFtZSAgICAgdyAgICAgICAgICAgMQogICAgICAgICAgICBleGVjdXRl
ICAgICByICAgICAgICAgICAxCiAgICAgICAgICAgICBzd2Fwb24gICAgIGIgICAgICAgICAgIDEK
ICAgICAgICAgICAgcXVvdGFvbiAgICAgYiAgICAgICAgICAgMQogICAgICAgICAgICBtb3VudG9u
ICAgICBiICAgICAgICAgICAxCisJICAgICAgb3BlbiAgICAgcgkgICAxCiAKIGNsYXNzIGZkIDEK
ICAgICAgICAgICAgICAgIHVzZSAgICAgYiAgICAgICAgICAgMQogCi1jbGFzcyBsbmtfZmlsZSAx
NworY2xhc3MgbG5rX2ZpbGUgMTgKICAgICAgICAgICAgICBpb2N0bCAgICAgbiAgICAgICAgICAg
MQotICAgICAgICAgICAgICByZWFkICAgICByICAgICAgICAgIDEwCi0gICAgICAgICAgICAgd3Jp
dGUgICAgIHcgICAgICAgICAgMTAKKyAgICAgICAgICAgICAgcmVhZCAgICAgciAgICAgICAgICAg
MQorICAgICAgICAgICAgIHdyaXRlICAgICB3ICAgICAgICAgICAxCiAgICAgICAgICAgICBjcmVh
dGUgICAgIHcgICAgICAgICAgIDEKLSAgICAgICAgICAgZ2V0YXR0ciAgICAgciAgICAgICAgICAg
NwotICAgICAgICAgICBzZXRhdHRyICAgICB3ICAgICAgICAgICA3CisgICAgICAgICAgIGdldGF0
dHIgICAgIHIgICAgICAgICAgIDEKKyAgICAgICAgICAgc2V0YXR0ciAgICAgdyAgICAgICAgICAg
MQogICAgICAgICAgICAgICBsb2NrICAgICBuICAgICAgICAgICAxCi0gICAgICAgcmVsYWJlbGZy
b20gICAgIHIgICAgICAgICAgIDEwCi0gICAgICAgICByZWxhYmVsdG8gICAgIHcgICAgICAgICAg
IDEwCisgICAgICAgcmVsYWJlbGZyb20gICAgIHIgICAgICAgICAgIDEKKyAgICAgICAgIHJlbGFi
ZWx0byAgICAgdyAgICAgICAgICAgMQogICAgICAgICAgICAgYXBwZW5kICAgICB3ICAgICAgICAg
ICAxCiAgICAgICAgICAgICB1bmxpbmsgICAgIHcgICAgICAgICAgIDEKICAgICAgICAgICAgICAg
bGluayAgICAgdyAgICAgICAgICAgMQpAQCAtMTkxLDggKzE5Myw5IEBAIGNsYXNzIGxua19maWxl
IDE3CiAgICAgICAgICAgICBzd2Fwb24gICAgIGIgICAgICAgICAgIDEKICAgICAgICAgICAgcXVv
dGFvbiAgICAgYiAgICAgICAgICAgMQogICAgICAgICAgICBtb3VudG9uICAgICBiICAgICAgICAg
ICAxCisJICAgICAgb3BlbiAgICAgcgkgICAxCiAKLWNsYXNzIGNocl9maWxlIDIwCitjbGFzcyBj
aHJfZmlsZSAyMQogICBleGVjdXRlX25vX3RyYW5zICAgICByICAgICAgICAgICAxCiAgICAgICAg
IGVudHJ5cG9pbnQgICAgIHIgICAgICAgICAgIDEKICAgICAgICAgICAgZXhlY21vZCAgICAgbiAg
ICAgICAgICAgMQpAQCAtMjEzLDggKzIxNiw5IEBAIGNsYXNzIGNocl9maWxlIDIwCiAgICAgICAg
ICAgICBzd2Fwb24gICAgIGIgICAgICAgICAgIDEKICAgICAgICAgICAgcXVvdGFvbiAgICAgYiAg
ICAgICAgICAgMQogICAgICAgICAgICBtb3VudG9uICAgICBiICAgICAgICAgICAxCisJICAgICAg
b3BlbiAgICAgcgkgICAxCiAKLWNsYXNzIGJsa19maWxlIDE3CitjbGFzcyBibGtfZmlsZSAxOAog
ICAgICAgICAgICAgIGlvY3RsICAgICBuICAgICAgICAgICAxCiAgICAgICAgICAgICAgIHJlYWQg
ICAgIHIgICAgICAgICAgMTAKICAgICAgICAgICAgICB3cml0ZSAgICAgdyAgICAgICAgICAxMApA
QCAtMjMyLDggKzIzNiw5IEBAIGNsYXNzIGJsa19maWxlIDE3CiAgICAgICAgICAgICBzd2Fwb24g
ICAgIGIgICAgICAgICAgIDEKICAgICAgICAgICAgcXVvdGFvbiAgICAgYiAgICAgICAgICAgMQog
ICAgICAgICAgICBtb3VudG9uICAgICBiICAgICAgICAgICAxCisJICAgICAgb3BlbiAgICAgcgkg
ICAxCiAKLWNsYXNzIHNvY2tfZmlsZSAxNworY2xhc3Mgc29ja19maWxlIDE4CiAgICAgICAgICAg
ICAgaW9jdGwgICAgIG4gICAgICAgICAgIDEKICAgICAgICAgICAgICAgcmVhZCAgICAgciAgICAg
ICAgICAxMAogICAgICAgICAgICAgIHdyaXRlICAgICB3ICAgICAgICAgIDEwCkBAIC0yNTEsOCAr
MjU2LDkgQEAgY2xhc3Mgc29ja19maWxlIDE3CiAgICAgICAgICAgICBzd2Fwb24gICAgIGIgICAg
ICAgICAgIDEKICAgICAgICAgICAgcXVvdGFvbiAgICAgYiAgICAgICAgICAgMQogICAgICAgICAg
ICBtb3VudG9uICAgICBiICAgICAgICAgICAxCisJICAgICAgb3BlbiAgICAgcgkgICAxCiAKLWNs
YXNzIGZpZm9fZmlsZSAxNworY2xhc3MgZmlmb19maWxlIDE4CiAgICAgICAgICAgICAgaW9jdGwg
ICAgIG4gICAgICAgICAgIDEKICAgICAgICAgICAgICAgcmVhZCAgICAgciAgICAgICAgICAxMAog
ICAgICAgICAgICAgIHdyaXRlICAgICB3ICAgICAgICAgIDEwCkBAIC0yNzAsNiArMjc2LDcgQEAg
Y2xhc3MgZmlmb19maWxlIDE3CiAgICAgICAgICAgICBzd2Fwb24gICAgIGIgICAgICAgICAgIDEK
ICAgICAgICAgICAgcXVvdGFvbiAgICAgYiAgICAgICAgICAgMQogICAgICAgICAgICBtb3VudG9u
ICAgICBiICAgICAgICAgICAxCisJICAgICAgb3BlbiAgICAgcgkgICAxCiAKIGNsYXNzIHNvY2tl
dCAyMgogICAgICAgICAgICAgIGlvY3RsICAgICBuICAgICAgICAgICAxCi0tIAoxLjYuNi4xCgo=
--0016361e839a6863ec0484ac0524
Content-Type: application/octet-stream;
	name="0002-Increase-the-matching-threshold.patch"
Content-Disposition: attachment;
	filename="0002-Increase-the-matching-threshold.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g88tk22d1

RnJvbSBmMDg5MTU5NzFiZTNmNTRhY2I5NGM5MzFkYjMzZGM2NGYwYzNkNDM1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8ZjA4OTE1OTcxYmUzZjU0YWNiOTRjOTMxZGIzM2Rj
NjRmMGMzZDQzNS4xMjcxNzI0MjA5LmdpdC5rbWFjbWlsbGFuQHRyZXN5cy5jb20+CkluLVJlcGx5
LVRvOiA8ODNiMjJjZmRjMDEwNzNhMzc4ZmM5ZDUwODc1NTc1ZDI1MmI5NTAwMy4xMjcxNzI0MjA5
LmdpdC5rbWFjbWlsbGFuQHRyZXN5cy5jb20+ClJlZmVyZW5jZXM6IDw4M2IyMmNmZGMwMTA3M2Ez
NzhmYzlkNTA4NzU1NzVkMjUyYjk1MDAzLjEyNzE3MjQyMDkuZ2l0LmttYWNtaWxsYW5AdHJlc3lz
LmNvbT4KRnJvbTogS2FybCBNYWNNaWxsYW4gPGttYWNtaWxsYW5AdHJlc3lzLmNvbT4KRGF0ZTog
TW9uLCAxOSBBcHIgMjAxMCAyMDo0MDo0OCAtMDQwMApTdWJqZWN0OiBbUEFUQ0ggMi8yXSBJbmNy
ZWFzZSB0aGUgbWF0Y2hpbmcgdGhyZXNob2xkLgoKLS0tCiBzZXBvbGdlbi9zcmMvc2Vwb2xnZW4v
bWF0Y2hpbmcucHkgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zZXBvbGdlbi9zcmMvc2Vwb2xnZW4vbWF0Y2hp
bmcucHkgYi9zZXBvbGdlbi9zcmMvc2Vwb2xnZW4vbWF0Y2hpbmcucHkKaW5kZXggMWE5YTNlNS4u
NDkyNjk0ZiAxMDA2NDQKLS0tIGEvc2Vwb2xnZW4vc3JjL3NlcG9sZ2VuL21hdGNoaW5nLnB5Cisr
KyBiL3NlcG9sZ2VuL3NyYy9zZXBvbGdlbi9tYXRjaGluZy5weQpAQCAtNTAsNyArNTAsNyBAQCBj
bGFzcyBNYXRjaDoKICAgICAgICAgICAgICAgICByZXR1cm4gMQogCiBjbGFzcyBNYXRjaExpc3Q6
Ci0gICAgREVGQVVMVF9USFJFU0hPTEQgPSAxMjAKKyAgICBERUZBVUxUX1RIUkVTSE9MRCA9IDE1
MAogICAgIGRlZiBfX2luaXRfXyhzZWxmKToKICAgICAgICAgIyBNYXRjaCBvYmplY3RzIHRoYXQg
cGFzcyB0aGUgdGhyZXNob2xkCiAgICAgICAgIHNlbGYuY2hpbGRyZW4gPSBbXQotLSAKMS42LjYu
MQoK
--0016361e839a6863ec0484ac0524--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
