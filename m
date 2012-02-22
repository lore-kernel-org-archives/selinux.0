Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1MJoGBp030945
	for <selinux@tycho.nsa.gov>; Wed, 22 Feb 2012 14:50:16 -0500
Message-ID: <4F4546F6.5050603@tresys.com>
Date: Wed, 22 Feb 2012 14:50:14 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Paul Menzel <paulepanter@users.sourceforge.net>
CC: <selinux@tycho.nsa.gov>
Subject: Re: No feedback when cloning `http://oss.tresys.com/git/selinux.git`
References: <1329939142.3296.5.camel@mattotaupa>
In-Reply-To: <1329939142.3296.5.camel@mattotaupa>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/22/12 14:32, Paul Menzel wrote:
> Dear SELinux folks,
> 
> 
> trying to clone the SELinux user space programs [1] I issue
> 
> 
>         $ git clone http://oss.tresys.com/git/selinux.git
>         Cloning into 'selinux'...
> 
> but it just hangs there. So I thought it does not work. Letting it stay
> for more than a minute it finished. Other Git repositories give some
> kind of feedback. Are some hooks missing?

Are you sure you're waiting long enough?  I was able to clone a fresh copy of the repo using the above command w/o problem.  It took 48s for me.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
