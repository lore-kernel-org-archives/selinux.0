Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5IHpYrT018873
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 13:51:34 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5IHpVrD002620
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 17:51:31 GMT
Subject: Re: Fedora Core 2 setools RPM
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Joshua D. Guttman disp: current" <guttman@mitre.org>
Cc: "John D. Ramsdell" <ramsdell@mitre.org>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   Amy L Herzog <aherzog@mitre.org>
In-Reply-To: <nhak6y43hgj.fsf@malabar.mitre.org>
References: <200406171847.i5HIlPSf000906@gotham.columbia.tresys.com>
	 <ogtpt7x10ni.fsf@mitre.org>
	 <1087567982.27697.47.camel@moss-spartans.epoch.ncsc.mil>
	 <nhak6y43hgj.fsf@malabar.mitre.org>
Content-Type: text/plain
Message-Id: <1087581080.27697.132.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 18 Jun 2004 13:51:20 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-06-18 at 13:26, Joshua D. Guttman wrote:
> I can see that analysis of the TE configuration is sufficient to
> identify a set of flows that includes all the possible flows among
> security contexts.  But if one wants more exact information about the
> set of flows among security contexts that are permitted by a
> particular configuration, wouldn't one need to consider any
> constraints?  

User identity and role seem largely irrelevant when it comes to
analyzing information flow in the system; that is essentially controlled
by the TE policy (and if MLS were enabled, by their combination).  At
most, I would incorporate constraints and other factors (e.g. role allow
rules) as a refinement _after_ determining the set of flows based on
types; constructing a complete graph among entire security contexts
seems costly and unnecessary.  And I don't think you want user identity
in the picture at all, as it just adds noise.

> I take it that "flow among types" is a bit less precise than "flow
> among security contexts".  Presumably there's flow from t_1 to t_2 if
> there exist any u_1,r_1 and u_2,r_2 such that there's flow 
> 
>         u_1:r_1:t_1 --> u_2:r_2:t_2.  
> 
> Is this an accurate interpretation?

If there is a flow from t_1 to t_2 in the TE policy, but no
corresponding flow among contexts that include t_1 and t_2 in the
policy, then that is likely a bug in the policy.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
