Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA23112
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 11:43:40 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA00014
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 16:42:37 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id QAA00010 for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 16:42:35 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Shaun Savage <savages@pcez.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: package configuration (for dpkg - rpm will have the same issues)
Date: Wed, 20 Mar 2002 17:43:25 +0100
References: <Pine.GSO.4.33.0203150854350.15480-100000@raven> <20020320153129.C4B3EC61D@lyta.coker.com.au> <3C98B2BF.9090706@pcez.com>
In-Reply-To: <3C98B2BF.9090706@pcez.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_DG6AJKD7X2K4RDPG3D39"
Message-Id: <20020320164325.E84DD2FC38@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_DG6AJKD7X2K4RDPG3D39
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Wed, 20 Mar 2002 17:03, Shaun Savage wrote:
> I am trying to secure courier mail system, What a pain.

I've attached the .te file for my work in progress, below are the 
file_contexts entries.  I've only got the authdaemon going so far, I am only 
aiming to get the POP and IMAP servers working.

What have you got so far?

/etc/courier/(|/.*)             system_u:object_r:etc_courier_t
/usr/lib/courier(|/.*)          system_u:object_r:etc_courier_t
/usr/lib/courier/authlib/.*     system_u:object_r:courier_exec_t
/usr/lib/courier/courier/.*     system_u:object_r:courier_exec_t
/usr/sbin/courier.*             system_u:object_r:courier_exec_t
/var/run/courier.*              system_u:object_r:courier_var_run_t

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--------------Boundary-00=_DG6AJKD7X2K4RDPG3D39
Content-Type: text/plain;
  charset="iso-8859-1";
  name="courier.te"
Content-Transfer-Encoding: base64
Content-Description: courier.te
Content-Disposition: attachment; filename="courier.te"

