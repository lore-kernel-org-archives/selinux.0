From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Fedora Core 5 Tomcat 4 problems
Date: Fri, 26 May 2006 11:04:57 +1000
Cc: "Michael K. Smith" <mksmith@adhost.com>, SELinux@tycho.nsa.gov
References: <C099D5CE.24D51%mksmith@adhost.com> <200605251323.13498.russell@coker.com.au> <1148556951.20976.11.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1148556951.20976.11.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605261105.01703.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 25 May 2006 21:35, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2006-05-25 at 13:23 +1000, Russell Coker wrote:
> > On Thursday 25 May 2006 02:20, "Michael K. Smith" <mksmith@adhost.com> 
wrote:
> > > I am attempting to start Tomcat 4 using an rc script that uses the
> > > unprivileged user "tomcat" to run the application.  The relevant line
> > > is:
> > >
> > > su -l tomcat -p -s /bin/bash -c /usr/local/tomcat/bin/startup.sh
> >
> > The tomcat start script is broken, it should be using runuser instead. 
> > Change it to use runuser instead of su (runuser takes the same parameters
> > so it's an easy change) and many of the problems you list will go away.
> >
> > Also please file a bug report requesting that runuser be used.
>
> Has runuser been upstreamed, or generally ported to other distros yet?
> Or is it still Fedora-specific?

It is specific to Fedora.

For Debian the best solution is to modify start-stop-daemon, this is on my 
todo list.  For Gentoo the best solution is to modify the program that they 
use to start daemons (not sure of the name but know that they have one).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
