Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9B4RH3P025036
	for <selinux@tycho.nsa.gov>; Sun, 11 Oct 2009 00:27:17 -0400
Received: from mailhub245.itcs.purdue.edu (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n9B4Su28012389
	for <selinux@tycho.nsa.gov>; Sun, 11 Oct 2009 04:28:56 GMT
Received: from jacques-thomass-macbook-pro-17.local (c-24-13-127-145.hsd1.in.comcast.net [24.13.127.145])
	(authenticated bits=0)
	by mailhub245.itcs.purdue.edu (8.14.2/8.14.2/smtp-auth.purdue.edu) with ESMTP id n9B4REVF014762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Sun, 11 Oct 2009 00:27:15 -0400
Message-ID: <4AD15EA2.9050804@cs.purdue.edu>
Date: Sun, 11 Oct 2009 00:27:14 -0400
From: Jacques Thomas <jthomas@cs.purdue.edu>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: SECMARK: implementation question
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dear All,

If I understand correctly, the permission check for inbound packet (the 
"packet recv" operation) is performed by selinux_socket_sock_recv_skb, 
which hooks into the socket_sock_recv_skb hook.

Does anybody remember the rationale for doing the check there instead of 
the NF_INET_LOCAL_IN hook ?

I am asking that because the permission for outbound packets ("packet 
send") seems to be performed in the NF_INET_LOCAL_OUT. I am sure there 
should be a good reason for this asymetry, but I don't get it.

Thanks for your time,
Jacques Thomas

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
