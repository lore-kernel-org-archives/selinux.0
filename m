Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j12DFT53021895
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 08:15:30 -0500 (EST)
Subject: Re: Latest diffs
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1107287300.26936.226.camel@moss-spartans.epoch.ncsc.mil>
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA9717.2000609@redhat.com>
	 <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>
	 <1107287300.26936.226.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1107349736.890.72.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 02 Feb 2005 08:08:56 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-01 at 14:48, Stephen Smalley wrote:
> After Jim's merge of some of your changes, I've committed the patch
> below, which introduces an allow_execmem boolean for all execmem allow
> rules, wraps some additional execmod allow rules with your boolean,
> removes execmod permission to shlib_t entirely (should only be allowed
> to texrel_shlib_t except for special domains for programs like java),
> and assigns texrel_shlib_t to libGL.  Actually, some of the individual
> execmod allow rules may now be redundant with the conditional rule you
> put in uses_shlib.  I think that we may need to further break up these
> booleans to allow certain programs to have these permissions without
> granting them more widely.

BTW, I think that putting the conditional rule in uses_shlib() is likely
not what you want, as it means that if you allow execmod at all to
texrel_shlib_t, you essentially allow it for all domains.  In practice,
I think you will only want to allow it where needed, and especially not
for daemon domains.  Hence, I would recommend removing it from
uses_shlib() and instead add it selectively to domains that have a
legitimate need, as has already been done for a few cases as well as the
user domains.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
