Subject: Re: ipsec and getpeercon()
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joy Latten <latten@us.ibm.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        paul.moore@hp.com
In-Reply-To: <1156880256.22210.216.camel@moss-spartans.epoch.ncsc.mil>
References: <1156874881.6255.5.camel@twoface.columbia.tresys.com>
	 <1156880256.22210.216.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 15:46:59 -0400
Message-Id: <1156880819.8075.14.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-29 at 15:37 -0400, Stephen Smalley wrote:
> On Tue, 2006-08-29 at 14:08 -0400, Joshua Brindle wrote:
> > I'm trying to use getpeercon() with a tcp stream socket over an ipsec
> > host2host connection and it isn't working, it always returns the context
> > of the local domain/socket:
> > 
> > 
> > [root@rawhide-clone ~]# runcon -t passwd_t ./server
> > server: got connection from 10.1.13.104, root:system_r:passwd_t:s0-s0:c0.c255
> > 
> > [root@rawhide-clone ~]# runcon -t initrc_t ./server
> > server: got connection from 10.1.13.104, root:system_r:initrc_t:s0-s0:c0.c255
> > 
> > the process connecting is unconfined_t
> > 
> > Am I doing something wrong or is something broken?
> 
> You didn't provide much information above.  Kernel version?  ipsec-tools
> version?  racoon version?  ipsec configuration?  setkey -D output?
> setkey -DP output?

Sorry,

Linux rawhide-clone 2.6.17-1.2586.fc6 #1 SMP Thu Aug 24 08:51:22 EDT
2006 i686 i686 i386 GNU/Linux

ipsec-tools.i386                         0.6.5-3.1

[root@rawhide-clone ~]# setkey -D
10.1.13.104 10.1.13.90
        esp mode=transport spi=43920387(0x029e2c03) reqid=0(0x00000000)
        E: 3des-cbc  ed1dd172 479fc39e 699c619d d626a652 9489f426
12bec67e
        A: hmac-sha1  6917f1a2 30a207f8 a1680143 5d490f66 431fd11d
        seq=0x00000000 replay=4 flags=0x00000000 state=mature
        created: Aug 15 11:03:34 2006   current: Aug 15 11:50:10 2006
        diff: 2796(s)   hard: 3600(s)   soft: 2880(s)
        last:                           hard: 0(s)      soft: 0(s)
        current: 0(bytes)       hard: 0(bytes)  soft: 0(bytes)
        allocated: 0    hard: 0 soft: 0
        sadb_seq=3 pid=10324 refcnt=0
10.1.13.104 10.1.13.90
        ah mode=transport spi=232904746(0x0de1d82a) reqid=0(0x00000000)
        A: hmac-sha1  d0cb6f60 9f4ce933 adcee87f 7ff92c05 f850eb35
        seq=0x00000000 replay=4 flags=0x00000000 state=mature
        created: Aug 15 11:03:34 2006   current: Aug 15 11:50:10 2006
        diff: 2796(s)   hard: 3600(s)   soft: 2880(s)
        last:                           hard: 0(s)      soft: 0(s)
        current: 0(bytes)       hard: 0(bytes)  soft: 0(bytes)
        allocated: 0    hard: 0 soft: 0
        sadb_seq=2 pid=10324 refcnt=0
10.1.13.90 10.1.13.104
        esp mode=transport spi=161190146(0x099b9102) reqid=0(0x00000000)
        E: 3des-cbc  0a57f388 64520697 db36d889 f0933005 78ec7d6d
a7d2fd42
        A: hmac-sha1  372a4cec 3035f96f fa3e3e33 85e16efb 85d88ba7
        seq=0x00000000 replay=4 flags=0x00000000 state=mature
        created: Aug 15 11:03:35 2006   current: Aug 15 11:50:10 2006
        diff: 2795(s)   hard: 3600(s)   soft: 2880(s)
        last:                           hard: 0(s)      soft: 0(s)
        current: 0(bytes)       hard: 0(bytes)  soft: 0(bytes)
        allocated: 0    hard: 0 soft: 0
        sadb_seq=1 pid=10324 refcnt=0
