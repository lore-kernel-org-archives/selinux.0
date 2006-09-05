Subject: Re: SE Linux API
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mark <elihusmails@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <9f066ee90609050644r4e38ec73x937b6dd51fb60251@mail.gmail.com>
References: <9f066ee90609050644r4e38ec73x937b6dd51fb60251@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 11:28:38 -0400
Message-Id: <1157470118.4014.140.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-09-05 at 09:44 -0400, Mark wrote:
> Is there documentation for the SE Linux API?  I would like to start
> getting familiar with the programming end of SE Linux.

There isn't an application development guide for SELinux, if that's what
you mean.  The guides and books I've seen have been focused on policy
writing, not application development.

libselinux includes man pages for (most of) its public functions, but
not a general overview/intro-style page.

There is a brief selinux-doc/PORTING guide I wrote a long time ago to
help in making the transition to the new SELinux API introduced in Linux
2.6; while it was oriented toward people making that transition and is a
bit old, it has some useful info.

Naturally, you can look at examples in libselinux/utils,
policycoreutils, and a wide range of modified packages in Fedora, e.g.
see
http://selinux.sourceforge.net/devel/userland.php3

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
