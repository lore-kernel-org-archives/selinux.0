Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA05080
	for <selinux@tycho.nsa.gov>; Wed, 27 Nov 2002 08:59:55 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA19257
	for <selinux@tycho.nsa.gov>; Wed, 27 Nov 2002 13:57:42 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id NAA19253
	for <selinux@tycho.nsa.gov>; Wed, 27 Nov 2002 13:57:42 GMT
Message-Id: <200211271407.JAA21945@moss-shockers.ncsc.mil>
Date: Wed, 27 Nov 2002 09:07:14 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: role dominance
To: selinux@tycho.nsa.gov, giorgio.zanin@poste.it
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> As explained in SELinux documentation, a role automatically inherits the 
> domains authorized for any role that it dominates in the hierarchy. What 
> I don't know is about user-roles associations. Consider the following 
> situation:
> 
> U1: SELinux user identity
> R1, R2: roles
> T1, T2: types
> 
> R1 dominates R2
> R1 is authorized for type T1 and R2 for type T2
> 
> it follows R1 is authorized for type T2 too.
> 
> If U1 is authorized for role R1, certainly (U1, R1, T2) is a valid 
> security context, because of the dominance relation between R1 and R2. 
> What about (U1,R2,T2)? In other words, if a role dominates another role 
> and a user is explicitly authorized to the dominant role, is then the 
> user implicitly authorized to the dominated role?

Yes, the user is implicitly authorized for the dominated role, and (U1,R2,T2) 
would be a valid security context.  

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
