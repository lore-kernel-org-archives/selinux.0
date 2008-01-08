From: Paul Moore <paul.moore@hp.com>
To: tmiller@tresys.com
Subject: Re: [patch 0/2] policy capability support
Date: Tue, 8 Jan 2008 12:05:25 -0500
Cc: selinux@tycho.nsa.gov, method@manicmethod.com,
        Stephen Smalley <sds@tycho.nsa.gov>, dwalsh@redhat.com,
        cpebenito@tresys.com, kmacmillan@mentalrootkit.com
References: <20071206213852.083412876@tresys.com>
In-Reply-To: <20071206213852.083412876@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801081205.25197.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 06 December 2007 4:38:52 pm tmiller@tresys.com wrote:
> Updated policycap patch set based on recent discussion.  The
> consensus seems to be to only allow policycaps in the base module. 
> This is now enforced by the checkpolicy/checkmodule parser.

I haven't heard much about this patch lately - what is the current 
status?  I know Stephen had some minor comments but other than that I 
didn't see any objections ...

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
