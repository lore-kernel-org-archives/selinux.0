Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5AMPHgA023652
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 18:25:17 -0400 (EDT)
Received: from free.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5AMHC1O004512
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 22:17:12 GMT
Date: Fri, 10 Jun 2005 21:21:26 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: gyurdiev@redhat.com, "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
Subject: Re: Restorecon script
Message-ID: <20050610202126.GC8525@lkcl.net>
References: <1118426293.3720.14.camel@dhcp83-8.boston.redhat.com> <200506101819.j5AIJi5F009499@gotham.columbia.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200506101819.j5AIJi5F009499@gotham.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 10, 2005 at 02:19:44PM -0400, Karl MacMillan wrote:

> > I don't see how it's possible to solve this problem just by
> > restructuring directories. Can you give an example of how
> > the gconf-vs-orbit problem can be solved - see the file_type_auto_trans
> > thread for full description.
> > 
> 
> I thought this was answered - they need to be put in separate directories, e.g.
> /tmp/orbit/orbit-$USER and /tmp/gconfd/gconfd-$USER. That way /tmp/orbit and
> /tmp/gconfd can have different types and the only changes required for orbit and
> gconfd are to put their files in a different location. If /tmp is tmpfs there
> needs to be a script that creates these directories with the correct labels at
> boot.

 and a solution to the "i can't do that because there are so many
 applications implicitly utilising /tmp/orbit-$USER, /tmp/gconfd-$USER,
 /tmp/.ICE-unix, /tmp/.font-unix, /tmp/.X11-unix, is to create a
 runtime-configurable library that can be told "use
 /tmp/<DIR>/.xxx-$USER instead of /tmp/.xxx-$USER".

 once all programs use the library, change the location.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
