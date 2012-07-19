Message-ID: <1342704589.31048.22.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Information about XSELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ole Kliemann <ole@plastictree.net>
Cc: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov,
        Daniel J
 Walsh <dwalsh@redhat.com>
Date: Thu, 19 Jul 2012 09:29:49 -0400
In-Reply-To: <20120716221818.GA16156@telvanni>
References: <20120716161006.GA14824@telvanni>
	 <201207170423.14495.russell@coker.com.au> <20120716221818.GA16156@telvanni>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-07-17 at 00:18 +0200, Ole Kliemann wrote:
> On Tue, Jul 17, 2012 at 04:23:14AM +1000, Russell Coker wrote:
> > On Tue, 17 Jul 2012, Ole Kliemann <ole@plastictree.net> wrote:
> > > Is it included in any major distributions? (Currently using 
> > > Ubuntu 12.04)
> > 
> > Unless Ubuntu have done some significant enhancements over my Debian work 
> > without telling me then it's not going to work.
> 
> I'm no expert, but as far as I can tell, it's just not there in 
> Ubuntu.
> 
> I understood from a bug report on this list that it's included in 
> Fedora. So I installed it on a test system and could reproduce 
> the bug (X server fails to start when xserver_object_manager is 
> set). 
> 
> I'm willing to switch to whatever distribution is providing the 
> means to seperate user contexts under X.

XSELinux is included in Fedora, but they don't enable it by default so
it doesn't get much testing.  They took a different approach for
isolating X applications via nested Xephyr servers in their sandbox
tool.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
