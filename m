Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5IHR0rT018684
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 13:27:01 -0400 (EDT)
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: "John D. Ramsdell" <ramsdell@mitre.org>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   guttman@mitre.org (Joshua D. Guttman), aherzog@mitre.org (Amy L. Herzog)
Subject: Re: Fedora Core 2 setools RPM
Reply-To: guttman@mitre.org (Joshua D. Guttman disp: current)
References: <200406171847.i5HIlPSf000906@gotham.columbia.tresys.com>
	<ogtpt7x10ni.fsf@mitre.org>
	<1087567982.27697.47.camel@moss-spartans.epoch.ncsc.mil>
From: guttman@mitre.org (Joshua D. Guttman)
Date: 18 Jun 2004 13:26:52 -0400
In-Reply-To: <1087567982.27697.47.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <nhak6y43hgj.fsf@malabar.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@epoch.ncsc.mil> writes:

>   > I also noticed that it appears that none of the setools documentation
>   > tells users that your flow analysis ignores CONSTRAIN statements in a
>   > policy.  I think users should know this fact.
>   
>   The apol information flow analysis is for flow among types; hence,
>   it is only natural for it to only consider the TE configuration.
>   As a flow can only exist if allowed by the TE configuration,
>   analysis of the TE configuration is sufficient to identify all
>   flows.

May I raise a small question here?  

I can see that analysis of the TE configuration is sufficient to
identify a set of flows that includes all the possible flows among
security contexts.  But if one wants more exact information about the
set of flows among security contexts that are permitted by a
particular configuration, wouldn't one need to consider any
constraints?  

I take it that "flow among types" is a bit less precise than "flow
among security contexts".  Presumably there's flow from t_1 to t_2 if
there exist any u_1,r_1 and u_2,r_2 such that there's flow 

        u_1:r_1:t_1 --> u_2:r_2:t_2.  

Is this an accurate interpretation?

I think it would be great if libapol became a common access point for
many analysis methods to get information about the facts of the
configuration.  This should be easier if we have an agreement on all
the info that could be relevant.  

        Joshua 

 
-- 
	Joshua D. Guttman		<guttman@mitre.org>
	MITRE, Mail Stop S119		Office:	+1 781 271 2654
	202 Burlington Rd.		Fax:	+1 781 271 8953
	Bedford, MA 01730-1420 USA	Cell:	+1 781 526 5713



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
