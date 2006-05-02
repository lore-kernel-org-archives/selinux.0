Subject: RE: We are attempting once again to split policy out
	intoindividual RPMS.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Jeremy Katz <katzj@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        James Morris <jmorris@redhat.com>,
        selinux-dev <selinux-dev@tresys.com>, SE Linux <selinux@tycho.nsa.gov>,
        Paul Nasrat <pnasrat@redhat.com>, James Antill <jantill@redhat.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158816FEC4@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158816FEC4@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 02 May 2006 14:27:27 -0400
Message-Id: <1146594447.13611.217.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-02 at 14:06 -0400, Joshua Brindle wrote:
> I strongly disagree with this. Not because rpm (or whatever) can subvert
> the policy directly by making a new type and installing a policy that
> can subvert policy. Although this is an issue because one can't
> necessarilly map file types to domains with privileges, it can possibly
> be controlled by policy server (assuming there are some pretty strict
> metapolicy rules around).
> 
> A bigger issue (assuming we can control the former) is that an untrusted
> rpm can label a file with the expectation that it will be active later.
> Eg., label a malicious file passwd_exec_t before the passwd module is
> installed. Wait for the passwd module to be installed (by a more trusted
> RPM that has the policy rights to insert it) and viola, you have a rogue
> binary that can enter passwd_t and modify shadow_t.

This is another reason (besides error checking) why you want rpm to
check the labels on the installed files at the end of the transaction to
verify that they were all valid under the package's policy; if not, it
should reset them to a known state.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
