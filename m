Subject: Re: [ SEMANAGE ] Replace semanage debugging system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <434BCC58.7030509@cornell.edu>
References: <434B62B8.4080309@cornell.edu>
	 <1129037671.3308.84.camel@moss-spartans.epoch.ncsc.mil>
	 <1129039592.3308.110.camel@moss-spartans.epoch.ncsc.mil>
	 <434BCC58.7030509@cornell.edu>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 10:30:09 -0400
Message-Id: <1129041009.3308.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-11 at 10:29 -0400, Ivan Gyurdiev wrote:
> Taking all of the arguments directly is bad - does not respond well to 
> change, and I've already changed this at least 3 times. However, we 
> could take 1) the void* arg, 2) the message structure (auxilary data) 2) 
> the fmt, and 3) the variadic list..and I think that would be flexible 
> enough. I changed it, because I thought this would be a simpler, and 
> more intuitive interface, but I can change it back..

The auxiliary data could be directly embedded in the handle, avoiding
any need to introduce a new structure (or allocation), with the get
methods operating directly on the handle much like the old strerror
interface.  I don't think you want msg_write needing to allocate any
memory or performing any formatting string writing, as that should all
be done in the callback if desired.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
