Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5IIIWrT019016
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 14:18:33 -0400 (EDT)
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: "John D. Ramsdell" <ramsdell@mitre.org>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   Amy L Herzog <aherzog@mitre.org>, guttman@mitre.org (Joshua D. Guttman)
Subject: Re: Fedora Core 2 setools RPM
Reply-To: guttman@mitre.org (Joshua D. Guttman disp: current)
References: <200406171847.i5HIlPSf000906@gotham.columbia.tresys.com>
	<ogtpt7x10ni.fsf@mitre.org>
	<1087567982.27697.47.camel@moss-spartans.epoch.ncsc.mil>
	<nhak6y43hgj.fsf@malabar.mitre.org>
	<1087581080.27697.132.camel@moss-spartans.epoch.ncsc.mil>
From: guttman@mitre.org (Joshua D. Guttman)
Date: 18 Jun 2004 14:18:13 -0400
In-Reply-To: <1087581080.27697.132.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <nhafz8s3f2y.fsf@malabar.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@epoch.ncsc.mil> writes:

>   
>   > I take it that "flow among types" is a bit less precise than
>   > "flow among security contexts".  Presumably there's flow from
>   > t_1 to t_2 if there exist any u_1,r_1 and u_2,r_2 such that
>   > there's flow
>   > 
>   >         u_1:r_1:t_1 --> u_2:r_2:t_2.  
>   > 
>   > Is this an accurate interpretation?
>   
>   If there is a flow from t_1 to t_2 in the TE policy, but no
>   corresponding flow among contexts that include t_1 and t_2 in the
>   policy, then that is likely a bug in the policy.

Really?  Consider the case r_1=r_2, where the role-type relation
permits r_1 to execute with type t_1 but not with type t_2.  If the
arrow is created by an execve_secure, then isn't it important for the
policy to prevent this event?  

Whereas with some powerful role r_3, permitted to execute with types
t_1 and t_2, the event should be permitted.

Are you saying that you don't think policy analysis should be
sensitive to these questions?  (Ever?)

Or are you saying that you don't usually think of these events as
"information flow" relations?  If the latter, well OK, but maybe
that's mainly a verbal point.  There's certainly some causal
interaction here, and presumably policy analysis needs to be able to
talk about it using some terminology or other.

>   constructing a complete graph among entire security contexts seems
>   costly and unnecessary.

Well, yes, if you do it the obvious way by enumerating all the
(tupled) nodes and the arrows between them.  However, lots of model
checking work has invented representations under which conceptually
you're working with that big graph, although the representation is
vastly more compact because it's sensitive to uniformities in how the
components of the nodes are related.

I'm just trying to check that all the conceptually relevant info is
available somehow, if we get our data via libapol.

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
