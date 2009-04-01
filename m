Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n313ghNV002294
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 23:42:43 -0400
Received: from smtp102.prem.mail.sp1.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id n313gg0b012679
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 03:42:43 GMT
Message-ID: <49D2E2A0.5070901@schaufler-ca.com>
Date: Tue, 31 Mar 2009 20:42:24 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Nicolas Williams <Nicolas.Williams@sun.com>
CC: Jarrett Lu <Jarrett.Lu@sun.com>, nfs-discuss@opensolaris.org,
        labeled-nfs@linux-nfs.org, nfsv4@ietf.org, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft posted
 to IETF	website
References: <49CBFB94.6030408@sun.com> <20090327001102.GU9992@Sun.COM> <1238158539.15207.6.camel@localhost.localdomain> <1238160162.15207.19.camel@localhost.localdomain> <49CD06E7.6030802@sun.com> <20090327172632.GA9992@Sun.COM> <49CD2169.3080209@sun.com> <1238434634.2484.90.camel@localhost.localdomain> <49D10FC1.3000103@sun.com> <49D188D6.6020107@schaufler-ca.com> <20090331183445.GH9992@Sun.COM>
In-Reply-To: <20090331183445.GH9992@Sun.COM>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Nicolas Williams wrote:
> On Mon, Mar 30, 2009 at 08:07:02PM -0700, Casey Schaufler wrote:
>   
>> Not to throw a puppy in the gears, but sophisticated handshaking and
>> negotiation protocols are not the answer. We had TSIG session management
>> for doing that and it is just not enough. How would you negotiate the
>> differences between two SELinux policies?
>>     
>
> You don't.  You either establish that they are the same (or that one or
> both peers are translating to a common policy) or that they are not.  In
> the latter case you fail to communicate further.  It seems quite
> reasonable to me to have a single policy for a site -- that seems doable
> for MLS, but for DTE it's more likely that there will be OS-specific
> parts of a site policy, and the potential need to map between existing
> OS-specific policies and something else seems daunting, at least at
> first glance, but I'm an optimist, so I think it must be doable :)
>   

You only get common policy on a single system image. Oh, with MLS
you can limit it to MLS hosts and unlabeled hosts, but you'll always
have at least the two. Even with MLS you'll have machines that are
disallowed each other's levels and/or categories. This situation
had a major impact on the Smack design, where there is no interpretation
of the label at all.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
