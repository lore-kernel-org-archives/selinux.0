Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k92FXTss014091
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 11:33:29 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k92FWKgt020708
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 15:32:20 GMT
Subject: Re: Default Mikefile in /usr/share/selinux/devel not nice
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45212E39.9080105@us.ibm.com>
References: <451D8C2F.9040901@us.ibm.com>
	 <1159590751.12161.10.camel@gorn.pebenito.net> <45212E39.9080105@us.ibm.com>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 11:33:24 -0400
Message-Id: <1159803204.14831.34.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-10-02 at 10:20 -0500, Michael C Thompson wrote:
> Chris PeBenito wrote:
> > On Fri, 2006-09-29 at 16:12 -0500, Michael C Thompson wrote:
> >> I just discovered a nasty surprise waiting for me in the default 
> >> Makefile provided by selinux-policy-devel.
> >>
> >> Basically, the Makefile produces, on an MLS system, a TYPE value of 
> >> mls-msc (this is due to the SELINUXTYPE=mls line in 
> >> /etc/selinux/config). This will not 'enable_mls' for the M4FLAGS, 
> >> because the Makefile in /usr/share/selinux/devel/include/ does a 
> >> findstring for '-mls'.
> >>
> >> Dan Walsh has suggested a fix for the default Makefile, but I'm 
> >> wondering why we can't just change 
> >> /usr/share/selinux/devel/include/Makefile to do a $(findstring 
> >> mls,$TYPE)) instead, since its not unreasonable to think that TYPE=mls 
> >> makes sense.
> > 
> > There is some confusion here, the SELINUXTYPE is not the same as TYPE in
> > refpolicy, it is NAME in refpolicy.  The TYPE of the Redhat MLS policy
> > is strict-mls.  TYPE=mls does not make sense, since it does not specify
> > if the policy is strict or targeted.
> 
> Are there flags (like 'enable_mls') in the policy which require this 
> delineation?

Yes, strict_policy and targeted_policy.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
