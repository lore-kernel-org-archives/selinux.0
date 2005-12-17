Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBHFgZXf011012
	for <selinux@tycho.nsa.gov>; Sat, 17 Dec 2005 10:42:35 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBHFgXsp028074
	for <selinux@tycho.nsa.gov>; Sat, 17 Dec 2005 15:42:33 GMT
Message-ID: <43A43599.2080801@cornell.edu>
Date: Sat, 17 Dec 2005 10:58:17 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: New strategy for enableaudit.
References: <43A4182B.9000402@redhat.com> <43A42F09.8080204@cornell.edu> <43A42D3A.1090907@redhat.com>
In-Reply-To: <43A42D3A.1090907@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> This is only a short term solution until we get boolean support for 
> dontaudit rules.  But modules could do the same thing.   This
> gives me the ability to debug problems being covered by dontaudit 
> rules for now though.
So what's the planned solution using boolean support?
There's a number of things that could be done here...

Are you thinking of the module compiler placing dontaudit rules in a 
conditional block, based on a shared (base) boolean?




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
