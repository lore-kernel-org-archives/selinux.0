Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA17508
	for <selinux@tycho.nsa.gov>; Wed, 14 Aug 2002 19:03:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA02314
	for <selinux@tycho.nsa.gov>; Wed, 14 Aug 2002 23:02:34 GMT
Received: from hotmail.com (f186.law14.hotmail.com [64.4.21.186])
	by jazzswing.ncsc.mil  with ESMTP id XAA02310
	for <selinux@tycho.nsa.gov>; Wed, 14 Aug 2002 23:02:34 GMT
From: "M. H." <metalhead00@hotmail.com>
To: selinux@tycho.nsa.gov
Subject: relabel of socket fails somehow. any ideas?
Date: Wed, 14 Aug 2002 16:03:33 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F186DE8IqpFuiHV5EIK00002cb7@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I am trying to change the sid of a file representing a socket, after I bind 
to the socket. For some strange reason, this always fails, with the avc 
complaining that I am not allowed to relabel a socket to the given type, 
even though I have explicitly allowed that (running dmesg through 
newscripts.pl tells me to add an "allow .... { relabelto };" rule which I 
already have.) I have also allowed { relabelfrom }  for the original type of 
the socket (tmp_t in this case.)

Is the avc not picking up my "allow .... { relabelto };" for some reason, or 
is there another reason while i can't relabel a socket after binding to it 
(I wouldn't think there should be.)

Thanks,


_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
