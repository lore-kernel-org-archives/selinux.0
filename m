Subject: Re: Question about stat
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: selinux@tycho.nsa.gov, Yoshinori Sato <yo-satoh@sios.com>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>
In-Reply-To: <4562EFE0.5080807@kaigai.gr.jp>
References: <4562EFE0.5080807@kaigai.gr.jp>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 09:12:24 -0500
Message-Id: <1164118344.13758.101.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-11-21 at 21:24 +0900, KaiGai Kohei wrote:
> I found a strange behavior of the stat in coreutils-5.97-14.fc7.src.rpm.
> 
> see below,
> 
> [kaigai@masu ~]$ stat -c "%C" mytest.sql
> (null)
> [kaigai@masu ~]$ stat -Z -c "%C" mytest.sql
> user_u:object_r:user_home_t:s0
> [kaigai@masu ~]$
> 
> Because stat command without '-Z' option doesn't try to obtain
> the security context of the files specified, the format string
> which contains "%C" doesn't work correctly.
> 
> Is it expected behavior?

That sounds like a bug to me; the use of '%C' in the format string
should implicitly enable the invocation of getfilecon.  I'd suggest
filing a bug against coreutils in fedora devel at bugzilla.redhat.com,
as there is no "upstream" repository presently for the coreutils selinux
patch.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
