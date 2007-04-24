Subject: Re: splice syscall
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <20070424190620.37853.qmail@web51507.mail.re2.yahoo.com>
References: <20070424190620.37853.qmail@web51507.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 16:00:03 -0400
Message-Id: <1177444803.24282.190.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-04-24 at 12:06 -0700, Steve G wrote:
> >Is the splice syscall controlled by SE Linux other than the initial creation of
> >the descriptors?
> 
> On second thought, you can mimick this syscall in user space, so I guess it
> doesn't matter. (The thought was that maybe it could be used to upgrade/downgrade
> information.)

The lack of security_file_permission() hook calls on the code path
should likely be corrected (so that access is revalidated on use, e.g.
to support revocation of access upon file relabel or policy change), but
SELinux checking would have been initially applied when the descriptor
was created, inherited, or transferred.  And if I understand correctly,
you are not relying on the read/write checking in general for LSPP, only
the open time checking, so this wouldn't be any different.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
