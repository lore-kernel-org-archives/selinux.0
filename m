Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i064hdRb007204
	for <selinux@tycho.nsa.gov>; Mon, 5 Jan 2004 23:43:44 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i064gbxr013350
	for <selinux@tycho.nsa.gov>; Tue, 6 Jan 2004 04:42:37 GMT
Received: from hawaii.efficax.net (rrcs-sw-24-153-230-186.biz.rr.com [24.153.230.186])
	by jazzswing.ncsc.mil  with ESMTP id i064gaYc013347
	for <selinux@tycho.nsa.gov>; Tue, 6 Jan 2004 04:42:36 GMT
Received: from hawaii.efficax.net (hawaii.efficax.net [127.0.0.1])
	by hawaii.efficax.net (8.12.10/8.12.10) with ESMTP id i064hbhl032718
	for <selinux@tycho.nsa.gov>; Mon, 5 Jan 2004 22:43:37 -0600
Received: (from nick@localhost)
	by hawaii.efficax.net (8.12.10/8.12.10/Submit) id i064hbAX032716
	for selinux@tycho.nsa.gov; Mon, 5 Jan 2004 22:43:37 -0600
Subject: 
From: Nick <nagray@austin.rr.com>
Reply-To: nagray@austin.rr.com
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1073364216.20253.137.camel@hawaii.efficax.net>
Mime-Version: 1.0
Date: Mon, 05 Jan 2004 22:43:37 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was building Fedora tonight after taking a couple of weeks off and
during the "rpmbuild --rebuild *.src.rpm" I am getting this error

Any quick ideas?


RPM build errors:
    File not found by glob: /var/tmp/star-1.5a25-root/usr/bin/*star
    File not found: /var/tmp/star-1.5a25-root/usr/bin/spax
    File not found by glob:
/var/tmp/star-1.5a25-root/usr/share/man/man1/star*

-- 
Nick (Nix) Gray
Senior Systems Engineer
Bruzenak Inc.
(512) 331-7998

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
