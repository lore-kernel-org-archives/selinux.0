Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6KIQWMt004384
	for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2009 14:26:34 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n6KIQ973011480
	for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2009 18:26:09 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n6KIQVXU028896
	for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2009 14:26:31 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n6KIQU93022150
	for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2009 14:26:30 -0400
Received: from [10.16.3.86] (dhcp-100-3-86.bos.redhat.com [10.16.3.86])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n6KIQTLH013831
	for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2009 14:26:29 -0400
Message-ID: <4A64B6D4.6070205@redhat.com>
Date: Mon, 20 Jul 2009 14:26:28 -0400
From: Christopher Pardy <cpardy@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: adding human understandable, and translatable description support
 to selinux
References: <4A648075.3090402@redhat.com> <1248110839.23783.721.camel@gorn>	 <4A64ADA3.6020105@redhat.com> <1248114027.23783.725.camel@gorn>
In-Reply-To: <1248114027.23783.725.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> 
> Did you forget to do reply to all?
> 

yes!

If that's the best way to go fine, however the xml file is only
generated when I acutually compile the modules if I install a module
through semanage any data that module adds will be left out. I
certainly wouldn't be opposed to extending policy.xml as part of this
but there needs to be a way for installed modules to work too.
Additionally if we're going to continue the trend of using policy.xml
for management rather than development we really should move it.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
