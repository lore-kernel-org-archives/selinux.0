Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA29118
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 08:25:10 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA28526
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 13:23:48 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id NAA28522
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 13:23:47 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 021C892443
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 00:25:04 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 91F8641A08
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 14:24:57 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: te for courier-pop and courier-imap
Date: Thu, 21 Mar 2002 14:24:57 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_LXRBUOMK9TTZZNYDKELI"
Message-Id: <20020321132457.91F8641A08@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_LXRBUOMK9TTZZNYDKELI
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I've attached my new te rules for courier that work.  You will note that I am 
granting the POP server ability to read all data under home directories and 
to unlink/rename files.  This is not what I want, but firstly I have to get 
appropriate te rules to have mail delivered in a different context.

Also we definately need to have different security types for the home 
directory and for directories under that.  For example I want to allow Apache 
to read my home directory so it can get to ~/www (which will be home_www_t or 
something).  I definately don't want Apache reading my email, or any of the 
other junk that's accumulated in my home directory (I really don't know what 
possibly secret material might be in my home directory).

Here's the courier file_contexts data again.

/etc/courier/(|/.*)             system_u:object_r:etc_courier_t
/usr/lib/courier(|/.*)          system_u:object_r:etc_courier_t
/usr/lib/courier/pop3d          system_u:object_r:courier_pop_exec_t
/usr/lib/courier/imapd          system_u:object_r:courier_pop_exec_t
/usr/lib/courier/authlib/.*     system_u:object_r:courier_authdaemon_exec_t
/usr/lib/courier/courier/.*     system_u:object_r:courier_exec_t
/usr/lib/courier/courier/courierpop.*   system_u:object_r:courier_pop_exec_t
/usr/lib/courier/courier/courierpop3.*  system_u:object_r:courier_pop_exec_t
/usr/lib/courier/courier/imaplogin      system_u:object_r:courier_pop_exec_t
/usr/sbin/couriertcpd           system_u:object_r:courier_tcpd_exec_t
/usr/sbin/courierlogger         system_u:object_r:courier_exec_t
/var/run/courier.*              system_u:object_r:courier_var_run_t

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--------------Boundary-00=_LXRBUOMK9TTZZNYDKELI
Content-Type: text/plain;
  charset="us-ascii";
  name="courier.te"
Content-Transfer-Encoding: base64
Content-Description: courier.te
Content-Disposition: attachment; filename="courier.te"

