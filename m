Subject: Re: fix for segfault in getconlist of libselinux-1.22
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andreas Steinmetz <ast@domdv.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <425029B0.3070208@domdv.de>
References: <425029B0.3070208@domdv.de>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 11:30:01 -0400
Message-Id: <1112628601.7629.99.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-04-03 at 19:36 +0200, Andreas Steinmetz wrote:
> fix for segfault in case of non-exisiting user attached.

Thanks, merged as of libselinux 1.23.4.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
