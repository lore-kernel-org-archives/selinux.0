MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: setools-1.5.1
Date: Tue, 29 Mar 2005 12:32:54 -0500
Message-ID: <E6E16A6D4277CD459BBDE6713766033CFB7E6B@exchange.mvalent.local>
From: "James R. Marcus" <jmarcus@mvalent.net>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

An 
emerge libselinux
and then
emerge setools
worked.
thanks,
James

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Tuesday, March 29, 2005 12:04 PM
To: James R. Marcus
Cc: selinux@tycho.nsa.gov
Subject: Re: setools-1.5.1

On Tue, 2005-03-29 at 11:49 -0500, James R. Marcus wrote:
> I tried updating my machine to setools-1.5.1 and it failed.
> I had switch permissive mode and did emerge setools.

Current version of setools is 2.0.  Your bug report is likely more
appropriate to gentoo-hardened, as it would appear to be specific to
Gentoo, right?

> `seuser_read_conf_info':
> : undefined reference to `selinux_policy_root'

Do you have libselinux >= 1.14?  That is what defines that function.
Current stable version is 1.22.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
