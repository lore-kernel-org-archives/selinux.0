From: Steve Grubb <sgrubb@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: checking user status
Date: Wed, 19 Aug 2009 10:36:20 -0400
Cc: Daniel J Walsh <dwalsh@redhat.com>, Larry Ross <selinux.larry@gmail.com>,
        selinux@tycho.nsa.gov
References: <81092d890908161153h38ae37fdx9123ecea3adb6d51@mail.gmail.com> <4A8AEE9E.1020102@redhat.com> <1250692461.3629.309.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1250692461.3629.309.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200908191036.26365.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 19 August 2009 10:34:21 am Stephen Smalley wrote:
> I do agree that the callers should be modified to use the userspace AVC;
> then they would pick up the normal avc auditing support (but would need
> to set up the proper callback to invoke the audit interfaces, just like
> dbusd does).

Right. Also libaudit has the functions in place to correctly handle encoding 
if they are needed.

> I think the bug would be against shadow-utils.  Did anyone already open
> it?

It would be against password.

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
