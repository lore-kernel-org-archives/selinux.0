Date: Wed, 15 Aug 2001 08:55:40 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ryan Senior <slax@ksni.net>
cc: SELinux@tycho.nsa.gov
Subject: Re: patch
In-Reply-To: <3B794470.56B00DCE@ksni.net>
Message-ID: <Pine.SOL.3.95.1010815084756.24997D-200000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-758783491-997880140=:24997"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-758783491-997880140=:24997
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Tue, 14 Aug 2001, Ryan Senior wrote:

> patching file initpolicy.conf

The patch is for the kernel-2.4/security/policy_parse.y file, so
it shouldn't be modifying initpolicy.conf at all.  I've attached
a version of the patch that should be easier to apply.  Assuming that you
save it to ~/parser.patch, apply it as follows:

cd slinux
patch -p1 < ~/parser.patch

It should say: patching file kernel-2.4/security/policy_parse.y.

Then do 'cd kernel-2.4; make' to rebuild the checkpolicy program.
You should then be able to compile the policy configuration.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




---559023410-758783491-997880140=:24997
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="parser.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.3.95.1010815085539.24997E@clipper.gw.tislabs.com>
Content-Description: 

SW5kZXg6IHNsaW51eC9rZXJuZWwtMi40L3NlY3VyaXR5L3BvbGljeV9wYXJz
ZS55DQpkaWZmIC11IHNsaW51eC9rZXJuZWwtMi40L3NlY3VyaXR5L3BvbGlj
eV9wYXJzZS55OjEuMSBzbGludXgva2VybmVsLTIuNC9zZWN1cml0eS9wb2xp
Y3lfcGFyc2UueToxLjINCi0tLSBzbGludXgva2VybmVsLTIuNC9zZWN1cml0
eS9wb2xpY3lfcGFyc2UueToxLjEJRnJpIEphbiAgNSAxNDoxODowMiAyMDAx
DQorKysgc2xpbnV4L2tlcm5lbC0yLjQvc2VjdXJpdHkvcG9saWN5X3BhcnNl
LnkJTW9uIE1heSAgNyAxNDowMToyMyAyMDAxDQpAQCAtMTc3NSw3ICsxNzc1
LDYgQEANCiB7DQogCWNoYXIgKmlkOw0KIAljbGFzc19kYXR1bV90ICpjbGFk
YXR1bTsNCi0JdHlwZV9kYXR1bV90ICpkYXR1bTsNCiAJcGVybV9kYXR1bV90
ICpwZXJkYXR1bTsNCiAJZWJpdG1hcF90IHN0eXBlcywgdHR5cGVzLCB0Y2xh
c3NlczsNCiAJYWNjZXNzX3ZlY3Rvcl90ICphdnA7DQpAQCAtMTgxNCw3ICsx
ODEzLDcgQEANCiAJaGljbGFzcyA9IDA7DQogCXdoaWxlICgoaWQgPSBxdWV1
ZV9yZW1vdmUoaWRfcXVldWUpKSkgew0KIAkJY2xhZGF0dW0gPSBoYXNodGFi
X3NlYXJjaChwb2xpY3lkYnAtPnBfY2xhc3Nlcy50YWJsZSwgaWQpOw0KLQkJ
aWYgKCFkYXR1bSkgew0KKwkJaWYgKCFjbGFkYXR1bSkgew0KIAkJCXNwcmlu
dGYoZXJyb3Jtc2csICJ1bmtub3duIGNsYXNzICVzIHVzZWQgaW4gcnVsZSIs
IGlkKTsNCiAJCQl5eWVycm9yKGVycm9ybXNnKTsNCiAJCQlnb3RvIGJhZDsN
CkBAIC0yMDkxLDcgKzIwOTAsNiBAQA0KIAkJaWYgKHJldCkgew0KIAkJCXl5
ZXJyb3IoImhhc2ggdGFibGUgb3ZlcmZsb3ciKTsNCiAJCQlmcmVlKHJvbGUp
Ow0KLQkJCWZyZWUoaWQpOw0KIAkJCWZyZWUocm9sZV9pZCk7DQogCQkJcmV0
dXJuIC0xOw0KIAkJfQ0K
---559023410-758783491-997880140=:24997--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
