Subject: Re: sshd transition points (user@ip or net_context with setcon)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050222145243.GB30826@lkcl.net>
References: <20050221134124.GR14038@lkcl.net>
	 <1109080870.2256.66.camel@moss-spartans.epoch.ncsc.mil>
	 <20050222145243.GB30826@lkcl.net>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 09:44:57 -0500
Message-Id: <1109083497.2256.89.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-22 at 14:52 +0000, Luke Kenneth Casson Leighton wrote:
>  *hand-waving* something along the lines of AllowUsers not showing
>  up in the avc audit logs?  doesn't cut it because the authentication
>  failure from a different location would appear in the auth logs
>  instead.
> 
>  *more-hand-waving* sshd's multi-stage approach isn't tracked well
>  enough by the selinux strict policy yet?

I think using AllowUsers makes sense for the original problem you
described, and that the multiple sshd instance approach makes sense when
you want to isolate the reachable roles per interface.  The latter point
(about sshd's privsep architecture not being fully leveraged by SELinux
yet) is certainly valid, but not necessarily justifying for your
intended usage.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
