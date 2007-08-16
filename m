Subject: Re: confining the unconfined_t domain
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD0219DEFA@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD0219DEFA@blums0008.bluelnk.net>
Content-Type: text/plain
Date: Thu, 16 Aug 2007 14:07:02 -0400
Message-Id: <1187287622.909.72.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-16 at 10:15 -0700, Clarkson, Mike R (US SSA) wrote:
> I'd like to prevent the unconfined_t domain from executing certain files
> associated with domains that I've added. What is the best way to do
> this?
> 
> I was trying to track down how the unconfined_t domain is given the
> executable permissions to all executable files. I assume it is through
> the  exec_type attribute somehow. I found the
> corecmd_exec_all_executables and corecmd_mmap_all_executables interfaces
> in corecommands.if, which both give execute privilege to exec_type, but
> I don't see these being called from the unconfined module. Can someone
> point out how this privilege is provided to the unconfined_t domain?

Um, unconfined_t is "unconfined".  By definition.

And removing the ability to execute another program doesn't change what
unconfined_t can do (i.e. its actual permissions); it can always create
its own copy of the same code and execute it in unconfined_t.

Use a different domain if you want it to be confined.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
