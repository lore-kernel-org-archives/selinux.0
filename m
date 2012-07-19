Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6JH1pii017045
	for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2012 13:01:51 -0400
Message-ID: <1342717308.5578.YahooMailClassic@web87704.mail.ir2.yahoo.com>
Date: Thu, 19 Jul 2012 18:01:48 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: Information about XSELinux
To: Ole Kliemann <ole@plastictree.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20120719141823.GA19890@telvanni>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Because the XSELinux extension is now in xorg source this is where the bug is located. I think it is an isolated case as the Xi services had been extended to introduce device ids 0 & 1 that are not real device IDs, this caused XSELinux a problem as they do not have devPrivates which means no context can be applied - hence crash.

When X is built, xorg do check for errors in XSELinux as they have fixed an selabel_open problem.

Richard

--- On Thu, 19/7/12, Ole Kliemann <ole@plastictree.net> wrote:

> From: Ole Kliemann <ole@plastictree.net>
> Subject: Re: Information about XSELinux
> To: "Richard Haines" <richard_c_haines@btinternet.com>
> Cc: selinux@tycho.nsa.gov
> Date: Thursday, 19 July, 2012, 15:18
> Thanks Richard, your X-setest tool is
> quite helpful to understand 
> what's going on.
> 
> Under Ubuntu I compiled the xserver-xorg package and
> manually 
> enabled --enable-selinux. Now it's working here. (They are
> at 
> 1.11.4). I'm now writing a simple policy from scratch to
> extend 
> traditional linux user seperation to X.
> 
> I have one question though: This bug that appears under
> Fedora 
> and crashes the Xserver, is that a bug in the xorg sources
> or 
> something that came with patches from Fedora?
> 
> And how often have things like this happend in the past? I'm
> 
> planing on using this on a production system and ask myself
> how 
> careful I will have to be with updates to xorg in the
> future.
> 
> On Tue, Jul 17, 2012 at 03:22:46PM +0100, Richard Haines
> wrote:
> > I've attached some updated XSELinux information that
> I've been working on for the next version of the SELinux
> Notebook (old XSELinux stuff at: http://selinuxproject.org/page/NB_XWIN).
> > 
> > The XSELinux module is in the X source and always
> included with Fedora - I don't use other distributions so
> don't know whether they enable it in their builds or not. If
> they do build it, then you need the reference policy modules
> and then enable the xserver boolean as follows:
> > 
> >      setsebool xserver_object_manager true
> > 
> > I'm not sure what the current development status is but
> I've submitted a couple of patches (the last one for
> xorg-x11-server-1.12.2 as it core dumps when XSELinux is
> enabled with the above boolean).
> > 
> > I've written a few apps to 'play with XSELinux' that
> are mentioned in the text. Let me know if you would like the
> source (tested on Fedora 16/17).
> > 
> > I have not really done anything with the XSELinux
> reference policy modules as they come with Fedora and seem
> to work (well for my limited use anyway).
> > 
> > Richard
> > 
> > --- On Mon, 16/7/12, Ole Kliemann <ole@plastictree.net>
> wrote:
> > 
> > > From: Ole Kliemann <ole@plastictree.net>
> > > Subject: Information about XSELinux
> > > To: selinux@tycho.nsa.gov
> > > Date: Monday, 16 July, 2012, 17:10
> > > Hi everyone!
> > > 
> > > I'm desperately trying to implement proper
> privilege
> > > seperation 
> > > while using X.
> > > 
> > > Currently I'm looking into XSELinux but am having
> a really
> > > hard 
> > > time finding any information, documention etc.
> > > 
> > > What's the development status?
> > > Where can I get it?
> > > Is it included in any major distributions?
> (Currently using
> > > 
> > > Ubuntu 12.04)
> > > 
> > > Any hint on where to find information would be
> highly 
> > > appreciated!
> > > 
> > > Many thanks in advance and best regards,
> > > Ole
> > >
> 
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
