Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBALJGIi023652
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 16:19:16 -0500 (EST)
Subject: Re: Adding a new user domain
From: Nick Gray <nick-lists@austin.rr.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <1102709019.1628.192.camel@moss-spartans.epoch.ncsc.mil>
References: <1102624510.24067.8.camel@hawaii.grays-systems.com>
	 <1102624952.32175.249.camel@moss-spartans.epoch.ncsc.mil>
	 <1102627745.24067.22.camel@hawaii.grays-systems.com>
	 <1102683607.1628.3.camel@moss-spartans.epoch.ncsc.mil>
	 <1102709001.24067.41.camel@hawaii.grays-systems.com>
	 <1102709019.1628.192.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 10 Dec 2004 15:19:13 -0600
Message-Id: <1102713553.24067.59.camel@hawaii.grays-systems.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-12-10 at 15:03 -0500, Stephen Smalley wrote:
> On Fri, 2004-12-10 at 15:03, Nick Gray wrote:
> > I'm trying to reconcile the difference between SELinux and the current
> > practice of creating a privilege separated user and running a daemon as
> > that user.
> 
> For SELinux, you just define a domain for the daemon - you don't need
> separate SELinux user identities.  But you can certainly use a separate
> Linux uid and a SELinux domain for defense in depth.

I am thinking DISA would smack me on that one eventually since the SRRs
they have given me so far have just checked the system as a traditional
linux setup. After we are able to get to the next level, which includes
having a policy in place, we will work on checking the system with a
better focus on SELinux in particular.

> > I noticed that there is not an 'apache' user in the Core 3 setup even
> > with Apache installed and running. Is it the belief that the security
> > model is robust enough that this method of privilege separation is no
> > longer necessary. I guess I can see how that would be the case, it just
> > feels a little odd.
> 
> What?  I have an apache user on my system, and my httpd.conf says User
> apache.  But that is orthogonal to SELinux.

My mistake, I forgot that I removed apache from the install. I found the
Apache doc. and I am beginning the painful process of getting tomcat to
run under its own policy. Thanks. All content to be served will be
through tomcat

> > Where is the Apache doc? I think it should be able to use it in creating
> > the tomcat policy!
> 
> I don't think so, but here you go.  Please post questions re Fedora
> SELinux to the fedora selinux list, not just to me.  Also, have you read
> the Fedora SELinux FAQ?
> 
> http://fedora.redhat.com/docs/selinux-apache-fc3/
> http://fedora.redhat.com/docs/selinux-faq-fc3/
> 

Yes, I have read everything, several times, until until my brain hurts.
We need better step by step documentation as a foundation for promoting
this system. (i.e. there is no man page for 'runas')





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
