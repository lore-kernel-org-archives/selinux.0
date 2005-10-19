Subject: Re: [ SEMANAGE ] Remove connection requirement from POLICYDB
	backend
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <43552AD9.6020701@cornell.edu>
References: <43552AD9.6020701@cornell.edu>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 12:13:33 -0400
Message-Id: <1129738413.2375.208.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-18 at 13:03 -0400, Ivan Gyurdiev wrote:
> This patch removes the is_connected check from the POLICYDB backend, 
> because it doesn't accomplish anything. What we really want to check is 
> whether the function was initialized or not (which can't be done at this 
> point anyway, because we're _already_ executing this function - this is 
> handled by the default database which I added).

Both patches (default dbase, remove connect) merged as of libsemanage
1.3.24.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
