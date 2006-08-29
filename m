Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7TJSc3f028750
	for <selinux@tycho.nsa.gov>; Tue, 29 Aug 2006 15:28:38 -0400
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7TJSJx8024174
	for <selinux@tycho.nsa.gov>; Tue, 29 Aug 2006 19:28:20 GMT
Message-ID: <44F49564.30904@hp.com>
Date: Tue, 29 Aug 2006 15:28:36 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: ipsec and getpeercon()
References: <1156874881.6255.5.camel@twoface.columbia.tresys.com>
In-Reply-To: <1156874881.6255.5.camel@twoface.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> I'm trying to use getpeercon() with a tcp stream socket over an ipsec
> host2host connection and it isn't working, it always returns the context
> of the local domain/socket:

This may not help you, but I did a quick test using both the current
rawhide kernel as well as David Miller's net-2.6.19 git tree (with the
patchset I posted earlier applied) using NetLabel/CIPSO and everything
worked as expected, i.e. the MLS label of the context was correct.

> [root@rawhide-clone ~]# runcon -t passwd_t ./server
> server: got connection from 10.1.13.104, root:system_r:passwd_t:s0-s0:c0.c255
> 
> [root@rawhide-clone ~]# runcon -t initrc_t ./server
> server: got connection from 10.1.13.104, root:system_r:initrc_t:s0-s0:c0.c255
> 
> the process connecting is unconfined_t
> 
> Am I doing something wrong or is something broken?
> 
> if ((new_fd = accept(sockfd, (struct sockaddr *)&their_addr,
>                             &sin_size)) == -1) {
>     perror("accept");
>     continue;
> }
> if (getpeercon(new_fd, con))
>          perror("getpeercon");
> }
>     printf("server: got connection from %s, %s\n",
>                  inet_ntoa(their_addr.sin_addr), con);
> 
> 
> I also tried getsockopt(new_fd, SOL_SOCKET, SO_PEERSEC, con, &len)
> 

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
