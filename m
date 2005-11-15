Subject: Re: Port of audit2allow to python
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1132080405.28124.70.camel@moss-spartans.epoch.ncsc.mil>
References: <437A0930.80906@redhat.com>
	 <1132080405.28124.70.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 13:57:22 -0500
Message-Id: <1132081042.28124.75.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-15 at 13:46 -0500, Stephen Smalley wrote:
> On Tue, 2005-11-15 at 11:13 -0500, Daniel J Walsh wrote:
> > Next step add reference policy generation.
> 
> Doesn't yield the same output as the old perl script, even after sorting
> both outputs to avoid ordering issues.
> 
> Looks like the new script is incorrectly adding allow rules for:
> - security_compute_sid errors, and
> - avc:  granted messages

Also, the new script doesn't appear to support the -v option yet
(collects up the auxiliary audit information like the comm= and name=
information and saves it in comment lines after each allow rule). Not
sure how crucial that is, or whether we should be saving the audit event
id instead so that people can use ausearch to query the corresponding
system call audit record easily.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
