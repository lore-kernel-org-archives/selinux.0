Subject: Re: Frame Pointer build error
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ccallen <ccallen@windowpane.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <00ce01c303f0$c1f37c60$398314d1@windowpane.com>
References: <00ce01c303f0$c1f37c60$398314d1@windowpane.com>
Content-Type: text/plain
Message-Id: <1050497783.2682.38.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 16 Apr 2003 08:56:25 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-04-16 at 04:18, ccallen wrote:
> While building lsm-2.5-selinux-20003040709 I recieved an error from
> /lsm-2.5/init/main.c saying that the compiler cant handle frame pointers (I
> turned it off for now). Is there a piticular version of gcc thats best to
> use?

Unfortunately, the test in init/main.c flags all instances of gcc 2.96
as being broken, whereas not all are.  See
http://marc.theaimsgroup.com/?l=linux-kernel&m=104748366426351&w=2.  If
you want to be conservative, the Documentation/Changes file describes
gcc version requirements for the kernel; gcc 2.95.3 still seems to be
the recommended one for x86.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
