Subject: Re: Restorecon script
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
In-Reply-To: <20050610201814.GB8525@lkcl.net>
References: <200506101806.j5AI635F009168@gotham.columbia.tresys.com>
	 <1118427661.3720.36.camel@dhcp83-8.boston.redhat.com>
	 <20050610201814.GB8525@lkcl.net>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 16:54:17 -0400
Message-Id: <1118436857.4812.19.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-10 at 21:18 +0100, Luke Kenneth Casson Leighton wrote:
> On Fri, Jun 10, 2005 at 02:21:01PM -0400, Ivan Gyurdiev wrote:
> > >  If the files are under the user's
> > > control then they should be fully under their control. 
> > 
> > The way to do that is by integrating ugly libselinux code into
> > a large number of applications. I think this will not be 
> > well received by the upstream developers at this time.
>  
>  at some point, i believe that they are going to have to.
> 
>  developers use "chown()" and "chgrp()" etc. all the time.

This is different from chown and chgrp, because unlike chown and
chgrp, SElinux centralizes labeling decisions using regular
expressions. This makes the code slower.
Also, chown and chgrp are part of POSIX, whereas SElinux is not,
which makes the code non-portable. Also, SElinux is
not yet widely used, which means it has to be if-deffed out.
Also, it requires a library to be linked in, while chown
and chmod do not (other than libc).

Also, Stephen has mentioned that the current setfscreatecon
code does not work well with multiple threads.

Due to all of the above, adding SELinux code in applications
currently seems like a bad idea.

>  how about "auto-file-domaining" on chown() and chgrp(), in
>  a similar way that exec() performs auto-domain-transitioning?

Automatic transitions already exist, and are not sufficient.
A full regexp match is too slow to perform by default in all
cases.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
