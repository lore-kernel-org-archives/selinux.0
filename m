Subject: Re: What's the relationship between existing mls files?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20041022144919.50063.qmail@web51510.mail.yahoo.com>
References: <20041022144919.50063.qmail@web51510.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1098458335.7614.182.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 22 Oct 2004 11:18:56 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-10-22 at 10:49, Park Lee wrote:
>         I've look through these files, and found that there are only a
> few differences among them, then what is the relationship between the
> two similar groups of files ?

Originally, the kernel security server (policy engine) and the
checkpolicy policy compiler were built from the same core code using
macros to generate appropriate code for kernel or userspace as
appropriate.  They share the same internal policy data structures and
have a shared knowledge of the binary policy format, and checkpolicy -d
also allowed exercising a userspace copy of the security server
functions for debugging purposes.  The source code was then subsequently
forked and has gradually diverged as the kernel code has been further
specialized.  The checkpolicy core code has more recently been pushed
into libsepol to allow re-use by other components and was reworked at
the same time to shed the legacy aspects.  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
