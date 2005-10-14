Subject: Re: Non-PAM Policycoreutils
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Timothy <timothy@diyab.net>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <434EDB86.2050702@diyab.net>
References: <434EA0C1.7050706@diyab.net>
	 <1129227395.13490.8.camel@moss-spartans.epoch.ncsc.mil>
	 <434EB30B.4080606@diyab.net>
	 <1129232343.13490.35.camel@moss-spartans.epoch.ncsc.mil>
	 <434EBBDD.6040503@diyab.net>
	 <1129233760.13490.44.camel@moss-spartans.epoch.ncsc.mil>
	 <434EDB86.2050702@diyab.net>
Content-Type: text/plain
Date: Fri, 14 Oct 2005 11:20:12 -0400
Message-Id: <1129303212.3394.0.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-13 at 18:11 -0400, Timothy wrote:
> Just _XOPEN_SOURCE caused new errors but _XOPEN_SOURCE defined to 500
> works.  New patch attached.

Thanks, merged into policycoreutils 1.27.12.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
