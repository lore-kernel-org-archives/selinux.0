Message-Id: <200209151031.KAA19100@jazzband.ncsc.mil>
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: pppd and net_context
Date: Sun, 15 Sep 2002 11:32:04 +0200
References: <20020911130902.A6BE2FA8D@ivanova.coker.com.au> <200209121615.01677.russell@coker.com.au>
In-Reply-To: <200209121615.01677.russell@coker.com.au>
Cc: Russell Coker <russell@coker.com.au>, SELinux <SELinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_GT3HKT0YHATO3893BC5M"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_GT3HKT0YHATO3893BC5M
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

last week I add the isdn4linux devices to my selinux rules.=20
That do you think, is the attached patch correct?=20
The type declaration should be ok, also the netifcon entries. Both are=20
wrote on "Configure the SELinux Policy".=20
I am not sure with the two allow entries, because I don't found anything=20
about it in the documentation.=20
And why uses the loopback device the special node_lo_t ?

Thanks

Carsten

Am Donnerstag, 12. September 2002 16:15 schrieben Sie:
> On Wed, 11 Sep 2002 15:08, Carsten Grohmann wrote:
> > Hi Russel,
> >
> > I missing the attached patch in your policy. This patch is necessary =
to
> > label the trafic over the ippp0 interface correct.
>
> I have not done anything seriously with network contexts, I am spending
> all my time working on host based security.  So therefore I don't feel
> that I am qualified to determine whether your patch is suitable for my
> policy tree.
>
> I recommend that you send it to Stephen Smalley, if he likes it then I'=
ll
> put it in my tree too.
>
>
> Russell Coker

--------------Boundary-00=_GT3HKT0YHATO3893BC5M
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="netcontext.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="netcontext.diff"

