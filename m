Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA24690
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 11:46:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA17140
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 15:45:08 GMT
Received: from tomcat.admin.navo.hpc.mil (tomcat.admin.navo.hpc.mil [204.222.179.33])
        by jazzband.ncsc.mil  with ESMTP id PAA17136 for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 15:45:08 GMT
Date: Fri, 12 Jul 2002 10:46:27 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200207121546.KAA74379@tomcat.admin.navo.hpc.mil>
To: russell@coker.com.au, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: revising the su decision
In-Reply-To: <20020712020642.D58E442F2@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker <russell@coker.com.au>
> 
> Up until now the su program was not modified, so changing to a different UID 
> was a separate and independant operation from changing domain via newrole.
> 
> However now that the sshd policy has been set to default to not allow logins 
> as sysadm_r:sysadm_t this causes some inconveniance.  I have to ssh in to my 
> server as a non-root account with a non-sysadm_r context.  Then I have to use 
> newrole to change to sysadm_r (entering the password), and then I have to su 
> to the root account (entering the root password).
> 
> This requires entering the password two times (or three if not using ssh 
> authorized_keys).
> 
> This is excessively painful, and I think that to make SE Linux more usable we 
> need to address this issue, possibly by changing su to allow it to change 
> roles too.
> 
> What do you think?

I'm not sure that is a good thing - (depends on the security policy).

The separation now means that a root compromise is not all that usefull.

Consider what happes if a root compromise performs a "su - root". It
currently looks like the compromise would suddenly get whatever role has
been assiged to root.

The advantage of the newrole is to REQUIRE a password before gaining
sysadm_r.

Now, If you merge the newrole functions into su and remove the automatic
su to itself (ie su root when root still requires a password, AND su to
any account requires a password), then my objections are much weaker.

My experience are from non SELinux systems (UNICOS MLS, where this wasn't
allowed either). IF the user logged in a non-privileged account, then
that user couldn't GAIN privileges just by performing a su (even with the
password). In this situation (connections over an untrusted network), the
privileged user DIDN'T get even the privilege the account was authorized
(got the security level and compartment authorized on the network instead).
Whichever was minimum (network label or account minimum).

This eliminates the ability of an account compromise (from offsite) gaining
access to sensitive files, even if the account was authorized access.

As an aside - this level of security weakened considerably after SGI
took over UNICOS.

Another item - su is designed to set UID access (files and such), not
external privileges. Used with the root account which had UID access to
everything, you gained all priveleges. This change looks like a step toward
an all powerful account.

Yes it is convienent for some things - but it also makes the system more
vulnerable.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
