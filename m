Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1MMWXZ3023911
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2011 17:32:38 -0500
Received: from tcsfw1.trustedcs.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p1MMWb8e019139
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2011 22:32:37 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: I want to add the following to mcs constraints in SELinux policy
Date: Tue, 22 Feb 2011 17:32:40 -0500
Message-ID: <170D6ABBBA770349AA49582A86FCED1503A84572@HAVOC.tcs-sec.com>
In-Reply-To: <4D642363.6050403@redhat.com>
References: <4D642363.6050403@redhat.com>
From: <chanson@TrustedCS.com>
To: <dwalsh@redhat.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 
> 
> mlsconstrain { tcp_socket udp_socket rawip_socket } node_bind
> 	(( h1 dom h2 ) or ( t1 == mcsnetwrite ));
> 
> 
> For some reason we do not do this in MLS policy.  Does anyone 
> know why we don't do this for MLS?
> 

I believe it is because we didn't make ports in MLS labeled objects. On
other trusted network implementations, there was the idea of
polyinstantiated ports so every label could always have one. We didn't
do that on Linux, we just allow the port access to be first come, first
serve and let TE instead of MLS define what application should be using
the port. There could be connections coming into to the port at multiple
levels if application is a trusted service and has the ability to talk
to each of the clients. 

-Chad
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
