Subject: Re: tcpdump
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200304132007.45102.russell@coker.com.au>
References: <200304132007.45102.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1050415152.16051.82.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Apr 2003 10:09:58 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-04-13 at 06:07, Russell Coker wrote:
> I just tried using a machine as a router when it didn't have the correct SE 
> policy for network access.
> I get messages such as the following:
> avc:  denied  { rawip_send } for  saddr=210.49.228.68 daddr=61.95.69.3 
> netif=eth0 scontext=system_u:object_r:netmsg_eth1_t 
> tcontext=system_u:object_r:netif_eth0_t tclass=netif
> AVC: 4 messages suppressed.

This indicates that a packet that was received on eth1 (and hence
labeled netmsg_eth1_t by default) is being sent on eth0, and the send on
eth0 is being denied.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
