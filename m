Subject: Re: [PATCH] repost: new sockcreate interface to specify context of
	socket when they are created
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov, kmacmillan@tresys.com, jmorris@namei.org
In-Reply-To: <1150921519.3432.0.camel@moss-tarheels.epoch.ncsc.mil>
References: <1150902506.27852.35.camel@localhost.localdomain>
	 <1150905799.27531.33.camel@moss-spartans.epoch.ncsc.mil>
	 <1150919192.18657.164.camel@sgc>
	 <1150919411.27531.89.camel@moss-spartans.epoch.ncsc.mil>
	 <1150921381.18657.170.camel@sgc>
	 <1150921519.3432.0.camel@moss-tarheels.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-9cQQe5NCx4mqQ/xPUv/A"
Date: Wed, 21 Jun 2006 17:07:34 -0400
Message-Id: <1150924055.18657.174.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-9cQQe5NCx4mqQ/xPUv/A
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-06-21 at 16:25 -0400, Michael LeMay wrote:
> Yes, but make sure you use the one from June 2nd that has the class
> "key", not "retained_key".  Thanks!

I have committed the attached patch for keys to refpolicy, please
doublecheck that this is correct.  I changed the raw rules to interfaces
too.

> On Wed, 2006-06-21 at 16:23 -0400, Christopher J. PeBenito wrote:
> > On Wed, 2006-06-21 at 15:50 -0400, Stephen Smalley wrote:
> > > On Wed, 2006-06-21 at 15:46 -0400, Christopher J. PeBenito wrote:
> > > > On Wed, 2006-06-21 at 12:03 -0400, Stephen Smalley wrote:
> > > > > On Wed, 2006-06-21 at 11:08 -0400, Eric Paris wrote:
> > > > > > Below is a patch to add a new /proc/self/attr/sockcreate
> > > > [cut]
> > > > > /proc/self/attr/keycreate is in -mm, so this patch won't apply relative
> > > > > to it.  Permission definition also has to be regenerated relative to the
> > > > > keycreate refpolicy patch, as that took the same permission slot.
> > > > 
> > > > I'm going to need a patch for refpolicy that has the the final ordering
> > > > of permissions with key and sockcreate patches.  I haven't added the key
> > > > class at all yet since I have been waiting for the perm set to finalize.
> > > 
> > > Apply the key+keycreate patch first.  sockcreate refpolicy patch has to
> > > be re-based and re-submitted, but the kernel patch has already been
> > > re-based and submitted.
> > 
> > Is the one from June 2nd the right one ([PATCH] refpolicy: Kernel access
> > key retention policy support) to start, and then the one from yesterday
> > that has setkeycreate?
> > 
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--=-9cQQe5NCx4mqQ/xPUv/A
Content-Disposition: attachment; filename=refpolicy-key.diff
Content-Type: text/x-patch; name=refpolicy-key.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64

