Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1INdSQW027291
	for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2007 18:39:28 -0500
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1INeiBV004372
	for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2007 23:40:44 GMT
Received: by nz-out-0506.google.com with SMTP id z3so1416849nzf
        for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2007 15:40:44 -0800 (PST)
Message-ID: <e739902b0702181540r3734cb6bh7c68ed1f9f323d1e@mail.gmail.com>
Date: Sun, 18 Feb 2007 15:40:43 -0800
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: selinux@tycho.nsa.gov
Subject: PATCH: Remove redundant role statement from the apache.te file.
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_33923_19835270.1171842043701"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_33923_19835270.1171842043701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all,

I am working on writing a policy for the Boa web server.  I am using
the SELinux by example book and the apache modules for guidance.
Going through the apache.te file I noticed the following entry is
redundant:

    role system_r types httpd_t;

This statement is provided as part of the init_daemon_domain interface
in the modules/system/init.if interface file.  Here is the line in the
init_daemon_domain interface function:

   role system_r types $1;

I have attached a patch to remove role entry from the apache.te file.

Thanks!

- Ryan

------=_Part_33923_19835270.1171842043701
Content-Type: text/x-patch; name=apache.te.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eyc4gg4x
Content-Disposition: attachment; filename="apache.te.diff"

SW5kZXg6IHBvbGljeS9tb2R1bGVzL3NlcnZpY2VzL2FwYWNoZS50ZQo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBw
b2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9hcGFjaGUudGUJKHJldmlzaW9uIDIxODEpCisrKyBwb2xp
Y3kvbW9kdWxlcy9zZXJ2aWNlcy9hcGFjaGUudGUJKHdvcmtpbmcgY29weSkKQEAgLTMzLDcgKzMz
LDYgQEAKIHR5cGUgaHR0cGRfdDsKIHR5cGUgaHR0cGRfZXhlY190OwogaW5pdF9kYWVtb25fZG9t
YWluKGh0dHBkX3QsaHR0cGRfZXhlY190KQotcm9sZSBzeXN0ZW1fciB0eXBlcyBodHRwZF90Owog
CiAjIGh0dHBkX2NhY2hlX3QgaXMgdGhlIHR5cGUgZ2l2ZW4gdG8gdGhlIC92YXIvY2FjaGUvaHR0
cGQKICMgZGlyZWN0b3J5IGFuZCB0aGUgZmlsZXMgdW5kZXIgdGhhdCBkaXJlY3RvcnkK
------=_Part_33923_19835270.1171842043701--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
