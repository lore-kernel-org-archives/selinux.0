Subject: Re: Existence of "helper" functions (specifcally MLS)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: David Quigley <dpquigl@tycho.nsa.gov>,
        Michael C Thompson <thompsmc@us.ibm.com>, selinux@tycho.nsa.gov
In-Reply-To: <3CA9DB29-D76C-41BE-ABE7-2F710F6658D2@nall.com>
References: <44BFECE8.80501@us.ibm.com>
	 <1153748747.1641.18.camel@moss-terrapins.epoch.ncsc.mil>
	 <A5B53838-B8A8-47B0-9E4A-72A794702EBD@nall.com>
	 <1153751437.6122.74.camel@moss-spartans.epoch.ncsc.mil>
	 <3CA9DB29-D76C-41BE-ABE7-2F710F6658D2@nall.com>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 11:34:20 -0400
Message-Id: <1153755260.6122.85.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-07-24 at 10:25 -0500, Joe Nall wrote:
> > Only the policy engine can interpret the security labels.  So you have
> > two choices:  ask the kernel's policy engine via selinuxfs or use
> > libsepol on the on-disk policy file.  Advantage of the former is  
> > that a)
> > the kernel has already parsed and loaded the policy into memory, so  
> > you
> > avoid that cost again, and b) you ensure that you are dealing with the
> > same exact policy that the kernel is enforcing.
> 
> I understand this if you include non-MLS components, but how does the
> interpretation of the MLS component of a context vary with policy on one
> machine?

The relationship between s0 and s1 is not implicit in the names; s0
could dominate s1; that is entirely defined by the policy itself.

Also, in general, we try to avoid MLS-specific logic outside of the
policy engine; in many cases, applications that might historically have
done a specific MLS dominance check on a traditional trusted OS should
instead be performing a SELinux permission check via avc_has_perm or
security_compute_av, and then you can internally map that permission to
a MLS relationship via the mlsconstrain statements in the policy.  So
the first question is whether this application should be performing a
MLS label comparison at all, or whether we can abstract that to a
service permission check.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
