Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA25329
	for <selinux@tycho.nsa.gov>; Fri, 31 May 2002 11:12:32 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA21100
	for <selinux@tycho.nsa.gov>; Fri, 31 May 2002 15:12:24 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id PAA21094
	for <selinux@tycho.nsa.gov>; Fri, 31 May 2002 15:12:22 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: LaMont Jones <lamont@hp.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: bind and SE Linux
Date: Fri, 31 May 2002 17:12:18 +0200
References: <20020530204303.69C3912133@security.hp.com>
In-Reply-To: <20020530204303.69C3912133@security.hp.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_I8EZC9WJVFN1VDN51A50"
Message-Id: <20020531151219.4CC91467D@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_I8EZC9WJVFN1VDN51A50
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

After receiving the following message I changed my SE Policy for named to 
allow receiving on TCP port 53 as well.

I currently have this in my net_contexts file:
ifdef(`named.te', `udp 53 system_u:object_r:named_port_t
tcp 53 system_u:object_r:named_port_t')

And I have this in my named.te:
# Bind to the named port.
allow named_t named_port_t:udp_socket name_bind;
allow named_t named_port_t:tcp_socket name_bind;

I have attached the full named.te file I'm using now because it's totally 
different from the old one.


On Thu, 30 May 2002 22:42, LaMont Jones wrote:
> > Why does postfix make TCP connections to the name server instead of UDP?
>
> The most likely situation is that the answer came back claiming that it
> was truncated, and so the resolver switched over to TCP (as it's supposed
> to...)
>
> From the postfix source (flags is passed in, the only non-zero value
> ever used is RES_DEFNAMES.):
>     /*
>      * Set search options: debugging, parent domain search, append local
>      * domain. Do not allow the user to control other features.
>      */
> #define USER_FLAGS (RES_DEBUG | RES_DNSRCH | RES_DEFNAMES)
>
>     if ((flags & USER_FLAGS) != flags)
>         msg_panic("dns_query: bad flags: %d", flags);
>     _res.options &= ~(USER_FLAGS);
>     _res.options |= flags;
>
> From there, postfix uses res_search to do the query, so any failover
> to TCP is going to be the resolver library's decision.
>
> lamont
>
> > I expected it to use UDP only.  See below for SE Linux logs to show the
> > TCP connections.
>
> TCP queries are a perfectly valid fact of life.  blocking them will cause
> problems, regardless of how well it works 95% of the time...
>
> lamont

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--------------Boundary-00=_I8EZC9WJVFN1VDN51A50
Content-Type: text/plain;
  charset="iso-8859-1";
  name="named.te"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="named.te"

IwojIEF1dGhvcjogIFl1aWNoaSBOYWthbXVyYSA8eW5ha2FtQG9yaS5oaXRhY2hpLXNrLmNvLmpw
PgojCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKIwojIFJ1bGVzIGZvciB0aGUg
bmFtZWRfdCBkb21haW4uCiMKdHlwZSBuYW1lZF9wb3J0X3QscG9ydF90eXBlOwoKZGFlbW9uX2Rv
bWFpbihuYW1lZCkKIyBuZGNfdCBpcyB0aGUgZG9tYWluIGZvciB0aGUgbmRjIHByb2dyYW0KdHlw
ZSBuZGNfdCwgZG9tYWluLCBwcml2bG9nOwpyb2xlIHN5c2FkbV9yIHR5cGVzIG5kY190OwoKY2Fu
X2V4ZWMobmFtZWRfdCwgbmFtZWRfZXhlY190KQoKIyBBIHR5cGUgZm9yIGNvbmZpZ3VyYXRpb24g
ZmlsZXMgb2YgbmFtZWQuCnR5cGUgbmFtZWRfY29uZl90LCBmaWxlX3R5cGUsc3lzYWRtZmlsZTsK
CiMgZm9yIHByaW1hcnkgem9uZSBmaWxlcwp0eXBlIG5hbWVkX3pvbmVfdCwgZmlsZV90eXBlLCBz
eXNhZG1maWxlOwoKIyBmb3Igc2Vjb25kYXJ5IHpvbmUgZmlsZXMKdHlwZSBuYW1lZF9jYWNoZV90
LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGU7CgojIFVzZSBjYXBhYmlsaXRpZXMuIFN1cnBsdXMgY2Fw
YWJpbGl0aWVzIG1heSBiZSBhbGxvd2VkLgphbGxvdyBuYW1lZF90IG5hbWVkX3Q6Y2FwYWJpbGl0
eSB7IHNldHVpZCBzZXRnaWQgbmV0X2JpbmRfc2VydmljZSBjaG93biBmb3duZXIgZGFjX292ZXJy
aWRlIHN5c19uaWNlIH07CgphbGxvdyBuYW1lZF90IGV0Y190OnsgZmlsZSBsbmtfZmlsZSB9IHsg
Z2V0YXR0ciByZWFkIH07CmFsbG93IG5hbWVkX3QgcmVzb2x2X2NvbmZfdDpmaWxlIHsgZ2V0YXR0
ciByZWFkIH07CgojTmFtZWQgY2FuIHVzZSBuZXR3b3JrCmNhbl9uZXR3b3JrKG5hbWVkX3QpCiMg
YWxsb3cgVURQIHRyYW5zZmVyIHRvL2Zyb20gYW55IHByb2dyYW0KY2FuX3VkcF9zZW5kKGRvbWFp
biwgbmFtZWRfdCkKY2FuX3VkcF9zZW5kKG5hbWVkX3QsIGRvbWFpbikKCiMgQmluZCB0byB0aGUg
bmFtZWQgcG9ydC4KYWxsb3cgbmFtZWRfdCBuYW1lZF9wb3J0X3Q6dWRwX3NvY2tldCBuYW1lX2Jp
bmQ7CmFsbG93IG5hbWVkX3QgbmFtZWRfcG9ydF90OnRjcF9zb2NrZXQgbmFtZV9iaW5kOwoKI3Jl
YWQgY29uZmlndXJhdGlvbiBmaWxlcwpyX2Rpcl9maWxlKG5hbWVkX3QsIG5hbWVkX2NvbmZfdCkK
CiNyZWFkIHpvbmUgZmlsZXMgLSBjaGFuZ2UgdGhpcyB0byByd19kaXJfY3JlYXRlX2ZpbGUoKSB0
bwojIGVuYWJsZSBkb21haW4gYXV0byB1cGRhdGVzLgpyX2Rpcl9maWxlKG5hbWVkX3QsIG5hbWVk
X3pvbmVfdCkKCiN3cml0ZSBjYWNoZSBmb3Igc2Vjb25kYXJ5IHpvbmVzCnJ3X2Rpcl9jcmVhdGVf
ZmlsZShuYW1lZF90LCBuYW1lZF9jYWNoZV90KQoKYWxsb3cgbmFtZWRfdCBzZWxmOnVuaXhfc3Ry
ZWFtX3NvY2tldCBjcmVhdGVfc3RyZWFtX3NvY2tldF9wZXJtczsKYWxsb3cgbmFtZWRfdCBzZWxm
OnVuaXhfZGdyYW1fc29ja2V0IGNyZWF0ZV9zb2NrZXRfcGVybXM7CgojQSB0eXBlIGZvciAvdXNy
L3NiaW4vbmRjCnR5cGUgbmRjX2V4ZWNfdCwgZmlsZV90eXBlLHN5c2FkbWZpbGUsIGV4ZWNfdHlw
ZTsKZG9tYWluX2F1dG9fdHJhbnMoc3lzYWRtX3QsIG5kY19leGVjX3QsIG5kY190KQp1c2VzX3No
bGliKG5kY190KQoKYWxsb3cgbmRjX3QgZXRjX3Q6ZGlyIHJfZGlyX3Blcm1zOwphbGxvdyBuZGNf
dCBzZWxmOnVuaXhfc3RyZWFtX3NvY2tldCBjcmVhdGVfc3RyZWFtX3NvY2tldF9wZXJtczsKYWxs
b3cgbmRjX3Qgc2VsZjp1bml4X3N0cmVhbV9zb2NrZXQgY29ubmVjdDsKYWxsb3cgbmRjX3Qgc2Vs
ZjpjYXBhYmlsaXR5IGRhY19vdmVycmlkZTsKYWxsb3cgbmRjX3QgdmFyX3J1bl9uYW1lZF90OnNv
Y2tfZmlsZSByd19maWxlX3Blcm1zOwphbGxvdyBuZGNfdCBuYW1lZF90OnVuaXhfc3RyZWFtX3Nv
Y2tldCBjb25uZWN0dG87Cg==

--------------Boundary-00=_I8EZC9WJVFN1VDN51A50--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
