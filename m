Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5IIi2rT019203
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 14:44:03 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5IIhqpw011332
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 18:43:53 GMT
Subject: Re: Fedora Core 2 setools RPM
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Joshua D. Guttman disp: current" <guttman@mitre.org>
Cc: "John D. Ramsdell" <ramsdell@mitre.org>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   Amy L Herzog <aherzog@mitre.org>
In-Reply-To: <nhafz8s3f2y.fsf@malabar.mitre.org>
References: <200406171847.i5HIlPSf000906@gotham.columbia.tresys.com>
	 <ogtpt7x10ni.fsf@mitre.org>
	 <1087567982.27697.47.camel@moss-spartans.epoch.ncsc.mil>
	 <nhak6y43hgj.fsf@malabar.mitre.org>
	 <1087581080.27697.132.camel@moss-spartans.epoch.ncsc.mil>
	 <nhafz8s3f2y.fsf@malabar.mitre.org>
Content-Type: text/plain
Message-Id: <1087584215.27697.173.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 18 Jun 2004 14:43:35 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-06-18 at 14:18, Joshua D. Guttman wrote:
> Really?  Consider the case r_1=r_2, where the role-type relation
> permits r_1 to execute with type t_1 but not with type t_2.  If the
> arrow is created by an execve_secure, then isn't it important for the
> policy to prevent this event?  
> 
> Whereas with some powerful role r_3, permitted to execute with types
> t_1 and t_2, the event should be permitted.

A dangerous game, as I've noted previously.  If the TE configuration
allows a transition from t_1 to t_2, then even if r_1 is not allowed to
enter t_2 by the role-type relation, a r_1:t_1 process may be able to
influence a r_3:t_2 process due to the set of permissions granted
between t_1 and t_2 to support the r_3:t_1 -> r_3:t_2 transition and
subsequent operation.

A more realistic case is newrole.  user_t -> newrole_t -> sysadm_t is an
allowed series of domain transitions, and the only thing preventing
jdoe:user_r:user_t from using newrole to get to sysadm_t is the fact
that jdoe is restricted to user_r and user_r is restricted to user_t by
the kernel policy.  But from an information flow perspective, you simply
want to prove that user_t can only reach sysadm_t through specific gate
domains like newrole_t.

> Are you saying that you don't think policy analysis should be
> sensitive to these questions?  (Ever?)

At most, as a refinement of a basic analysis of the TE configuration. 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
