Subject: Re: [patch] libselinux MLS category bug
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>
In-Reply-To: <36282A1733C57546BE392885C061859236466D@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C061859236466D@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Message-Id: <1093291039.27211.268.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 23 Aug 2004 15:57:19 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-23 at 13:52, Chad Hanson wrote:
> The attached patch (against libselinux-1.16) fixes a bug in the
> "context_range_set" function.  This function was rejecting
> any MLS range which contained an MLS category.

Thanks, merged.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
