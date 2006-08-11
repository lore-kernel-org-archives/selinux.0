Subject: Re: [PATCH 3/3] Separate local file contexts into
	file_contexts.local
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1155303269.8722.64.camel@sgc.columbia.tresys.com>
References: <1155303269.8722.64.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 16:52:11 -0400
Message-Id: <1155329531.30078.121.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-08-11 at 09:34 -0400, Christopher J. PeBenito wrote:
> Semanage was looking at the main file contexts in some cases, since the
> local file contexts were merged into the main file contexts.  This patch
> fixes the code to look at the appropriate file context databases.

Thanks, merged, although I did make the libsemanage copy file error
non-fatal (another patch has made several others non-fatal too).

Also, I'm not sure that semanage handles conflicts very well presently,
e.g.
	semanage fcontext -a -t login_exec_t '/bin/bash'

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
