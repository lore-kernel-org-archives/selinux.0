Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l26HDsQL007382
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 12:13:54 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l26HFIxq025017
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 17:15:19 GMT
Subject: Re: [RFC] Policy Management Server release
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015888BAC2F@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015888BAC2F@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 06 Mar 2007 12:14:00 -0500
Message-Id: <1173201240.3177.65.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-02 at 15:09 -0500, Joshua Brindle wrote:
> A release of the policy management server has been put on
> oss.tresys.com. This version is completely redesigned from the last
> release in that it uses hooks within libsepol expansion code to handle
> enforcement. This allows the policy management server to handle the
> access control more abstractly, similar to SELinux within the Linux
> kernel. This release also has a less granular object model, not for a
> technical reason but because it was felt that the extra permissions
> weren't necessarilly useful. Since this is an RFC we'd love to hear
> comments about the design and the object model.
> 

Glad to see this released. As this is a lot of code, I'd personally like
to see separate RFC emails for different aspects of the design with
small illustrative patches.

For example, can you explain how access to change booleans could be
delegated to separate administrative domains (i.e., only allow the web
admin to change web related booleans)? This is the control that I think
is the most immediately useful. I'd be interested in seeing what the
policy would look like and the enforcement code. A few illustrative
examples like that would go a long way towards helping everyone
understand the changes.

Initial comments:

1) What are plans for submission for merging? Any idea how to
incrementally introduce functionality without requiring merging the
entire patch set?

2) This seems to present two separate concepts: access control over
policy and remote management. I'd like to see these separated when
submitted for review. I have three primary concerns:

* The addition of remote management adds significant complication (a
separate, threaded policy server). Making certain that this code is
correct and secure is both difficult and important since it can be
exposed directly to a wider network.

* Deploying a separate daemon is more difficult (extra packages,
configuration changes, etc.) and makes wider acceptance more difficult.
If we add this, Fedora would ship with 4 separate selinux related
daemons, which is going to cause complaints (3 is already too many).

* The access control is more clearly useful than the remote management
(to me). I believe that it is far more likely that remote management of
selinux will happen as part of a larger management framework that would
make selinux configuration changes locally on each node. I'm not against
this, I just think that it will be an uphill battle to gain wide
acceptance for the remot3e.

Given those concerns, I would prefer to see an exec based access
enforcement mechanism merged first. This would be significantly simpler,
both in code and in deployment / acceptance. It would also make it
simpler to merge the hooks one at a time based on usefulness.

3) I would, obviously, like merging of this code and my proposed policy
representation to be possible and easy. The most important part of that
merging is the access control hooks. Looking at the hooks, e.g.,:

int sepol_sec_avrule_add_check(sepol_handle_t *sh, policydb_t *new_pol,
int spec, uint32_t stype, uint32_t ttype, uint32_t class,
sepol_access_vector_t perms)

Two things jump out:

* By passing in ids and an sepol_access_vector_t you are requiring that
the hooks have intimate knowledge of the policydb representation. If you
instead pass strings (like the symbol add hook does) or opague, string
oriented structs in the same style as the sepol records (which my patch
creates) then much of the details of the policy would be removed.

* It appears that you are essentially diffing between the old and new
policy in the terule hooks, adding even more knowledge of the policydb
(and requiring the building of id maps?). If you only passed the access
that was being added or removed, the diffing could be done as part of
libsepol and more easily changed with the policy representation.

Those changes would give these patches a much better chance of working
together and, I think, improve the readability of the enforcement
callbacks.

I'll leave any more detailed feedback to separate patch submissions.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
