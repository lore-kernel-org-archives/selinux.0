Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l85FZnme004661
	for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2007 11:35:49 -0400
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l85FZlJV020920
	for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2007 15:35:48 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
Message-Id: <6E78FE11-FAA3-4C3B-A87E-FA60ABB71863@sf-net.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: SELinux List <selinux@tycho.nsa.gov>
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: tunable and if-else conditional
Date: Wed, 5 Sep 2007 17:35:43 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

reading an older poste (http://www.nsa.gov/selinux/list-archive/0610/ 
thread_body16.cfm) I wonder about the difference between tunable and  
an if-else conditional.

<quote>
Tunable_policy are blocks that will be replaced by a similar language  
feature when it becomes available. Tunables will be similar to  
conditionals, except they will be selected during the policy module  
linking instead of being selectable at runtime.
</quote>

Using the latest stable refpolicy (20070629) the feature has already  
changed? I would guess so because I can change the booleans via  
setsebool at runtime.

Looking at the file "loadable_module.spt" the tunable seems to me  
exact the same like a if-else conditional. But I'm not a M4 guy and  
wanted to make sure. Is this right that a tunable and a if-else  
conditional is the same now?

cheers,
Stefan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
