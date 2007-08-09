Subject: Re: java error after installing reference policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mark <elihusmails@gmail.com>
Cc: selinux@tycho.nsa.gov,
        "fedora-selinux-list@redhat.com" <fedora-selinux-list@redhat.com>
In-Reply-To: <9f066ee90708090815t514eddf6k7d02903d806d7c6c@mail.gmail.com>
References: <9f066ee90708090815t514eddf6k7d02903d806d7c6c@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 12:41:20 -0400
Message-Id: <1186677680.6916.589.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-09 at 11:15 -0400, Mark wrote:
> I followed the instructions for installing the latest reference
> policy: http://oss.tresys.com/projects/refpolicy/wiki/UseRefpolicy 

Why?  The stock Fedora policy is already refpolicy-based.
What kind of policy did you build (build.conf settings)?

> After rebooting, I get the following command when I run SLIDE: 
> 
> Java HotSpot(TM) Client VM warning: Attempt to allocate stack guard
> pages failed.
> Error occurred during initialization of VM
> Could not reserve enough space for code cache
> 
> I then tried just running "java -version", and I get the same error
> message. 
> 
> I am running Sun's JDK version 1.6 update 2.

Likely need to set booleans for execstack/execmem.  Or make sure java
runs in a domain that has those permissions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