10.1.13.90 10.1.13.104
        ah mode=transport spi=135759512(0x08178698) reqid=0(0x00000000)
        A: hmac-sha1  fcccf815 4ba32275 78731b59 20659361 6f7ddf81
        seq=0x00000000 replay=4 flags=0x00000000 state=mature
        created: Aug 15 11:03:34 2006   current: Aug 15 11:50:10 2006
        diff: 2796(s)   hard: 3600(s)   soft: 2880(s)
        last:                           hard: 0(s)      soft: 0(s)
        current: 0(bytes)       hard: 0(bytes)  soft: 0(bytes)
        allocated: 0    hard: 0 soft: 0
        sadb_seq=0 pid=10324 refcnt=0


[root@rawhide-clone ~]# setkey -D
10.1.13.104 10.1.13.90
        esp mode=transport spi=43920387(0x029e2c03) reqid=0(0x00000000)
        E: 3des-cbc  ed1dd172 479fc39e 699c619d d626a652 9489f426
12bec67e
        A: hmac-sha1  6917f1a2 30a207f8 a1680143 5d490f66 431fd11d
        seq=0x00000000 replay=4 flags=0x00000000 state=mature
        created: Aug 15 11:03:34 2006   current: Aug 15 11:50:10 2006
        diff: 2796(s)   hard: 3600(s)   soft: 2880(s)
        last:                           hard: 0(s)      soft: 0(s)
        current: 0(bytes)       hard: 0(bytes)  soft: 0(bytes)
        allocated: 0    hard: 0 soft: 0
        sadb_seq=3 pid=10324 refcnt=0
10.1.13.104 10.1.13.90
        ah mode=transport spi=232904746(0x0de1d82a) reqid=0(0x00000000)
        A: hmac-sha1  d0cb6f60 9f4ce933 adcee87f 7ff92c05 f850eb35
        seq=0x00000000 replay=4 flags=0x00000000 state=mature
        created: Aug 15 11:03:34 2006   current: Aug 15 11:50:10 2006
        diff: 2796(s)   hard: 3600(s)   soft: 2880(s)
        last:                           hard: 0(s)      soft: 0(s)
        current: 0(bytes)       hard: 0(bytes)  soft: 0(bytes)
        allocated: 0    hard: 0 soft: 0
        sadb_seq=2 pid=10324 refcnt=0
10.1.13.90 10.1.13.104
        esp mode=transport spi=161190146(0x099b9102) reqid=0(0x00000000)
        E: 3des-cbc  0a57f388 64520697 db36d889 f0933005 78ec7d6d
a7d2fd42
        A: hmac-sha1  372a4cec 3035f96f fa3e3e33 85e16efb 85d88ba7
        seq=0x00000000 replay=4 flags=0x00000000 state=mature
        created: Aug 15 11:03:35 2006   current: Aug 15 11:50:10 2006
        diff: 2795(s)   hard: 3600(s)   soft: 2880(s)
        last:                           hard: 0(s)      soft: 0(s)
        current: 0(bytes)       hard: 0(bytes)  soft: 0(bytes)
        allocated: 0    hard: 0 soft: 0
        sadb_seq=1 pid=10324 refcnt=0
10.1.13.90 10.1.13.104
        ah mode=transport spi=135759512(0x08178698) reqid=0(0x00000000)
        A: hmac-sha1  fcccf815 4ba32275 78731b59 20659361 6f7ddf81
        seq=0x00000000 replay=4 flags=0x00000000 state=mature
        created: Aug 15 11:03:34 2006   current: Aug 15 11:50:10 2006
        diff: 2796(s)   hard: 3600(s)   soft: 2880(s)
        last:                           hard: 0(s)      soft: 0(s)
        current: 0(bytes)       hard: 0(bytes)  soft: 0(bytes)
        allocated: 0    hard: 0 soft: 0
        sadb_seq=0 pid=10324 refcnt=0


> 
> > 
> > if ((new_fd = accept(sockfd, (struct sockaddr *)&their_addr,
> >                             &sin_size)) == -1) {
> >     perror("accept");
> >     continue;
> > }
> > if (getpeercon(new_fd, con))
> >          perror("getpeercon");
> > }
> >     printf("server: got connection from %s, %s\n",
> >                  inet_ntoa(their_addr.sin_addr), con);
> > 
> > 
> > I also tried getsockopt(new_fd, SOL_SOCKET, SO_PEERSEC, con, &len)
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