SW5kZXg6IHBvbGljeS9mbGFzay9zZWN1cml0eV9jbGFzc2VzDQo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQotLS0gcG9s
aWN5L2ZsYXNrL3NlY3VyaXR5X2NsYXNzZXMJKHJldmlzaW9uIDE4OTApDQorKysgcG9saWN5L2Zs
YXNrL3NlY3VyaXR5X2NsYXNzZXMJKHdvcmtpbmcgY29weSkNCkBAIC05MCw0ICs5MCw3IEBADQog
DQogY2xhc3MgcGFja2V0DQogDQorIyBLZXJuZWwgYWNjZXNzIGtleSByZXRlbnRpb24NCitjbGFz
cyBrZXkNCisNCiAjIEZMQVNLDQpJbmRleDogcG9saWN5L2ZsYXNrL2FjY2Vzc192ZWN0b3JzDQo9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09DQotLS0gcG9saWN5L2ZsYXNrL2FjY2Vzc192ZWN0b3JzCShyZXZpc2lvbiAxODkw
KQ0KKysrIHBvbGljeS9mbGFzay9hY2Nlc3NfdmVjdG9ycwkod29ya2luZyBjb3B5KQ0KQEAgLTI1
Miw2ICsyNTIsNyBAQA0KIAlleGVjbWVtDQogCWV4ZWNzdGFjaw0KIAlleGVjaGVhcA0KKwlzZXRr
ZXljcmVhdGUNCiB9DQogDQogDQpAQCAtNjE3LDMgKzYxOCwxNCBAQA0KIAlyZWN2DQogCXJlbGFi
ZWx0bw0KIH0NCisNCitjbGFzcyBrZXkNCit7DQorCXZpZXcNCisJcmVhZA0KKwl3cml0ZQ0KKwlz
ZWFyY2gNCisJbGluaw0KKwlzZXRhdHRyDQorCWNyZWF0ZQ0KK30NCkluZGV4OiBwb2xpY3kvbW9k
dWxlcy9zZXJ2aWNlcy94c2VydmVyLnRlDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQotLS0gcG9saWN5L21vZHVsZXMv
c2VydmljZXMveHNlcnZlci50ZQkocmV2aXNpb24gMTg5MCkNCisrKyBwb2xpY3kvbW9kdWxlcy9z
ZXJ2aWNlcy94c2VydmVyLnRlCSh3b3JraW5nIGNvcHkpDQpAQCAtODAsNyArODAsNyBAQA0KICMN
CiANCiBhbGxvdyB4ZG1fdCBzZWxmOmNhcGFiaWxpdHkgeyBzZXRnaWQgc2V0dWlkIHN5c19yZXNv
dXJjZSBraWxsIHN5c190dHlfY29uZmlnIG1rbm9kIGNob3duIGRhY19vdmVycmlkZSBkYWNfcmVh
ZF9zZWFyY2ggZm93bmVyIGZzZXRpZCBpcGNfb3duZXIgc3lzX25pY2Ugc3lzX3Jhd2lvIG5ldF9i
aW5kX3NlcnZpY2UgfTsNCi1hbGxvdyB4ZG1fdCBzZWxmOnByb2Nlc3MgeyBzZXRleGVjIHNldHBn
aWQgc2V0c2NoZWQgc2V0cmxpbWl0IHNpZ25hbF9wZXJtcyB9Ow0KK2FsbG93IHhkbV90IHNlbGY6
cHJvY2VzcyB7IHNldGV4ZWMgc2V0cGdpZCBzZXRzY2hlZCBzZXRybGltaXQgc2lnbmFsX3Blcm1z
IHNldGtleWNyZWF0ZSB9Ow0KIGFsbG93IHhkbV90IHNlbGY6Zmlmb19maWxlIHJ3X2ZpbGVfcGVy
bXM7DQogYWxsb3cgeGRtX3Qgc2VsZjpzaG0gY3JlYXRlX3NobV9wZXJtczsNCiBhbGxvdyB4ZG1f
dCBzZWxmOnNlbSBjcmVhdGVfc2VtX3Blcm1zOw0KQEAgLTIxNCw2ICsyMTQsNyBAQA0KIA0KIHVz
ZXJkb21fZG9udGF1ZGl0X3VzZV91bnByaXZfdXNlcl9mZHMoeGRtX3QpDQogdXNlcmRvbV9kb250
YXVkaXRfc2VhcmNoX3N5c2FkbV9ob21lX2RpcnMoeGRtX3QpDQordXNlcmRvbV9jcmVhdGVfYWxs
X3VzZXJzX2tleXMoeGRtX3QpDQogIyBmb3IgLmRtcmMNCiB1c2VyZG9tX3JlYWRfdW5wcml2X3Vz
ZXJzX2hvbWVfY29udGVudF9maWxlcyh4ZG1fdCkNCiAjIFNlYXJjaCAvcHJvYyBmb3IgYW55IHVz
ZXIgZG9tYWluIHByb2Nlc3Nlcy4NCkluZGV4OiBwb2xpY3kvbW9kdWxlcy9zeXN0ZW0vbG9jYWxs
b2dpbi50ZQ0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQ0KLS0tIHBvbGljeS9tb2R1bGVzL3N5c3RlbS9sb2NhbGxvZ2lu
LnRlCShyZXZpc2lvbiAxODkwKQ0KKysrIHBvbGljeS9tb2R1bGVzL3N5c3RlbS9sb2NhbGxvZ2lu
LnRlCSh3b3JraW5nIGNvcHkpDQpAQCAtMTY5LDYgKzE2OSw3IEBADQogdXNlcmRvbV9zZWFyY2hf
YWxsX3VzZXJzX2hvbWVfY29udGVudChsb2NhbF9sb2dpbl90KQ0KIHVzZXJkb21fdXNlX3VucHJp
dl91c2Vyc19mZHMobG9jYWxfbG9naW5fdCkNCiB1c2VyZG9tX3NpZ2NobGRfYWxsX3VzZXJzKGxv
Y2FsX2xvZ2luX3QpDQordXNlcmRvbV9jcmVhdGVfYWxsX3VzZXJzX2tleXMobG9jYWxfbG9naW5f
dCkNCiANCiAjIFNlYXJjaCBmb3IgbWFpbCBzcG9vbCBmaWxlLg0KIG10YV9nZXRhdHRyX3Nwb29s
KGxvY2FsX2xvZ2luX3QpDQpJbmRleDogcG9saWN5L21vZHVsZXMvc3lzdGVtL3VzZXJkb21haW4u
aWYNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0NCi0tLSBwb2xpY3kvbW9kdWxlcy9zeXN0ZW0vdXNlcmRvbWFpbi5pZgko
cmV2aXNpb24gMTg5MCkNCisrKyBwb2xpY3kvbW9kdWxlcy9zeXN0ZW0vdXNlcmRvbWFpbi5pZgko
d29ya2luZyBjb3B5KQ0KQEAgLTQ3MzIsNiArNDczMiwyOCBAQA0KIA0KICMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMNCiAjIyA8c3VtbWFyeT4NCisjIwlDcmVhdGUga2V5
cyBmb3IgYWxsIHVzZXIgZG9tYWlucy4NCisjIyA8L3N1bW1hcnk+DQorIyMgPHBhcmFtIG5hbWU9
ImRvbWFpbiI+DQorIyMJPHN1bW1hcnk+DQorIyMJRG9tYWluIGFsbG93ZWQgYWNjZXNzLg0KKyMj
CTwvc3VtbWFyeT4NCisjIyA8L3BhcmFtPg0KKyMNCitpbnRlcmZhY2UoYHVzZXJkb21fY3JlYXRl
X2FsbF91c2Vyc19rZXlzJyxgDQorCWlmZGVmKGBzdHJpY3RfcG9saWN5JyxgDQorCQlnZW5fcmVx
dWlyZShgDQorCQkJYXR0cmlidXRlIHVzZXJkb21haW47DQorCQknKQ0KKw0KKwkJYWxsb3cgJDEg
dXNlcmRvbWFpbjprZXkgY3JlYXRlOw0KKwknLGANCisJCXVuY29uZmluZWRfY3JlYXRlX2tleXMo
JDEpDQorCScpDQorJykNCisNCisjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjDQorIyMgPHN1bW1hcnk+DQogIyMJU2VuZCBhIGRidXMgbWVzc2FnZSB0byBhbGwgdXNlciBk
b21haW5zLg0KICMjIDwvc3VtbWFyeT4NCiAjIyA8cGFyYW0gbmFtZT0iZG9tYWluIj4NCkluZGV4
OiBwb2xpY3kvbW9kdWxlcy9zeXN0ZW0vdW5jb25maW5lZC5pZg0KPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0tIHBv
bGljeS9tb2R1bGVzL3N5c3RlbS91bmNvbmZpbmVkLmlmCShyZXZpc2lvbiAxODkwKQ0KKysrIHBv
bGljeS9tb2R1bGVzL3N5c3RlbS91bmNvbmZpbmVkLmlmCSh3b3JraW5nIGNvcHkpDQpAQCAtMzYw
LDYgKzM2MCwyNCBAQA0KIA0KICMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMNCiAjIyA8c3VtbWFyeT4NCisjIwlDcmVhdGUga2V5cyBmb3IgdGhlIHVuY29uZmluZWQgZG9t
YWluLg0KKyMjIDwvc3VtbWFyeT4NCisjIyA8cGFyYW0gbmFtZT0iZG9tYWluIj4NCisjIwk8c3Vt
bWFyeT4NCisjIwlEb21haW4gYWxsb3dlZCBhY2Nlc3MuDQorIyMJPC9zdW1tYXJ5Pg0KKyMjIDwv
cGFyYW0+DQorIw0KK2ludGVyZmFjZShgdW5jb25maW5lZF9jcmVhdGVfa2V5cycsYA0KKwlnZW5f
cmVxdWlyZShgDQorCQl0eXBlIHVuY29uZmluZWRfdDsNCisJJykNCisNCisJYWxsb3cgJDEgdW5j
b25maW5lZF90OmtleSBjcmVhdGU7DQorJykNCisNCisjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjDQorIyMgPHN1bW1hcnk+DQogIyMJU2VuZCBtZXNzYWdlcyB0byB0aGUg
dW5jb25maW5lZCBkb21haW4gb3ZlciBkYnVzLg0KICMjIDwvc3VtbWFyeT4NCiAjIyA8cGFyYW0g
bmFtZT0iZG9tYWluIj4NCg==


--=-9cQQe5NCx4mqQ/xPUv/A--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
