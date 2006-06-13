Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5DK2ug4004496
	for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2006 16:02:56 -0400
Received: from fsjrez04.rome.afmc.ds.af.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5DK2t14005650
	for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2006 20:02:55 GMT
Message-ID: <43055FDD054D464FA7923D0FFAF2C9C7024B1316@fsjrez02.adm.rl.af.mil>
From: "Wightman, Reid K Civ AFRL/IFEB" <Reid.Wightman@rl.af.mil>
To: selinux@tycho.nsa.gov
Subject: RE: selinuxfs
Date: Tue, 13 Jun 2006 16:02:52 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> I suppose a selinuxfs man page might be nice.  
> selinux-doc/README has a brief description at the end of the 
> original set of selinuxfs nodes, but hasn't been kept up to 
> date.  Note that you really aren't supposed to directly 
> operate on the selinuxfs nodes - you should access them 
> indirectly via the libselinux interfaces (using helper utilities as
> appropriate) for portability.

I'm tinkering with some of the libselinux functions right now and getting a
strange error from security_compute_user().  I see that it copies data out
of <selinuxfs>/user .  On my system, this file is 0 bytes (everything is
stock FC5, selinux status is enabled/targeted/permissive, and I just
reloaded the policy).  Is this right?  How do the files here get populated?

Thanks,
Reid

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
