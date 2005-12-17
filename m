Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBHFEoXf010824
	for <selinux@tycho.nsa.gov>; Sat, 17 Dec 2005 10:14:50 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBHFElsp025752
	for <selinux@tycho.nsa.gov>; Sat, 17 Dec 2005 15:14:47 GMT
Message-ID: <43A42F09.8080204@cornell.edu>
Date: Sat, 17 Dec 2005 10:30:17 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: New strategy for enableaudit.
References: <43A4182B.9000402@redhat.com>
In-Reply-To: <43A4182B.9000402@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> I have added enableaudit to Rules.modular to create a base.conf 
> without audit rules.
>
> Then in the Fedora spec file I create a regulare base.pp and a 
> enableaudit.pp.
> I ship both in the RPM.
>
> Now the user can execute
>
> semodule -b /usr/share/selinux/targeted/enableaudit.pp
>
> To turn off the dontaudit rules.
>
What about audit rules in modules...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
