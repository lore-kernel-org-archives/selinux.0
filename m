Subject: Re: [PATCH] Lazy config init in libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <824347.57110.qm@web51509.mail.yahoo.com>
References: <824347.57110.qm@web51509.mail.yahoo.com>
Content-Type: text/plain
Date: Mon, 26 Feb 2007 14:10:22 -0500
Message-Id: <1172517022.19041.280.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 11:08 -0800, Steve G wrote:
> Hi,
> 
> After running strace a number of times in the other performance patch, I realized
> that we are reading a config file in a lot of cases where we don't even use the
> results. Example, "ls" opens, reads, and parses /etc/selinux/config and it
> doesn't care unless you pass the -Z flag. So...this patch does 2 things. It does
> a lazy read of the config file and it moves the check for /etc/security to be a
> second class citizen instead of something checked for first. This patch should
> make shell scripts run faster.
> 
> Signed-off-by: Steve Grubb <linux_4ever@yahoo.com>

The problem with doing it on first use is it isn't thread-safe; the code
is initializing globals for the library's subsequent use.  And making
those variables per-thread would be wasteful as they truly are global
state to the library.  So initializing them in the library constructor
is the right thing to do.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
