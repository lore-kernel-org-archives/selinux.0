Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA07770
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 13:12:34 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA13531
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 17:11:34 GMT
Received: from hotmail.com (f265.law14.hotmail.com [64.4.20.140])
	by jazzswing.ncsc.mil  with ESMTP id RAA13527
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 17:11:33 GMT
From: "M. H." <metalhead00@hotmail.com>
To: selinux@tycho.nsa.gov
Subject: socket_secure fails with "Function not implemented"
Date: Tue, 13 Aug 2002 10:11:31 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F2658oBC9xfDYBWjLb400005049@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi everyone,

I was trying to write a little test program using socket_secure(), however 
it never succeeds and sets errno to "Function not implemented."
The same happens when I try to run the libsecure/test/ programs like 
'unix_stream_client' and 'unix_stream_server.'
Any idea what I may be doing wrong (I was left with the expression that 
socket_secure is implemented...)?

Thanks.


_________________________________________________________________
Join the world’s largest e-mail service with MSN Hotmail. 
http://www.hotmail.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
