Subject: Re: Fedora Core 5 Tomcat 4 problems
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: "Michael K. Smith" <mksmith@adhost.com>, SELinux@tycho.nsa.gov
In-Reply-To: <200605251323.13498.russell@coker.com.au>
References: <C099D5CE.24D51%mksmith@adhost.com>
	 <200605251323.13498.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 25 May 2006 07:35:51 -0400
Message-Id: <1148556951.20976.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-05-25 at 13:23 +1000, Russell Coker wrote:
> On Thursday 25 May 2006 02:20, "Michael K. Smith" <mksmith@adhost.com> wrote:
> > I am attempting to start Tomcat 4 using an rc script that uses the
> > unprivileged user "tomcat" to run the application.  The relevant line is:
> >
> > su -l tomcat -p -s /bin/bash -c /usr/local/tomcat/bin/startup.sh
> 
> The tomcat start script is broken, it should be using runuser instead.  Change 
> it to use runuser instead of su (runuser takes the same parameters so it's an 
> easy change) and many of the problems you list will go away.
> 
> Also please file a bug report requesting that runuser be used.

Has runuser been upstreamed, or generally ported to other distros yet?
Or is it still Fedora-specific?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
