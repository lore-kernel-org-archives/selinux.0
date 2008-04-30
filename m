Date: Thu, 1 May 2008 09:06:36 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC][PATCH v2] selinux:  support deferred mapping of contexts
In-Reply-To: <1209588984.25678.389.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0805010853300.2731@us.intercode.com.au>
References: <1209588984.25678.389.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 30 Apr 2008, Stephen Smalley wrote:

> As discussed in:
> http://marc.info/?t=120837952900003&r=1&w=2
> the ability to permit package managers and similar programs to set down
> unknown file contexts is still desired/required, not only for putting
> policy modules in packages but also for enabling build systems to create
> images of different distro releases with different policies w/o
> requiring all of the types to be defined in the build host policy.
> 

Does this solve all known issues for this case?  e.g. what if a script 
needs to be run by RPM on a file it just created ?  Does that ever happen?


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
