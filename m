Subject: Re: Multiple contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux@tycho.nsa.gov
In-Reply-To: <20050112230148.GC11846@lkcl.net>
References: <20050110232312.GI6967@lkcl.net>
	 <1105474191.20566.134.camel@moss-spartans.epoch.ncsc.mil>
	 <20050111214818.GE26175@lkcl.net>
	 <1105538449.22495.8.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112144411.GZ26175@lkcl.net>
	 <1105542047.22495.69.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112181814.GD26175@lkcl.net>
	 <1105552982.22495.169.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112182954.GF26175@lkcl.net>
	 <1105565236.23136.12.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112230148.GC11846@lkcl.net>
Content-Type: text/plain
Message-Id: <1105632203.24406.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 13 Jan 2005 11:03:23 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 18:01, Luke Kenneth Casson Leighton wrote:
>  yep - and the policy analysis tools would need to understand the
>  new format.

It isn't a format issue; it is whether the policy is self-contained
within the binary policy or whether it is distributed throughout the
filesystem (and more generally, the set of all object attributes).

>  1) if someone does a "chcon -t F2 foobar" all bets would be off as
>     far as static analysis is concerned.

Non-tranquility (ability to change the label on a subject or object) is
an issue, but you can bound it statically in the policy, i.e. the policy
can already ensure that F1 can never be relabeled to F2 or vice versa. 
If the policy allows F1 to be relabeled to F2 or vice versa, then that
fact will also show up in an information flow analysis of the policy,
without requiring examination of filesystem state.  Also, some further
controls over relabeling are coming in the MLS work.

>  2 ) even if they did chcon -t "F1,F2" foobar, you would still expect
>      them to be doing that as an "interim" measure whilst they were
>      testing something _pending_ formal analysis by putting that
>      into the policy files.

If the mechanism allows it to happen at all, you can't make any
guarantees without examination of the filesystem state. 

>  the analysis would need the macro-munging approach _anyway_ in
>  order to "grok" the new syntax - an intermediate preprocessing
>  stage that "notices" multiple-file-applications (including
>  possibly expanding regexps!)  and ending up with something
>  like this:

No.  The analysis tools operate on policy.conf or binary policy already;
they don't care about the macros, nor should they.  The raw policy.conf
or binary policy tells the true story about possible information flow,
and that is what we want to know.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
