Subject: Re: audit2allow and mls
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Rosalie Hiebel <rosalie.hiebel@L-3Com.com>
Cc: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <p0600202dc1e90d941990@[192.168.50.32]>
References: <p0600202dc1e90d941990@[192.168.50.32]>
Content-Type: text/plain
Date: Mon, 05 Feb 2007 10:48:58 -0500
Message-Id: <1170690538.12293.281.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-02-02 at 11:25 -0500, Rosalie Hiebel wrote:
> Is there version of audit2allow which is capable of generating rules specific
> to the mls policy?  I see that audit2allow's tests for mls  (calling 
> get_mls_flag),
> but this is after the rules in the .te file have been generated.

Not presently.  Ideally, audit2allow could check whether the denial was
caused by a constraint (as done by audit2why via libsepol) and then try
to determine a type attribute that could be used as an override, and
then call the appropriate refpolicy interface to add that attribute to
the domain. 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
