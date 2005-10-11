Subject: Re: [ SEMANAGE ] Replace semanage debugging system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <434B62B8.4080309@cornell.edu>
References: <434B62B8.4080309@cornell.edu>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 09:34:31 -0400
Message-Id: <1129037671.3308.84.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-11 at 02:59 -0400, Ivan Gyurdiev wrote:
> The attached patch replaces the current semanage debugging system, with 
> one based on callbacks. It breaks API, so the libsemanage.map file needs 
> to be updated, but I'm not sure how to do that properly, so I left that 
> part out...

At present, you can just modify it without introducing a new interface
version, because the shared library interface has not been officially
released in any form yet.

> - replaced use of __FUNCTION__ with __func__, which should not be GNU 
> specific

OTOH, __func__ is not known to older versions of gcc, and we already
build with -D_GNU_SOURCE.  

An obvious concern about the new msg_write function is that it requires
memory allocation itself.  Thus, on a memory allocation failure in the
caller, we might easily end up dropping the out of memory error message
due to lack of available memory at this point.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
