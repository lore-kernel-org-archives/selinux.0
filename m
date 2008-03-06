Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m263gD8r016384
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 22:42:13 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m263gC4X004428
	for <selinux@tycho.nsa.gov>; Thu, 6 Mar 2008 03:42:12 GMT
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Ronald van den Blink <selinux@a61.nl>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov
Message-Id: <C5C7FABD-BA26-403D-82D2-8F5066620298@nall.com>
From: Joe Nall <joe@nall.com>
To: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <47CF1616.1010201@redhat.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: Unreserved portnumbers in corenetwork
Date: Wed, 5 Mar 2008 21:41:55 -0600
References: <37866.80.95.164.250.1204712494.squirrel@www.a61.nl>	 <1204730645.14217.39.camel@gorn>	 <51324.80.95.164.250.1204732077.squirrel@www.a61.nl>	 <1204733123.14217.48.camel@gorn>	 <DE51A2D4-4153-4E12-BAA8-0D2711553ECF@a61.nl>	 <1204735380.14217.60.camel@gorn>	 <6507AB86-A6D5-4314-BC06-86458D15C786@a61.nl> <47CF034E.2010407@redhat.com> <1204749406.1397.136.camel@moss-spartans.epoch.ncsc.mil> <47CF1616.1010201@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why not just decouple the ports from the application by giving them  
names like port8080_t? This would allow multiple policies to be  
written to manage that resource, only one of which should be active at  
a time.  I think the real issue is the assumption that only one  
application will own ports like 80, 8080, 443 and 8443.

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
