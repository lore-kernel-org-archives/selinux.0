Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7NF2tOb028840
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 11:02:55 -0400 (EDT)
Subject: Re: libselinux category patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <430B3049.5070402@redhat.com>
References: <430A33E5.1030100@redhat.com> <430B2D6A.5010105@tresys.com>
	 <430B3049.5070402@redhat.com>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 10:50:34 -0400
Message-Id: <1124808634.7874.72.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-08-23 at 10:18 -0400, Daniel J Walsh wrote:
> This code is not part of libselinux,  it is a library that SELinux calls 
> out to that will be specific to the vendor that ships it.
> I see this library being different between our version of MCS/MLS and 
> other third party versions of MLS, IE one that translates using the 
> Mitre Libraries.
> 
> MCS version of libtrans.so translates s0->"".
> 
> MLS policy can do what ever it wants with this part of the range.

While it is true that systems with a real MLS policy will likely have
their own libsetrans implementation, I think it would make sense to have
your default libsetrans implementation at least provide a way to map
sensitivity names as well as category names via the config file,
including a way to specify that they should just be dropped (e.g.
s0="").  Whether or not you should further allow mapping of entire
combinations, like s0:c0,c127=puritycontrol, via the config in your
default libsetrans implementation is more open to debate.

Also, how do you intend to deal with multiple libsetrans
implementations?  Symlink to the real translation library?  Managed via
the alternatives system?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
