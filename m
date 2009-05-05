Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n45JQfBs015958
	for <selinux@tycho.nsa.gov>; Tue, 5 May 2009 15:26:41 -0400
Received: from mailhub4.stratus.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n45JQci8001989
	for <selinux@tycho.nsa.gov>; Tue, 5 May 2009 19:26:40 GMT
Subject: Using interfaces defined elsewhere
From: Bandan Das <bandan.das@stratus.com>
To: selinux <selinux@tycho.nsa.gov>
Cc: "Johnson, Richard" <Richard.Johnson@stratus.com>
Content-Type: text/plain
Date: Tue, 05 May 2009 15:25:56 -0400
Message-Id: <1241551556.23813.80.camel@BSD.mno.stratus.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Here's what I am trying to do :

I have a mySNMP policy with sources: mysnmp.te mysnmp.fc mysnmp.if and a
dummyapp policy with sources: dummyapp.te dummyapp.fc and dummyapp.if.
The SNMP policy interface file has an interface called
mysnmp_config_read_access() and I would like to use it in my dummyapp
policy sources : mysnmp_config_read_access(dummyapp_t)

What's the best way to do this ? Not just for the above example for a
case where I have multiple custom interface files. 

I tried copying the SNMP interface file
to /usr/share/selinux/include/mysnmp. But the problem with this approach
is that I have to be root to be able to do this. Can I ask make to use
multiple interface files (dummyapp.if and mysnmp.if) when compiling the
dummyapp policy module ? 

Thanks,
Bandan

 
-- 
BSD


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
