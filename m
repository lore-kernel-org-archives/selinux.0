Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7TI7JvB025705
	for <selinux@tycho.nsa.gov>; Tue, 29 Aug 2006 14:07:19 -0400
Received: from twoface.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7TI70x8012291
	for <selinux@tycho.nsa.gov>; Tue, 29 Aug 2006 18:07:01 GMT
Subject: ipsec and getpeercon()
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux@tycho.nsa.gov
Cc: paul.moore@hp.com
Content-Type: text/plain
Date: Tue, 29 Aug 2006 14:08:01 -0400
Message-Id: <1156874881.6255.5.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm trying to use getpeercon() with a tcp stream socket over an ipsec
host2host connection and it isn't working, it always returns the context
of the local domain/socket:


[root@rawhide-clone ~]# runcon -t passwd_t ./server
server: got connection from 10.1.13.104, root:system_r:passwd_t:s0-s0:c0.c255

[root@rawhide-clone ~]# runcon -t initrc_t ./server
server: got connection from 10.1.13.104, root:system_r:initrc_t:s0-s0:c0.c255

the process connecting is unconfined_t

Am I doing something wrong or is something broken?

if ((new_fd = accept(sockfd, (struct sockaddr *)&their_addr,
                            &sin_size)) == -1) {
    perror("accept");
    continue;
}
if (getpeercon(new_fd, con))
         perror("getpeercon");
}
    printf("server: got connection from %s, %s\n",
                 inet_ntoa(their_addr.sin_addr), con);


I also tried getsockopt(new_fd, SOL_SOCKET, SO_PEERSEC, con, &len)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
