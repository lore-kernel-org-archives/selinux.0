Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA12522
	for <selinux@tycho.nsa.gov>; Wed, 29 May 2002 15:09:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA16311
	for <selinux@tycho.nsa.gov>; Wed, 29 May 2002 19:07:55 GMT
Received: from smtpproxy2.mitre.org (smtpproxy2.mitre.org [192.80.55.70])
        by jazzband.ncsc.mil  with ESMTP id TAA16307 for <selinux@tycho.nsa.gov>; Wed, 29 May 2002 19:07:55 GMT
To: "Frank Mayer" <mayerf@tresys.com>
Cc: "NSA Selinux Mailinglist" <selinux@tycho.nsa.gov>,
        guttman@mitre.org (Joshua D. Guttman),
        Stephen Smalley <sds@tislabs.com>
Subject: Re: Proposal: install policy.conf
Reply-To: guttman@mitre.org (Joshua D. Guttman disp: current)
References: <ACEHIKGIGFEDAIKEMMMIIENMKDAA.mayerf@tresys.com>
From: guttman@mitre.org (Joshua D. Guttman)
Date: 29 May 2002 15:09:00 -0400
In-Reply-To: <ACEHIKGIGFEDAIKEMMMIIENMKDAA.mayerf@tresys.com>
Message-ID: <nha4rgqojoz.fsf@banjara.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

"Frank Mayer" <mayerf@tresys.com> writes:

>   
>   
>   What we'd like to see is /etc/security/policy.conf treated as the
>   definitive policy for a system, allowing all sorts of tools to
>   change, create, or otherwise manage all or portions of the
>   installed policy.
>   

My colleagues and I agree with this suggestion:  It puts the
"definitive policy" in a single location, with an unambiguous
semantics.  We think it's desirable to separate the actual policy
itself from a particular approach to policy management (embodied in
the current multi-file, build process), which may or may not turn out
to be the ideal way to understand and construct policies.  

Stephen Smalley <sds@tislabs.com> replied (in part): 

>   
>   
>   Do we want to include something in the compiled policy (currently
>   installed into /etc/security/selinux/policy.VERSION) that helps to
>   associate it with a particular policy.conf?  For example, we could compute
>   a message digest of the policy.conf file and include it in the compiled
>   policy header.
>   

Definitely:  that way, analysis proving that a policy.conf satisfies
some security goal can be tied to an actual running system in an
unambiguous, remotely verifiable way (e.g. with the help of
TCPA-enabled hardware).  

Cheers --

        Joshua 


-- 
	Joshua D. Guttman		<guttman@mitre.org> 
	MITRE, Mail Stop S119		Office:	+1 781 271 2654
	202 Burlington Rd.		Cell:	+1 781 526 5713
	Bedford, MA 01730-1420 USA	Fax:	+1 781 271 8953



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
