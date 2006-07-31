Subject: Re: [PATCH 2/2] userland support for new
	range_transition	statements
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        "'SELinux List'" <SELinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <44CE51C8.6080805@trustedcs.com>
References: <44CA298B.7080706@trustedcs.com>
	 <1154370592.26550.144.camel@localhost.localdomain>
	 <44CE51C8.6080805@trustedcs.com>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 16:52:40 -0400
Message-Id: <1154379160.3582.48.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-07-31 at 13:54 -0500, Darrel Goeddel wrote:
> Correct.  I think you inadvertently pointed out some tests I forgot to run -
> I have not compiled/tested monolithic policies with this patchset.  I am
> assuming that you can still specify an older output format when compiling
> monolithically unlike the modular case where it always writes the newest
> formats.  There we would be able to print out a warning about unsupported
> bits being discarded.  The case I have tested with this code path is
> libselinux downgrading a version 21 policy to version 20 for use in an older
> kernel.  In that case, I really don't see an appropriate feedback mechanism.
> Any thoughts on that case?  Warn about policy downgrades in some manner?

policydb_write() calls WARN() in the case where it has to discard
booleans and conditional rules upon downgrading to a policy version that
doesn't support them.  Likewise, a single warning message would be
suitable if you encounter any range transitions with non-process class
and are writing a policy with a lower version.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
