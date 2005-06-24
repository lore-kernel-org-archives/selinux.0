Subject: RE: file contexts and modularity
From: Stephen Smalley <sds@tycho.nsa.gov>
To: ivg2@cornell.edu
Cc: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <1119627837.30464.11.camel@celtics.boston.redhat.com>
References: <200506231939.j5NJdXqc031369@gotham.columbia.tresys.com>
	 <1119558539.16753.74.camel@celtics.boston.redhat.com>
	 <1119614906.12865.39.camel@moss-spartans.epoch.ncsc.mil>
	 <1119627837.30464.11.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 14:32:48 -0400
Message-Id: <1119637968.12865.119.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-24 at 11:43 -0400, Ivan Gyurdiev wrote:
> The current interface keeps the policydb_t as an opaque data structure..
> On the other hand it also passes in a sel_root parameter (for
> selinux_policy_root(), which I'm not so sure about).

Yes, I think we need to hide that from adduser.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
