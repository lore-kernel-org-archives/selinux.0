Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2R9VQIT016453
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 05:31:26 -0400
Received: from web86906.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2R9VP6d019985
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 09:31:25 GMT
Date: Tue, 27 Mar 2007 10:31:09 +0100 (BST)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: SELinux cache.
To: SELinux List <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <800112.19807.qm@web86906.mail.ukl.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Every one,

  SELinux maintains a cache called "access vector
cache (avc)" for caching the security server
decisions. Beside the avc, is there is any other cache
as well, which is maintained outside the domain of
Linux kernel or SElinux?.

The book "SELinux by example" have mentioned a cache
in the userspace (library libselinux), but
unfortunately, i was not able to locate this library.

Currently, my selinux is running in "Enforcing" mode,
with "targeted" policy. Some times, it executes the
functions within the selinux/hooks.c such as
"may_create", "may_link", "file_has_perm" and some
times not. The avc calls are normally executed within
these methods. So, logically, these methods should be
consulted, before examining the avc for a cache
miss/hit. 

Am, i running SELInux in the wrong mode, i mean, at
the moment it is "targeted", shall it be "strict" in
order to execute these "hooks.c" functions each time a
permission check is made, or there is another cache
maintained outside the SELInux domain bounderies.


Thanking you in advance.
Best,
JG





	
	
		
___________________________________________________________ 
New Yahoo! Mail is the ultimate force in competitive emailing. Find out more at the Yahoo! Mail Championships. Plus: play games and win prizes. 
http://uk.rd.yahoo.com/evt=44106/*http://mail.yahoo.net/uk 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
