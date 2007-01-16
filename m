Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0GJe8WS020795
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 14:40:08 -0500
Received: from host496.ipowerweb.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l0GJf11E015157
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 19:41:01 GMT
From: "Tom Fortmann" <tfortmann@xcapesolutions.net>
To: <selinux@tycho.nsa.gov>
Subject: FW: Current/Future Plans to Support Stacking LSM Modules
Date: Tue, 16 Jan 2007 13:41:10 -0600
Message-ID: <003801c739a6$461871f0$030a0a0a@ACER>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Can you send me a pointer to the limited stacking that selinux supports?

I will join the LSM list.  I started here because LSM already supports a
basic stacking method.  However, SELinux does not support the
mod_reg_security call necessary to take advantage of this capability.  

The product we are developing adds additional security at the application
data layer.  It is a commercial product so I can't say a lot, other then to
say that SELinux currently does not provide the additional features we are
working on.

Thomas Fortmann
Sr. Software Engineer
Xcape Solutions, Inc.

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
Behalf Of Casey Schaufler
Sent: Tuesday, January 16, 2007 12:46 PM
To: Tom Fortmann; selinux@tycho.nsa.gov
Cc: linux-security-module@vger.kernel.org
Subject: Re: Current/Future Plans to Support Stacking LSM Modules


--- Tom Fortmann <tfortmann@xcapesolutions.net> wrote:

> Are their any current or future plans to support
> stacking additional
> security modules on the LSM interface?

It has certainly been considered from
time to time. David Wheeler's early work
came pretty close.

> Alternatively, are there any current or future plans
> to allow the SELinux
> framework to be expanded with third party loadable
> modules?

SELinux does currently, although somewhat
begrudgingly, allow limited stacking in
support of a particular set of modules. 

It wasn't but a year ago that the SELinux
community was arguing that LSM ought to be
dispensed with, as they argued that:
  - No one else was using LSM
  - SELinux does everything that a rational
    being might want done anyway.

> We are working on some enhanced security solutions
> that require access to
> the LSM interface, but we do not want to preclude
> the use of SELinux by our
> customers.

You might take this onto the LSM list (I've
added it to the CC here) as there are a (very)
few people who follow LSM that do not subscribe
here.

Just out of curiosity, what's your module
going to do?


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
