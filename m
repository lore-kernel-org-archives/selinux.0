Subject: Re: Multiple contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux@tycho.nsa.gov
In-Reply-To: <20050112181814.GD26175@lkcl.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net>
	 <20050110232312.GI6967@lkcl.net>
	 <1105474191.20566.134.camel@moss-spartans.epoch.ncsc.mil>
	 <20050111214818.GE26175@lkcl.net>
	 <1105538449.22495.8.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112144411.GZ26175@lkcl.net>
	 <1105542047.22495.69.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112181814.GD26175@lkcl.net>
Content-Type: text/plain
Message-Id: <1105552982.22495.169.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 Jan 2005 13:03:02 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 13:18, Luke Kenneth Casson Leighton wrote:
>  sorry.
> 
>  something simple:
> 
>  i am thinking along the lines of more than one file context being
>  associated with a file - that sort of thing.
> 
>  and permission being checked and allowed on either of the contexts.

I already explained why you don't want that - it puts the policy into
the filesystem state.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
