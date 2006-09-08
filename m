Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k88DIuTB018065
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 09:18:56 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k88DIAIs003464
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 13:18:10 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC] SELinux and PostgreSQL
Date: Fri, 8 Sep 2006 09:19:56 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B015883C166F@exchange.columbia.tresys.com>
In-Reply-To: <200609082206.02747.russell@coker.com.au>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <russell@coker.com.au>
Cc: "James W. Hoeft" <Jim@MagitekLtd.com>,
        "KaiGai Kohei" <kaigai@kaigai.gr.jp>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Russell Coker [mailto:russell@coker.com.au] 
> 
> On Friday 08 September 2006 12:10, "Joshua Brindle" 
> <jbrindle@tresys.com>
> wrote:
> > > I'm confused. Password column is a good example - let's say the 
> > > password column is labeled at top secret, then how can a 
> secret user 
> > > create a new row? I would assume a password would
> >
> > Well, first of all a secret user can write a top secret 
> column but I 
> > think I know what you meant..
> 
> Yes, in the MLS side of things the user can write-up (limited 
> to the high level of their range unless there is an attribute 
> on either the domain or the type to allow going higher).
> 
> But if you have the password labeled with a restrictive type 
> (something equivalent to shadow_t) then it becomes a little 
> more tricky.
> 
> > > be required, but that either means a secret user cannot read or 
> > > cannot write (or can't do either). If that's not the 
> case, then does 
> > > that mean the row can be created without a password? In 
> which case, 
> > > does that mean only top secret users
> >
> > Probably a trusted stored procedure that has a higher level 
> of access 
> > would be used
> 
> Or a trusted SQL client program.  When considering ways of 
> improving the security of database backed web sites my best 
> ideas involved having multiple programs doing database access 
> with different contexts.
> 

Trusted stored procedures are nicer IMO. They allow a centralized way
for any other client to check eg., passwords. For example, instead of
being able to do select * from users where uid = '1'; and get the entire
row (including password) they would have to do fetch_my_user_row(1,
'mypassword'); and the stored proc would only return it if the password
matched the password in the row.

Even if the password column is hashed (which in most cases it will be)
its still better to force people to use stored procedures instead of
letting them get the entire table with hashed passwords to brute force
at their leasure.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
