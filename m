Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lARIbQTg007354
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2007 13:37:26 -0500
Received: from KIL-SM-1.UCIS.Dal.Ca (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lARIbKu2015565
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2007 18:37:20 GMT
Received: from [129.173.2.172] (GTolliver-XP.UCIS.Dal.Ca [129.173.2.172])
	by KIL-SM-1.UCIS.Dal.Ca (8.12.10/8.12.10) with ESMTP id lARIas7M025530
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2007 14:36:55 -0400
Message-ID: <474C63DF.90807@dal.ca>
Date: Tue, 27 Nov 2007 14:37:19 -0400
From: tolliver@dal.ca
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: file_contexts question
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello,

This is a newbie question.

I would like to know the best way to determine what should be in the 
*file_contexts* file for httpd.

This is to prevent httpd from braking in the event of a Server restart.

Of course it has to pertain to the directory in which the www resides.

Thanks in advance.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
