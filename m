Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0GIjfno018678
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 13:45:41 -0500
Received: from web36608.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l0GIkVAN016996
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 18:46:31 GMT
Message-ID: <20070116184620.75850.qmail@web36608.mail.mud.yahoo.com>
Date: Tue, 16 Jan 2007 10:46:20 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Current/Future Plans to Support Stacking LSM Modules
To: Tom Fortmann <tfortmann@xcapesolutions.net>, selinux@tycho.nsa.gov
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <002701c73999$4a9fe1c0$030a0a0a@ACER>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


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
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
