Subject: Re: Multiple contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux@tycho.nsa.gov
In-Reply-To: <20050111214818.GE26175@lkcl.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net>
	 <20050110232312.GI6967@lkcl.net>
	 <1105474191.20566.134.camel@moss-spartans.epoch.ncsc.mil>
	 <20050111214818.GE26175@lkcl.net>
Content-Type: text/plain
Message-Id: <1105538449.22495.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 Jan 2005 09:00:49 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-01-11 at 16:48, Luke Kenneth Casson Leighton wrote:
>  recursion was added to ACLs - or "inheritance" - because to fix access
>  to subdirectories and all contents you are required in NT 4.0 to change
>  ALL permissions on ALL subdirectories and contents!
> 
>  basically you now have to traverse the directory tree right
>  up to the mount point [as stephen says] in order to determine access
>  rights, combining and checking permissions as you go.
> 
>  eeuuuw.
> 
>  ... was that what you were referring to stephen?

No.  I'm simply referring to the fact that if your policy is encoded in
the file attributes themselves, as with ACLs, then you cannot analyze
the potential information flow among security equivalence classes in the
system (which is necessary if you want to ensure confidentiality or
integrity guarantees) without looking at all of the file attributes. 
Centralizing the policy allows you to analyze the potential information
flow separately, and organizing the set of subjects and objects into
security equivalence classes (types in TE, levels in MLS) makes the
system manageable (vs. per-object policy as with ACLs).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
