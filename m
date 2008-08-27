From: Paul Moore <paul.moore@hp.com>
To: Trent Jaeger <tjaeger@cse.psu.edu>
Subject: Re: Socket and inode label consistency
Date: Wed, 27 Aug 2008 14:34:04 -0400
Cc: Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
References: <1D98C7BF-3D76-4A9C-B43C-31BE0C57227B@cse.psu.edu> <1219860339.2910.22.camel@localhost.localdomain> <5680A933-013B-413E-8012-BD843F8C22BE@cse.psu.edu>
In-Reply-To: <5680A933-013B-413E-8012-BD843F8C22BE@cse.psu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808271434.04677.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 27 August 2008 2:20:48 pm Trent Jaeger wrote:
> On Aug 27, 2008, at 2:05 PM, Eric Paris wrote:
> >> Hi,
> >>
> >>
> >> What we want is to create a socket within the context of a
> >> multilevel secure process.  For example, if the process has an MLS
> >> range of s0-s1, we may want an s0 or s1 socket.
> >>
> >>
> >> Thus, in theory, we should be able to avoid dealing with context
> >> changes on connected sockets and such.  Once the socket goes into
> >> any use, it cannot be relabeled.
> >>
> >>
> >> I am not sure that setxattr will work as this is an inode
> >> operation, and I do not see a reference from an inode to an
> >> associated socket.
> >>
> >>
> >> Originally, I was thinking of setsockopt, but I agree that it
> >> would be
> >> nice to deal with it via the file interface, like fsetfilecon.
> >
> > /proc/self/attr/sockcreate and I know I wrote some libselinux stuff
> > around it too....
>
> OK.  We'll take a look.

Yeah, as others have said setsockcreatecon() is your friend here.  If 
you need a working example there is a test utility included in the 
audit-test project on sourceforge[1] which uses setsockcreatecon() to 
create some strangely labeled sockets.  If you download the audit-test 
sources the tool can be found in utils/network-server; it isn't the 
prettiest piece of code but it works ;)

If you have any questions or problems don't hesitate to ask.

[1] http://sourceforge.net/projects/audit-test

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
