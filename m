Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA05924
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2001 18:30:46 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA12032
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2001 23:30:28 GMT
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by jazzswing.ncsc.mil  with ESMTP id XAA12026
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2001 23:30:27 GMT
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA09936
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2001 15:29:35 -0800 (PST)
	mail_from (casey@sgi.com)
Received: from sgi.com (sgigate.sgi.com [198.29.75.75])
	by cthulhu.engr.sgi.com (SGI-8.9.3/8.9.3) with ESMTP id PAA82929
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2001 15:30:38 -0800 (PST)
Message-ID: <3A95A11E.FEB392B5@sgi.com>
Date: Thu, 22 Feb 2001 15:30:38 -0800
From: Casey Schaufler <casey@sgi.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: questions...
References: <Pine.SOL.3.95.1010222142757.25226A-100000@clipper.gw.tislabs.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Stephen Smalley wrote:
> 
> On Thu, 22 Feb 2001, Casey Schaufler wrote:
> 
> > I guess I'm a little slow today. How would having MAC access
> > superceding DAC access be anything like the capabilities scheme?
> 
> See Spence Minear's paper at
> http://www.bsdcon.org/proceedings/spencer_minear/example_of_secure_bsd_os.ps
> for a discussion of the parallels between Type Enforcement and POSIX.1e
> capabilities.  In the DTOS system, Type Enforcement was used both
> to identify subjects that could override MLS restrictions and to
> identify subjects that could override Unix DAC restrictions.  At the
> same time, Type Enforcement was used to strictly limit such subjects
> to least privilege.  Their ability to override such restrictions
> could be limited to a particular set of objects since the rules
> are based on domain-type pairs.

OKay, I get it now. I keep forgetting that you're replacing
the entire access control scheme.

A claim that MAC affects DAC like Capabilities gives me
a certain amount of discomfort. Tranditionally, You gots
yer DAC, you gots yer MAC, and you gots yer Capabilities
and you could remove any one without changing the behavior
of the others. This is the way it's speced in the POSIX1e
scheme, and the way it's implemented in Irix. To quote
an old co-worker, "the mixed metaphore never boils".
To provide interactions between a DAC policy and a MAC
policy may be useful, but it's neither fish nor fowl
at that point. If you are going to have a policy which
is based on a label and on a user id you may have
something good, but you ain't got a [DM]AC policy.

-- 

Casey Schaufler				Manager, Trust Technology, SGI
casey@sgi.com				voice: 650.933.1634
casey_p@pager.sgi.com			Pager: 888.220.0607

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
