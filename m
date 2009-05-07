Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n47HFMCR023176
	for <selinux@tycho.nsa.gov>; Thu, 7 May 2009 13:15:22 -0400
Subject: Re: [PATCH] libsemanage: Add Ruby Bindings
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4A03161A.60206@manicmethod.com>
References: <1241708115-30840-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <4A03161A.60206@manicmethod.com>
Content-Type: text/plain
Date: Thu, 07 May 2009 13:11:11 -0400
Message-Id: <1241716271.6624.1.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-05-07 at 13:10 -0400, Joshua Brindle wrote:
> David P. Quigley wrote:
> > From: David P. Quigley <dpquigl@moss-guppy.epoch.ncsc.mil>
> > 
> > This patch adds a SWIG specification file for ruby bindings for libsemanage.
> > The spec file is almost identical to the python SWIG file with the exception
> > that all list generating typemaps have been removed and the python related
> > functions have been replaced with the corresponding ruby ones. Finally the
> > Makefile is modified to be able to build the new bindings. Something to note is
> > that on 64-bit systems ruby.h might be found somewhere under /usr/lib64 instead
> > of /usr/lib so LIBDIR=/usr/lib64 will be needed to build the ruby bindings from
> > source.
> 
> What is going to be using these bindings?

I currently have several Facter addons for Puppet that make use of them.
We are looking into what can be done to expand Puppet's ability to
effectively manage systems with SELinux. 

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
