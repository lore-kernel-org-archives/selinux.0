Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8ECqYkw001449
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 08:52:34 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8ECpfg7026364
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 12:51:41 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k8ECqXSG007401
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 08:52:33 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k8ECqWNt017608
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 08:52:33 -0400
Received: from [172.16.83.40] (dhcp83-40.boston.redhat.com [172.16.83.40])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id k8ECqWY9020087
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 08:52:32 -0400
Message-ID: <45095092.6080603@redhat.com>
Date: Thu, 14 Sep 2006 08:52:34 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: ipsec, netlabels, secmark- How about a little usability?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We have been having some meetings to discuss how we can use this stuff 
in the real world (IE Non MLS), and I think the current implementation 
is coming up short.  The discussions I have seen have talked about using 
getpeercon to look at the other end of the connections, but this is not 
in the spirit of SELinux where modification of the applications should 
not be necessary to secure the environment.


Lets look at some real world situations where having better controls on 
the network would work and someone explain to me how Joe Average 
SysAdmin will set them up.


1.  By default httpd has to be able to talk to itself in order to do 
gracefull shutdown,
service httpd graceful.

So I end up adding a rule allowing httpd to name_connect to the 
httpd_port_t.    But I really only want to allow this for localhost.  IE 
I don't want to allow my httpd to name_connect to other machines httpd 
ports?  I can't do this now.

2.  I as a sysadm have setup a apache web site that allows connections 
from the outside and needs to connect to three mysql servers on my 
internal network. So I need to allow it to connect to those three 
machines on the internal network only.  How am I as the Sysadm going to 
set this up.

3.  I want to setup two machines in my environment with bind running on 
them.  One, Machine A,  is a bind master the other, Machine B,  is a 
bind slave.  I want to allow bind zone transfer from Machine A to 
Machine B, but I want to guarantee that the process kicking off the zone 
transfer on Machine A is running as named_t and the process receiving 
the zone transfer on Machine B is running as named_t. 
How do I do that?

4.  I have a machine that is running two bind domains, one on my 
internal network needs to listen on eth0, the other on the externel 
network needs to listen on eth1.  How do I set this up?

=======================================================

If someone was to pass a law and make me the King of SELinux, The way 
this would happen is that iptables would be extended to add a -t 
SecurityContext flag, which I then could simple SELinux rules to set 
this up in a lanquage that most Sysadmins of Linux boxes could readily 
understand.





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
