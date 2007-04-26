Subject: Re: [PATCH 0/6] Drop legacy boolean/users support (setlocaldefs)
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <method@manicmethod.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
In-Reply-To: <1177594803.24282.322.camel@moss-spartans.epoch.ncsc.mil>
References: <1177594803.24282.322.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 14:48:36 -0400
Message-Id: <1177613316.3405.29.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-26 at 09:40 -0400, Stephen Smalley wrote:
> The following patch series completely removes the legacy support for
> local boolean and user definitions (setlocaldefs) from libsepol and
> libselinux and updates libsemanage and policycoreutils for the resulting
> interface changes and removals.  As such, it requires bumping the .so
> versions, which has already been done on the policyrep branch (and these
> patches are therefore intended to be applied there first, and then
> merged to trunk later along with the policyrep work).
> 
> The preservebools support is left temporarily intact since the
> corresponding kernel support for automatically preserving booleans
> across policy reload is not yet in a released kernel.org kernel.
> 

Entire patch series:

Acked-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

And merged into the policyrep branch.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
