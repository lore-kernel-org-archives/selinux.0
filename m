Subject: Re: ainit
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   fedora-selinux-list@redhat.com
In-Reply-To: <200507212142.28830.russell@coker.com.au>
References: <200507212142.28830.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 25 Jul 2005 10:18:53 -0400
Message-Id: <1122301133.2351.44.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-07-21 at 21:42 +1000, Russell Coker wrote:
> The attached patch is needed for correct functionality of ainit with the 
> latest strict policy when running reasonably recent rawhide packages.
> 
> Is this really what we want?  Having a system process allocate shared memory 
> that can be used by any user processes?  Also it seems likely that other 
> sound programs will need to access the shared memory in question.

Not a good idea.  Look at nscd handling for its shmem interface; we use
an attribute to allow certain domains such access, but most domains are
limited to the socket IPC-based interface.  This program should likewise
have some kind of fallback to an IPC-based interface if the shmem
interface isn't allowed.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
