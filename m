Subject: Re: [PATCH] setfiles support for altroot
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <JBrindle@snu.edu>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <seba8444.037@atlas.snu.edu>
References: <seba8444.037@atlas.snu.edu>
Content-Type: text/plain
Message-Id: <1052494186.1044.392.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 09 May 2003 11:29:47 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-05-08 at 17:22, Joshua Brindle wrote:
> This allows setfiles to label files in somewhere other than / as if they were in /, 
> very useful for labeling off the live filesystem before installing.
> This is necessary for Gentoo to support SELinux, is it reasonable for it
> to be imported into CVS and included in the next nsa release? If there are any
> problems with it let me know (I really suck at C so there probably are problems)

This sounds useful, but we may not get to reviewing it and merging it
for a little bit; we're presently preoccupied with the reworking of
SELinux for mainline 2.5.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
