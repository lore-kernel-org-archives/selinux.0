Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MCZfgA004703
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 08:35:41 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MCUuYP002282
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 12:30:56 GMT
Message-ID: <42E0E706.5050903@redhat.com>
Date: Fri, 22 Jul 2005 08:31:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: Iptables discussion
References: <200507212030.j6LKUTvx008177@gotham.columbia.tresys.com>	 <1121978850.15334.2.camel@celtics.boston.redhat.com>	 <42E00E51.7050001@tresys.com>	 <1121979985.15334.5.camel@celtics.boston.redhat.com>	 <42E0105F.9030607@tresys.com>	 <1121981131.15334.13.camel@celtics.boston.redhat.com>	 <42E0310B.5070404@tresys.com> <1122033206.19625.7.camel@localhost.localdomain>
In-Reply-To: <1122033206.19625.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Network Integration with SELinux, stinks from a users point of view.

Lets look at some potential usage scenarios.

User has two network devices (Internal and External)  He wants to allow 
only Apache to listen on the external device, and only communicate via 
LDAP over the internal device?  How would he set that up?  (IF someone 
says he will rewrite policy, I will scream, and then ask you to write 
policy to allow this. ) 

MLS System, wants to have two Apache systems,  One listening at port 80 
for Top Secret communications, another at port 81 for secret.  How do 
you do this?

You want to setup a Zone Transfer between your two named servers.  You 
want to guarantee that named_t on one machine is talking to named_t on 
another machine over an encrypted line? 

I believe the only way for users to do these things successfully is to 
have integration of SELinux with iptables, and no writing/rewriting of 
policy will solve the problem.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
