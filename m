Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v56Nvik3016216
 for <selinux@tycho.nsa.gov>; Tue, 6 Jun 2017 19:57:47 -0400
Subject: Re: [PATCH] security: selinux: use kmem_cache for ebitmap
To: Paul Moore <paul@paul-moore.com>
References: <1496653814-3653-1-git-send-email-junil0814.lee@lge.com>
 <CAHC9VhSDux6oAcD1ZULOTcCp69JFY1c4Jati3odg4ROoRROp-w@mail.gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, serge@hallyn.com,
 william.c.roberts@intel.com, adobriyan@gmail.com,
 akpm@linux-foundation.org, dledford@redhat.com, danielj@mellanox.com,
 mka@chromium.org, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 junil0814.lee@lge.com
From: "=?UTF-8?B?7J207KSA7J28L+yXsOq1rOybkC9NQ+yXsOq1rOyGjCBCU1Dsi6QgQlNQNg==?=
 =?UTF-8?Q?=ed=8c=80=28junil0814.lee@lge.com=29?=" <junil0814.lee@lge.com>
Message-ID: <885540aa-dc08-cf4b-4b85-7a4d1ce04068@lge.com>
Date: Wed, 7 Jun 2017 08:57:32 +0900
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSDux6oAcD1ZULOTcCp69JFY1c4Jati3odg4ROoRROp-w@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------58424AB5D40B4BEC3A44609A"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------58424AB5D40B4BEC3A44609A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Paul Moore wrote on 2017-06-06 오전 6:39:
> On Mon, Jun 5, 2017 at 5:10 AM, Junil Lee <junil0814.lee@lge.com> wrote:
>> The allocated size for each ebitmap_node is 192byte by kzalloc().
>> Then, ebitmap_node size is fixed, so it's possible to use only 144byte
>> for each object by kmem_cache_zalloc().
>> It can reduce some dynamic allocation size.
>>
>> Signed-off-by: Junil Lee <junil0814.lee@lge.com>
>> ---
>> security/selinux/ss/ebitmap.c | 24 +++++++++++++++++++-----
>> security/selinux/ss/ebitmap.h | 3 +++
>> security/selinux/ss/services.c | 4 ++++
>> 3 files changed, 26 insertions(+), 5 deletions(-)
>>
>> diff --git a/security/selinux/ss/ebitmap.c
> b/security/selinux/ss/ebitmap.c
>> index 9db4709a..076c96f 100644
>> --- a/security/selinux/ss/ebitmap.c
>> +++ b/security/selinux/ss/ebitmap.c
>> @@ -24,6 +24,8 @@
>>
>> #define BITS_PER_U64 (sizeof(u64) * 8)
>>
>> +static struct kmem_cache *ebitmap_node_cachep;
>> +
>> int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2)
>> {
>> struct ebitmap_node *n1, *n2;
>> @@ -54,7 +56,7 @@ int ebitmap_cpy(struct ebitmap *dst, struct ebitmap
> *src)
>> n = src->node;
>> prev = NULL;
>> while (n) {
>> - new = kzalloc(sizeof(*new), GFP_ATOMIC);
>> + new = kmem_cache_zalloc(ebitmap_node_cachep, GFP_ATOMIC);
>> if (!new) {
>> ebitmap_destroy(dst);
>> return -ENOMEM;
>> @@ -162,7 +164,7 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
>> if (e_iter == NULL ||
>> offset >= e_iter->startbit + EBITMAP_SIZE) {
>> e_prev = e_iter;
>> - e_iter = kzalloc(sizeof(*e_iter), GFP_ATOMIC);
>> + e_iter = kmem_cache_zalloc(ebitmap_node_cachep, GFP_ATOMIC);
>> if (e_iter == NULL)
>> goto netlbl_import_failure;
>> e_iter->startbit = offset - (offset % EBITMAP_SIZE);
>> @@ -299,7 +301,7 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned
> long bit, int value)
>> if (!value)
>> return 0;
>>
>> - new = kzalloc(sizeof(*new), GFP_ATOMIC);
>> + new = kmem_cache_zalloc(ebitmap_node_cachep, GFP_ATOMIC);
>> if (!new)
>> return -ENOMEM;
> 
> I believe there is a kfree() in ebitmap_set_bit() that also needs to
> be converted.
> 

Thanks for your advice Paul.
reattach patch v2.

Thanks,
Junil Lee.

> -- 
> paul moore
> www.paul-moore.com

--------------58424AB5D40B4BEC3A44609A
Content-Type: text/plain; charset=UTF-8;
 name="0001-security-selinux-use-kmem_cache-for-ebitmap.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-security-selinux-use-kmem_cache-for-ebitmap.patch"

RnJvbSAwNzE2OWZmNzNjNzkxZGYwOTc5YWEzNmQwMTMzYWVkNGRiNzI3YTFhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKdW5pbCBMZWUgPGp1bmlsMDgxNC5sZWVAbGdlLmNv
bT4KRGF0ZTogTW9uLCA1IEp1biAyMDE3IDE3OjA1OjQ2ICswOTAwClN1YmplY3Q6IFtQQVRD
SF0gc2VjdXJpdHk6IHNlbGludXg6IHVzZSBrbWVtX2NhY2hlIGZvciBlYml0bWFwCgpUaGUg
YWxsb2NhdGVkIHNpemUgZm9yIGVhY2ggZWJpdG1hcF9ub2RlIGlzIDE5MmJ5dGUgYnkga3ph
bGxvYygpLgpUaGVuLCBlYml0bWFwX25vZGUgc2l6ZSBpcyBmaXhlZCwgc28gaXQncyBwb3Nz
aWJsZSB0byB1c2Ugb25seSAxNDRieXRlCmZvciBlYWNoIG9iamVjdCBieSBrbWVtX2NhY2hl
X3phbGxvYygpLgpJdCBjYW4gcmVkdWNlIHNvbWUgZHluYW1pYyBhbGxvY2F0aW9uIHNpemUu
CgpTaWduZWQtb2ZmLWJ5OiBKdW5pbCBMZWUgPGp1bmlsMDgxNC5sZWVAbGdlLmNvbT4KLS0t
CiBzZWN1cml0eS9zZWxpbnV4L3NzL2ViaXRtYXAuYyAgfCAyNiArKysrKysrKysrKysrKysr
KysrKy0tLS0tLQogc2VjdXJpdHkvc2VsaW51eC9zcy9lYml0bWFwLmggIHwgIDMgKysrCiBz
ZWN1cml0eS9zZWxpbnV4L3NzL3NlcnZpY2VzLmMgfCAgNCArKysrCiAzIGZpbGVzIGNoYW5n
ZWQsIDI3IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc2Vj
dXJpdHkvc2VsaW51eC9zcy9lYml0bWFwLmMgYi9zZWN1cml0eS9zZWxpbnV4L3NzL2ViaXRt
YXAuYwppbmRleCA5ZGI0NzA5YS4uYWQzODI5OSAxMDA2NDQKLS0tIGEvc2VjdXJpdHkvc2Vs
aW51eC9zcy9lYml0bWFwLmMKKysrIGIvc2VjdXJpdHkvc2VsaW51eC9zcy9lYml0bWFwLmMK
QEAgLTI0LDYgKzI0LDggQEAKIAogI2RlZmluZSBCSVRTX1BFUl9VNjQJKHNpemVvZih1NjQp
ICogOCkKIAorc3RhdGljIHN0cnVjdCBrbWVtX2NhY2hlICplYml0bWFwX25vZGVfY2FjaGVw
OworCiBpbnQgZWJpdG1hcF9jbXAoc3RydWN0IGViaXRtYXAgKmUxLCBzdHJ1Y3QgZWJpdG1h
cCAqZTIpCiB7CiAJc3RydWN0IGViaXRtYXBfbm9kZSAqbjEsICpuMjsKQEAgLTU0LDcgKzU2
LDcgQEAgaW50IGViaXRtYXBfY3B5KHN0cnVjdCBlYml0bWFwICpkc3QsIHN0cnVjdCBlYml0
bWFwICpzcmMpCiAJbiA9IHNyYy0+bm9kZTsKIAlwcmV2ID0gTlVMTDsKIAl3aGlsZSAobikg
ewotCQluZXcgPSBremFsbG9jKHNpemVvZigqbmV3KSwgR0ZQX0FUT01JQyk7CisJCW5ldyA9
IGttZW1fY2FjaGVfemFsbG9jKGViaXRtYXBfbm9kZV9jYWNoZXAsIEdGUF9BVE9NSUMpOwog
CQlpZiAoIW5ldykgewogCQkJZWJpdG1hcF9kZXN0cm95KGRzdCk7CiAJCQlyZXR1cm4gLUVO
T01FTTsKQEAgLTE2Miw3ICsxNjQsNyBAQCBpbnQgZWJpdG1hcF9uZXRsYmxfaW1wb3J0KHN0
cnVjdCBlYml0bWFwICplYm1hcCwKIAkJaWYgKGVfaXRlciA9PSBOVUxMIHx8CiAJCSAgICBv
ZmZzZXQgPj0gZV9pdGVyLT5zdGFydGJpdCArIEVCSVRNQVBfU0laRSkgewogCQkJZV9wcmV2
ID0gZV9pdGVyOwotCQkJZV9pdGVyID0ga3phbGxvYyhzaXplb2YoKmVfaXRlciksIEdGUF9B
VE9NSUMpOworCQkJZV9pdGVyID0ga21lbV9jYWNoZV96YWxsb2MoZWJpdG1hcF9ub2RlX2Nh
Y2hlcCwgR0ZQX0FUT01JQyk7CiAJCQlpZiAoZV9pdGVyID09IE5VTEwpCiAJCQkJZ290byBu
ZXRsYmxfaW1wb3J0X2ZhaWx1cmU7CiAJCQllX2l0ZXItPnN0YXJ0Yml0ID0gb2Zmc2V0IC0g
KG9mZnNldCAlIEVCSVRNQVBfU0laRSk7CkBAIC0yODgsNyArMjkwLDcgQEAgaW50IGViaXRt
YXBfc2V0X2JpdChzdHJ1Y3QgZWJpdG1hcCAqZSwgdW5zaWduZWQgbG9uZyBiaXQsIGludCB2
YWx1ZSkKIAkJCQkJcHJldi0+bmV4dCA9IG4tPm5leHQ7CiAJCQkJZWxzZQogCQkJCQllLT5u
b2RlID0gbi0+bmV4dDsKLQkJCQlrZnJlZShuKTsKKwkJCQlrbWVtX2NhY2hlX2ZyZWUoZWJp
dG1hcF9ub2RlX2NhY2hlcCwgbik7CiAJCQl9CiAJCQlyZXR1cm4gMDsKIAkJfQpAQCAtMjk5
LDcgKzMwMSw3IEBAIGludCBlYml0bWFwX3NldF9iaXQoc3RydWN0IGViaXRtYXAgKmUsIHVu
c2lnbmVkIGxvbmcgYml0LCBpbnQgdmFsdWUpCiAJaWYgKCF2YWx1ZSkKIAkJcmV0dXJuIDA7
CiAKLQluZXcgPSBremFsbG9jKHNpemVvZigqbmV3KSwgR0ZQX0FUT01JQyk7CisJbmV3ID0g
a21lbV9jYWNoZV96YWxsb2MoZWJpdG1hcF9ub2RlX2NhY2hlcCwgR0ZQX0FUT01JQyk7CiAJ
aWYgKCFuZXcpCiAJCXJldHVybiAtRU5PTUVNOwogCkBAIC0zMzIsNyArMzM0LDcgQEAgdm9p
ZCBlYml0bWFwX2Rlc3Ryb3koc3RydWN0IGViaXRtYXAgKmUpCiAJd2hpbGUgKG4pIHsKIAkJ
dGVtcCA9IG47CiAJCW4gPSBuLT5uZXh0OwotCQlrZnJlZSh0ZW1wKTsKKwkJa21lbV9jYWNo
ZV9mcmVlKGViaXRtYXBfbm9kZV9jYWNoZXAsIHRlbXApOwogCX0KIAogCWUtPmhpZ2hiaXQg
PSAwOwpAQCAtNDAwLDcgKzQwMiw3IEBAIGludCBlYml0bWFwX3JlYWQoc3RydWN0IGViaXRt
YXAgKmUsIHZvaWQgKmZwKQogCiAJCWlmICghbiB8fCBzdGFydGJpdCA+PSBuLT5zdGFydGJp
dCArIEVCSVRNQVBfU0laRSkgewogCQkJc3RydWN0IGViaXRtYXBfbm9kZSAqdG1wOwotCQkJ
dG1wID0ga3phbGxvYyhzaXplb2YoKnRtcCksIEdGUF9LRVJORUwpOworCQkJdG1wID0ga21l
bV9jYWNoZV96YWxsb2MoZWJpdG1hcF9ub2RlX2NhY2hlcCwgR0ZQX0tFUk5FTCk7CiAJCQlp
ZiAoIXRtcCkgewogCQkJCXByaW50ayhLRVJOX0VSUgogCQkJCSAgICAgICAiU0VMaW51eDog
ZWJpdG1hcDogb3V0IG9mIG1lbW9yeVxuIik7CkBAIC01MTksMyArNTIxLDE1IEBAIGludCBl
Yml0bWFwX3dyaXRlKHN0cnVjdCBlYml0bWFwICplLCB2b2lkICpmcCkKIAl9CiAJcmV0dXJu
IDA7CiB9CisKK3ZvaWQgZWJpdG1hcF9jYWNoZV9pbml0KHZvaWQpCit7CisJZWJpdG1hcF9u
b2RlX2NhY2hlcCA9IGttZW1fY2FjaGVfY3JlYXRlKCJlYml0bWFwX25vZGUiLAorCQkJCQkJ
CXNpemVvZihzdHJ1Y3QgZWJpdG1hcF9ub2RlKSwKKwkJCQkJCQkwLCBTTEFCX1BBTklDLCBO
VUxMKTsKK30KKwordm9pZCBlYml0bWFwX2NhY2hlX2Rlc3Ryb3kodm9pZCkKK3sKKwlrbWVt
X2NhY2hlX2Rlc3Ryb3koZWJpdG1hcF9ub2RlX2NhY2hlcCk7Cit9CmRpZmYgLS1naXQgYS9z
ZWN1cml0eS9zZWxpbnV4L3NzL2ViaXRtYXAuaCBiL3NlY3VyaXR5L3NlbGludXgvc3MvZWJp
dG1hcC5oCmluZGV4IDk2MzdiOGMuLjZkNWE5YWMgMTAwNjQ0Ci0tLSBhL3NlY3VyaXR5L3Nl
bGludXgvc3MvZWJpdG1hcC5oCisrKyBiL3NlY3VyaXR5L3NlbGludXgvc3MvZWJpdG1hcC5o
CkBAIC0xMzAsNiArMTMwLDkgQEAgdm9pZCBlYml0bWFwX2Rlc3Ryb3koc3RydWN0IGViaXRt
YXAgKmUpOwogaW50IGViaXRtYXBfcmVhZChzdHJ1Y3QgZWJpdG1hcCAqZSwgdm9pZCAqZnAp
OwogaW50IGViaXRtYXBfd3JpdGUoc3RydWN0IGViaXRtYXAgKmUsIHZvaWQgKmZwKTsKIAor
dm9pZCBlYml0bWFwX2NhY2hlX2luaXQodm9pZCk7Cit2b2lkIGViaXRtYXBfY2FjaGVfZGVz
dHJveSh2b2lkKTsKKwogI2lmZGVmIENPTkZJR19ORVRMQUJFTAogaW50IGViaXRtYXBfbmV0
bGJsX2V4cG9ydChzdHJ1Y3QgZWJpdG1hcCAqZWJtYXAsCiAJCQkgIHN0cnVjdCBuZXRsYmxf
bHNtX2NhdG1hcCAqKmNhdG1hcCk7CmRpZmYgLS1naXQgYS9zZWN1cml0eS9zZWxpbnV4L3Nz
L3NlcnZpY2VzLmMgYi9zZWN1cml0eS9zZWxpbnV4L3NzL3NlcnZpY2VzLmMKaW5kZXggMjAy
MTY2Ni4uMmYwMmZhNiAxMDA2NDQKLS0tIGEvc2VjdXJpdHkvc2VsaW51eC9zcy9zZXJ2aWNl
cy5jCisrKyBiL3NlY3VyaXR5L3NlbGludXgvc3Mvc2VydmljZXMuYwpAQCAtMjA1NCw5ICsy
MDU0LDExIEBAIGludCBzZWN1cml0eV9sb2FkX3BvbGljeSh2b2lkICpkYXRhLCBzaXplX3Qg
bGVuKQogCiAJaWYgKCFzc19pbml0aWFsaXplZCkgewogCQlhdnRhYl9jYWNoZV9pbml0KCk7
CisJCWViaXRtYXBfY2FjaGVfaW5pdCgpOwogCQlyYyA9IHBvbGljeWRiX3JlYWQoJnBvbGlj
eWRiLCBmcCk7CiAJCWlmIChyYykgewogCQkJYXZ0YWJfY2FjaGVfZGVzdHJveSgpOworCQkJ
ZWJpdG1hcF9jYWNoZV9kZXN0cm95KCk7CiAJCQlnb3RvIG91dDsKIAkJfQogCkBAIC0yMDY3
LDYgKzIwNjksNyBAQCBpbnQgc2VjdXJpdHlfbG9hZF9wb2xpY3kodm9pZCAqZGF0YSwgc2l6
ZV90IGxlbikKIAkJaWYgKHJjKSB7CiAJCQlwb2xpY3lkYl9kZXN0cm95KCZwb2xpY3lkYik7
CiAJCQlhdnRhYl9jYWNoZV9kZXN0cm95KCk7CisJCQllYml0bWFwX2NhY2hlX2Rlc3Ryb3ko
KTsKIAkJCWdvdG8gb3V0OwogCQl9CiAKQEAgLTIwNzQsNiArMjA3Nyw3IEBAIGludCBzZWN1
cml0eV9sb2FkX3BvbGljeSh2b2lkICpkYXRhLCBzaXplX3QgbGVuKQogCQlpZiAocmMpIHsK
IAkJCXBvbGljeWRiX2Rlc3Ryb3koJnBvbGljeWRiKTsKIAkJCWF2dGFiX2NhY2hlX2Rlc3Ry
b3koKTsKKwkJCWViaXRtYXBfY2FjaGVfZGVzdHJveSgpOwogCQkJZ290byBvdXQ7CiAJCX0K
IAotLSAKMi42LjIKCg==
--------------58424AB5D40B4BEC3A44609A--
