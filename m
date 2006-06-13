Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5DMLtYK006693
	for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2006 18:21:55 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k5DMLs16022688
	for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2006 22:21:54 GMT
Message-ID: <448F3A93.60203@gentoo.org>
Date: Tue, 13 Jun 2006 18:22:11 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: "Wightman, Reid K Civ AFRL/IFEB" <Reid.Wightman@rl.af.mil>
CC: selinux@tycho.nsa.gov
Subject: Re: selinuxfs
References: <43055FDD054D464FA7923D0FFAF2C9C7024B1316@fsjrez02.adm.rl.af.mil>
In-Reply-To: <43055FDD054D464FA7923D0FFAF2C9C7024B1316@fsjrez02.adm.rl.af.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Wightman, Reid K Civ AFRL/IFEB wrote:
>   
>> I suppose a selinuxfs man page might be nice.  
>> selinux-doc/README has a brief description at the end of the 
>> original set of selinuxfs nodes, but hasn't been kept up to 
>> date.  Note that you really aren't supposed to directly 
>> operate on the selinuxfs nodes - you should access them 
>> indirectly via the libselinux interfaces (using helper utilities as
>> appropriate) for portability.
>>     
>
> I'm tinkering with some of the libselinux functions right now and getting a
> strange error from security_compute_user().  I see that it copies data out
> of <selinuxfs>/user .  On my system, this file is 0 bytes (everything is
> stock FC5, selinux status is enabled/targeted/permissive, and I just
> reloaded the policy).  Is this right?  How do the files here get populated?
>
>   
see security/selinux/selinuxfs.c

its a pseudo filesystem like /proc which has callbacks in the kernel 
when the file is read or written to.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
