Subject: Re: Multiple contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux@tycho.nsa.gov
In-Reply-To: <20050112224105.GA11846@lkcl.net>
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
	 <20050112224105.GA11846@lkcl.net>
Content-Type: text/plain
Message-Id: <1105631750.24406.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 13 Jan 2005 10:55:50 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 17:41, Luke Kenneth Casson Leighton wrote:
>  ... so, ultimately, it would be better to have some m4-macro-based
>  tools that do that, munging to an intermediate step (which is same
>  as what we have now) and then munging _that_ to a binary policy
>  file (exactly as is now).

I don't especially care whether it is based on m4 macros, post-processed
policy.conf, or even direct manipulation of the binary policy by a
tool.  I just don't want it in the filesystem state, which requires
complete traversal of all objects to assess.  Note that we have an
increasing ability to directly act on binary policies.  apol already
supports analysis of binary policies directly.  libsepol supports direct
manipulation of binary policies, and is already used for boolean
manipulation by several tools and for user manipulation by genpolusers. 
The experimental binary policy module work by Tresys is another good
step in this direction (but needs more people testing and experimenting
with it if it is ever going to get mainstreamed...).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
