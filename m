Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8EDoEIA003421
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 09:50:14 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8EDnMg7006123
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 13:49:22 GMT
Message-ID: <45095E10.2020205@tresys.com>
Date: Thu, 14 Sep 2006 09:50:08 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ipsec, netlabels, secmark- How about a little usability?
References: <45095092.6080603@redhat.com>
In-Reply-To: <45095092.6080603@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> We have been having some meetings to discuss how we can use this stuff 
> in the real world (IE Non MLS), and I think the current implementation 
> is coming up short.  The discussions I have seen have talked about 
> using getpeercon to look at the other end of the connections, but this 
> is not in the spirit of SELinux where modification of the applications 
> should not be necessary to secure the environment.
>

I disagree, the conversations for these things are centered around 
security aware apps (eg., I'm talking about it because of policy server)

>
> Lets look at some real world situations where having better controls 
> on the network would work and someone explain to me how Joe Average 
> SysAdmin will set them up.
>
the world is bigger than you think it seems..

>
> 1.  By default httpd has to be able to talk to itself in order to do 
> gracefull shutdown,
> service httpd graceful.
>
> So I end up adding a rule allowing httpd to name_connect to the 
> httpd_port_t.    But I really only want to allow this for localhost.  
> IE I don't want to allow my httpd to name_connect to other machines 
> httpd ports?  I can't do this now.
>
you can with secmark can't you?
iptables -I -p tcp -d localhost -s localhost -i lo --dport 80 -j SECMARK 
--selctx system_u:object_r:httpd_client_packet_t


> 2.  I as a sysadm have setup a apache web site that allows connections 
> from the outside and needs to connect to three mysql servers on my 
> internal network. So I need to allow it to connect to those three 
> machines on the internal network only.  How am I as the Sysadm going 
> to set this up.
>
again, secmark

> 3.  I want to setup two machines in my environment with bind running 
> on them.  One, Machine A,  is a bind master the other, Machine B,  is 
> a bind slave.  I want to allow bind zone transfer from Machine A to 
> Machine B, but I want to guarantee that the process kicking off the 
> zone transfer on Machine A is running as named_t and the process 
> receiving the zone transfer on Machine B is running as named_t. How do 
> I do that?
>
It sounds like bind might need to be modified to read an ipsec socket 
label and then you'll add spd rules to both machines. Not sure how you 
expect bind to treat some connections as special without modifying it.

> 4.  I have a machine that is running two bind domains, one on my 
> internal network needs to listen on eth0, the other on the externel 
> network needs to listen on eth1.  How do I set this up?
>
this would require 2 bind domains.. non-trivial right now unfortunately.

> =======================================================
>
> If someone was to pass a law and make me the King of SELinux, The way 
> this would happen is that iptables would be extended to add a -t 
> SecurityContext flag, which I then could simple SELinux rules to set 
> this up in a lanquage that most Sysadmins of Linux boxes could readily 
> understand.
umm, -j SECMARK --selctx?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
