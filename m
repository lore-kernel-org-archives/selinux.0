Date: Thu, 1 May 2008 22:11:06 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [RFC][PATCH v2] selinux:  support deferred mapping of contexts
In-Reply-To: <1209639872.25678.409.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0805012209480.24536@us.intercode.com.au>
References: <1209588984.25678.389.camel@moss-spartans.epoch.ncsc.mil>
 <Xine.LNX.4.64.0805010853300.2731@us.intercode.com.au>
 <1209639872.25678.409.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 1 May 2008, Stephen Smalley wrote:

> It isn't a perfectly general solution, of course.
> 
> An alternative approach would be for rpm to load policy at least
> defining the types first before setting down the files, which was our
> original preference, but that wasn't viewed as workable by the distro
> folks.  It might be easier if we had a specific SELinux kernel interface
> (i.e. another selinuxfs node) that permitted adding types w/o performing
> a complete policy reload.

I gather the problem is build hosts where you don't want to give that much 
privilege to users.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
