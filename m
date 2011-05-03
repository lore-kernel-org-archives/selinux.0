Message-ID: <4DC02770.1040406@redhat.com>
Date: Tue, 03 May 2011 12:04:00 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <selinux@tycho.nsa.gov>,
        Lennart Poettering <lennart@poettering.net>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: libselinux mountpoint changing patch.
References: <4DC01640.9000206@redhat.com> <1304436800.1587.20.camel@moss-pluto>
In-Reply-To: <1304436800.1587.20.camel@moss-pluto>
Content-Type: multipart/mixed;
 boundary="------------070902080508090204070803"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070902080508090204070803
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/03/2011 11:33 AM, Stephen Smalley wrote:
> On Tue, 2011-05-03 at 10:50 -0400, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> The Fedora Distribution is looking to standardize kernel subsystem file
>> systems to be mounted under /sys/fs. They would like us to move /selinux
>> to /sys/fs/selinux.  This patch changes libselinux in the following ways:
>>
>> 1.  load_policy will first check if /sys/fs/selinux exists and mount the
>> selinuxfs at this location, if it does not exists it will fall back to
>> mounting the file system at /selinux (if it exists).
>>
>> 2.  The init functions of selinux will now check if /sys/fs/selinux is
>> mounted, if it is and has an SELinuxfs mounted on it, the code will then
>> check if the selinuxfs is mounted rw, if it is, libselinux will set the
>> mountpoint, if it is readonly, libselinux will return no mountpoint.  If
>> /sys/fs/selinux does not exists, the same check will be done for
>> /selinux and finally for an entry in /proc/mounts.
>>
>> NOTE:  We added the check for RO, to allow tools like mock to be able to
>> tell a chroot that SELinux is disabled while enforcing it outside the
>> chroot.
>>
>>
>> # getenforce
>> Enabled
>> # mount -t selinuxfs -o remount,ro selinuxfs /var/chroot/selinux
> 
> Just to clarify, the right commands to use are:
> mount --bind /selinux /var/chroot/selinux
> mount -o remount,ro /var/chroot/selinux
> 
> Do not use:
> mount -t selinuxfs -o ro selinuxfs /var/chroot/selinux
> as this will in fact change the flags on /selinux as well.  Surprise!
> Result of there only being a single instance (superblock) of selinuxfs,
> although you can have multiple vfsmounts of it.
> 
>> # chroot /var/chroot
>> # getenforce
>> Disabled
>>
>> 3. In order to make this work, I needed to stop enabled from checking if
>> /proc/filesystem for entries if selinux_mnt did not exist.  Now enabeled
>> checks if selinux_mnt has been discovered otherwise it will report
>> selinux disabled.
> 
> Looks reasonable, minor comments below.
> 
> Can we really not get all the necessary information from a single call
> (as opposed to having to call both statfs() and statvfs())?  Isn't
> statvfs() implemented on Linux by calling the statfs system call?
> 
Not that I can see.

> I'd suggest adding a #define OLDSELINUXMNT "/selinux" to policy.h and
> using OLDSELINUXMNT in init.c and load_policy.c rather than sprinkling
> "/selinux" around multiple places.   Wouldn't hurt to #define SELINUXFS
> "selinuxfs" as well and replacing all occurrences in init.c and
> load_policy.c.
> 
Ok
> As check_mountpoint() sets selinux_mnt, I'd pick a more descriptive
> name.  Actually, could you perhaps fold the logic into set_selinuxmnt()?
> That would mean the validation would happen when set_selinuxmnt() gets
> called by load_policy, which isn't strictly necessary but does no harm.
> 

Done

I have to change set_selinuxmnt to return an int now, though.
Does this mean we would need an API version bump?  Changing from void
return to int?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3AJ28ACgkQrlYvE4MpobPMBwCghY08MsDjpufL/NPkFWfC7M6v
9kgAoI8Gi0Z0LROlxPYgtvcShmZkLEKb
=4NO/
-----END PGP SIGNATURE-----

--------------070902080508090204070803
Content-Type: text/plain;
 name="libselinux-mountpoint.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libselinux-mountpoint.patch"

