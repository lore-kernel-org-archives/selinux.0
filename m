Date: Wed, 3 Dec 2003 11:56:39 -0500
From: "Serge E. Hallyn" <hallyn@cs.wm.edu>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: policy under version control
Message-ID: <20031203165639.GA2150@escher.cs.wm.edu>
References: <1070465788.3774.29.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1070465788.3774.29.camel@colossus.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> We are also working on binary policy modules, which more directly
> address what you are wanting I think. This will allow you to create
> small binary policy modules separately from a base policy. This is

For DTE, I "compile" a set of modules into policy.  Each module (ie ssh)
can define related types and domains (ie ssh_t, ssh_et, ssh_socket_t, ssh_d).
In order to facilitate concise (and precise) inter-module access rules, types
and domains can each be specified by:

   their explicit name (ie sbin_t and bin_t)
   hierarchy (so you can call bin_t and sbin_t binaries.bin_t and
      binaries.sbin_t, then talk about access to binaries.*, but still
      talk about just bin_t)
   group (there can be groups of types, and groups of domains)
   "all"

Priority of listed access rules goes up with precision, so
Domain my_domain
   access all none
   access binaries.* rx
   access bin_t rwx
End

gives the intuitive result.  Also, "incoming" access rules take
priority over "outgoing" access rules, so if we have a wu_ftpd domain
giving itself write access to root_t, but root_t itself denied that
access, then wu_ftpd will not have that access.  (again to give the
intuitive result, not in any misguided attempt to "protect" from a
module)

Modules are, then, intended to be pretty much standalone, so you do
just apply a module to a base policy.  Some additional hooks check
for maintenance of desired constraints (anything you care to implement,
but currently there's only a modified version of BLP) accross module
application.

I can see the value (for selinux) in sending out binary policy modules,
but it seems that easily modifiable source modules should be more
useful.  I've been meaning for quite some time to implement this kind
of thing to work with selinux, but I just keep getting sidetracked...

I also keep debating whether it would be simple enough to implement
with the current selinux policy system.  It seems flexible enough that
it should be.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