LS0tIC4uL29yaWdpbmFsL25ldF9jb250ZXh0cwlXZWQgQXVnIDIxIDIwOjIyOjQyIDIwMDIKKysr
IG5ldF9jb250ZXh0cwlXZWQgU2VwICA0IDE1OjQ4OjUzIDIwMDIKQEAgLTUzLDYgKzUzLDcgQEAK
IG5ldGlmY29uIGV0aDAgc3lzdGVtX3U6b2JqZWN0X3I6bmV0aWZfZXRoMF90IHN5c3RlbV91Om9i
amVjdF9yOm5ldG1zZ19ldGgwX3QKIG5ldGlmY29uIGV0aDEgc3lzdGVtX3U6b2JqZWN0X3I6bmV0
aWZfZXRoMV90IHN5c3RlbV91Om9iamVjdF9yOm5ldG1zZ19ldGgxX3QKIG5ldGlmY29uIGV0aDIg
c3lzdGVtX3U6b2JqZWN0X3I6bmV0aWZfZXRoMl90IHN5c3RlbV91Om9iamVjdF9yOm5ldG1zZ19l
dGgyX3QKK25ldGlmY29uIGlwcHAwIHN5c3RlbV91Om9iamVjdF9yOm5ldGlmX2lwcHAwX3Qgc3lz
dGVtX3U6b2JqZWN0X3I6bmV0bXNnX2lwcHAwX3QKIG5ldGlmY29uIGlwc2VjMCBzeXN0ZW1fdTpv
YmplY3RfcjpuZXRpZl9pcHNlYzBfdCBzeXN0ZW1fdTpvYmplY3RfcjpuZXRtc2dfaXBzZWMwX3QK
IG5ldGlmY29uIGlwc2VjMSBzeXN0ZW1fdTpvYmplY3RfcjpuZXRpZl9pcHNlYzFfdCBzeXN0ZW1f
dTpvYmplY3RfcjpuZXRtc2dfaXBzZWMxX3QKIG5ldGlmY29uIGlwc2VjMiBzeXN0ZW1fdTpvYmpl
Y3RfcjpuZXRpZl9pcHNlYzJfdCBzeXN0ZW1fdTpvYmplY3RfcjpuZXRtc2dfaXBzZWMyX3QKLS0t
IC4uL29yaWdpbmFsL3R5cGVzL25ldHdvcmsudGUJVHVlIEp1biAxOCAxOTo0MDo0MiAyMDAyCisr
KyB0eXBlcy9uZXR3b3JrLnRlCVdlZCBTZXAgIDQgMTU6NDg6MTUgMjAwMgpAQCAtNTQsNiArNTQs
NyBAQAogdHlwZSBuZXRpZl9ldGgxX3QsIG5ldGlmX3R5cGU7CiB0eXBlIG5ldGlmX2V0aDJfdCwg
bmV0aWZfdHlwZTsKIHR5cGUgbmV0aWZfbG9fdCwgbmV0aWZfdHlwZTsKK3R5cGUgbmV0aWZfaXBw
cDBfdCwgbmV0aWZfdHlwZTsKIAogdHlwZSBuZXRpZl9pcHNlYzBfdCwgbmV0aWZfdHlwZTsKIHR5
cGUgbmV0aWZfaXBzZWMxX3QsIG5ldGlmX3R5cGU7CkBAIC02OSw2ICs3MCw3IEBACiB0eXBlIG5l
dG1zZ19ldGgxX3QsIG5ldG1zZ190eXBlOwogdHlwZSBuZXRtc2dfZXRoMl90LCBuZXRtc2dfdHlw
ZTsKIHR5cGUgbmV0bXNnX2xvX3QsIG5ldG1zZ190eXBlOwordHlwZSBuZXRtc2dfaXBwcDBfdCwg
bmV0bXNnX3R5cGU7CiAKIHR5cGUgbmV0bXNnX2lwc2VjMF90LCBuZXRtc2dfdHlwZTsKIHR5cGUg
bmV0bXNnX2lwc2VjMV90LCBuZXRtc2dfdHlwZTsKQEAgLTExNiw2ICsxMTgsOCBAQAogYWxsb3cg
bmV0bXNnX2xvX3Qgbm9kZV9sb190Om5vZGUgeyB0Y3BfcmVjdiB1ZHBfcmVjdiByYXdpcF9yZWN2
IH07CiBhbGxvdyBuZXRtc2dfbG9fdCBub2RlX3Q6bm9kZSB7IHRjcF9yZWN2IHVkcF9yZWN2IHJh
d2lwX3JlY3YgfTsKIGFsbG93IG5ldG1zZ19sb190IG5ldGlmX2xvX3Q6bmV0aWYgeyB0Y3BfcmVj
diB1ZHBfcmVjdiByYXdpcF9yZWN2IH07CithbGxvdyBuZXRtc2dfaXBwcDBfdCBub2RlX3Q6bm9k
ZSB7IHRjcF9yZWN2IHVkcF9yZWN2IHJhd2lwX3JlY3YgfTsKK2FsbG93IG5ldG1zZ19pcHBwMF90
IG5ldGlmX2lwcHAwX3Q6bmV0aWYgeyB0Y3BfcmVjdiB1ZHBfcmVjdiByYXdpcF9yZWN2IH07CiBh
bGxvdyBuZXRtc2dfaXBzZWMwX3Qgbm9kZV90Om5vZGUgeyB0Y3BfcmVjdiB1ZHBfcmVjdiByYXdp
cF9yZWN2IH07CiBhbGxvdyBuZXRtc2dfaXBzZWMwX3QgbmV0aWZfaXBzZWMwX3Q6bm9kZSB7IHRj
cF9yZWN2IHVkcF9yZWN2IHJhd2lwX3JlY3YgfTsKIGFsbG93IG5ldG1zZ19pcHNlYzFfdCBub2Rl
X3Q6bm9kZSB7IHRjcF9yZWN2IHVkcF9yZWN2IHJhd2lwX3JlY3YgfTsK

--------------Boundary-00=_GT3HKT0YHATO3893BC5M--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
