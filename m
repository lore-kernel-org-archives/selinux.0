Subject: Re: fix setfiles segfault caused by libselinux-1.22
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andreas Steinmetz <ast@domdv.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <42513C67.7020604@domdv.de>
References: <42513C67.7020604@domdv.de>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 11:30:28 -0400
Message-Id: <1112628628.7629.101.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-04-04 at 15:08 +0200, Andreas Steinmetz wrote:
> setfiles does reset user defined functions by calling the related setup
> function with NULL as argument. Instead of resetting to the default
> these setup functions did set up NULL as the function pointer. Fix attached.

Thanks, merged as of libselinux 1.23.4.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
