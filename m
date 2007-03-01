Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l21FguD3004736
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 10:42:56 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l21FiKOE002586
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 15:44:20 GMT
Subject: Re: Added application_exec_type patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45E5E54F.1@redhat.com>
References: <45E5E54F.1@redhat.com>
Content-Type: text/plain
Date: Thu, 01 Mar 2007 10:44:38 -0500
Message-Id: <1172763878.11157.104.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-28 at 15:25 -0500, Daniel J Walsh wrote:
> This patch  an attribute  of application_exec_type to any executable 
> that can be executed by a user. 

The domains also need to be collected (minus the ones that we discussed
on IRC, like cvs and rsync) into an attribute.  Then we should be able
to apply that towards fixing the ssh command line/sockets problem (where
the incoming client has done something like "ssh
myserver /usr/bin/passwd").

> I have only patched the executables that currently transition to a 
> domain if run under inetd or init, but do not transition if run by a user.

The stuff in the apps layer will have to be covered too.  They may have
policies, but they're still applications.  Their domain transitions will
still happen.

> Also changed corecommand_exec_any to only execute executables that a 
> user is supposed to run.  So if sysadm_t tries to execute a dameon 
> directly it will get a permission denied.

This interface has to remain the same.  "All executables" actually has
to mean all executables for the semantics of the interface to be
maintained.  If we want sysadm's behavior to be the above, it is the one
that needs to change.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
