Date: Wed, 27 Mar 2002 11:18:39 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: newrole passwords (Was:  Fractal Based Encryption)
In-Reply-To: <Pine.GSO.4.33.0203271012340.8022-100000@raven>
Message-ID: <Pine.GSO.4.33.0203271116480.8022-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-838545539-1017245919=:8022"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-838545539-1017245919=:8022
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Wed, 27 Mar 2002, Russell Coker wrote:
> Another thing, it would be nice if the run_init and newrole programs prompted
> you for which user's password they expected.  Often when I've su'd to root I
> forget which account I originally logged in with, then newrole and run_init
> fail because I entered the password for the wrong account.  In my Debian
> package I've added the account name to the error message so at least you can
> get it right the second time.

The attached patch changes newrole and run_init to display the user
identity prior to the authentication (as well as after if the
authentication fails).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-838545539-1017245919=:8022
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="showuser.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0203271118390.8022@raven>
Content-Description: 
Content-Disposition: attachment; filename="showuser.patch"

SW5kZXg6IHV0aWxzL25ld3JvbGUvbmV3cm9sZS5jDQo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09DQpSQ1MgZmlsZTogL2N2cy9sc20vc2VsaW51eC91dGlscy9u
ZXdyb2xlL25ld3JvbGUuYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTMN
CnJldHJpZXZpbmcgcmV2aXNpb24gMS4xNA0KZGlmZiAtdSAtcjEuMTMgLXIx
LjE0DQotLS0gdXRpbHMvbmV3cm9sZS9uZXdyb2xlLmMJMjAwMi8wMS8xNSAy
MDoxOTo0NQkxLjEzDQorKysgdXRpbHMvbmV3cm9sZS9uZXdyb2xlLmMJMjAw
Mi8wMy8yNyAxNTo0Njo1NAkxLjE0DQpAQCAtNDA3LDkgKzQwNyw3IEBADQog
ICBwdy0+cHdfZGlyID0geHN0cmR1cChwdy0+cHdfZGlyKTsNCiAgIHB3LT5w
d19zaGVsbCA9IHhzdHJkdXAocHctPnB3X3NoZWxsKTsNCiANCi0jaWZkZWYg
Q0FOVFNQRUxMR0RCDQogICBwcmludGYoIkF1dGhlbnRpY2F0aW5nICVzLlxu
Iixwdy0+cHdfbmFtZSk7DQotI2VuZGlmICANCiANCiAgIC8qIEF1dGhlbnRp
Y2F0ZSB0aGUgdXNlciBydW5uaW5nIHRoaXMgcHJvZ3JhbS4gKi8NCiAjaWZk
ZWYgVVNFX1BBTQ0KQEAgLTQxNyw3ICs0MTUsNyBAQA0KICNlbHNlIC8qICFV
U0VfUEFNICovDQogICBpZiggIWF1dGhlbnRpY2F0ZV92aWFfc2hhZG93X3Bh
c3N3ZChwdykgKSB7DQogI2VuZGlmIC8qIGlmL2Vsc2UgVVNFX1BBTSAqLw0K
LSAgICBmcHJpbnRmKHN0ZGVyciwibmV3cm9sZTogaW5jb3JyZWN0IHBhc3N3
b3JkXG4iKTsNCisgICAgZnByaW50ZihzdGRlcnIsIm5ld3JvbGU6IGluY29y
cmVjdCBwYXNzd29yZCBmb3IgJXNcbiIsIHB3LT5wd19uYW1lKTsNCiAgICAg
cmV0dXJuKC0xKTsNCiAgIH0NCiANCkluZGV4OiB1dGlscy9ydW5faW5pdC9y
dW5faW5pdC5jDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTog
L2N2cy9sc20vc2VsaW51eC91dGlscy9ydW5faW5pdC9ydW5faW5pdC5jLHYN
CnJldHJpZXZpbmcgcmV2aXNpb24gMS40DQpyZXRyaWV2aW5nIHJldmlzaW9u
IDEuNQ0KZGlmZiAtdSAtcjEuNCAtcjEuNQ0KLS0tIHV0aWxzL3J1bl9pbml0
L3J1bl9pbml0LmMJMjAwMS8xMi8wNiAxNTo1MTo0NwkxLjQNCisrKyB1dGls
cy9ydW5faW5pdC9ydW5faW5pdC5jCTIwMDIvMDMvMjcgMTU6NDg6MjAJMS41
DQpAQCAtMjU4LDkgKzI1OCw3IEBADQogICB9DQogICBjb250ZXh0X2ZyZWUo
IG9jb250ZXh0ICk7DQogICANCi0jaWZkZWYgQ0FOVFNQRUxMR0RCDQogICBw
cmludGYoIkF1dGhlbnRpY2F0aW5nICVzLlxuIixwX3Bhc3N3ZF9saW5lLT5w
d19uYW1lKTsNCi0jZW5kaWYgIA0KIA0KICAgLyogQXV0aGVudGljYXRlIHRo
ZSB1c2VyIHJ1bm5pbmcgdGhpcyBwcm9ncmFtLiAqLw0KICNpZmRlZiBVU0Vf
UEFNDQpAQCAtMjY4LDcgKzI2Niw3IEBADQogI2Vsc2UgLyogIVVTRV9QQU0g
Ki8NCiAgIGlmKCAhYXV0aGVudGljYXRlX3ZpYV9zaGFkb3dfcGFzc3dkKHBf
cGFzc3dkX2xpbmUpICkgew0KICNlbmRpZiAvKiBpZi9lbHNlIFVTRV9QQU0g
Ki8NCi0gICAgZnByaW50ZihzdGRlcnIsICJydW5faW5pdDogaW5jb3JyZWN0
IHBhc3N3b3JkXG4iKTsNCisgICAgZnByaW50ZihzdGRlcnIsICJydW5faW5p
dDogaW5jb3JyZWN0IHBhc3N3b3JkIGZvciAlc1xuIiwgcF9wYXNzd2RfbGlu
ZS0+cHdfbmFtZSk7DQogICAgIHJldHVybigtMSk7DQogICB9DQogDQo=
---559023410-838545539-1017245919=:8022--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
