Subject: Re: What's the relationship between existing mls files?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20041022171255.77893.qmail@web51507.mail.yahoo.com>
References: <20041022171255.77893.qmail@web51507.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1098467023.7614.299.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 22 Oct 2004 13:43:43 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-10-22 at 13:12, Park Lee wrote:
> Then, If I change one of the files, I must change it's countpart, Am I
> right?

If you make a change to anything that affects the security server logic
or the binary policy format, then you need to change both the libsepol
code and the kernel code, yes.  You could revise the internal data
structures of one or the other without necessarily changing the other,
e.g. for optimization purposes, as long as the logic itself remains
consistent and the binary policy format is unchanged.  But it is
preferable to keep the code as consistent as possible.

> Don't the kernel code and the core code refer to the same thing?
> (please forgive my ignorance)

As I said, originally checkpolicy was built from the same core source
code as the kernel security server using macros to convert kernel types
and APIs to corresponding userland ones, but the code was forked to
allow specialization and to avoid requiring a copy of the kernel source
tree for building checkpolicy.  So the libsepol code and the
linux-2.6/security/selinux/ss code originated from the same code base
and implements the same basic logic.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
