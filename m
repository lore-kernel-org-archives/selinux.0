Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5B5FLgA025256
	for <selinux@tycho.nsa.gov>; Sat, 11 Jun 2005 01:15:21 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5B57dmF021830
	for <selinux@tycho.nsa.gov>; Sat, 11 Jun 2005 05:07:39 GMT
Date: Fri, 10 Jun 2005 23:11:46 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <gyurdiev@redhat.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
Subject: Re: Restorecon script
Message-ID: <20050610221146.GJ8525@lkcl.net>
References: <200506101819.j5AIJi5F009499@gotham.columbia.tresys.com> <1118428283.3720.45.camel@dhcp83-8.boston.redhat.com> <20050610202629.GF8525@lkcl.net> <1118440668.4812.68.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1118440668.4812.68.camel@dhcp83-8.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 10, 2005 at 05:57:48PM -0400, Ivan Gyurdiev wrote:
> 
> > > Who will create /tmp/orbit and /tmp/gconfd, and how will you
> > > get them to have different types? 
> >  
> >  a special selinux-aware library, that all gconfd-aware programs and
> >  orbit-aware programs must utilise, respectively.
> > 
> >  heck, it could even do the setfilecon() for you.
> 
> That library is libselinux. I've already tried this,
> and it doesn't work very well, for the reasons mentioned in my chown()
> email.
 
 sorry, i introduced two issues in my email: the one about chown() was
 just a thought tacked on to the end.

 please ignore and totally disassociate any thought about chown() from
 the "/tmp/<DIR>/.SOCKET-$USER" idea.

 
> ==========
> 
> I do agree with the other comments, however, that a per application
> solution is appropriate. 

 you mean a per-application-or-better-per-client-server group
 (gconfd is just the server...)

 which implies two functions: one for creating the socket in the right
 place (and the subdirectory if appropriate, hence there is a place
 where selinux could be introduced, if appropriate, to set the
 appropriate permissions: almost undoubtedly this will be needed).

 one for connection _to_ the socket.

> For /tmp, we can we can implement a tmpskel
> similar to /skel that gets created at init.

> Please consider that this script was just yesterday's solution to make
> the policy usable. I do realize that it has drawbacks, and does not
> work well in the long run, so thanks for the comments.
> 
> The important thing to me is the agreement that creating folders
> ahead of time is the right thing to do. The mechanism for doing
> that can be changed.
> 
> 

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
-

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
