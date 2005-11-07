Subject: Re: [ SEMANAGE ] Cleanup : move some things around
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <436DDB51.2080903@cornell.edu>
References: <436DDB51.2080903@cornell.edu>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 10:33:19 -0500
Message-Id: <1131377599.20591.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-11-06 at 05:30 -0500, Ivan Gyurdiev wrote:
> Changes (Joshua, please take a look - minor changes):
> 
> - renames semanage_module_conn to semanage_direct_handle, and moves that 
> from the generic policy.h into direct_api.h. I think this is supposed to 
> differ for ps vs direct, otherwise I don't understand the union in the 
> handle. We should add future direct-handle specific fields into this 
> structure.
> 
> - moves sepol_handle initialization and cleanup code into handle.c (from 
> direct_api.c). You could argue that we should be making the _opposite_ 
> change, moving the handle field into the structure created above. 
> However, we can't do that, because we share records with sepol, whether 
> we're using direct or ps.

I'd prefer to hold cleanups until we have stabilized the functionality
and interfaces as desired for test1.  I'm also not clear on why we want
a sepol handle in the ps case.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
