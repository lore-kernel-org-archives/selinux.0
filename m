Subject: Re: Question on type_member rule
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Rosalie Hiebel <rosalie.hiebel@L-3Com.com>
Cc: LSPP <redhat-lspp@redhat.com>, Janak Desai <jdesai@us.ibm.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <p06002038c130a6f940c3@[192.168.50.32]>
References: <p06002037c130476cd8d9@[192.168.50.32]>
	 <1158342058.18951.85.camel@moss-spartans.epoch.ncsc.mil>
	 <p06002038c130a6f940c3@[192.168.50.32]>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 16:32:56 -0400
Message-Id: <1158352376.18951.174.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-15 at 15:23 -0400, Rosalie Hiebel wrote:
> Thanks very much for the explanation of how the context of instance 
> directories is computed.  Once I added the proper type_member rule, 
> it was working as you described.

Ok, good.

> I want an application which runs at various MLS levels to see only 
> the instance  whose MLS level matches the process's MLS level; I 
> thought polyinstantiation by context would easily provide this.

If the application is security-aware and knows what level it is
operating in, it could just directly manage and access the proper
per-level instance directories.  No need to have it transparently
created and mounted in that situation.

Now, if the main application itself is security-aware, but you want it
to launch sub-applications that are untrusted and security-unaware, then
the main application could very well use pam_namespace to set up the
namespace in the child process prior to exec'ing the sub-application in
the desired level.  That would provide transparency to the
sub-applications as well as providing stronger isolation than doing
everything in the main application.

>    We 
> also would occasionally like certain processes to be able to see all 
> instances of it at or below the MLS level of the process.  Is this 
> possible with polyinstantiation?  (Would the user being in the list 
> of excluded uids be required?)

I think there are different options here, e.g.:
- put the user in the exclusion list to avoid creating a separate
namespace altogether, or
- directly access the instance directories if they live outside of the
polyinstantiated directory (as per namespace.conf), or
- unmount any bind mounts from the current namespace in order to see the
instance directories if they live within the polyinstantiated directory.

Or just create the process outside of anything that uses pam_namespace.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
