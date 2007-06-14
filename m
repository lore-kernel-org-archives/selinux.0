Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5EIIhTj022142
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 14:18:44 -0400
Received: from mail4.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5EIIgtB003128
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 18:18:42 GMT
Date: Thu, 14 Jun 2007 14:18:38 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Chad Sellers <csellers@tresys.com>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of capabilities
In-Reply-To: <1181843177.17547.667.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Line.LNX.4.64.0706141414360.19417@localhost.localdomain>
References: <C296D9C6.23423%csellers@tresys.com>
 <1181836512.17547.640.camel@moss-spartans.epoch.ncsc.mil>
 <1181836985.17547.645.camel@moss-spartans.epoch.ncsc.mil>
 <Line.LNX.4.64.0706141250100.18953@localhost.localdomain>
 <1181843177.17547.667.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 14 Jun 2007, Stephen Smalley wrote:

> In the short term though, I don't expect distros to make a wholesale
> removal of suid bits, whether for this support or for file capabilities
> support.  It would tend to get used incrementally by newer developments,
> and possibly retroactively applied by security-oriented specialized
> distros and custom built ones (which tend to disable permissive mode and
> selinux=disabled altogether in their kernel configs).

Agreed.  Applied selectively, I think it would definitely help people see 
the value of SELinux, but should not be enabled by default in a distro at 
this stage :-)


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
