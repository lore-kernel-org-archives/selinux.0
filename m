Subject: Re: [ SEMANAGE ] Some seusers mapping validation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <4367044C.1000501@cornell.edu>
References: <4366EE1B.1060303@cornell.edu> <4366F160.2070005@cornell.edu>
	 <4367044C.1000501@cornell.edu>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 16:24:21 -0500
Message-Id: <1130880261.22731.323.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-01 at 00:59 -0500, Ivan Gyurdiev wrote:
> >
> > You can see why I want (2), and most of (3) skipped in the case of 
> > seusers...need to add tracking of when the policy is modified.
> Well... with the attached patch I need a policydb, regardless of whether 
> modifications occured.. otoh if no modifications, then I don't have to 
> call expand, which takes so long... can go through the policydb_cache 
> function instead (not sure if that's any faster, however..)

All five patches merged as of libsemanage 1.3.40, with the minor change
to make errors upon copying of seusers non-fatal.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
