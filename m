Subject: Re: [RFC] semodule policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1140118126.13925.211.camel@sgc.columbia.tresys.com>
References: <1140118126.13925.211.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 15:58:10 -0500
Message-Id: <1140123490.12655.183.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-16 at 14:28 -0500, Christopher J. PeBenito wrote:
> I agree with Joshua, my current idea would be a .fc like (abbreviated):
> 
> modules				-d	selinux_config_t
> modules/(active|previous|tmp)(/.*)? 	semodule_store_t
> modules/semanage.read.LOCK	--	semodule_read_lock_t
> modules/semanage.trans.LOCK	--	semodule_trans_lock_t

Will libsemanage be modified to set and preserve the type on the lock
files?  How will it obtain the correct type for the lock files in the
bootstrap case where there is no file_contexts yet?  It would be easier
if they lived in separate subdirectories so that we could just use
directory inheritance, as with the installed kernel binary policy file
and the installed file_contexts file.  Top-level files
in /etc/selinux/$SELINUXTYPE have the same issue, like seusers and
setrans.conf, if we ever want them individually typed.  selinux_config_t
tends to be widely readable.

> Then semodule_t would have a dir type_transition on selinux_config_t.
> Then the rest of semodule_t policy should hopefully fall in place.

Should the domain be semanage_t to reflect use of libsemanage, and put
all three of semodule, setsebool, and semanage into it?

> As for /usr/share/selinux/$NAME/*.pp, I agree that they should have a
> different label, but I'm not sure they should be policy_config_t.
> 
> [1] http://marc.theaimsgroup.com/?l=selinux&m=113992576831596&w=2

Likely should add a new type for them.  Then we can possibly create
pipelines from their type to the store files via the approved programs.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