IwojIEF1dGhvcjogIFJ1c3NlbGwgQ29rZXIgPHJ1c3NlbGxAY29rZXIuY29tLmF1PgojCgojIFR5
cGUgZm9yIGZpbGVzIGNyZWF0ZWQgZHVyaW5nIGV4ZWN1dGlvbiBvZiBjb3VyaWVyLgp0eXBlIGNv
dXJpZXJfdmFyX3J1bl90LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGU7Cgp0eXBlIGV0Y19jb3VyaWVy
X3QsIGZpbGVfdHlwZSwgc3lzYWRtZmlsZTsKCnR5cGUgY291cmllcl9leGVjX3QsIGZpbGVfdHlw
ZSwgc3lzYWRtZmlsZSwgZXhlY190eXBlOwoKZGVmaW5lKGBjb3VyaWVyX2RvbWFpbicsIGAKIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCiMKIyBSdWxlcyBmb3IgdGhlIGNvdXJpZXJf
JDFfdCBkb21haW4uCiMKIyBjb3VyaWVyXyQxX2V4ZWNfdCBpcyB0aGUgdHlwZSBvZiB0aGUgY291
cmllcl8kMSBleGVjdXRhYmxlcy4KIwp0eXBlIGNvdXJpZXJfJDFfdCwgZG9tYWluLCBwcml2bG9n
Owp0eXBlIGNvdXJpZXJfJDFfZXhlY190LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGUsIGV4ZWNfdHlw
ZTsKCnJvbGUgc3lzdGVtX3IgdHlwZXMgY291cmllcl8kMV90OwoKYWxsb3cgY291cmllcl8kMV90
IGluaXRfdDpwcm9jZXNzIHNpZ2NobGQ7CmRvbWFpbl9hdXRvX3RyYW5zKGluaXRyY190LCBjb3Vy
aWVyXyQxX2V4ZWNfdCwgY291cmllcl8kMV90KQoKZmlsZV90eXBlX2F1dG9fdHJhbnMoY291cmll
cl8kMV90LCB2YXJfcnVuX3QsIGNvdXJpZXJfdmFyX3J1bl90KQoKIyBhbGxvdyBpdCB0byByZWFk
IGl0J3MgY29uZmlnIGZpbGVzIGV0YwphbGxvdyBjb3VyaWVyXyQxX3QgeyBldGNfY291cmllcl90
IHZhcl90IH06ZGlyIHJfZGlyX3Blcm1zOwphbGxvdyBjb3VyaWVyXyQxX3QgZXRjX2NvdXJpZXJf
dDpmaWxlIHJfZmlsZV9wZXJtczsKYWxsb3cgY291cmllcl8kMV90IGV0Y190OmRpciByX2Rpcl9w
ZXJtczsKYWxsb3cgY291cmllcl8kMV90IGV0Y190OnsgZmlsZSBsbmtfZmlsZSB9IHJfZmlsZV9w
ZXJtczsKCiMgZXhlY3V0ZSBzY3JpcHRzIGV0YwphbGxvdyBjb3VyaWVyXyQxX3QgeyBiaW5fdCBj
b3VyaWVyXyQxX2V4ZWNfdCB9OmZpbGUgcnhfZmlsZV9wZXJtczsKYWxsb3cgY291cmllcl8kMV90
IGJpbl90OmRpciByX2Rpcl9wZXJtczsKYWxsb3cgY291cmllcl8kMV90IGZzX3Q6ZmlsZXN5c3Rl
bSBnZXRhdHRyOwoKIyBzZXQgcHJvY2VzcyBncm91cCBhbmQgYWxsb3cgcGVybWlzc2lvbnMgb3Zl
ci1yaWRlCmFsbG93IGNvdXJpZXJfJDFfdCBzZWxmOnByb2Nlc3MgeyBzZXRwZ2lkIGZvcmsgc2ln
Y2hsZCBzaWduYWwgfTsKYWxsb3cgY291cmllcl8kMV90IHNlbGY6Y2FwYWJpbGl0eSBkYWNfb3Zl
cnJpZGU7CgojIEluaGVyaXQgYW5kIHVzZSBkZXNjcmlwdG9ycyBmcm9tIGluaXQuCmFsbG93IGNv
dXJpZXJfJDFfdCB7IG5ld3JvbGVfdCBpbml0X3QgfTpmZCBpbmhlcml0X2ZkX3Blcm1zOwphbGxv
dyBjb3VyaWVyXyQxX3QgeyBuZXdyb2xlX3QgaW5pdF90IH06cHJvY2VzcyBzaWdjaGxkOwoKIyBV
c2UgdGhlIG5ldHdvcmsuCmNhbl9uZXR3b3JrKGNvdXJpZXJfJDFfdCkKYWxsb3cgY291cmllcl8k
MV90IHNlbGY6Zmlmb19maWxlIHsgcmVhZCB3cml0ZSBnZXRhdHRyIH07CmFsbG93IGNvdXJpZXJf
JDFfdCBzZWxmOnVuaXhfc3RyZWFtX3NvY2tldCBjcmVhdGVfc3RyZWFtX3NvY2tldF9wZXJtczsK
YWxsb3cgY291cmllcl8kMV90IHNlbGY6dW5peF9kZ3JhbV9zb2NrZXQgY3JlYXRlX3NvY2tldF9w
ZXJtczsKCmFsbG93IGNvdXJpZXJfJDFfdCBudWxsX2RldmljZV90OmNocl9maWxlIHJ3X2ZpbGVf
cGVybXM7CgojIGFsbG93IGl0IHRvIGxvZyB0byAvZGV2L3R0eQphbGxvdyBjb3VyaWVyXyQxX3Qg
ZGV2dHR5X3Q6Y2hyX2ZpbGUgcndfZmlsZV9wZXJtczsKCmFsbG93IGNvdXJpZXJfJDFfdCB7IHVz
cl90IGV0Y19ydW50aW1lX3QgfTpmaWxlIHJfZmlsZV9wZXJtczsKYWxsb3cgY291cmllcl8kMV90
IHVzcl90OmRpciByX2Rpcl9wZXJtczsKYWxsb3cgY291cmllcl8kMV90IHJvb3RfdDpkaXIgcl9k
aXJfcGVybXM7CmNhbl9leGVjKGNvdXJpZXJfJDFfdCwgY291cmllcl8kMV9leGVjX3QpCmNhbl9l
eGVjKGNvdXJpZXJfJDFfdCwgYmluX3QpCnVzZXNfc2hsaWIoY291cmllcl8kMV90KQoKYWxsb3cg
Y291cmllcl8kMV90IHByb2NfdDpkaXIgcl9kaXJfcGVybXM7CmFsbG93IGNvdXJpZXJfJDFfdCBw
cm9jX3Q6ZmlsZSByX2ZpbGVfcGVybXM7CgonKWRubAoKY291cmllcl9kb21haW4oYXV0aGRhZW1v
bikKCiMgc2hvdWxkIG5vdCBiZSBuZWVkZWQhCmFsbG93IGNvdXJpZXJfYXV0aGRhZW1vbl90IHVz
ZXJfaG9tZV90OmRpciByX2Rpcl9wZXJtczsKYWxsb3cgY291cmllcl9hdXRoZGFlbW9uX3Qgc2Vs
Zjp1bml4X3N0cmVhbV9zb2NrZXQgY29ubmVjdHRvOwphbGxvdyBjb3VyaWVyX2F1dGhkYWVtb25f
dCBzZWxmOmNhcGFiaWxpdHkgeyBzZXR1aWQgc2V0Z2lkIH07Cgpjb3VyaWVyX2RvbWFpbih0Y3Bk
KQphbGxvdyBjb3VyaWVyX3RjcGRfdCBzZWxmOmNhcGFiaWxpdHkgbmV0X2JpbmRfc2VydmljZTsK
YWxsb3cgY291cmllcl90Y3BkX3Qgc2Jpbl90OmRpciByX2Rpcl9wZXJtczsKY2FuX2V4ZWMoY291
cmllcl90Y3BkX3QsIGNvdXJpZXJfZXhlY190KQoKIyBkb21haW4gZm9yIHBvcCBhbmQgaW1hcApj
b3VyaWVyX2RvbWFpbihwb3ApCmRvbWFpbl9hdXRvX3RyYW5zKGNvdXJpZXJfdGNwZF90LCBjb3Vy
aWVyX3BvcF9leGVjX3QsIGNvdXJpZXJfcG9wX3QpCmFsbG93IGNvdXJpZXJfdGNwZF90IGNvdXJp
ZXJfcG9wX2V4ZWNfdDpmaWxlIHJlYWQ7CmFsbG93IGNvdXJpZXJfcG9wX3QgY291cmllcl90Y3Bk
X3Q6dGNwX3NvY2tldCByd19zdHJlYW1fc29ja2V0X3Blcm1zOwpkb21haW5fYXV0b190cmFucyhj
b3VyaWVyX3BvcF90LCBjb3VyaWVyX2F1dGhkYWVtb25fZXhlY190LCBjb3VyaWVyX2F1dGhkYWVt
b25fdCkKYWxsb3cgY291cmllcl9wb3BfdCBjb3VyaWVyX2F1dGhkYWVtb25fZXhlY190OmZpbGUg
cmVhZDsKYWxsb3cgY291cmllcl9hdXRoZGFlbW9uX3QgY291cmllcl90Y3BkX3Q6ZmQgdXNlOwph
bGxvdyBjb3VyaWVyX2F1dGhkYWVtb25fdCBjb3VyaWVyX3RjcGRfdDp0Y3Bfc29ja2V0IHJ3X3N0
cmVhbV9zb2NrZXRfcGVybXM7CmFsbG93IGNvdXJpZXJfYXV0aGRhZW1vbl90IGNvdXJpZXJfdGNw
ZF90OmZpZm9fZmlsZSByd19maWxlX3Blcm1zOwphbGxvdyBjb3VyaWVyX3BvcF90IGNvdXJpZXJf
YXV0aGRhZW1vbl90OnByb2Nlc3Mgc2lnY2hsZDsKZG9tYWluX2F1dG9fdHJhbnMoY291cmllcl9h
dXRoZGFlbW9uX3QsIGNvdXJpZXJfcG9wX2V4ZWNfdCwgY291cmllcl9wb3BfdCkKYWxsb3cgY291
cmllcl9hdXRoZGFlbW9uX3QgY291cmllcl9wb3BfZXhlY190OmZpbGUgcmVhZDsKCiMgZG8gdGhl
IGFjdHVhbCB3b3JrIChyZWFkIHRoZSBNYWlsZGlyKQphbGxvdyBjb3VyaWVyX3BvcF90IHVzZXJf
aG9tZV90OmRpciByd19kaXJfcGVybXM7CmFsbG93IGNvdXJpZXJfcG9wX3QgdXNlcl9ob21lX3Q6
ZmlsZSByX2ZpbGVfcGVybXM7CmFsbG93IGNvdXJpZXJfcG9wX3QgdXNlcl9ob21lX3Q6ZmlsZSB7
IHJlbmFtZSB1bmxpbmsgfTsK

--------------Boundary-00=_LXRBUOMK9TTZZNYDKELI--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
