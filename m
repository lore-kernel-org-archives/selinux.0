Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3171BhX021669
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 03:01:11 -0400
Received: from tundra.namei.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3171AXa015332
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 07:01:10 GMT
Date: Wed, 1 Apr 2009 17:58:38 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Jarrett Lu <Jarrett.Lu@sun.com>
cc: Nicolas Williams <Nicolas.Williams@sun.com>, labeled-nfs@linux-nfs.org,
        nfs-discuss@opensolaris.org, selinux@tycho.nsa.gov, nfsv4@ietf.org
Subject: Re: [Labeled-nfs] [nfsv4] New MAC label support Internet Draft posted
 to IETF website
In-Reply-To: <49D2E073.3060003@sun.com>
Message-ID: <alpine.LRH.2.00.0904011751320.21948@tundra.namei.org>
References: <20090327001102.GU9992@Sun.COM> <1238158539.15207.6.camel@localhost.localdomain> <1238160162.15207.19.camel@localhost.localdomain> <49CD06E7.6030802@sun.com> <20090327172632.GA9992@Sun.COM> <49CD2169.3080209@sun.com> <1238434634.2484.90.camel@localhost.localdomain>
 <49D10FC1.3000103@sun.com> <1238447664.2484.119.camel@localhost.localdomain> <49D1B133.3010907@sun.com> <20090331182851.GG9992@Sun.COM> <49D2E073.3060003@sun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 31 Mar 2009, Jarrett Lu wrote:

> I'm in general agreement with you on this. I am not sure to what extent 
> the extensibility stuff makes sense, e.g. how much may be enough? I 
> guess we need to study more use scenarios. I suspect TE systems may have 
> more challenges in this area, just because security policies on TE 
> systems tend to be more flexible. For example, how many things are 
> critical in order to translate label correctly, OS version, vendor, 
> label parser, security policy file? How likely DTE systems are 
> configured with exact same policy files? Does it make sense that a 
> (harmless) update to security policy file causes label translation 
> failures from that point on?

With SELinux systems, policies do not need to be identical to be 
considered part of the same DOI.  Generally, labels need to remain 
semantically equivalent (i.e. mean the same thing on each system), and the 
policies need to be managed within the same administrative boundary. 
Systems may restrict which labels they'll interpret from remote systems 
(similar to root_squash).


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
