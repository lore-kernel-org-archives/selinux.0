Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6FK05Ha019840
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 16:00:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6FK04H5003754
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 20:00:04 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id h6FK03RX003751 for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 20:00:03 GMT
Subject: [patch] Re: enforcement and initrds
From: Colin Walters <walters@verbum.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1058289355.13738.705.camel@moss-huskers.epoch.ncsc.mil>
References: <1058151822.9620.25.camel@columbia>
	 <1058185993.13738.597.camel@moss-huskers.epoch.ncsc.mil>
	 <1058214662.19392.31.camel@columbia>
	 <1058289355.13738.705.camel@moss-huskers.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-z8hYnDeBLVu+WzXiewvY"
Message-Id: <1058299027.26237.163.camel@columbia>
Mime-Version: 1.0
Date: 15 Jul 2003 15:57:08 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-z8hYnDeBLVu+WzXiewvY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2003-07-15 at 13:15, Stephen Smalley wrote:
> On Mon, 2003-07-14 at 16:31, Colin Walters wrote:
> > That's a good point, but then again we could just make DEVELOP=n instead
> > mean that once enforcing mode was switched on, it couldn't be switched
> > off.
> 
> I'd prefer to be able to compile out the permissive mode support
> entirely for production kernels.

I can understand that.

> romfs or ramfs?  

romfs, sorry about my initial misstatement.

> It isn't an issue whether it is labeled before the
> policy is loaded; all permission checks are allowed until the policy is
> loaded and the security server is initialized.  

Ahh, I see.  Ok.  

I've created an initrd.te which appears to work for me.  I put it in
types/initrd.te.

> At some point, we'd like
> to generate an initial bootstrapping policy that is built into the
> security server, but there isn't any point in doing that until things
> stabilize a bit more, and that initial policy could be dependent on your
> particular kernel configuration and your initrd setup.

Yeah...I think this initrd.te is a first step towards that bootstrapping
policy.


--=-z8hYnDeBLVu+WzXiewvY
Content-Disposition: attachment; filename=initrd.te
Content-Type: text/plain; name=initrd.te; charset=UTF-8
Content-Transfer-Encoding: base64

Iw0KIyBEZXNjcmlwdGlvbjogYWxsb3cgcmFtZnMvY3JhbWZzIGluaXRyZCBib290c3RyYXBwaW5n
IGZyb20gdW5sYWJlbGVkX3QNCiMgQXV0aG9yczogQ29saW4gV2FsdGVycyA8d2FsdGVyc0B2ZXJi
dW0ub3JnPg0KDQojIE9wZXJhdGUgb24gdW5sYWJlbGVkIGZpbGVzLg0KYWxsb3cga2VybmVsX3Qg
dW5sYWJlbGVkX3Q6ZmlsZV9jbGFzc19zZXQgY3JlYXRlX2ZpbGVfcGVybXM7DQphbGxvdyBrZXJu
ZWxfdCB1bmxhYmVsZWRfdDpkaXIgY3JlYXRlX2Rpcl9wZXJtczsNCiMgQWxsb3cgcnVubmluZyBz
Y3JpcHRzIGFuZCBzdWNoIG9uIHRoZSBpbml0cmQuDQpjYW5fZXhlYyhrZXJuZWxfdCwgdW5sYWJl
bGVkX3QpOw0KDQojIE1vdW50IHBlcm1pc3Npb25zLCBzdG9sZW4gZnJvbSBtb3VudC50ZQ0KYWxs
b3cga2VybmVsX3QgdW5sYWJlbGVkX3Q6ZmlsZXN5c3RlbSBtb3VudF9mc19wZXJtczsNCmFsbG93
IGtlcm5lbF90IHVubGFiZWxlZF90OmRpciBtb3VudG9uOw0KYWxsb3cga2VybmVsX3QgcHJvY190
OmRpciBtb3VudG9uOw0KDQojIE9wZXJhdGUgb24gdG1wZnMuDQphbGxvdyBrZXJuZWxfdCB0bXBm
c190OmZpbGVfY2xhc3Nfc2V0IGNyZWF0ZV9maWxlX3Blcm1zOw0KYWxsb3cga2VybmVsX3QgdG1w
ZnNfdDpkaXIgY3JlYXRlX2Rpcl9wZXJtczsNCg0KDQo=

--=-z8hYnDeBLVu+WzXiewvY--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
