Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA23761
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 17:05:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA10256
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 21:04:24 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id VAA10252 for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 21:04:22 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Ryan Bergauer" <privateryan@mindspring.com>, <selinux@tycho.nsa.gov>
Subject: Re: More Samba
Date: Thu, 1 Aug 2002 23:05:38 +0200
References: <000101c23996$e14d4390$0300a8c0@donkey>
In-Reply-To: <000101c23996$e14d4390$0300a8c0@donkey>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_EXN6DLKGW62KKLI9AGG5"
Message-Id: <20020801210538.BCB2C772C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_EXN6DLKGW62KKLI9AGG5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Thu, 1 Aug 2002 22:06, Ryan Bergauer wrote:
> Ok, here is an updated version of my Samba policy. It requires that a
> few lines be added to other files, namely.
>
> to net_contexts:
>
> ifdef(`samba.te', `portcon tcp 137 system_u:object_r:samba_port_t
> portcon tcp 138 system_u:object_r:samba_port_t
> portcon tcp 139 system_u:object_r:samba_port_t')

I've just added the following to my tree:
ifdef(`samba.te', `portcon tcp 137 system_u:object_r:smbd_port_t
portcon udp 137 system_u:object_r:nmbd_port_t
portcon tcp 138 system_u:object_r:smbd_port_t
portcon udp 138 system_u:object_r:nmbd_port_t
portcon tcp 139 system_u:object_r:smbd_port_t
portcon udp 139 system_u:object_r:nmbd_port_t')

> to logrotate.te:
>
> ifdef(`samba.te', `allow logrotate_t samba_log_t: dir { read search
> getattr };
> allow logrotate_t samba_log_t: file { getattr };
> allow logrotate_t samba_var_t: dir { read search getattr };
> allow logrotate_t samba_var_t: file { read getattr };')

Why does logrotate just need read access?

> I'm also receiving the following denied message, and I'm like some
> suggestions on the best way to handle it.
>
> avc:   denied   { read } for  pid=3486 exe=/bin/cat
> path=/var/log/samba/log.nmbd dev=03:02 ino=1753604
> scontext=system_u:object_r:system_crond_t
> tcontext=system_u:object_r:samba_log_t tclass=file

What script calls it?

I've attached my latest samba.te file...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--------------Boundary-00=_EXN6DLKGW62KKLI9AGG5
Content-Type: text/plain;
  charset="iso-8859-1";
  name="samba.te"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="samba.te"

IwojIEF1dGhvcjogUnlhbiBCZXJnYXVlciAoYmVyZ2F1ZXJAcmljZS5lZHUpCiMKCiMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwojCiMgRGVjbGFyYXRpb25zIGZvciBTYW1iYQojCgpk
YWVtb25fZG9tYWluKHNtYmQpCmRhZW1vbl9kb21haW4obm1iZCkKdHlwZSBzYW1iYV9ldGNfdCwg
ZmlsZV90eXBlLCBzeXNhZG1maWxlOwp0eXBlIHNhbWJhX2xvZ190LCBmaWxlX3R5cGUsIHN5c2Fk
bWZpbGU7CnR5cGUgc2FtYmFfdmFyX3QsIGZpbGVfdHlwZSwgc3lzYWRtZmlsZTsKdHlwZSBzYW1i
YV9zaGFyZV90LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGU7CgojIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMKIwojIFJ1bGVzIGZvciB0aGUgc21iZF90IGRvbWFpbi4KIwoKIyBQZXJtaXNz
aW9ucyBub3JtYWxseSBmb3VuZCBpbiBldmVyeV9kb21haW4uCmdlbmVyYWxfZG9tYWluX2FjY2Vz
cyhzbWJkX3QpCmdlbmVyYWxfZmlsZV9yZWFkX2FjY2VzcyhzbWJkX3QpCmdlbmVyYWxfcHJvY19y
ZWFkX2FjY2VzcyhzbWJkX3QpCgp0eXBlIHNtYmRfcG9ydF90LCBwb3J0X3R5cGU7CmFsbG93IHNt
YmRfdCBzbWJkX3BvcnRfdDp0Y3Bfc29ja2V0IG5hbWVfYmluZDsKCiMgVXNlIGNhcGFiaWxpdGll
cy4KYWxsb3cgc21iZF90IHNtYmRfdDpjYXBhYmlsaXR5IHsgc2V0Z2lkIHNldHVpZCBzeXNfcmVz
b3VyY2UgbmV0X2JpbmRfc2VydmljZSBsZWFzZSB9OwoKIyBVc2UgdGhlIG5ldHdvcmsuCmNhbl9u
ZXR3b3JrKHNtYmRfdCkKCiMgUmVhZC9Xcml0ZSB1c2VyIGhvbWUgZGlyZWN0b3JpZXMuCmFsbG93
IHNtYmRfdCB1c2VyX2hvbWVfdDpkaXIgY3JlYXRlX2Rpcl9wZXJtczsKYWxsb3cgc21iZF90IHVz
ZXJfaG9tZV90OmZpbGUgY3JlYXRlX2ZpbGVfcGVybXM7CgojIFBlcm1pc3Npb25zIGZvciBTYW1i
YSBmaWxlcyBpbiAvZXRjL3NhbWJhCiNhbGxvdyBzbWJkX3Qgc2FtYmFfZXRjX3Q6ZmlsZSB7IHdy
aXRlIHNldGF0dHIgZ2V0YXR0ciByZWFkIGxvY2sgfTsKYWxsb3cgc21iZF90IHNhbWJhX2V0Y190
OmZpbGUgeyBnZXRhdHRyIHJlYWQgfTsKYWxsb3cgc21iZF90IHNhbWJhX2V0Y190OmRpciB7IHNl
YXJjaCBnZXRhdHRyIH07CgojIFBlcm1pc3Npb25zIGZvciBTYW1iYSBjYWNoZSBmaWxlcyBpbiAv
dmFyL2NhY2hlL3NhbWJhCmFsbG93IHNtYmRfdCBzYW1iYV92YXJfdDpkaXIgeyB3cml0ZSByZW1v
dmVfbmFtZSBhZGRfbmFtZSBsb2NrIGdldGF0dHIgc2VhcmNoIH07CmFsbG93IHNtYmRfdCBzYW1i
YV92YXJfdDpmaWxlIHsgbG9jayB1bmxpbmsgY3JlYXRlIHdyaXRlIHNldGF0dHIgcmVhZCBnZXRh
dHRyIHJlbmFtZSB9OwoKIyBQZXJtaXNzaW9ucyB0byB3cml0ZSBsb2cgZmlsZXMuCmFsbG93IHNt
YmRfdCBzYW1iYV9sb2dfdDpmaWxlIHsgYXBwZW5kIGdldGF0dHIgY3JlYXRlIH07CmFsbG93IHNt
YmRfdCBzYW1iYV9sb2dfdDpkaXIgeyBzZWFyY2ggfTsKCiMgQWNjZXNzIFNhbWJhIHNoYXJlcy4K
YWxsb3cgc21iZF90IHNhbWJhX3NoYXJlX3Q6ZGlyIGNyZWF0ZV9kaXJfcGVybXM7CmFsbG93IHNt
YmRfdCBzYW1iYV9zaGFyZV90OmZpbGUgY3JlYXRlX2ZpbGVfcGVybXM7CgojIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMKIwojIFJ1bGVzIGZvciB0aGUgbm1iZF90IGRvbWFpbi4KIwoK
IyBQZXJtaXNzaW9ucyBub3JtYWxseSBmb3VuZCBpbiBldmVyeV9kb21haW4uCmdlbmVyYWxfZG9t
YWluX2FjY2VzcyhubWJkX3QpCmdlbmVyYWxfZmlsZV9yZWFkX2FjY2VzcyhubWJkX3QpCmdlbmVy
YWxfcHJvY19yZWFkX2FjY2VzcyhubWJkX3QpCgp0eXBlIG5tYmRfcG9ydF90LCBwb3J0X3R5cGU7
CmFsbG93IG5tYmRfdCBubWJkX3BvcnRfdDp1ZHBfc29ja2V0IG5hbWVfYmluZDsKCiMgVXNlIGNh
cGFiaWxpdGllcy4KYWxsb3cgbm1iZF90IG5tYmRfdDpjYXBhYmlsaXR5IHsgbmV0X2JpbmRfc2Vy
dmljZSB9OwoKIyBVc2UgdGhlIG5ldHdvcmsuCmNhbl9uZXR3b3JrKG5tYmRfdCkKCiMgUGVybWlz
c2lvbnMgZm9yIFNhbWJhIGZpbGVzIGluIC9ldGMvc2FtYmEKYWxsb3cgbm1iZF90IHNhbWJhX2V0
Y190OmZpbGUgeyBnZXRhdHRyIHJlYWQgfTsKYWxsb3cgbm1iZF90IHNhbWJhX2V0Y190OmRpciB7
IHNlYXJjaCBnZXRhdHRyIH07CgojIFBlcm1pc3Npb25zIGZvciBTYW1iYSBjYWNoZSBmaWxlcyBp
biAvdmFyL2NhY2hlL3NhbWJhCmFsbG93IG5tYmRfdCBzYW1iYV92YXJfdDpkaXIgeyB3cml0ZSBy
ZW1vdmVfbmFtZSBhZGRfbmFtZSBsb2NrIGdldGF0dHIgc2VhcmNoIH07CmFsbG93IG5tYmRfdCBz
YW1iYV92YXJfdDpmaWxlIHsgbG9jayB1bmxpbmsgY3JlYXRlIHdyaXRlIHNldGF0dHIgcmVhZCBn
ZXRhdHRyIHJlbmFtZSB9OwoKIyBQZXJtaXNzaW9ucyB0byB3cml0ZSBsb2cgZmlsZXMuCmFsbG93
IG5tYmRfdCBzYW1iYV9sb2dfdDpmaWxlIHsgYXBwZW5kIGdldGF0dHIgY3JlYXRlIH07CmFsbG93
IG5tYmRfdCBzYW1iYV9sb2dfdDpkaXIgeyBzZWFyY2ggfTsKCmFsbG93IG5tYmRfdCBubWJkX3Q6
IHVkcF9zb2NrZXQgcmVjdmZyb207Cg==

--------------Boundary-00=_EXN6DLKGW62KKLI9AGG5--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
