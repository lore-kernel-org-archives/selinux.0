Subject: Re: bash: cd: /etc/selinux/strict/users/: No such file or directory
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Roger Brunell <rog_brunell@yahoo.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050516120907.86410.qmail@web60425.mail.yahoo.com>
References: <20050516120907.86410.qmail@web60425.mail.yahoo.com>
Content-Type: text/plain
Date: Mon, 16 May 2005 11:34:47 -0400
Message-Id: <1116257687.28782.85.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-05-16 at 05:09 -0700, Roger Brunell wrote:
> Folks;
>   This (the subject line) is immedaiately after doing a fresh load of policy
> 1.22 on a Knoppix (Debian derived) system.
> 
>   The home.dirs file was messed up; and I had just created a
> /etc/default/useradd file. a 'make reload' didn't fix the home.dir problem; so
> I deleted the entire /etc/selinux/strict subtree and reran the entire load
> process.
> 
>   I need to know what parts of the structure are needed to be made by hand?

Try 'make install load'.  It used to be the case that load depended on
install, but Dan Walsh decoupled them to avoid clobbering locally
customizable files upon a subsequent make load (so that updates to the
TE configuration wouldn't clobber local customizations to users or
booleans).  In any event, that particular error shouldn't be fatal; it
should just proceed to load the policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
