Subject: Re: [ SEPOL ] Extract user records from binary policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <43399C1A.60500@cornell.edu>
References: <4334E273.9070703@cornell.edu>  <4334E4C8.8050206@cornell.edu>
	 <1127762342.19016.186.camel@moss-spartans.epoch.ncsc.mil>
	 <4338A1BD.9050204@cornell.edu>
	 <1127847506.21671.96.camel@moss-spartans.epoch.ncsc.mil>
	 <43399C1A.60500@cornell.edu>
Content-Type: text/plain
Date: Tue, 27 Sep 2005 15:23:47 -0400
Message-Id: <1127849027.21671.119.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-27 at 15:23 -0400, Ivan Gyurdiev wrote:
> Well, I could define a new function which allocates the string (after 
> computing proper length), writes to it, and returns a valid ptr... 
> however that's just moving the potential point of failure from two calls 
> in users.c into one function in mls.c....
> 
> Like this?
> 
> int sepol_mls_struct_to_string(policydb_t* policydb, context_struct_t* 
> mls, char** str).
> int sepol_mls_struct_from_string(policydb_t* policydb, char* str, 
> context_struct_t** mls).

Yes, although I think that context_struct_t* is fine in both cases (i.e.
require the caller to provide one), especially as the caller may be
building up a complete context structure and just want the MLS fields
filled in by the mls function.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
