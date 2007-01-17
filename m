Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0HK8Jch002673
	for <selinux@tycho.nsa.gov>; Wed, 17 Jan 2007 15:08:19 -0500
Received: from host496.ipowerweb.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l0HK9BaJ029243
	for <selinux@tycho.nsa.gov>; Wed, 17 Jan 2007 20:09:12 GMT
From: "Tom Fortmann" <tfortmann@xcapesolutions.net>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
References: <003801c739a6$461871f0$030a0a0a@ACER> <1168977133.22731.149.camel@moss-spartans.epoch.ncsc.mil>
Subject: RE: FW: Current/Future Plans to Support Stacking LSM Modules
Date: Wed, 17 Jan 2007 14:09:25 -0600
Message-ID: <006801c73a73$643b81e0$030a0a0a@ACER>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1168977133.22731.149.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen,

The security measures we are trying to implement require us to actually
inspect, and in some case modify, the application data flowing over a socket
connection.  Our goal is to secure legacy server applications at the socket
layer.  We have done some proof of concept work at the netfilter layer, but
the ultimate solution is better suited above the TCP/IP packet layer.

Does SELinux provide a mechanism for us to do this, and or does it call the
secondary LSM hooks that provide this type of access.  Specifically the
socket_xxxx hooks?

Thanks again for all of your help,
Tom

Thomas Fortmann
Sr. Software Engineer
Xcape Solutions, Inc.
-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Tuesday, January 16, 2007 1:52 PM
To: Tom Fortmann
Cc: selinux@tycho.nsa.gov
Subject: Re: FW: Current/Future Plans to Support Stacking LSM Modules

On Tue, 2007-01-16 at 13:41 -0600, Tom Fortmann wrote:
> Can you send me a pointer to the limited stacking that selinux supports?

http://www.nsa.gov/selinux/papers/module/x341.html

> I will join the LSM list.  I started here because LSM already supports a
> basic stacking method.  However, SELinux does not support the
> mod_reg_security call necessary to take advantage of this capability.  

No, SELinux does support trivial stacking by implementing a
register_security hook, which is what mod_reg_security() calls.  That is
used to combine SELinux with the Linux capabilities module.

> The product we are developing adds additional security at the application
> data layer.  It is a commercial product so I can't say a lot, other then
to
> say that SELinux currently does not provide the additional features we are
> working on.

If you are adding additional security at the application data layer,
then you can do that in userspace, and use SELinux Type Enforcement to
make it unbypassable and tamperproof.  You don't need to change the
kernel.

-- 
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
