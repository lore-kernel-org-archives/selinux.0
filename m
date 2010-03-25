Subject: Re: svirt on MLS has strange AVC.
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Paul Moore <paul.moore@hp.com>,
        "Daniel P. Berrange" <berrange@redhat.com>,
        SELinux
 <selinux@tycho.nsa.gov>, Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <1269542084.1031.52.camel@moss-pluto.epoch.ncsc.mil>
References: <4BA7E4BF.1040002@redhat.com>
	 <1269484959.2925.9.camel@dhcp235-240.rdu.redhat.com>
	 <1269525768.1031.9.camel@moss-pluto.epoch.ncsc.mil>
	 <201003251249.48641.paul.moore@hp.com>
	 <1269540418.1031.34.camel@moss-pluto.epoch.ncsc.mil>
	 <4BABA73B.6030306@redhat.com>
	 <1269541433.2980.7.camel@dhcp231-113.rdu.redhat.com>
	 <1269542084.1031.52.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 25 Mar 2010 14:45:13 -0400
Message-ID: <1269542713.2980.14.camel@dhcp231-113.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-03-25 at 14:34 -0400, Stephen Smalley wrote:

> But the behavior for the new connection/server socket was changed for
> MLS during the LSPP work to reflect the level of the client.  This makes
> sense when you have a single-level client connecting to a ranged server
> - the connection is then established at the requesting level and the
> traffic is labeled and protected accordingly.

I still don't understand why MLS is some 'other' class citizen of the
context.  If it makes sense to reflect the level it should make sense to
reflect the type, and role, and user, if they are available.  Doesn't
it?  I know that some labeling magic (CIPSO) don't deal with anything
but the level and thus the only thing we can/should do is play with the
level, but when we have the info (unix domain sockets and I think some
IPSec labeling right), why do we discard that additional info that makes
these things 'make sense'?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
