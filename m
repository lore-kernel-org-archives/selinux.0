Subject: RE: Restorecon script
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
In-Reply-To: <1118437418.363.21.camel@localhost>
References: <200506101806.j5AI635F009168@gotham.columbia.tresys.com>
	 <1118427661.3720.36.camel@dhcp83-8.boston.redhat.com>
	 <1118437418.363.21.camel@localhost>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 17:30:45 -0400
Message-Id: <1118439045.4812.43.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-10 at 17:03 -0400, Joshua Brindle wrote:
> On Fri, 2005-06-10 at 14:21 -0400, Ivan Gyurdiev wrote:
> <snip>
> > 
> > The way to do that is by integrating ugly libselinux code into
> > a large number of applications. I think this will not be 
> > well received by the upstream developers at this time.
> > 
> 
> which is why the patches to upstream developers should either make the
> directory structure the app uses configurable or change it to use
> multiple directories. This is a good idea anyway, putting objects with
> different security properties into different places. This should be much
> more acceptable to an upstream developer than integrating "ugly
> libselinux code"

I don't see how it's possible to eliminate the problem of ambiguity
by creating more directories. Can you demonstrate an example,
where you do not need to create anything ahead of time,
and can rely on the app to create its own folders?

If you need to pre-create stuff, then you won't need selinux-aware
code in your apps. That's the approach we're taking.

Assuming this could be made to work (which I don't see how it can),
I don't see why it's a good idea to force directory structure based on
policy. Directories are made for grouping things, and security
properties may or may not be the criterion you'd like to use
for grouping. For example, the /tmp directory groups temporary files,
which obviously need to be of different contexts - hence this entire
problem.

>  SELinux on Red Hat is suppose to be transparent and this clearly
> is not.

This is strict policy only, not targeted.

>  If the rpm added the directories to user homedirs and labeled
> them the net effect would be the same. I really question how this can be
> thought of as anything other than an administrative issue. The admin
> installs the app, the app needs it's resources labeled, the admin (by
> way of rpm) should label the resources, I can't see how any other way
> makes sense.

Okay, I agree with this solution. It's not very clear how to implement
right now, but it is the right thing to do, eventually.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
