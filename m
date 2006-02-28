Subject: Re: Context translation and MLS categories
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Chad Hanson <chanson@TrustedCS.com>, joe@nall.com,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        SELinux List <SELinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <44048377.2010707@cornell.edu>
References: <4403E1A0.8030704@cornell.edu>
	 <1141132115.22297.158.camel@moss-spartans.epoch.ncsc.mil>
	 <44047455.4010601@cornell.edu>
	 <1141144322.22297.267.camel@moss-spartans.epoch.ncsc.mil>
	 <44048377.2010707@cornell.edu>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 12:34:07 -0500
Message-Id: <1141148047.22297.272.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-02-28 at 12:08 -0500, Ivan Gyurdiev wrote:
> 1) We translate the entire range when displaying
> 2) When modifying the range, we unroll the user's range as (s,c) pairs, 
> then translate each of them, and present them as required clearances to 
> be added or removed

In general, you can't unroll it in this manner.  It may make sense to do
so for a particular policy (e.g. MCS in particular), but not in the
general case for MLS.

> 3) When the range is displayed again, re-translate the whole thing.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
