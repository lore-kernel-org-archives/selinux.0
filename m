Subject: Re: [patch] newrole  and libselinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>
In-Reply-To: <36282A1733C57546BE392885C061859231E505@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C061859231E505@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Message-Id: <1092319468.16219.49.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 12 Aug 2004 10:04:28 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-08-07 at 16:24, Chad Hanson wrote:
> I have attached a patch which adds additional error checking into the
> newrole command to prevent seg faults. Also, I have attached a patch to
> libselinux to correct the handling the MLS contexts when used with
> categories.

Thanks, merged.  However, I suspect that there may be other bugs in
handling MLS ranges properly, e.g. it looks like context_range_set()
will reject a MLS component that includes a colon, e.g. one that
contains a compartment set.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
