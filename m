Date: Fri, 10 Jun 2005 21:18:14 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <gyurdiev@redhat.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
Subject: Re: Restorecon script
Message-ID: <20050610201814.GB8525@lkcl.net>
References: <200506101806.j5AI635F009168@gotham.columbia.tresys.com> <1118427661.3720.36.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1118427661.3720.36.camel@dhcp83-8.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 10, 2005 at 02:21:01PM -0400, Ivan Gyurdiev wrote:
> >  If the files are under the user's
> > control then they should be fully under their control. 
> 
> The way to do that is by integrating ugly libselinux code into
> a large number of applications. I think this will not be 
> well received by the upstream developers at this time.
 
 at some point, i believe that they are going to have to.

 developers use "chown()" and "chgrp()" etc. all the time.

 the people developing selinux have done a _great_ job designing
 something that covers nearly all of the cases.

 ... idea for you.
 
 how about "auto-file-domaining" on chown() and chgrp(), in
 a similar way that exec() performs auto-domain-transitioning?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
