Subject: Re: Query MLS info outside of SELinux/LSM?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: Paul Moore <paul.moore@hp.com>, James Morris <jmorris@namei.org>,
        SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <BDEE5CBC-F62F-4B14-BCD3-42B7215987DD@nall.com>
References: <4411AFCB.60401@hp.com>
	 <1142010664.25454.128.camel@moss-spartans.epoch.ncsc.mil>
	 <4411B5F2.6060702@hp.com>
	 <1142012234.25454.139.camel@moss-spartans.epoch.ncsc.mil>
	 <4411B9A9.5020102@hp.com>
	 <1142013189.25454.152.camel@moss-spartans.epoch.ncsc.mil>
	 <BDEE5CBC-F62F-4B14-BCD3-42B7215987DD@nall.com>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 14:15:32 -0500
Message-Id: <1142018132.25454.190.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-03-10 at 13:03 -0600, Joe Nall wrote:
> If there is a naming convention for system high you can ask for a  
> translation of SystemHigh and look the the level and categories  
> returned. Use of CIPSO could be dependent on certain names or aliases  
> being available in setrans.conf.

I think he means his NetLabel kernel component, not a userspace
component, so he isn't dealing with translations at all there.  Just the
raw kernel representation.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
