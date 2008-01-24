Subject: Re: [patch] fixfiles -C: relabel all file contexts that have
	changed
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Marshall Miller <mmiller@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1201203580.4502.56.camel@hostmachine.tresys.com>
References: <1201203580.4502.56.camel@hostmachine.tresys.com>
Content-Type: text/plain
Date: Thu, 24 Jan 2008 15:44:44 -0500
Message-Id: <1201207484.21288.148.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-01-24 at 14:39 -0500, Marshall Miller wrote:
> This fixes the situation where one path is a substring of another path, but not a prefix.  For example, if /lib and /var/lib have both changed in the file_contexts file, then /var/lib would not be selected for relabel even though it should.

Thanks, applied.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
