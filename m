Subject: Re: [patch] libselinux malloc return value checking
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>
In-Reply-To: <36282A1733C57546BE392885C0618592364669@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C0618592364669@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Message-Id: <1093291028.27211.266.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 23 Aug 2004 15:57:08 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-23 at 13:51, Chad Hanson wrote:
> The attached patch (against libselinux-1.16) adds return value checking
> to malloc, strdup, etc.

Thanks, merged.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
