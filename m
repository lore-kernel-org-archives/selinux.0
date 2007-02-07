Subject: Re: MLS concepts, relational question
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: Michael C Thompson <thompsmc@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <B4E50D01-92C0-4AC2-BDF6-542A5FE1B810@nall.com>
References: <45CA366B.1070801@us.ibm.com>
	 <B4E50D01-92C0-4AC2-BDF6-542A5FE1B810@nall.com>
Content-Type: text/plain
Date: Wed, 07 Feb 2007 16:26:32 -0500
Message-Id: <1170883592.11912.152.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-07 at 15:07 -0600, Joe Nall wrote:
> On Feb 7, 2007, at 2:28 PM, Michael C Thompson wrote:
> 
> > OK, so assume there are two labels:
> > Label A -- s2:c1 - s15:c0.c1023
> > Label B -- s0:c1,c3,c5,...,c1021,c1023 (odd repeating)
> 
> 'Label' A is a range of two labels
> 'Label' B is what I think of as a label.

Yes.  Dominance is a function of two levels, not two ranges.
Note that you only express relationships between levels in the
constraint language used to express the MLS policy.  You can also see
the definitions of mls_level_eq, _dom, and _incomp in the SELinux code
and their use in constraint_expr_eval().

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
