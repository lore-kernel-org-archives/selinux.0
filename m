Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3HFelI4006033
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2003 11:40:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3HFYd8X006179
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2003 15:40:44 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id h3HDo8KP027851 for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2003 13:50:17 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id h3HDo8D23456
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2003 09:50:08 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.64.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id h3HDo7q28922
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2003 09:50:07 -0400
Received: from redhat.com (dwalsh.cipe.redhat.com [10.0.2.138])
	by mail.boston.redhat.com (8.11.6/8.11.6) with ESMTP id h3HDo4215323
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2003 09:50:07 -0400
Message-ID: <3E9EB10C.8010409@redhat.com>
Date: Thu, 17 Apr 2003 09:50:04 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: logging messages
References: <200303132210.40371.russell@coker.com.au>
In-Reply-To: <200303132210.40371.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

How do I get the kernel to log a message again.  Seems like the SELinux 
kernel on
logs a denial message a single time after a reboot.  When I change the 
policy and
rerun the offending command I would like to see a new error message in 
/var/log/messages.

Is there a way to turn this on?


Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
