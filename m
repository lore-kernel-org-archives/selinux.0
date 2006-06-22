Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5MF5fRn016595
	for <selinux@tycho.nsa.gov>; Thu, 22 Jun 2006 11:05:41 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5MF5bue014853
	for <selinux@tycho.nsa.gov>; Thu, 22 Jun 2006 15:05:39 GMT
From: Steve Grubb <sgrubb@redhat.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [RFC 2/7] NetLabel: core network changes
Date: Thu, 22 Jun 2006 11:05:00 -0400
Cc: paul.moore@hp.com, redhat-lspp@redhat.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        sds@epoch.ncsc.mil, jmorris@redhat.com
References: <20060621194234.979661000@flek.zko.hp.com> <20060621200030.880930000@flek.zko.hp.com> <20060622.020055.115910616.davem@davemloft.net>
In-Reply-To: <20060622.020055.115910616.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606221105.00331.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 22 June 2006 05:00, David Miller wrote:
> >  #define NETLINK_GENERIC              16
> > +#define NETLINK_NETLABEL     17      /* Network packet labeling */
> >  
> >  #define MAX_LINKS 32         
>
> Please use generic netlink.

Since this is a security interface, shouldn't it be its own protocol so that 
SE Linux can control commands being sent? Paul's patches do include a netlink 
table in security/selinux/nlmsgtab.c. But I do not see any hooks to control 
generic netlink messages. (There seems to be several protocols that SE Linux 
is not controlling.) I could see that someone in secadm role should be able 
to issue these commands, but someone at sysadm or auditadm would not.

If moving this over to generic is a must, then I think SE Linux will have to 
clip into generic to control its packet flow.

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
