Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBIMZTXf019596
	for <selinux@tycho.nsa.gov>; Sun, 18 Dec 2005 17:35:30 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBIMYZmN026244
	for <selinux@tycho.nsa.gov>; Sun, 18 Dec 2005 22:34:35 GMT
Message-ID: <43A5E41A.1050800@tresys.com>
Date: Sun, 18 Dec 2005 17:35:06 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: New strategy for enableaudit.
References: <43A4182B.9000402@redhat.com> <43A42F09.8080204@cornell.edu> <43A42D3A.1090907@redhat.com> <43A43599.2080801@cornell.edu>
In-Reply-To: <43A43599.2080801@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> 
>> This is only a short term solution until we get boolean support for 
>> dontaudit rules.  But modules could do the same thing.   This
>> gives me the ability to debug problems being covered by dontaudit 
>> rules for now though.
> 
> So what's the planned solution using boolean support?
> There's a number of things that could be done here...
> 
> Are you thinking of the module compiler placing dontaudit rules in a 
> conditional block, based on a shared (base) boolean?
> 
not automatically; the refpolicy should just have all dontaudits under a 
   specific boolean. This will be easier when nested conditionals are 
available.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
