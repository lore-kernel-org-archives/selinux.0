Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA06542
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 11:06:48 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0MG6lI22358
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 16:06:47 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id h0MG6kf22354 for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 16:06:46 GMT
Date: Wed, 22 Jan 2003 11:06:33 -0500 (EST)
From: Wayne Salamon <wsalamon@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Tom <tom@lemuria.org>, <selinux@tycho.nsa.gov>
Subject: Re: Apache/mysql policy status ?
In-Reply-To: <200301221622.15207.russell@coker.com.au>
Message-ID: <Pine.LNX.4.33.0301221047140.24032-200000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="554330684-1035609432-1043251593=:24032"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--554330684-1035609432-1043251593=:24032
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 22 Jan 2003, Russell Coker wrote:

>
> For apache2 putting the following on the apache command line should allow it
> to start:
> < /dev/null > /dev/null 2>&1
>
> Therefore the change to allow apache access to the admin_tty_type should not
> be absolutely required.
>

  OK, I've commented out the rule, and placed the above text in the
comment.

> The comment "The user role is authorized for this domain" doesn't match the
> "role system_r" on the next line...
>

  Fixed.

>
> For access to /tmp there's the tmp_domain() macro.
>

  Changed for httpd_php. I didn't change the user_script and sys_script
tmp file transitions however.

  Attached is the new patch. I haven't addressed the MySQL or PHP issues.

  Thanks,


-- 
Wayne Salamon
wsalamon@tislabs.com


--554330684-1035609432-1043251593=:24032
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="apache.te.newdiff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0301221106330.24032@vox.gw.tislabs.com>
Content-Description: 
Content-Disposition: attachment; filename="apache.te.newdiff"

