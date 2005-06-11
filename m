Message-Id: <200506111745.j5BHjX5F009794@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>
Cc: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>
Subject: RE: Restorecon script
Date: Sat, 11 Jun 2005 13:45:33 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1118440053.4812.60.camel@dhcp83-8.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> Sent: Friday, June 10, 2005 5:48 PM
> To: Karl MacMillan
> Cc: 'Stephen Smalley'; 'Joshua Brindle'; 'Daniel J Walsh'; 'SELinux'; selinux-
> dev@tresys.com
> Subject: RE: Restorecon script
> 
> 
> > Creating more least-privilege code limits the damage from malicious code,
> > certainly, but in this case it doesn't fix all problems. Some code will be
> run
> > in the user domain that will be exploitable or the user will simply run a
> > Trojan. At that point the malicious code running in user_t can, for example,
> > disclose sensitive user data by either moving it or relabeling it so that an
> > application like apache can read it. This can potentially be addressed but
> it
> > will be enormously difficult and time consuming.
> 
> ROLE_t has access to cp, which equates a relabel, does it not?
> If the user can read the file...
> 

I'm confused . . . you seem to be disagreeing by agreeing. That is exactly the
point I've been hammering on - we have no protection from malicious code in
ROLE_t disclosing user data. From my previous mail:

> Removing the relabeling privilege from the user is probably difficult and they
> can just copy files into the appropriate directories and get the same result
> (assuming type transition rules are in place).

Karl

> > A post install script that creates directories and/or relabels existing
> > directories.
> 
> ... ok

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
