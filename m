Subject: Re: Minor genhomedircon patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41F90DD2.5040601@redhat.com>
References: <41F90538.9010107@redhat.com>
	 <1106839940.28623.117.camel@moss-spartans.epoch.ncsc.mil>
	 <41F90BFD.4010208@redhat.com>
	 <1106840307.28623.122.camel@moss-spartans.epoch.ncsc.mil>
	 <41F90DD2.5040601@redhat.com>
Content-Type: text/plain
Message-Id: <1106840839.28623.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 27 Jan 2005 10:47:19 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-01-27 at 10:50, Daniel J Walsh wrote:
> Without this change UID are compared as strings instead of integers.

Thanks, merged into sourceforge CVS as of policycoreutils 1.21.6.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
