Subject: Re: writing rules to disallow a domain to read particular files
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: jsingh@ensim.com
Cc: Colin Walters <walters@verbum.org>,
   Luke Kenneth Casson Leighton <lkcl@lkcl.net>, nsa <SELinux@tycho.nsa.gov>
In-Reply-To: <1098092475.6415.10.camel@jsingh.india.ensim.com>
References: <1097940101.2569.5.camel@jsingh.india.ensim.com>
	 <1097948413.3872.3.camel@x-infinity.verbum.private>
	 <1098017660.2740.33.camel@jsingh.india.ensim.com>
	 <1098030922.15741.20.camel@x-infinity.verbum.private>
	 <1098092475.6415.10.camel@jsingh.india.ensim.com>
Content-Type: text/plain
Message-Id: <1098105734.27895.43.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 18 Oct 2004 09:22:14 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-10-18 at 05:41, Jaspreet Singh wrote:
> Hi,
> 
> could you please explain me how are booleans handled in selinux targeted
> policies.
> 
> eg. a grep on booleans like -
> 
> "read_default_t" , "snmpd_disable_trans" etc ...
> 
> relieved that their declaration exists in policy.conf file.
> 
> I have changed some rules in policy and having a tough time compiling
> due to -
> 
> :ERROR 'unknown boolean user_direct_mouse in conditional expression' at
> token 'user_direct_mouse' on line 4862:

Targeted policy doesn't include user roles, just daemon domains.  Use
strict policy if you want to separate users.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
