MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: concept of a permissive domain
Date: Fri, 12 Oct 2007 14:40:39 -0400
Message-ID: <C33537E7.2F014%csellers@tresys.com>
In-Reply-To: <470F7BC0.4030003@redhat.com>
From: "Chad Sellers" <csellers@tresys.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, "Eric Paris" <eparis@redhat.com>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/12/07 9:50 AM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I would like to get this moving again.
> 
> I believe we came to a conclusion that the permissive domain should be
> specified in userspace/policy.  So the next question is who can make the
> change and what is the syntax?
> 
> I see we can do this in two ways.
> 
> One we add a new access to the Process Class called Permissive;
> Which would cause the kernel to put this domain in the permissive
> domain.  I am sure Steven dislikes this suggestion.  :^)
> 
> 
> The second solution is to add a new command to audit, dontaudit,
> auditallow, nerverallow
> 
> So if we add permissiveallow or just permissive.
> 
> What does the syntax look like?
> 
> permissive httpd_t;
> 
> permissive httpd_t self:process *;
> 
> In order to implement this, we need to modify libsepol,
> checkmodule/checkpolicy?
> 
> Anything else?

The kernel, for one. Both of these involve new policy constructs that the
kernel would use. Or am I misunderstanding what you're saying?

The last message on this thread seems to be Karl's message talking about
potentially doing this in userspace (meaning make libsemanage or something
similar go through policy, allow everything for a domain, auditallow
everything that's not explicitly allowed) and how this is possible but
painful. Did I miss any later follow up to this? Where are we with respect
to doing this in kernel vs. in policy?

I really don't care either way any more. My main concern is I want us to
come up with something that doesn't create another new concept to confuse
users. To me, this means either
1) matches unconfined_t, perhaps call it unconfined_audit and make a domain
unconfined with auditallows. This could be done via Karl's earlier method.
Admittedly, the tool to create the policy would not be easy.
2) permissive domain that is the same as global permissive. This could be
done via an selinuxfs node (similar to global permissive) and made
persistent by some sort of state in /etc/selinux (like global permissive).

I know I may be in the minority here, but I really think we should consider
trying to minimize the differences in concepts we create as much as possible
to avoid complexity creep.

Thanks,
Chad

> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.7 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iD8DBQFHD3u/rlYvE4MpobMRAsb8AKCknzQMPwWk8NlkQXR/Et4HJ3drCgCfRxjj
> wSFzHkV45PqsE/GwUMaf8bk=
> =bWur
> -----END PGP SIGNATURE-----



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
