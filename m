Message-ID: <1346084656.9950.15.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: SELinux performance depending on type count
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ole Kliemann <ole@plastictree.net>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Date: Mon, 27 Aug 2012 12:24:16 -0400
In-Reply-To: <20120827152843.GD2168@telvanni>
References: <20120807130244.GE2085@telvanni>
	 <20120810213845.GQ2296@telvanni>
	 <1344861329.25589.16.camel@moss-pluto.epoch.ncsc.mil>
	 <20120827152843.GD2168@telvanni>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-08-27 at 17:28 +0200, Ole Kliemann wrote:
> On Mon, Aug 13, 2012 at 08:35:29AM -0400, Stephen Smalley wrote:
> > On Fri, 2012-08-10 at 23:38 +0200, Ole Kliemann wrote:
> > > [...]
> > >
> > > $ runcon -l s0:c0.c9999
> > > 
> > > Now I'm system_u:system_r:unconfined_t:s0:c0.c9999.
> > > I rerun the script. Average walltime is about 39sec.
> > > 
> > > Ouch! :-/
> > >
> > > [...]
> > 
> > I wonder how much of that time is spent on the chcon calls (i.e.
> > getxattr + setxattr) vs the actual accessing of the files.
> 
> I was away for some time, but in case you are still interested:
> 
> As can be seen with the attached script, the time it takes 
> accessing the files remains stable. Only creating and chcon'ing 
> files and dirs seems to be the problem. 
> 
> So for all of my purposes I consider this a non-issue.

Yes, that makes more sense to me.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
