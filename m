Subject: Re: Multiple contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux@tycho.nsa.gov
In-Reply-To: <20050113171732.GK17414@lkcl.net>
References: <20050111214818.GE26175@lkcl.net>
	 <1105538449.22495.8.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112144411.GZ26175@lkcl.net>
	 <1105542047.22495.69.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112181814.GD26175@lkcl.net>
	 <1105552982.22495.169.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112182954.GF26175@lkcl.net>
	 <1105565236.23136.12.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112230148.GC11846@lkcl.net>
	 <1105634671.24406.59.camel@moss-spartans.epoch.ncsc.mil>
	 <20050113171732.GK17414@lkcl.net>
Content-Type: text/plain
Message-Id: <1105636128.24406.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 13 Jan 2005 12:08:49 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-01-13 at 12:17, Luke Kenneth Casson Leighton wrote:
>  and there would therefore be in the policy.conf file lots of things
>  like "allow F1,F2 such-and-such".

Regardless of how the logic is implemented/specified, you had originally
proposed allowing access if access to any one of the types was allowed. 
But in the case of relabeling a file with multiple types, that logic
seems flawed, e.g. I doubt you want to allow someone to relabel a file
from F1,F2 to only F1 just because they have permission to
relabelfrom/to F1 but lack permission to relabel F2.

>  i thought that the only tricky bit would be at policy compile-time to
>  have to run through the complete list of files on the filesystem (which
>  is done by setfiles _anyway) making a distinction between the overlap
>  of the regexp associated with F1 and the regexp associated with F2.

No, you misunderstand.  setfiles is not run at policy compilation time. 
setfiles is only run at system install time (and in fact, it isn't even
run then anymore, as rpm now handles labeling upon install for us now).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
