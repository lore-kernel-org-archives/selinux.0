Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3IDCAI4011071
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2003 09:12:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3IDC8Vf009230
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2003 13:12:08 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h3IDC84D009227
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2003 13:12:08 GMT
Subject: Re: auditallow
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200304181237.45386.russell@coker.com.au>
References: <200304141822.43798.russell@coker.com.au>
	 <1050416640.1051.12.camel@moss-huskers.epoch.ncsc.mil>
	 <200304181237.45386.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1050671519.2593.25.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 18 Apr 2003 09:12:00 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-04-17 at 22:37, Russell Coker wrote:
> Thanks for the explanation.  However I believe that the policy compiler is not 
> behaving correctly in this regard.
> 
> I think that as a policy with auditallow rules and no matching allow rules 
> makes no sense the policy compiler should flag a warning about this at least.  
> Also an optional warning about auditdeny rules where there are matching allow 
> rules would be good.
> 
> This could be an optional feature, a "-v" option or something similar.

Along the same lines, you likely want warnings when there is a
type_transition rule that has no corresponding allow rules granting the
necessary permissions.  I'm not adverse to adding such warnings, but it
isn't a high priority for us at the moment.  If someone else wants to
write a patch for it, feel free.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
