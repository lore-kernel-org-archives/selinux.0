Subject: Re: Multiple contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Stephen Bennett <spb@gentoo.org>, ivg2@cornell.edu, SELinux@tycho.nsa.gov
In-Reply-To: <20050112230724.GD11846@lkcl.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net>
	 <1105474095.20566.131.camel@moss-spartans.epoch.ncsc.mil>
	 <1105560687.11135.26.camel@cobra.ivg2.net>
	 <1105566046.3933.5.camel@localhost>  <20050112230724.GD11846@lkcl.net>
Content-Type: text/plain
Message-Id: <1105632387.24406.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 13 Jan 2005 11:06:27 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 18:07, Luke Kenneth Casson Leighton wrote:
>  and you'd need to take all of the files matched by a regexp for one
>  filetype, and all of the files of the other, work out if there are any
>  common ones, and those would be your "multiple contexted" files.
> 
>  this you could do at policy compilation time.

No.  As I said, file_contexts is not part of the kernel policy.  It is
only used by userspace tools like setfiles and restorecon to set the
extended attributes upon installation to an initial labeling state (or
to recheck or to restore against that initial labeling state).  If the
policy is self-contained (as it is currently), then you don't need to
look at file_contexts or the on-disk attributes in order to determine
potential information flow, although you may choose to look at them
after an analysis of the policy in order to see how "real" certain flows
might be with the current system state.

>  the thing is - which is easier: to expect people to do that
>  analysis themselves [by modifying the default policies]
>  or to do it in an automated at-pol-compile-time?

The question doesn't make sense, because the automated
at-pol-compile-time analysis cannot be done if the policy is encoded in
the filesystem.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