ZGlmZiAtLWdpdCBhL2xpYnNlbGludXgvaW5jbHVkZS9zZWxpbnV4L3NlbGludXguaCBiL2xp
YnNlbGludXgvaW5jbHVkZS9zZWxpbnV4L3NlbGludXguaAppbmRleCBmMTEwZGNmLi42NDRk
NmQyIDEwMDY0NAotLS0gYS9saWJzZWxpbnV4L2luY2x1ZGUvc2VsaW51eC9zZWxpbnV4LmgK
KysrIGIvbGlic2VsaW51eC9pbmNsdWRlL3NlbGludXgvc2VsaW51eC5oCkBAIC01MTMsNyAr
NTEzLDcgQEAgZXh0ZXJuIGludCBzZWxpbnV4X2NoZWNrX3NlY3VyZXR0eV9jb250ZXh0KGNv
bnN0IHNlY3VyaXR5X2NvbnRleHRfdCB0dHlfY29udGV4dCkKICAgIE5vcm1hbGx5LCB0aGlz
IGlzIGRldGVybWluZWQgYXV0b21hdGljYWxseSBkdXJpbmcgbGlic2VsaW51eCAKICAgIGlu
aXRpYWxpemF0aW9uLCBidXQgdGhpcyBpcyBub3QgYWx3YXlzIHBvc3NpYmxlLCBlLmcuIGZv
ciAvc2Jpbi9pbml0CiAgICB3aGljaCBwZXJmb3JtcyB0aGUgaW5pdGlhbCBtb3VudCBvZiBz
ZWxpbnV4ZnMuICovCi12b2lkIHNldF9zZWxpbnV4bW50KGNoYXIgKm1udCk7CitpbnQgc2V0
X3NlbGludXhtbnQoY2hhciAqbW50KTsKIAogLyogY2xlYXIgc2VsaW51eG1udCB2YXJpYWJs
ZSBhbmQgZnJlZSBhbGxvY2F0ZWQgbWVtb3J5ICovCiB2b2lkIGZpbmlfc2VsaW51eG1udCh2
b2lkKTsKZGlmZiAtLWdpdCBhL2xpYnNlbGludXgvc3JjL2VuYWJsZWQuYyBiL2xpYnNlbGlu
dXgvc3JjL2VuYWJsZWQuYwppbmRleCBiM2M4YzQ3Li4wMThjNzg3IDEwMDY0NAotLS0gYS9s
aWJzZWxpbnV4L3NyYy9lbmFibGVkLmMKKysrIGIvbGlic2VsaW51eC9zcmMvZW5hYmxlZC5j
CkBAIC0xMSwxMCArMTEsNiBAQAogCiBpbnQgaXNfc2VsaW51eF9lbmFibGVkKHZvaWQpCiB7
Ci0JY2hhciAqYnVmPU5VTEw7Ci0JRklMRSAqZnA7Ci0Jc3NpemVfdCBudW07Ci0Jc2l6ZV90
IGxlbjsKIAlpbnQgZW5hYmxlZCA9IDA7CiAJc2VjdXJpdHlfY29udGV4dF90IGNvbjsKIApA
QCAtMzIsMzcgKzI4LDggQEAgaW50IGlzX3NlbGludXhfZW5hYmxlZCh2b2lkKQogCQkJCWVu
YWJsZWQgPSAwOwogCQkJZnJlZWNvbihjb24pOwogCQl9Ci0JCXJldHVybiBlbmFibGVkOwog
ICAgICAgICB9CiAKLQkvKiBEcm9wIGJhY2sgdG8gZGV0ZWN0aW5nIGl0IHRoZSBsb25nIHdh
eS4gKi8KLQlmcCA9IGZvcGVuKCIvcHJvYy9maWxlc3lzdGVtcyIsICJyIik7Ci0JaWYgKCFm
cCkKLQkJcmV0dXJuIC0xOwotCi0JX19mc2V0bG9ja2luZyhmcCwgRlNFVExPQ0tJTkdfQllD
QUxMRVIpOwotCXdoaWxlICgobnVtID0gZ2V0bGluZSgmYnVmLCAmbGVuLCBmcCkpICE9IC0x
KSB7Ci0JCWlmIChzdHJzdHIoYnVmLCAic2VsaW51eGZzIikpIHsKLQkJCWVuYWJsZWQgPSAx
OwotCQkJYnJlYWs7Ci0JCX0KLQl9Ci0KLQlpZiAobnVtIDwgMCkKLQkJZ290byBvdXQ7Ci0K
LQkvKiBTaW5jZSBhbiBzZWxpbnV4IGZpbGUgc3lzdGVtIGlzIGF2YWlsYWJsZSwgd2UgY29u
c2lkZXIKLQkgKiBzZWxpbnV4IGVuYWJsZWQuIElmIGdldGNvbl9yYXcgZmFpbHMsIHNlbGlu
dXggaXMgc3RpbGwKLQkgKiBlbmFibGVkLiBXZSBvbmx5IGNvbnNpZGVyIGl0IGRpc2FibGVk
IGlmIG5vIHBvbGljeSBpcyBsb2FkZWQuICovCi0JaWYgKGdldGNvbl9yYXcoJmNvbikgPT0g
MCkgewotCQlpZiAoIXN0cmNtcChjb24sICJrZXJuZWwiKSkKLQkJCWVuYWJsZWQgPSAwOwot
CQlmcmVlY29uKGNvbik7Ci0JfQotCi0gICAgICBvdXQ6Ci0JZnJlZShidWYpOwotCWZjbG9z
ZShmcCk7CiAJcmV0dXJuIGVuYWJsZWQ7CiB9CiAKZGlmZiAtLWdpdCBhL2xpYnNlbGludXgv
c3JjL2luaXQuYyBiL2xpYnNlbGludXgvc3JjL2luaXQuYwppbmRleCBhOTQ4OTIwLi41NDdm
MWViIDEwMDY0NAotLS0gYS9saWJzZWxpbnV4L3NyYy9pbml0LmMKKysrIGIvbGlic2VsaW51
eC9zcmMvaW5pdC5jCkBAIC03LDYgKzcsNyBAQAogI2luY2x1ZGUgPHN0ZGlvLmg+CiAjaW5j
bHVkZSA8c3RkaW9fZXh0Lmg+CiAjaW5jbHVkZSA8ZGxmY24uaD4KKyNpbmNsdWRlIDxzeXMv
c3RhdHZmcy5oPgogI2luY2x1ZGUgPHN5cy92ZnMuaD4KICNpbmNsdWRlIDxzdGRpbnQuaD4K
ICNpbmNsdWRlIDxsaW1pdHMuaD4KQEAgLTI0LDggKzI1LDYgQEAgc3RhdGljIHZvaWQgaW5p
dF9zZWxpbnV4bW50KHZvaWQpCiB7CiAJY2hhciAqYnVmPU5VTEwsICpwOwogCUZJTEUgKmZw
PU5VTEw7Ci0Jc3RydWN0IHN0YXRmcyBzZmJ1ZjsKLQlpbnQgcmM7CiAJc2l6ZV90IGxlbjsK
IAlzc2l6ZV90IG51bTsKIAlpbnQgZXhpc3RzID0gMDsKQEAgLTMzLDE3ICszMiw5IEBAIHN0
YXRpYyB2b2lkIGluaXRfc2VsaW51eG1udCh2b2lkKQogCWlmIChzZWxpbnV4X21udCkKIAkJ
cmV0dXJuOwogCi0JLyogV2UgY2hlY2sgdG8gc2VlIGlmIHRoZSBwcmVmZXJyZWQgbW91bnQg
cG9pbnQgZm9yIHNlbGludXggZmlsZQotCSAqIHN5c3RlbSBoYXMgYSBzZWxpbnV4ZnMuICov
Ci0JZG8gewotCQlyYyA9IHN0YXRmcyhTRUxJTlVYTU5ULCAmc2ZidWYpOwotCX0gd2hpbGUg
KHJjIDwgMCAmJiBlcnJubyA9PSBFSU5UUik7Ci0JaWYgKHJjID09IDApIHsKLQkJaWYgKCh1
aW50MzJfdClzZmJ1Zi5mX3R5cGUgPT0gKHVpbnQzMl90KVNFTElOVVhfTUFHSUMpIHsKLQkJ
CXNlbGludXhfbW50ID0gc3RyZHVwKFNFTElOVVhNTlQpOwotCQkJcmV0dXJuOwotCQl9Ci0J
fSAKKwlpZiAoc2V0X3NlbGludXhtbnQoU0VMSU5VWE1OVCkgPT0gMCkgcmV0dXJuOworCisJ
aWYgKHNldF9zZWxpbnV4bW50KE9MRFNFTElOVVhNTlQpID09IDApIHJldHVybjsKIAogCS8q
IERyb3AgYmFjayB0byBkZXRlY3RpbmcgaXQgdGhlIGxvbmcgd2F5LiAqLwogCWZwID0gZm9w
ZW4oIi9wcm9jL2ZpbGVzeXN0ZW1zIiwgInIiKTsKQEAgLTUyLDcgKzQzLDcgQEAgc3RhdGlj
IHZvaWQgaW5pdF9zZWxpbnV4bW50KHZvaWQpCiAKIAlfX2ZzZXRsb2NraW5nKGZwLCBGU0VU
TE9DS0lOR19CWUNBTExFUik7CiAJd2hpbGUgKChudW0gPSBnZXRsaW5lKCZidWYsICZsZW4s
IGZwKSkgIT0gLTEpIHsKLQkJaWYgKHN0cnN0cihidWYsICJzZWxpbnV4ZnMiKSkgeworCQlp
ZiAoc3Ryc3RyKGJ1ZiwgU0VMSU5VWEZTKSkgewogCQkJZXhpc3RzID0gMTsKIAkJCWJyZWFr
OwogCQl9CkBAIC03OSw3ICs3MCw3IEBAIHN0YXRpYyB2b2lkIGluaXRfc2VsaW51eG1udCh2
b2lkKQogCQl0bXAgPSBzdHJjaHIocCwgJyAnKTsKIAkJaWYgKCF0bXApCiAJCQlnb3RvIG91
dDsKLQkJaWYgKCFzdHJuY21wKHRtcCArIDEsICJzZWxpbnV4ZnMgIiwgMTApKSB7CisJCWlm
ICghc3RybmNtcCh0bXAgKyAxLCBTRUxJTlVYRlMsIDEwKSkgewogCQkJKnRtcCA9ICdcMCc7
CiAJCQlicmVhazsKIAkJfQpAQCAtODcsNyArNzgsNyBAQCBzdGF0aWMgdm9pZCBpbml0X3Nl
bGludXhtbnQodm9pZCkKIAogCS8qIElmIHdlIGZvdW5kIHNvbWV0aGluZywgZHVwIGl0ICov
CiAJaWYgKG51bSA+IDApCi0JCXNlbGludXhfbW50ID0gc3RyZHVwKHApOworCQlzZXRfc2Vs
aW51eG1udChwKTsKIAogICAgICAgb3V0OgogCWZyZWUoYnVmKTsKQEAgLTEwNCw5ICs5NSwz
MCBAQCB2b2lkIGZpbmlfc2VsaW51eG1udCh2b2lkKQogCiBoaWRkZW5fZGVmKGZpbmlfc2Vs
aW51eG1udCkKIAotdm9pZCBzZXRfc2VsaW51eG1udChjaGFyICptbnQpCitpbnQgc2V0X3Nl
bGludXhtbnQoY2hhciAqbW50KQogewotCXNlbGludXhfbW50ID0gc3RyZHVwKG1udCk7CisJ
c3RydWN0IHN0YXRmcyBzZmJ1ZjsKKwlpbnQgcmM7CisKKwkvKiBXZSBjaGVjayB0byBzZWUg
aWYgdGhlIHByZWZlcnJlZCBtb3VudCBwb2ludCBmb3Igc2VsaW51eCBmaWxlCisJICogc3lz
dGVtIGhhcyBhIHNlbGludXhmcy4gKi8KKwlkbyB7CisJCXJjID0gc3RhdGZzKG1udCwgJnNm
YnVmKTsKKwl9IHdoaWxlIChyYyA8IDAgJiYgZXJybm8gPT0gRUlOVFIpOworCWlmIChyYyA9
PSAwKSB7CisJCWlmICgodWludDMyX3Qpc2ZidWYuZl90eXBlID09ICh1aW50MzJfdClTRUxJ
TlVYX01BR0lDKSB7CisJCQlzdHJ1Y3Qgc3RhdHZmcyB2ZnNidWY7CisJCQlyYyA9IHN0YXR2
ZnMobW50LCAmdmZzYnVmKTsKKwkJCWlmIChyYyA9PSAwKSB7CisJCQkJaWYgKCEodmZzYnVm
LmZfZmxhZyAmIFNUX1JET05MWSkpIHsKKwkJCQkJc2VsaW51eF9tbnQgPSBzdHJkdXAobW50
KTsKKwkJCQkJcmV0dXJuIDA7CisJCQkJfQorCQkJfQorCQl9CisJfSAKKworCXJldHVybiAt
MTsKIH0KIAogaGlkZGVuX2RlZihzZXRfc2VsaW51eG1udCkKZGlmZiAtLWdpdCBhL2xpYnNl
bGludXgvc3JjL2xvYWRfcG9saWN5LmMgYi9saWJzZWxpbnV4L3NyYy9sb2FkX3BvbGljeS5j
CmluZGV4IDgzZDIxNDMuLmY2ZWFlNDkgMTAwNjQ0Ci0tLSBhL2xpYnNlbGludXgvc3JjL2xv
YWRfcG9saWN5LmMKKysrIGIvbGlic2VsaW51eC9zcmMvbG9hZF9wb2xpY3kuYwpAQCAtMzY5
LDcgKzM2OSwxNyBAQCBpbnQgc2VsaW51eF9pbml0X2xvYWRfcG9saWN5KGludCAqZW5mb3Jj
ZSkKIAkgKiBDaGVjayBmb3IgdGhlIGV4aXN0ZW5jZSBvZiBTRUxpbnV4IHZpYSBzZWxpbnV4
ZnMsIGFuZCAKIAkgKiBtb3VudCBpdCBpZiBwcmVzZW50IGZvciB1c2UgaW4gdGhlIGNhbGxz
IGJlbG93LiAgCiAJICovCi0JaWYgKG1vdW50KCJzZWxpbnV4ZnMiLCBTRUxJTlVYTU5ULCAi
c2VsaW51eGZzIiwgMCwgMCkgPCAwICYmIGVycm5vICE9IEVCVVNZKSB7CisJY2hhciAqbW50
cG9pbnQgPSBOVUxMOworCWlmIChtb3VudChTRUxJTlVYRlMsIFNFTElOVVhNTlQsIFNFTElO
VVhGUywgMCwgMCkgPT0gMCB8fCBlcnJubyA9PSBFQlVTWSkgeworCQltbnRwb2ludCA9IFNF
TElOVVhNTlQ7CisJfSBlbHNlIHsgCisJCS8qIGNoZWNrIG9sZCBtb3VudHBvaW50ICovCisJ
CWlmIChtb3VudChTRUxJTlVYRlMsIE9MRFNFTElOVVhNTlQsIFNFTElOVVhGUywgMCwgMCkg
PT0gMCB8fCBlcnJubyA9PSBFQlVTWSkgeworCQkJbW50cG9pbnQgPSBPTERTRUxJTlVYTU5U
OworCQl9CisJfSAKKworCWlmICghIG1udHBvaW50ICkgewogCQlpZiAoZXJybm8gPT0gRU5P
REVWKSB7CiAJCQkvKgogCQkJICogU0VMaW51eCB3YXMgZGlzYWJsZWQgaW4gdGhlIGtlcm5l
bCwgZWl0aGVyCkBAIC0zODQsOCArMzk0LDExIEBAIGludCBzZWxpbnV4X2luaXRfbG9hZF9w
b2xpY3koaW50ICplbmZvcmNlKQogCQl9CiAgICAgICAgICAgICAgICAgCiAJCWdvdG8gbm9s
b2FkOworCX0gCisJaWYgKHNldF9zZWxpbnV4bW50KG1udHBvaW50KSAhPSAwKSB7CisJCWZw
cmludGYoc3RkZXJyLCAiTW91bnQgZmFpbGVkIGZvciBzZWxpbnV4ZnMgb24gJXM6ICAlc1xu
IiwgbW50cG9pbnQsIHN0cmVycm9yKGVycm5vKSk7CisJCWdvdG8gbm9sb2FkOwogCX0KLQlz
ZXRfc2VsaW51eG1udChTRUxJTlVYTU5UKTsKIAogCS8qCiAJICogTm90ZTogIFRoZSBmb2xs
b3dpbmcgY29kZSBkZXBlbmRzIG9uIGhhdmluZyBzZWxpbnV4ZnMgCkBAIC0zOTcsNyArNDEw
LDcgQEAgaW50IHNlbGludXhfaW5pdF9sb2FkX3BvbGljeShpbnQgKmVuZm9yY2UpCiAJCXJj
ID0gc2VjdXJpdHlfZGlzYWJsZSgpOwogCQlpZiAocmMgPT0gMCkgewogCQkJLyogU3VjY2Vz
c2Z1bGx5IGRpc2FibGVkLCBzbyB1bW91bnQgc2VsaW51eGZzIHRvby4gKi8KLQkJCXVtb3Vu
dChTRUxJTlVYTU5UKTsKKwkJCXVtb3VudChzZWxpbnV4X21udCk7CiAJCQlmaW5pX3NlbGlu
dXhtbnQoKTsKIAkJfQogCQkvKgpkaWZmIC0tZ2l0IGEvbGlic2VsaW51eC9zcmMvcG9saWN5
LmggYi9saWJzZWxpbnV4L3NyYy9wb2xpY3kuaAppbmRleCAxMGU4NzEyLi5iZjI3MGI1IDEw
MDY0NAotLS0gYS9saWJzZWxpbnV4L3NyYy9wb2xpY3kuaAorKysgYi9saWJzZWxpbnV4L3Ny
Yy9wb2xpY3kuaApAQCAtOSwxMSArOSwxNSBAQAogLyogSW5pdGlhbCBsZW5ndGggZ3Vlc3Mg
Zm9yIGdldHRpbmcgY29udGV4dHMuICovCiAjZGVmaW5lIElOSVRDT05URVhUTEVOIDI1NQog
CisvKiBzZWxpbnV4IGZpbGUgc3lzdGVtIHR5cGUgKi8KKyNkZWZpbmUgU0VMSU5VWEZTICJz
ZWxpbnV4ZnMiCisKIC8qIHNlbGludXhmcyBtYWdpYyBudW1iZXIgKi8KICNkZWZpbmUgU0VM
SU5VWF9NQUdJQyAweGY5N2NmZjhjCiAKIC8qIFByZWZlcnJlZCBzZWxpbnV4IG1vdW50IGxv
Y2F0aW9uICovCi0jZGVmaW5lIFNFTElOVVhNTlQgIi9zZWxpbnV4IgorI2RlZmluZSBTRUxJ
TlVYTU5UICIvc3lzL2ZzL3NlbGludXgiCisjZGVmaW5lIE9MRFNFTElOVVhNTlQgIi9zZWxp
bnV4IgogCiAvKiBzZWxpbnV4ZnMgbW91bnQgcG9pbnQgKi8KIGV4dGVybiBjaGFyICpzZWxp
bnV4X21udDsK
--------------070902080508090204070803
Content-Type: application/pgp-signature;
 name="libselinux-mountpoint.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libselinux-mountpoint.patch.sig"

iEYEABECAAYFAk3AJ3AACgkQrlYvE4MpobOEPwCgqRSdjSyCUmHo6Fc0WsoRRgHM7OgAoNxv
aD2llfWYyOTXJaZOmu/5KGh9
--------------070902080508090204070803--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
