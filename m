Message-Id: <200211201935.OAA17353@moss-shockers.ncsc.mil>
Date: Wed, 20 Nov 2002 14:35:17 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: multiple dontaudit rules
To: SELinux@tycho.nsa.gov, carstengrohmann@gmx.de
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> in "Configuring the SELinux Policy" at point 4.2.5 wrote:
> "If multiple allow or auditallow access vector rules are specified for a 
> given type pair and class, then the union of the permission sets is used. 
> If multiple dontaudit rules are specified for a given type pair and class, 
> then the intersection of the permission sets is used. "
> 
> I am not sure but could it be better to handle multiple dontaudit rules in 
> the same way as the multiple allow rules. In my eyes, there isn't a good 
> reason to make a union of the one and a intersection of the others.

I think that this is a "bug" in the documentation that arose from
the internal implementation of dontaudit rules as auditdeny vectors.
In truth, the union of permission sets specified in multiple dontaudit
rules for a single type pair and class is used.  But in the implementation,
each dontaudit rule is converted to an auditdeny vector (its complement) and 
then intersected with the auditdeny vectors associated with any other rules
with the same type pair and class.  See 
http://marc.theaimsgroup.com/?l=selinux&m=102314424330376&w=2.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
