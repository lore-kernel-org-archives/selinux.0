Subject: Re: Multiple contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux@tycho.nsa.gov
In-Reply-To: <20050112182954.GF26175@lkcl.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net>
	 <20050110232312.GI6967@lkcl.net>
	 <1105474191.20566.134.camel@moss-spartans.epoch.ncsc.mil>
	 <20050111214818.GE26175@lkcl.net>
	 <1105538449.22495.8.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112144411.GZ26175@lkcl.net>
	 <1105542047.22495.69.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112181814.GD26175@lkcl.net>
	 <1105552982.22495.169.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112182954.GF26175@lkcl.net>
Content-Type: text/plain
Message-Id: <1105565236.23136.12.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 Jan 2005 16:27:16 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 13:29, Luke Kenneth Casson Leighton wrote:
>  i don't believe it does - or i am misunderstanding.
> 
>  having two policy files apache.fc and mymodifiedthing.fc which _both_
>  have a file context for the same file / directory, such that the
>  data that ends up in the security.selinux xattr is "apache_filetype_t,
>  "mymodifiedthing_filetype_t" doesn't mean, in my book "policy is in
>  filesystem state".
> 
>  ... does it?
> 
>  *lost*.

The file_contexts configuration is not part of the kernel policy.  It is
only used by userspace to set the contexts for files upon installation,
to recheck the state of the filesystem against the initial labeling
state, or to restore portions of the filesystem to the initial labeling
state.

If you change the SELinux module to support a list of file contexts
within the security.selinux attribute, and change its policy engine to
allow access if any access is allowed to any one of those contexts, then
the only way to truly identify what information flow is possible in the
system is by checking the current security.selinux attributes of all
files in the system for such combinations and collapsing them to a
single security equivalence class for analysis purposes.  Think:  policy
says allow P1 F1:file read; allow P2 F2:file write;, policy analysis
says that there is no allowed information flow from P2 to P1, but
someone does a chcon -t F1,F2 foobar and now P2 can write to foobar and
P1 can read from it, so information flow is now possible.  If you want
to control information flow throughout the system to prevent leakage of
information or to protect trusted processes against being corrupted by
untrustworthy input, you can't ignore the issue.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
