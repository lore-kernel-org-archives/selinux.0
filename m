Subject: RE: Restorecon script
From: Joshua Brindle <jbrindle@tresys.com>
To: gyurdiev@redhat.com
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
In-Reply-To: <1118427661.3720.36.camel@dhcp83-8.boston.redhat.com>
References: <200506101806.j5AI635F009168@gotham.columbia.tresys.com>
	 <1118427661.3720.36.camel@dhcp83-8.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 17:03:38 -0400
Message-Id: <1118437418.363.21.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-10 at 14:21 -0400, Ivan Gyurdiev wrote:
<snip>
> 
> The way to do that is by integrating ugly libselinux code into
> a large number of applications. I think this will not be 
> well received by the upstream developers at this time.
> 

which is why the patches to upstream developers should either make the
directory structure the app uses configurable or change it to use
multiple directories. This is a good idea anyway, putting objects with
different security properties into different places. This should be much
more acceptable to an upstream developer than integrating "ugly
libselinux code"

> > What if I am waiting to
> > relabel my ~/public_html until I am done with the content and this administrator
> > controlled script does it for me?
> 
> The script is only invoked when you launch a login shell (this is
> actually a problem). Also, it does not do anything with public_html.
> 
> 
Not sure if this is the problem you are referring but it seems awefully
awkward to me to require a user to open a login shell after installing
an app. SELinux on Red Hat is suppose to be transparent and this clearly
is not. If the rpm added the directories to user homedirs and labeled
them the net effect would be the same. I really question how this can be
thought of as anything other than an administrative issue. The admin
installs the app, the app needs it's resources labeled, the admin (by
way of rpm) should label the resources, I can't see how any other way
makes sense.





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
