Subject: Re: ps aux output under sysadm context in refpolicy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1203693559.3669.915.camel@bluejay.goodinassociates.com>
References: <1203628966.3669.820.camel@bluejay.goodinassociates.com>
	 <1203690930.2804.33.camel@moss-spartans.epoch.ncsc.mil>
	 <1203692165.3669.910.camel@bluejay.goodinassociates.com>
	 <1203692479.2804.54.camel@moss-spartans.epoch.ncsc.mil>
	 <1203693559.3669.915.camel@bluejay.goodinassociates.com>
Content-Type: text/plain
Date: Fri, 22 Feb 2008 10:49:17 -0500
Message-Id: <1203695357.2804.58.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-02-22 at 09:19 -0600, Jeremiah Jahn wrote:
> okay, done, apparently I have some attribute set some place, but apol
> only shows it a @ttr2718 Is there some way I can get this to translate
> to English? I'm not that familiar with apol.

Kernel policy doesn't preserve attribute names in the symbol table,
because it doesn't need them (my fault).

To get the attribute name, you'd need to run the analysis on the modular
policy or source policy instead.  The current version of apol can load
up any form of policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
