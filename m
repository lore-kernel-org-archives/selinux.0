Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5AM68gA023437
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 18:06:08 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5ALw31O003327
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 21:58:03 GMT
Subject: Re: Restorecon script
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
In-Reply-To: <20050610202629.GF8525@lkcl.net>
References: <200506101819.j5AIJi5F009499@gotham.columbia.tresys.com>
	 <1118428283.3720.45.camel@dhcp83-8.boston.redhat.com>
	 <20050610202629.GF8525@lkcl.net>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 17:57:48 -0400
Message-Id: <1118440668.4812.68.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > Who will create /tmp/orbit and /tmp/gconfd, and how will you
> > get them to have different types? 
>  
>  a special selinux-aware library, that all gconfd-aware programs and
>  orbit-aware programs must utilise, respectively.
> 
>  heck, it could even do the setfilecon() for you.

That library is libselinux. I've already tried this,
and it doesn't work very well, for the reasons mentioned in my chown()
email.

==========

I do agree with the other comments, however, that a per application
solution is appropriate. For /tmp, we can we can implement a tmpskel
similar to /skel that gets created at init.

Please consider that this script was just yesterday's solution to make
the policy usable. I do realize that it has drawbacks, and does not
work well in the long run, so thanks for the comments.

The important thing to me is the agreement that creating folders
ahead of time is the right thing to do. The mechanism for doing
that can be changed.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
