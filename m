Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hALMlwRb000968
	for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2003 17:47:59 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hALMlMp5026535
	for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2003 22:47:22 GMT
Received: from efficax.net (rrcs-sw-24-153-230-186.biz.rr.com [24.153.230.186])
	by jazzswing.ncsc.mil  with ESMTP id hALMlGt0026528
	for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2003 22:47:21 GMT
Subject: First attempt at "Configuring the SELinux Policy" - I Think I got
	it !
From: Nick <nagray@austin.rr.com>
To: SE Linux <selinux@tycho.nsa.gov>, LC Bruzenak <lenny@bruzenak.com>
Content-Type: text/plain
Message-Id: <1069454857.2867.42.camel@hawaii>
Mime-Version: 1.0
Date: Fri, 21 Nov 2003 16:47:38 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I read through the document and got stuck at my first attempt.


Nov 21 15:39:20 selinux kernel: avc:  denied  { read } for  pid=1012
exe=/usr/sbin/httpd name=logs dev=03:03 ino=180255
scontext=system_u:system_r:httpd_t
tcontext=system_u:object_r:httpd_log_files_t tclass=lnk_file
N

My interpretation is: (try not to laugh)

the httpd daemon (system_u:system_r:httpd_t) is trying to read a file
named logs (system_u:object_r:httpd_log_files_t) but  does not have
{read} access.

So what I did was look, look for this file called logs that the process
is trying to access.  After I found it, and realized what was going on,
I changed the config to write the files to /var/log/httpd/ dir, where
the policy expected to see them.

Now on the other 50 messages!

The question is, is this pretty much the method required for this type
of thing?

--

Nick Gray
Senior Network Engineer
Bruzenak Inc
nagray@bruzenak.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
