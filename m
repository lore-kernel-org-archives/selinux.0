Subject: Re: apmd policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1127933375.32172.79.camel@sgc.columbia.tresys.com>
References: <1127933375.32172.79.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 14:36:09 -0400
Message-Id: <1128018969.27495.127.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-09-28 at 14:49 -0400, Christopher J. PeBenito wrote:
> In the apmd.te, what is the difference between the apm_t and apmd_t
> domains?  The naming make it very confusing.  By looking at the TE rules
> and file contexts, I'm guessing that apm_t is an interactive program.

Yes, looks that way.  /usr/bin/apm is the client program, /usr/sbin/apmd
is the daemon, and they each have their own domain.  man 1 apm describes
the user command on Fedora.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
