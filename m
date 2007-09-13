Subject: Re: concept of a permissive domain
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <1189545987.4823.6.camel@localhost.localdomain>
References: <1189537981.3407.51.camel@localhost.localdomain>
	 <46E6FB25.5070507@redhat.com>
	 <1189545987.4823.6.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 13 Sep 2007 10:08:32 -0400
Message-Id: <1189692512.18713.61.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-09-11 at 17:26 -0400, Karl MacMillan wrote:
> On Tue, 2007-09-11 at 16:31 -0400, Daniel J Walsh wrote:
> [...]
> > One other feature/requirement would be to not override dontaudit rules.
> > So if I have a domain in permissive mode and I have a dontaudit rule  on
> > reading /etc/shadow.  The app should still be denied reading
> > /etc/shadow.  (This is not a show stopper, but would allow us to force
> > apps to take the code paths they will take in enforcing mode.)
> 
> This isn't specific to per-domain permissive, right? It would be useful
> in general for permissive.

I would be opposed to such a change, as it is a semantic change to what
dontaudit means.

Keep in mind that allow, auditallow, and dontaudit/auditdeny are all
independent of one another today and none of them imply the other, e.g.
	allow a b:file read;
	auditallow a b:file *;
	dontaudit a b:file *;
is perfectly valid and means:
- Let a read files labeled b,
- Audit all permission grantings from a to files labeled b,
- Don't audit any permission denials from a to files labeled b.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
