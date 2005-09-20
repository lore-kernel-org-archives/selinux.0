Subject: Re: policycoreutils: run_init blocks sigCHLD but doesn't unblock
	it before exec
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <87aciekgvx.fsf@glaurung.internal.golden-gryphon.com>
References: <87aciekgvx.fsf@glaurung.internal.golden-gryphon.com>
Content-Type: text/plain
Date: Tue, 20 Sep 2005 14:45:31 -0400
Message-Id: <1127241931.14569.129.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-09-15 at 01:02 -0500, Manoj Srivastava wrote:
> Hi,
> 
>         This was reported by a Debian user trying to run munin. Since
>  I forgot to unblock SIGCHLD, his causes weird errors e.g. in perl
>  which apparently assumes that CHLD is not blocked on startup. (and
>  thus breaks libnet-server-perl, used by munin or lrrd).
> 
>         The following patch is a simple fix.

Thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
