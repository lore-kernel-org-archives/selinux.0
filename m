Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA29171
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 15:21:58 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA18074
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 19:20:13 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id TAA18070
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 19:20:10 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: named.te
Date: Tue, 23 Apr 2002 21:21:39 +0200
References: <Pine.GSO.4.33.0204231410040.3983-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0204231410040.3983-100000@raven>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_3GC1XMP7XSG0W7ID98A1"
Message-Id: <20020423192139.DBB913A282@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_3GC1XMP7XSG0W7ID98A1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Tue, 23 Apr 2002 20:10, you wrote:
> On Tue, 23 Apr 2002, Russell Coker wrote:
> > Here's my latest BIND policy.
>
> And the definition of uses_authbind would be what?

That's in a macro file.  It's for the authbind helper program which is used 
to allow non-root processes to open ports <1024.  Authbind works by 
pre-loading a shared object that takes over the bind() call.  A bind() will 
result in executing a SUID program which binds to the port (if the UID of the 
calling code is considered appropriate) and returns the socket over a unix 
domain socket.

In a fully configured SE system it should not be necessary.  But I'm using it 
while I'm running SE Linux in debugging more.

I've attached the policy for the authbind program, here's the macro:
define(`uses_authbind',
`domain_auto_trans($1, authbind_exec_t, authbind_t)
allow authbind_t $1:process sigchld;
allow authbind_t $1:fd inherit_fd_perms;

allow authbind_t $1:{ tcp_socket udp_socket } rw_socket_perms;
')

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--------------Boundary-00=_3GC1XMP7XSG0W7ID98A1
Content-Type: text/plain;
  charset="iso-8859-1";
  name="authbind.te"
Content-Transfer-Encoding: base64
Content-Description: authbind.te
Content-Disposition: attachment; filename="authbind.te"

IwojIEF1dGhvcnM6ICBSdXNzZWxsIENva2VyIDxydXNzZWxsQGNva2VyLmNvbS5hdT4KIwoKIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCiMKIyBSdWxlcyBmb3IgdGhlIGF1dGhiaW5k
X3QgZG9tYWluLgojCiMgYXV0aGJpbmRfZXhlY190IGlzIHRoZSB0eXBlIG9mIHRoZSBhdXRoYmlu
ZCBleGVjdXRhYmxlLgojCnR5cGUgYXV0aGJpbmRfdCwgZG9tYWluLCBwcml2bG9nOwp0eXBlIGF1
dGhiaW5kX2V4ZWNfdCwgZmlsZV90eXBlLCBzeXNhZG1maWxlLCBleGVjX3R5cGU7Cgpyb2xlIHN5
c3RlbV9yIHR5cGVzIGF1dGhiaW5kX3Q7Cgp0eXBlIGV0Y19hdXRoYmluZF90LCBmaWxlX3R5cGUs
IHN5c2FkbWZpbGU7CgphbGxvdyBhdXRoYmluZF90IGV0Y19hdXRoYmluZF90OmZpbGUgcnhfZmls
ZV9wZXJtczsKYWxsb3cgYXV0aGJpbmRfdCB7IGV0Y190IGV0Y19hdXRoYmluZF90IH06ZGlyIHJf
ZGlyX3Blcm1zOwoKdXNlc19zaGxpYihhdXRoYmluZF90KQoKYWxsb3cgYXV0aGJpbmRfdCBzZWxm
OmNhcGFiaWxpdHkgbmV0X2JpbmRfc2VydmljZTsKCmFsbG93IGF1dGhiaW5kX3QgZG9tYWluOmZk
IHVzZTsK

--------------Boundary-00=_3GC1XMP7XSG0W7ID98A1--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