LS0tIGFwYWNoZS50ZS5vcmlnCUZyaSBKYW4gIDMgMTM6Mjg6MjQgMjAwMw0K
KysrIGFwYWNoZS50ZQlXZWQgSmFuIDIyIDEyOjAwOjQyIDIwMDMNCkBAIC01
NSw5ICs1NSw2IEBADQogZG9tYWluX2F1dG9fdHJhbnMoaW5pdHJjX3QsIGh0
dHBkX2V4ZWNfdCwgaHR0cGRfdCkNCiB0eXBlX3RyYW5zaXRpb24gaW5pdF90
IGh0dHBkX2V4ZWNfdDpwcm9jZXNzIGh0dHBkX3Q7DQogDQotIyBmb3IgcGhw
DQotdG1wX2RvbWFpbihodHRwZCkNCi0NCiAjDQogIyBBIHR5cGUgZm9yIGZp
bGVzIGluIC92YXIvcnVuIHNwZWNpZmljIHRvIGh0dHBkDQogIw0KQEAgLTM2
NSw2ICszNjIsMTggQEANCiBhbGxvdyBodHRwZF90IGh0dHBkX3VzZXJfc2Ny
aXB0X3J3X3Q6ZmlsZSByX2ZpbGVfcGVybXM7DQogYWxsb3cgaHR0cGRfdCBo
dHRwZF91c2VyX3NjcmlwdF9yd190OmRpciByX2Rpcl9wZXJtczsNCiANCisj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQorIyBX
aGVuIHRoZSBhZG1pbiBzdGFydHMgdGhlIHNlcnZlciwgdGhlIHNlcnZlciB3
YW50cyB0byBhY2Vzcw0KKyMgdGhlIFRUWSBvciBQVFkgYXNzb2NpYXRlZCB3
aXRoIHRoZSBzZXNzaW9uLiBUaGlzIGlzIHZlcnkgYmFkDQorIyBiZWhhdmlv
dXIgYXMgaXQgYWxsb3dzIHRoZSBzZXJ2ZXIgYWNjZXNzIHRvIHRoZSBzeXNh
ZG1fciBUVFlzDQorIyBhbmQgUFRZcywgYnV0IGFwYWNoZTIgZG9lc24ndCB3
b3JrIHdpdGhvdXQuDQorIyBJZiB5b3UgcnVuIGFwYWNoZSAxLngueCwgbGVh
dmUgaXQgY29tbWVudGVkIG91dC4NCisjIEZvciBhcGFjaGUyIHB1dHRpbmcg
dGhlIGZvbGxvd2luZyBvbiB0aGUgYXBhY2hlIGNvbW1hbmQgbGluZSANCisj
IHNob3VsZCBhbGxvdyBpdCB0byBzdGFydDogPCAvZGV2L251bGwgPiAvZGV2
L251bGwgMj4mMQ0KKyMgSWYgdGhpcyBhcHByb2FjaCBmYWlscywgdGhlbiB5
b3UgbWF5IHdhbnQgdG8gdW5jb21tZW50IHRoaXMgbGluZS4NCisjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIw0K
KyNhbGxvdyBodHRwZF90IGFkbWluX3R0eV90eXBlOmNocl9maWxlIHsgcmVh
ZCB3cml0ZSB9Ow0KKw0KICMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIw0K
ICMgQWxsb3cgaHR0cGQgdG8gcmVjZWl2ZSBtZXNzYWdlcyBmcm9tIHRoZSBu
ZXR3b3JrIGNhcmQNCiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjDQpAQCAtMzc2LDggKzM4NSw3IEBADQogYWxsb3cgaHR0cGRf
dCBob21lX3Jvb3RfdDpkaXIgeyBnZXRhdHRyIHNlYXJjaCB9Ow0KIGFsbG93
IGh0dHBkX3QgdXNlcl9ob21lX2Rpcl90eXBlOmRpciB7IGdldGF0dHIgc2Vh
cmNoIH07DQogYWxsb3cgaHR0cGRfdCB1c2VyX2hvbWVfdHlwZTpkaXIgeyBn
ZXRhdHRyIHNlYXJjaCByZWFkIH07DQotIyBuZWVkIGlvY3RsIGZvciBwaHAz
DQotYWxsb3cgaHR0cGRfdCB1c2VyX2hvbWVfdHlwZTp7IGZpbGUgbG5rX2Zp
bGUgfSB7IGdldGF0dHIgcmVhZCBpb2N0bCB9Ow0KK2FsbG93IGh0dHBkX3Qg
dXNlcl9ob21lX3R5cGU6eyBmaWxlIGxua19maWxlIH0geyBnZXRhdHRyIHJl
YWQgfTsNCiBkb250YXVkaXQgaHR0cGRfdCBzeXNhZG1faG9tZV9kaXJfdDpk
aXIgeyBnZXRhdHRyIHNlYXJjaCB9Ow0KIA0KICMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMNCkBAIC00NzgsMyArNDg2LDM5IEBADQogIyBVbmNv
bW1lbnQgdGhlIGZvbGxvd2luZyBsaW5lIHRvIGVuYWJsZToNCiAjY2FuX2V4
ZWMoaHR0cGRfdCwgc2hlbGxfZXhlY190KQ0KIA0KKyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQorIw0KKyMg
UEhQIERpcmVjdGl2ZXMNCisjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIw0KKw0KK3R5cGUgaHR0cGRfcGhwX2V4
ZWNfdCwgZmlsZV90eXBlLCBleGVjX3R5cGU7DQordHlwZSBodHRwZF9waHBf
dCwgZG9tYWluOw0KKw0KKyMgVHJhbnNpdGlvbiBmcm9tIHRoZSB1c2VyIGRv
bWFpbiB0byB0aGlzIGRvbWFpbi4NCitkb21haW5fYXV0b190cmFucyhodHRw
ZF90LCBodHRwZF9waHBfZXhlY190LCBodHRwZF9waHBfdCkNCisNCisjIFRo
ZSBzeXN0ZW0gcm9sZSBpcyBhdXRob3JpemVkIGZvciB0aGlzIGRvbWFpbi4N
Cityb2xlIHN5c3RlbV9yIHR5cGVzIGh0dHBkX3BocF90Ow0KKw0KK2dlbmVy
YWxfZG9tYWluX2FjY2VzcyhodHRwZF9waHBfdCkNCitnZW5lcmFsX2ZpbGVf
cmVhZF9hY2Nlc3MoaHR0cGRfcGhwX3QpDQordXNlc19zaGxpYihodHRwZF9w
aHBfdCkNCitjYW5fZXhlYyhodHRwZF9waHBfdCwgbGliX3QpDQorDQorIyBh
bGxvdyBwaHAgdG8gcmVhZCBhbmQgYXBwZW5kIHRvIGFwYWNoZSBsb2dmaWxl
cw0KK2FsbG93IGh0dHBkX3BocF90IGh0dHBkX2xvZ19maWxlc190OmZpbGUg
cmFfZmlsZV9wZXJtczsNCisNCisjIGFjY2VzcyB0byAvdG1wDQordG1wX2Rv
bWFpbihodHRwZF9waHApOw0KKw0KKyMgaWdub3JlIHRoZXNlIHRoaW5ncywg
UEhQIHNlZW1zIHRvIHdvcmsgZmluZSB3aXRob3V0DQorZG9udGF1ZGl0IGh0
dHBkX3BocF90IGh0dHBkX3N5c19zY3JpcHRfdDpkaXIgeyBzZWFyY2ggfTsN
CisNCisNCisjIGNvbm5lY3QgdG8gbXlzcWwNCitpZmRlZihgbXlzcWxkLnRl
JywgYA0KK2Nhbl91bml4X2Nvbm5lY3QoaHR0cGRfcGhwX3QsIG15c3FsZF90
KQ0KK2FsbG93IGh0dHBkX3BocF90IHZhcl9ydW5fbXlzcWxkX3Q6ZGlyIHsg
c2VhcmNoIH07DQorYWxsb3cgaHR0cGRfcGhwX3QgdmFyX3J1bl9teXNxbGRf
dDpzb2NrX2ZpbGUgeyB3cml0ZSB9Ow0KKycpDQorDQo=
--554330684-1035609432-1043251593=:24032--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
