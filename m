Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MEuxgA006114
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 10:56:59 -0400 (EDT)
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MEpOKk002369
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 14:51:25 GMT
Message-ID: <36282A1733C57546BE392885C06185920572EB@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: "'Karl MacMillan '" <kmacmillan@tresys.com>,
   "''Daniel J Walsh' '"
	 <dwalsh@redhat.com>,
   "'gyurdiev@redhat.com '" <gyurdiev@redhat.com>
Cc: "''Joshua Brindle' '" <jbrindle@tresys.com>,
   "'selinux@tycho.nsa.gov '"
	 <selinux@tycho.nsa.gov>
Subject: RE: Iptables discussion
Date: Fri, 22 Jul 2005 10:54:07 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> 
>> MLS System, wants to have two Apache systems,  One listening at port 80
>> for Top Secret communications, another at port 81 for secret.  How do
>> you do this?
>> 
>
>I know that this is just a motivating example, but I feel compelled to
>point out that 1) this problem is not really related to MLS in the real
>world and 2) separation based on ports is _very_ unlikely to meet the
>requirements of a system that will be processing data at different
>sensitivities.
>

Common MLS networking uses are having at least 2 interfaces, these
interfaces have different MLS labels. Also nodes/networks are given MLS
labels to tie together their usage on an interface.  

A simple web server example for say label unclass and confidential  would
want to make sure that those servers no matter which port they listen, only
communicate to nodes or the same label across an interface of the same label
as well. 

A client example of a web browser is the same. If you are unclass, the
browser should only communicate to unclass nodes and interfaces.  

iptables is complimentary and essential to solutions as it does the needed
filtering. 

-Chad

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
