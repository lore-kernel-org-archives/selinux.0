Date: Thu, 1 May 2008 23:22:36 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [RFC][PATCH v2] selinux:  support deferred mapping of contexts
In-Reply-To: <1209645099.25678.434.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0805012318440.4703@us.intercode.com.au>
References: <1209588984.25678.389.camel@moss-spartans.epoch.ncsc.mil>
 <Xine.LNX.4.64.0805010853300.2731@us.intercode.com.au>
 <1209639872.25678.409.camel@moss-spartans.epoch.ncsc.mil>
 <Xine.LNX.4.64.0805012209480.24536@us.intercode.com.au>
 <1209645099.25678.434.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 1 May 2008, Stephen Smalley wrote:

> the build host with no way to define it).  Or a mechanism for a
> hierarchy of policies (complex, and not clear how to handle objects as
> they may be visible to processes operating under more than one policy,
> e.g. both inside and outside of the chroot).

Indeed, this might be helped by encoding DOIs into labels but would likely 
add lots of complexity and performance overhead.  AFAICT, entities in 
different policy namespaces would need to be totally separated (unless 
purely hierarchical).


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
