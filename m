Message-Id: <1493239388.1829342.957407608.3C297B30@webmail.messagingengine.com>
From: Colin Walters <walters@verbum.org>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_149323938818293420"
Date: Wed, 26 Apr 2017 16:43:08 -0400
Subject: Re: is_selinux_enabled() always returns 0 after
 selinux_set_policy_root()
In-Reply-To: <1493238298.32540.13.camel@tycho.nsa.gov>
References: <1493237420.1820719.957368808.08E54C5A@webmail.messagingengine.com>
 <1493238298.32540.13.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.

--_----------=_149323938818293420
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"

On Wed, Apr 26, 2017, at 04:24 PM, Stephen Smalley wrote:
>
> Your analysis and proposed fix sound correct to me.  I blame Dan ;)

Thanks.  I tested the patch and confirmed it fixed ostree as it stands today,
but I'm going to change ostree to cache the result of `is_selinux_enabled()`
itself to work around this, since for our use cases it should never really
change dynamically.

Here's a git-format-patch version attached:

--_----------=_149323938818293420
Content-Disposition: attachment; filename="0001-config-Don-t-finalize-mount-state-in-selinux_set_pol.patch"
Content-Id: <1493239381.1829351.a9b120baf7813d0f9789ae82ccd7c7ced330f4b5.76A711F0@content.messagingengine.com>
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="0001-config-Don-t-finalize-mount-state-in-selinux_set_pol.patch"

RnJvbSA5MjY4MzM2YjNlM2E4OTk0ZTQ5NWU3YTk5N2M5OTc4NDUzZjdiMTU1
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDb2xpbiBXYWx0ZXJz
IDx3YWx0ZXJzQHZlcmJ1bS5vcmc+CkRhdGU6IFdlZCwgMjYgQXByIDIwMTcg
MTY6MjY6MjEgLTA0MDAKU3ViamVjdDogW1BBVENIXSBjb25maWc6IERvbid0
IGZpbmFsaXplIG1vdW50IHN0YXRlIGluCiBzZWxpbnV4X3NldF9wb2xpY3lf
cm9vdCgpCgpUaGlzIGJyZWFrcyBldmVyeSBmdXJ0aGVyIGNhbGwgdG8gZS5n
LiBgaXNfc2VsaW51eF9lbmFibGVkKClgIGFmdGVyIGEgcG9saWN5CnJvb3Qg
aGFzIGJlZW4gc2V0LiAgVGhpcyB0cmlwcGVkIHVwIHNvbWUgY29kZSBsYW5k
ZWQgaW4gbGlib3N0cmVlOgpodHRwczovL2dpdGh1Yi5jb20vb3N0cmVlZGV2
L29zdHJlZS9wdWxsLzc5NwpTaW5jZSBpbiBzb21lIGNhc2VzIHdlIGluaXRp
YWxpemUgYSBwb2xpY3kgdHdpY2UgaW4gcHJvY2VzcywgYW5kIHdlJ2QKY2Fs
bCBgaXNfc2VsaW51eF9lbmFibGVkKClgIGVhY2ggdGltZS4KCk1vcmUgaW5m
byBpbjogaHR0cDovL21hcmMuaW5mby8/bD1zZWxpbnV4Jm09MTQ5MzIzODA5
MzMyNDE3Jnc9MgotLS0KIGxpYnNlbGludXgvc3JjL3NlbGludXhfY29uZmln
LmMgfCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvbGlic2VsaW51eC9zcmMvc2VsaW51eF9jb25maWcuYyBiL2xp
YnNlbGludXgvc3JjL3NlbGludXhfY29uZmlnLmMKaW5kZXggZDhlMTQwYy4u
MjkyNzI4ZiAxMDA2NDQKLS0tIGEvbGlic2VsaW51eC9zcmMvc2VsaW51eF9j
b25maWcuYworKysgYi9saWJzZWxpbnV4L3NyYy9zZWxpbnV4X2NvbmZpZy5j
CkBAIC0yODIsNyArMjgyLDYgQEAgaW50IHNlbGludXhfc2V0X3BvbGljeV9y
b290KGNvbnN0IGNoYXIgKnBhdGgpCiAJfQogCXBvbGljeV90eXBlKys7CiAK
LQlmaW5pX3NlbGludXhtbnQoKTsKIAlmaW5pX3NlbGludXhfcG9saWN5cm9v
dCgpOwogCiAJc2VsaW51eF9wb2xpY3lyb290ID0gc3RyZHVwKHBhdGgpOwot
LSAKMi45LjMKCg==

--_----------=_149323938818293420--
