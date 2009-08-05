Subject: RE: A question about selinux userspace tools
From: Stephen Smalley <sds@tycho.nsa.gov>
To: TaurusHarry <harrytaurus2002@hotmail.com>
Cc: selinux-mailing-list <selinux@tycho.nsa.gov>
In-Reply-To: <COL109-W14E611B54676237F879250AB0D0@phx.gbl>
References: <COL109-W24536BCBD1CB8DA1812599AB0C0@phx.gbl>
	 <1249397076.9193.101.camel@moss-pluto.epoch.ncsc.mil>
	 <COL109-W14E611B54676237F879250AB0D0@phx.gbl>
Content-Type: text/plain
Date: Wed, 05 Aug 2009 08:09:11 -0400
Message-Id: <1249474151.21455.22.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-08-05 at 03:03 +0000, TaurusHarry wrote:
> Hey Smalley,
> 
> So many thanks for giving me your help so promptly, you are such a
> kind person !:-D
> 
> Yep, the quick test reveal that only with disabling bzip feature by
> "bzip-blocksize=0" would the libsemanage-2.0.33 successfully build a
> policy store, the option of bzip-blocksize=4 and bzip-small=true would
> result in the same libsepol out of memeory error.
> 
> If there is any thing I could ever help test for you, just let me
> know.

Thanks for testing.  Could you let us know the amount of memory and swap
you had configured on your laptop to help with reproducing the behavior?
And also, what your /proc/sys/vm/overcommit_memory
and /proc/sys/vm/overcommit_ratio settings were?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
