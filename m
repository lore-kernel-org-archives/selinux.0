Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5MIwclM022136
	for <selinux@tycho.nsa.gov>; Thu, 22 Jun 2006 14:58:38 -0400
Received: from mail2.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5MIwaZA005384
	for <selinux@tycho.nsa.gov>; Thu, 22 Jun 2006 18:58:36 GMT
Date: Thu, 22 Jun 2006 14:58:33 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Steve Grubb <sgrubb@redhat.com>
cc: David Miller <davem@davemloft.net>, paul.moore@hp.com,
        redhat-lspp@redhat.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        sds@epoch.ncsc.mil, jmorris@redhat.com
Subject: Re: [RFC 2/7] NetLabel: core network changes
In-Reply-To: <200606221105.00331.sgrubb@redhat.com>
Message-ID: <Pine.LNX.4.64.0606221457520.21897@d.namei>
References: <20060621194234.979661000@flek.zko.hp.com>
 <20060621200030.880930000@flek.zko.hp.com> <20060622.020055.115910616.davem@davemloft.net>
 <200606221105.00331.sgrubb@redhat.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="537530981-932703160-1151002713=:21897"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--537530981-932703160-1151002713=:21897
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 22 Jun 2006, Steve Grubb wrote:

> On Thursday 22 June 2006 05:00, David Miller wrote:
> > >  #define NETLINK_GENERIC              16
> > > +#define NETLINK_NETLABEL     17      /* Network packet labeling */
> > >  
> > >  #define MAX_LINKS 32         
> >
> > Please use generic netlink.
> 
> Since this is a security interface, shouldn't it be its own protocol so that 
> SE Linux can control commands being sent? Paul's patches do include a netlink 
> table in security/selinux/nlmsgtab.c. But I do not see any hooks to control 
> generic netlink messages. (There seems to be several protocols that SE Linux 
> is not controlling.) I could see that someone in secadm role should be able 
> to issue these commands, but someone at sysadm or auditadm would not.
> 
> If moving this over to generic is a must, then I think SE Linux will have to 
> clip into generic to control its packet flow.

SELinux will mediate them as 'generic' netlink.

Fine-grained SELinux support for generic netlink is todo.



-- 
James Morris
<jmorris@namei.org>
--537530981-932703160-1151002713=:21897--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
