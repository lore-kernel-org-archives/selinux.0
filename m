Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s1HLcOeM022221
 for <selinux@tycho.nsa.gov>; Mon, 17 Feb 2014 16:38:27 -0500
Received: by mail-qa0-f44.google.com with SMTP id w5so22761153qac.31
 for <selinux@tycho.nsa.gov>; Mon, 17 Feb 2014 13:38:26 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Ole Kliemann <ole@plastictree.net>
Subject: Re: RFC - Display context information using iproute2 ss utility
Date: Mon, 17 Feb 2014 16:38:23 -0500
Message-ID: <3213184.Z7JC3Pg3ZO@sifl>
In-Reply-To: <20140217201021.GA2741@telmora.telvanni>
References: <1391790157.3514.YahooMailNeo@web87902.mail.ir2.yahoo.com>
 <4844959.FlXfI971DN@sifl> <20140217201021.GA2741@telmora.telvanni>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Monday, February 17, 2014 09:10:21 PM Ole Kliemann wrote:
> On Fri, Feb 07, 2014 at 04:50:22PM -0500, Paul Moore wrote:
> > On Friday, February 07, 2014 06:03:25 PM Ole Kliemann wrote:
> > > On Fri, Feb 07, 2014 at 04:22:37PM +0000, Richard Haines wrote:
> > > > I've been patching the iproute2 "ss" utility to display the SELinux
> > > > security contexts for process and sockets, however I'm not sure
> > > > whether the socket contexts are correct (I expected most to show
> > > > system_u:object_r:....).
> > > > 
> > > > I'm taking the socket contexts from /proc/PID/fd as was mentioned in
> > > > a previous email regarding socket contexts - is this correct ??
> > > 
> > > I was doing it that way and it seemed to work ...
> > 
> > What you will see is the label of the socket's associated inode, not the
> > actual socket label.
> > 
> > > ... I could even change the context using 'chcon /proc/PID/fd'.
> > 
> > Yes, you really shouldn't do that.  I've actually got a patch kicking
> > around that I haven't had the time to test which will actually prevent
> > you from changing a socket's inode label.
> > 
> > > But I have no idea whether it is supposed to be a reliable way or
> > > any other methods exist. The whole sockfs thing kept me rather
> > > wondering...
> > 
> > It works as far as I know, it just turns out that it isn't quite what you
> > think it is :)
> 
> Thanks for clarification.
> 
> On a related question: Is it the same with pipes? I just
> realized, in one of my programs I am actually using setfilecon on
> /proc/self/fd/some_pipe to change the context of a pipe.
> 
> Do I have to expect this to break in a later kernel patch?
> 
> If yes, what would be the correct way? Do I have to use explicit
> FIFO files to be able to do this?

As you've probably figured out by now, sockets are just a little bit odd from 
a SELinux point of view.  The good news, in relation to your question, is that 
pipes are entirely different from sockets from a SELinux perspective.  Pipes 
should behave like normal fds with no hidden labels/properties.

-Paul

-- 
paul moore
www.paul-moore.com