IwojIEF1dGhvcjogIFJ1c3NlbGwgQ29rZXIgPHJ1c3NlbGxAY29rZXIuY29tLmF1PgojCgojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKIwojIFJ1bGVzIGZvciB0aGUgY291cmllcl90
IGRvbWFpbi4KIwojIGNvdXJpZXJfZXhlY190IGlzIHRoZSB0eXBlIG9mIHRoZSBjb3VyaWVyIGV4
ZWN1dGFibGVzLgojCnR5cGUgY291cmllcl90LCBkb21haW4sIHByaXZsb2c7CnR5cGUgY291cmll
cl9leGVjX3QsIGZpbGVfdHlwZSwgc3lzYWRtZmlsZSwgZXhlY190eXBlOwp0eXBlIGV0Y19jb3Vy
aWVyX3QsIGZpbGVfdHlwZSwgc3lzYWRtZmlsZTsKCnJvbGUgc3lzdGVtX3IgdHlwZXMgY291cmll
cl90OwoKYWxsb3cgY291cmllcl90IGluaXRfdDpwcm9jZXNzIHNpZ2NobGQ7CgojIFR5cGUgZm9y
IGZpbGVzIGNyZWF0ZWQgZHVyaW5nIGV4ZWN1dGlvbiBvZiBjb3VyaWVyLgp0eXBlIGNvdXJpZXJf
dmFyX3J1bl90LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGU7CmZpbGVfdHlwZV9hdXRvX3RyYW5zKGNv
dXJpZXJfdCwgdmFyX3J1bl90LCBjb3VyaWVyX3Zhcl9ydW5fdCkKCiMgYWxsb3cgaXQgdG8gcmVh
ZCBpdCdzIGNvbmZpZyBmaWxlcyBldGMKYWxsb3cgY291cmllcl90IHsgZXRjX2NvdXJpZXJfdCB2
YXJfdCB9OmRpciByX2Rpcl9wZXJtczsKYWxsb3cgY291cmllcl90IGV0Y19jb3VyaWVyX3Q6Zmls
ZSByX2ZpbGVfcGVybXM7CmFsbG93IGNvdXJpZXJfdCBldGNfdDpkaXIgcl9kaXJfcGVybXM7CmFs
bG93IGNvdXJpZXJfdCBldGNfdDp7IGZpbGUgbG5rX2ZpbGUgfSByX2ZpbGVfcGVybXM7CgojIGV4
ZWN1dGUgc2NyaXB0cyBldGMKYWxsb3cgY291cmllcl90IHsgYmluX3QgY291cmllcl9leGVjX3Qg
fTpmaWxlIHJ4X2ZpbGVfcGVybXM7CmFsbG93IGNvdXJpZXJfdCBiaW5fdDpkaXIgcl9kaXJfcGVy
bXM7CmFsbG93IGNvdXJpZXJfdCBmc190OmZpbGVzeXN0ZW0gZ2V0YXR0cjsKCiMgc2V0IHByb2Nl
c3MgZ3JvdXAgYW5kIGFsbG93IHBlcm1pc3Npb25zIG92ZXItcmlkZQphbGxvdyBjb3VyaWVyX3Qg
Y291cmllcl90OnByb2Nlc3MgeyBzZXRwZ2lkIGZvcmsgfTsKYWxsb3cgY291cmllcl90IGNvdXJp
ZXJfdDpjYXBhYmlsaXR5IGRhY19vdmVycmlkZTsKCiMgSW5oZXJpdCBhbmQgdXNlIGRlc2NyaXB0
b3JzIGZyb20gaW5pdC4KYWxsb3cgY291cmllcl90IGluaXRfdDpmZCBpbmhlcml0X2ZkX3Blcm1z
OwphbGxvdyBjb3VyaWVyX3QgeyBpbml0X3QgY291cmllcl90IH06cHJvY2VzcyBzaWdjaGxkOwoK
IyBVc2UgdGhlIG5ldHdvcmsuCmNhbl9uZXR3b3JrKGNvdXJpZXJfdCkKYWxsb3cgY291cmllcl90
IGNvdXJpZXJfdDpmaWZvX2ZpbGUgeyByZWFkIHdyaXRlIGdldGF0dHIgfTsKYWxsb3cgY291cmll
cl90IGNvdXJpZXJfdDp1bml4X3N0cmVhbV9zb2NrZXQgY3JlYXRlX3N0cmVhbV9zb2NrZXRfcGVy
bXM7CmFsbG93IGNvdXJpZXJfdCBjb3VyaWVyX3Q6dW5peF9kZ3JhbV9zb2NrZXQgY3JlYXRlX3Nv
Y2tldF9wZXJtczsKCmFsbG93IGNvdXJpZXJfdCBudWxsX2RldmljZV90OmNocl9maWxlIHJ3X2Zp
bGVfcGVybXM7CgojIFVzZSBjYXBhYmlsaXRpZXMKI2FsbG93IGNvdXJpZXJfdCBjb3VyaWVyX3Q6
Y2FwYWJpbGl0eSB7IG5ldF9yYXcgfTsKI2FsbG93IGNvdXJpZXJfdCBjb3VyaWVyX3Q6cHJvY2Vz
cyB7IHNldHNjaGVkIHNpZ25hbCB9OwoKIyBhbGxvdyBpdCB0byBsb2cgdG8gL2Rldi90dHkKYWxs
b3cgY291cmllcl90IGRldnR0eV90OmNocl9maWxlIHJ3X2ZpbGVfcGVybXM7Cgpkb21haW5fYXV0
b190cmFucyhpbml0cmNfdCwgY291cmllcl9leGVjX3QsIGNvdXJpZXJfdCkKCmFsbG93IGNvdXJp
ZXJfdCB7IHVzcl90IGV0Y19ydW50aW1lX3QgfTpmaWxlIHJfZmlsZV9wZXJtczsKYWxsb3cgY291
cmllcl90IHVzcl90OmRpciByX2Rpcl9wZXJtczsKYWxsb3cgY291cmllcl90IHJvb3RfdDpkaXIg
cl9kaXJfcGVybXM7CmNhbl9leGVjKGNvdXJpZXJfdCwgY291cmllcl9leGVjX3QpCmNhbl9leGVj
KGNvdXJpZXJfdCwgYmluX3QpCnVzZXNfc2hsaWIoY291cmllcl90KQoKYWxsb3cgY291cmllcl90
IHByb2NfdDpkaXIgcl9kaXJfcGVybXM7CmFsbG93IGNvdXJpZXJfdCBwcm9jX3Q6ZmlsZSByX2Zp
bGVfcGVybXM7CgojIGRvIHRoZSBhY3R1YWwgd29yawphbGxvdyBjb3VyaWVyX3QgdXNlcl9ob21l
X3Q6ZGlyIHJ3X2Rpcl9wZXJtczsKYWxsb3cgY291cmllcl90IHVzZXJfaG9tZV90OmZpbGUgcl9m
aWxlX3Blcm1zOwo=

--------------Boundary-00=_DG6AJKD7X2K4RDPG3D39--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
