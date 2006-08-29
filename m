Subject: Re: ipsec and getpeercon()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Joy Latten <latten@us.ibm.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        paul.moore@hp.com
In-Reply-To: <1156874881.6255.5.camel@twoface.columbia.tresys.com>
References: <1156874881.6255.5.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 15:37:36 -0400
Message-Id: <1156880256.22210.216.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-29 at 14:08 -0400, Joshua Brindle wrote:
> I'm trying to use getpeercon() with a tcp stream socket over an ipsec
> host2host connection and it isn't working, it always returns the context
> of the local domain/socket:
> 
> 
> [root@rawhide-clone ~]# runcon -t passwd_t ./server
> server: got connection from 10.1.13.104, root:system_r:passwd_t:s0-s0:c0.c255
> 
> [root@rawhide-clone ~]# runcon -t initrc_t ./server
> server: got connection from 10.1.13.104, root:system_r:initrc_t:s0-s0:c0.c255
> 
> the process connecting is unconfined_t
> 
> Am I doing something wrong or is something broken?

You didn't provide much information above.  Kernel version?  ipsec-tools
version?  racoon version?  ipsec configuration?  setkey -D output?
setkey -DP output?

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

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
