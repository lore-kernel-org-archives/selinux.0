Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA14321
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 07:42:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA14345
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 11:42:07 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id LAA14339
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 11:42:05 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policy questions
Date: Fri, 26 Jul 2002 13:42:46 +0200
References: <20020726030213.GB27354@snoopy.apana.org.au>
In-Reply-To: <20020726030213.GB27354@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_AVTUAGZJY2VYCX4VYX49"
Message-Id: <20020726114247.3A14A14D1@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_AVTUAGZJY2VYCX4VYX49
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Fri, 26 Jul 2002 05:02, Brian May wrote:
> Also the diff between my policy and Russells policy is almost 1000
> lines. So, before it gets too long, I am attaching it here for
> further comments.

domains/misc/custom is a custom configuration file (and is something that I'm 
using for experimental stuff).  I disregarded that part of your diff.

I have attached the amavis.te the I've put in my tree.  Note that I'm not 
including "allow domain tmpfile" type rules.  Also note that for an ifdef I 
do:
ifdef(`something', `
allow ...
')
Instead of:
ifdef(`something',
`allow... ')

This makes it easier to read future diff's that change the same line, and if 
you insert a line inside the ifdef then it's only a 1 line diff entry.  Also 
I'm in the habit of putting a space after a comma, I think it looks nice and 
makes it more reasable.

For the cardmgr changes, I don't allow cardmgr to create device nodes and it 
works fine.  Why does it need it?  What is it doing with device nodes anyway? 
 I'm not going to distribute such a policy until I know what cardmgr is 
really trying to do (I've had a quick look at the source and couldn't figure 
it out).

For clamav.te, I think you should do something similar to what I have done 
for the irc domain.  I've partially hacked the appropriate code into my tree. 
 Doing that will allow multiple user domains easily (the way you did it will 
require editing clamav.te every time you add a new user domain).

Also does it make sense to scan a virus as sysadm anyway?

Why is the following needed?
-allow local_login_t faillog_t:file append;
+allow local_login_t faillog_t:file { append read write };

For the following, shouldn't the .so file in question be given a type of 
shlib_t?
+# additions by Brian May <bam@snoopy.apana.org.au> 2002-07-14
+
+# /usr/lib/gconv/ISO8859-1.so
+allow local_login_t lib_t:file { execute };

The following is already in my tree, are you sure you have a recent version?
+# allow checking /var/run/lprng directory
+allow checkpc_t lpd_var_run_t:dir { getattr };

The following is in the daemon_domain macro:
+# additions by Brian May <bam@snoopy.apana.org.au> 2002-07-13
+file_type_auto_trans(nscd_t, var_run_t, var_run_nscd_t)

Is oav-update.te really an independant domain?  Maybe it should be included 
in one of the other files.  NB If you have oav-update.te but not amavis.te 
then your policy won't compile...  At the moment I'll leave it out of my tree 
for this reason.

BTW  Make sure you put your name at the top of every .te file you write so 
that you get any credit/flames that you deserve.  ;)  Also make sure you 
comment any non-obvious .te files so people can determine what they are for.

Your diff is missing kaffe.te.

I think that some of my postfix changes already did what you wanted, and I 
added the tcp_socket changes.  Please check my latest version and see how it 
compares to what you need.  I didn't include the postfix flush changes 
because I don't want to change too many things at once.  But the concept 
seems good.

I'm not sure if the following change to daemon_domain macro is what we really 
want, I'll have to think about it.
-domain_auto_trans(initrc_t, $1_exec_t, $1_t)
+domain_auto_trans({ init_t initrc_t }, $1_exec_t, $1_t)

I'll put a revised set of my policy on my web site soon incorporating most of 
your changes.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--------------Boundary-00=_AVTUAGZJY2VYCX4VYX49
Content-Type: text/plain;
  charset="iso-8859-1";
  name="amavis.te"
Content-Transfer-Encoding: base64
Content-Description: amavis.te
Content-Disposition: attachment; filename="amavis.te"

IwojIEF1dGhvcjogIEJyaWFuIE1heSA8YmFtQHNub29weS5hcGFuYS5vcmcuYXU+CiMKCiMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwojCiMgUnVsZXMgZm9yIHRoZSBhbWF2aXNkX3Qg
ZG9tYWluLgojCnR5cGUgYW1hdmlzZF9ldGNfdCwgZmlsZV90eXBlLCBzeXNhZG1maWxlOwp0eXBl
IGFtYXZpc2RfbG9nX3QsIGZpbGVfdHlwZSwgc3lzYWRtZmlsZTsKdHlwZSBhbWF2aXNkX2xpYl90
LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGU7CgojIGRhZW1vbgpkYWVtb25fZG9tYWluKGFtYXZpc2Qp
CgojIG5ldHdvcmtpbmcKY2FuX25ldHdvcmsoYW1hdmlzZF90KQppZmRlZihgcG9zdGZpeC50ZScs
IGAKY2FuX3RjcF9jb25uZWN0KHBvc3RmaXhfc210cF90LCBhbWF2aXNkX3QpOwonKQoKaWZkZWYo
YHNjYW5uZXJkYWVtb24udGUnLCBgCmNhbl90Y3BfY29ubmVjdChhbWF2aXNkX3QsIHNjYW5uZXJk
YWVtb25fdCk7CmFsbG93IHNjYW5uZXJkYWVtb25fdCBhbWF2aXNkX2xpYl90OmRpciByX2Rpcl9w
ZXJtczsKYWxsb3cgc2Nhbm5lcmRhZW1vbl90IGFtYXZpc2RfbGliX3Q6ZmlsZSByX2ZpbGVfcGVy
bXM7CicpCgppZmRlZihgY2xhbWF2LnRlJywgYApjbGFtc2Nhbl9kb21haW4oYW1hdmlzZCkKcm9s
ZSBzeXN0ZW1fciB0eXBlcyBhbWF2aXNkX2NsYW1zY2FuX3Q7CmFsbG93IGFtYXZpc2RfY2xhbXNj
YW5fdCBhbWF2aXNkX2xpYl90OmRpciByX2Rpcl9wZXJtczsKYWxsb3cgYW1hdmlzZF9jbGFtc2Nh
bl90IGFtYXZpc2RfbGliX3Q6ZmlsZSByX2ZpbGVfcGVybXM7CicpCgojIENhbiBjcmVhdGUgdW5p
eCBzb2NrZXRzCmFsbG93IGFtYXZpc2RfdCBzZWxmOnVuaXhfc3RyZWFtX3NvY2tldCBjcmVhdGVf
c3RyZWFtX3NvY2tldF9wZXJtczsKYWxsb3cgYW1hdmlzZF90IHNlbGY6dW5peF9kZ3JhbV9zb2Nr
ZXQgY3JlYXRlX3NvY2tldF9wZXJtczsKYWxsb3cgYW1hdmlzZF90IHNlbGY6Zmlmb19maWxlIGdl
dGF0dHI7CgojIEFjY2VzcyBjb25maWcgZmlsZXMgKGxpYmM2KS4KIyAvZXRjL2xvY2FsZS5hbGlh
cwphbGxvdyBhbWF2aXNkX3QgZXRjX3Q6ZmlsZSByX2ZpbGVfcGVybXM7CiMgL2V0Yy9sb2NhbHRp
bWUKYWxsb3cgYW1hdmlzZF90IGV0Y190Omxua19maWxlIHJfZmlsZV9wZXJtczsKIyAvdXNyL2xp
Yi9nY29udi8qLnNvCmFsbG93IGFtYXZpc2RfdCBsaWJfdDpmaWxlIHsgZXhlY3V0ZSB9OwojID8/
PwphbGxvdyBhbWF2aXNkX3QgcmVzb2x2X2NvbmZfdDpmaWxlIHJfZmlsZV9wZXJtczsKCiMgQWNj
ZXNzIGNvbmZpZyBmaWxlcyAoYW1hdmlzZCkuCmFsbG93IGFtYXZpc2RfdCBhbWF2aXNkX2V0Y190
OmZpbGUgcl9maWxlX3Blcm1zOwoKIyBBY2Nlc3MgYW1hdmlzZCBsb2cgZmlsZXMuCmZpbGVfdHlw
ZV9hdXRvX3RyYW5zKGFtYXZpc2RfdCwgdmFyX2xvZ190LCBhbWF2aXNkX2xvZ190KQoKIyBBY2Nl
c3MgYW1hdmlzZCB2YXIvbGliIGZpbGVzLgpjcmVhdGVfZGlyX2ZpbGUoYW1hdmlzZF90LCBhbWF2
aXNkX2xpYl90KQoKIyBSdW4gaGVscGVyIHByb2dyYW1zLgpjYW5fZXhlY19hbnkoYW1hdmlzZF90
LGJpbl90KQphbGxvdyBhbWF2aXNkX3QgdmFyX2xpYl90OmRpciBzZWFyY2g7CgojIHVua25vd24g
c3R1ZmYKYWxsb3cgYW1hdmlzZF90IHNlbGY6Zmlmb19maWxlIHsgcmVhZCB3cml0ZSB9OwphbGxv
dyBhbWF2aXNkX3QgcmFuZG9tX2RldmljZV90OmNocl9maWxlIHJlYWQ7CgojIGJyb2tlbiBzdHVm
Zgpkb250YXVkaXQgYW1hdmlzZF90IHN5c2FkbV9ob21lX2Rpcl90OmRpciBzZWFyY2g7CmRvbnRh
dWRpdCBhbWF2aXNkX3Qgc2hhZG93X3Q6ZmlsZSB7IGdldGF0dHIgcmVhZCB9Owpkb250YXVkaXQg
YW1hdmlzZF90IHN5c2FkbV9kZXZwdHNfdDpjaHJfZmlsZSB7IHJlYWQgd3JpdGUgfTsK

--------------Boundary-00=_AVTUAGZJY2VYCX4VYX49--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
