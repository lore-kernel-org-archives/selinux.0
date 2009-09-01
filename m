Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n81GBjcW019563
	for <selinux@tycho.nsa.gov>; Tue, 1 Sep 2009 12:11:45 -0400
Received: from pobox.globalherald.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n81GB8P5017271
	for <selinux@tycho.nsa.gov>; Tue, 1 Sep 2009 16:11:08 GMT
Received: from [192.168.2.3] (unknown [192.168.2.3])
	by pobox.globalherald.net (Postfix) with ESMTP id 6373A1FD082
	for <selinux@tycho.nsa.gov>; Tue,  1 Sep 2009 13:31:57 -0400 (EDT)
Date: Tue, 1 Sep 2009 13:31:56 -0400 (EDT)
From: josh@globalherald.net
To: selinux@tycho.nsa.gov
Subject: Re: CentOS / RHEL5: where is setrans.conf?
In-Reply-To: <alpine.LFD.2.00.0909011317390.26878@home-av-server.home-av>
Message-ID: <alpine.LFD.2.00.0909011330320.26878@home-av-server.home-av>
References: <alpine.LFD.2.00.0909011317390.26878@home-av-server.home-av>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> IOError: [Errno 2] No such file or directory: 
> '/etc/selinux/clip/setrans.conf'

Answering myself: page 743 of the RHEL Deployment Guide provides the 
answer here.  If the file doesn't exist, create it.  Example contents are 
listed below.

Thanks,
-Josh

s0:c0=Marketing
s0:c1=Finance
s0:c2=Payroll
s0:c3=Personnel


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
