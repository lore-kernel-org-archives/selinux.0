Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of
	capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1181681436.17547.280.camel@moss-spartans.epoch.ncsc.mil>
References: <1181591750.8805.151.camel@moss-spartans.epoch.ncsc.mil>
	 <1181654688.17547.110.camel@moss-spartans.epoch.ncsc.mil>
	 <1181681436.17547.280.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 12 Jun 2007 17:12:46 -0400
Message-Id: <1181682766.17547.304.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-06-12 at 16:50 -0400, Stephen Smalley wrote:
> On Tue, 2007-06-12 at 09:24 -0400, Stephen Smalley wrote:
> > On Mon, 2007-06-11 at 15:55 -0400, Stephen Smalley wrote:
> > > Extend SELinux to allow capabilities to be granted authoritatively.
> > > Introduces a new cap_override access vector to indicate when the
> > > secondary module (i.e. capability or dummy) check should be skipped.
> > > Handle the new class gracefully even if the policy does not yet have
> > > it defined.
> > 
> > For people who want to test/experiment with this kernel patch, below is
> > the policy patch I used to define the new class and permissions (it also
> > includes the previously added memprotect class since that hasn't been
> > added upstream yet).  If you rebuild your base policy with this patch
> > (e.g. grab the source package, add this patch, rebuild and reinstall),
> > then you can subsequently create loadable policy modules that use the
> > new cap_override permissions for testing.
> 
> One thing to note is that the applicability of this approach under
> targeted policy seems somewhat limited, as we have to ensure that a
> DAC-unprivileged process in unconfined_t (like an ordinary user shell)
> cannot ultimately gain unauthorized access to these capabilities granted
> to another domain, but at present, confined domains are always at the
> mercy of unconfined_t.

I suppose we would need to ensure that even the unconfined domains are
not given certain permissions (e.g. ptrace, sig*, setsched) to any
domain that is allowed these overrides.  That should be equivalent to
the same restrictions imposed by the file capabilities code.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
