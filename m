Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA24225
	for <selinux@tycho.nsa.gov>; Thu, 2 May 2002 23:07:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id DAA21103
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2002 03:06:08 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id DAA21099 for <selinux@tycho.nsa.gov>; Fri, 3 May 2002 03:06:05 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 86AB992460
	for <selinux@tycho.nsa.gov>; Fri,  3 May 2002 13:09:10 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 6A58C49
	for <selinux@tycho.nsa.gov>; Fri,  3 May 2002 13:05:31 +1000 (EST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: why is this needed?
Date: Fri, 3 May 2002 13:05:31 +1000
MIME-Version: 1.0
Message-Id: <20020503030531.6A58C49@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is in the sample policy, why is it needed?

allow initrc_t framebuf_device_t:lnk_file read;
allow initrc_t framebuf_device_t:devfile_class_set setattr;

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
