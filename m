Subject: Re: [ SEMANAGE ] Rename direct -> policydb as appropriate
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <435446B6.3090608@cornell.edu>
References: <435446B6.3090608@cornell.edu>
Content-Type: text/plain
Date: Tue, 18 Oct 2005 10:53:37 -0400
Message-Id: <1129647217.2375.101.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-17 at 20:49 -0400, Ivan Gyurdiev wrote:
> During an off-list discussion w/ Joshua, it became apparent that there's 
> confusion with the current naming of things.
> 
> In particular Tresys appear to use "direct" to refer to the method of 
> access - if something is not accessed over the policy server, it is 
> accessed directly, regardless of how it's stored. I've been using 
> "direct" to refer specifically to the policydb backend.
> 
> The following patch rename direct -> policydb as appropriate to prevent 
> further confusion. Note that both the FILE and POLICYDB database types 
> are both considered "DIRECT," and are initialized in the direct_api.c 
> connect() function.
> 
> Applies on top of the other patches sent, and should contain no 
> functional changes, other than renames.

Merged all 3 patches (dbase init, read lock, direct rename) as of
libsemanage 1.3.22, after merging my own patches for adding handles to
further sepol interfaces in 1.3.21.  I had to re-apply the change for
the dbase code again after the rename.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
