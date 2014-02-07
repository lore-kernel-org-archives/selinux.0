Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s17LomYh020107
 for <selinux@tycho.nsa.gov>; Fri, 7 Feb 2014 16:50:48 -0500
Received: by mail-qa0-f46.google.com with SMTP id ii20so6111561qab.5
 for <selinux@tycho.nsa.gov>; Fri, 07 Feb 2014 13:50:27 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Ole Kliemann <ole@plastictree.net>,
 Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: RFC - Display context information using iproute2 ss utility
Date: Fri, 07 Feb 2014 16:50:22 -0500
Message-ID: <4844959.FlXfI971DN@sifl>
In-Reply-To: <20140207170325.GA10040@telmora.telvanni>
References: <1391790157.3514.YahooMailNeo@web87902.mail.ir2.yahoo.com>
 <20140207170325.GA10040@telmora.telvanni>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, February 07, 2014 06:03:25 PM Ole Kliemann wrote:
> On Fri, Feb 07, 2014 at 04:22:37PM +0000, Richard Haines wrote:
> > I've been patching the iproute2 "ss" utility to display the SELinux
> > security contexts for process and sockets, however I'm not sure
> > whether the socket contexts are correct (I expected most to show
> > system_u:object_r:....).
> > 
> > I'm taking the socket contexts from /proc/PID/fd as was mentioned in
> > a previous email regarding socket contexts - is this correct ??
> 
> I was doing it that way and it seemed to work ...

What you will see is the label of the socket's associated inode, not the 
actual socket label.

> ... I could even change the context using 'chcon /proc/PID/fd'.

Yes, you really shouldn't do that.  I've actually got a patch kicking around 
that I haven't had the time to test which will actually prevent you from 
changing a socket's inode label. 

> But I have no idea whether it is supposed to be a reliable way or
> any other methods exist. The whole sockfs thing kept me rather
> wondering...

It works as far as I know, it just turns out that it isn't quite what you 
think it is :)

-- 
paul moore
www.paul-moore.com
