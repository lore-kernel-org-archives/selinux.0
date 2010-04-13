Subject: Re: MLS telnet question
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Benedict, Phillip M" <phillip.m.benedict@lmco.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <6235CF4DC66FD5478F0E350E17C202FF251F2BB146@HVXMSP3.us.lmco.com>
References: <6235CF4DC66FD5478F0E350E17C202FF251F2BB146@HVXMSP3.us.lmco.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Apr 2010 12:18:02 -0400
Message-Id: <1271175482.9577.7.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-04-09 at 08:02 -0400, Benedict, Phillip M wrote:
>  
> 
> Hello,
> 
>  
> 
> I am trying to come to a solution regarding the use of telnet on our
> MLS system. ( I know, … the decision to use it was made above me ) . L
> 
>  
> 
> What we have is a RHEL 5.3 system with the RedHat MLS policy
> installed. 
> 
> The system has multiple physical NICs attached to different networks.
> 
> Each network is designated for it’s own sensitivity level. ( so we
> might have one network for s1:c20, one for s2:c40 etc…)
> 
> User accounts are created with sensitivity labeling via semange. ( so
> we might have: user1 with s1:c20, and user2 with s2:c40 etc… )
> 
> The network does not carry any cipso data for evaluation by my server,
> so I don’t think I can use netlabel. 
> 
>  
> 
> Questions:
> 
> If I use IPTables/SECMARK to apply sensitivity labels to the packets
> as they come into the system, will xinetd spawn the telnet session
> with a matching sensitivity?  ( currently the telnet sessions are
> spawned at SystemLow-SystemHigh )

No.  iptables/secmark labels are only used for access control checks;
they are not "peer contexts" unlike NetLabel or labeled IPSEC.

xinetd.conf does have a LABELED flag that can be used to cause a tcp
non-waiting service to be created in the same context as the connecting
client, but that will only work if using a labeled networking mechanism
like NetLabel or labeled IPSEC.

> If telnet is spawned with the appropriate sensitivity, will SELinux
> disallow a users login who do not have  a matching sensitivity?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
