Subject: Re: setsockcreate
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <78E57BD4-C55B-4107-9272-A8CE9DF9F861@nall.com>
References: <78E57BD4-C55B-4107-9272-A8CE9DF9F861@nall.com>
Content-Type: text/plain
Date: Thu, 23 Aug 2007 17:06:17 -0400
Message-Id: <1187903177.1451.662.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-23 at 16:04 -0500, Joe Nall wrote:
> Should setsockcreate appear in the mls process write constraints in  
> policy/mls?
> 
> joe
> 
> mlsconstrain process { sigkill sigstop signal setsched setpgid setcap  
> setexec setfscreate setcurrent ptrace share }

I don't think it matters (likewise for the setcurrent/exec/fscreate
ones).  That's a check between the task and itself (we only allow a
process to change its own security attributes), so the level/range will
always be identical.  The important check is the one based on the label
that was set, which in that case would be the socket create check.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
