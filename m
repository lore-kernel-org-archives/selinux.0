Subject: Re: [ SEMANAGE ] Replace semanage debugging system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <434BD2CB.8050007@cornell.edu>
References: <434B62B8.4080309@cornell.edu>
	 <1129037671.3308.84.camel@moss-spartans.epoch.ncsc.mil>
	 <1129039592.3308.110.camel@moss-spartans.epoch.ncsc.mil>
	 <434BCC58.7030509@cornell.edu>
	 <1129041009.3308.125.camel@moss-spartans.epoch.ncsc.mil>
	 <434BD2CB.8050007@cornell.edu>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 10:46:52 -0400
Message-Id: <1129042012.3308.139.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-11 at 10:57 -0400, Ivan Gyurdiev wrote:
> Okay, so it sounds like the optimal setup is:
> - pass variadic list to callback
> - remove msg field from message structure (rename?)
> - embed message structure into handle to avoid allocation
> 
> Then handler takes four arguments instead of the current two:
> 
> - void* arg
> - message structure (rename?)
> - fmt
> - variadic list

Why not just use the handle directly, and drop the separate message
structure entirely?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
