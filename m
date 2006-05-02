Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k42Gat6r005768
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 12:36:55 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k42Gas4f020276
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 16:36:54 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k42GbFRC011894
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 12:37:15 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6/Submit) id k42GbFNk011893
	for selinux@tycho.nsa.gov; Tue, 2 May 2006 12:37:15 -0400
Subject: Re: We are attempting once again to split policy out into
	individual RPMS.
From: Paul Nasrat <pnasrat@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Jeremy Katz <katzj@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        James Morris <jmorris@redhat.com>, SELinux-dev@tresys.com,
        SE Linux <selinux@tycho.nsa.gov>, James Antill <jantill@redhat.com>
In-Reply-To: <1146587175.13611.145.camel@moss-spartans.epoch.ncsc.mil>
References: <44576B91.8060607@redhat.com>
	 <1146582758.13611.89.camel@moss-spartans.epoch.ncsc.mil>
	 <1146583639.32102.20.camel@orodruin.boston.redhat.com>
	 <1146587175.13611.145.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 02 May 2006 12:29:42 -0400
Message-Id: <1146587383.2737.35.camel@enki.eridu>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-02 at 12:26 -0400, Stephen Smalley wrote:
> On Tue, 2006-05-02 at 11:27 -0400, Jeremy Katz wrote:

> Ok, let's assume that we implement kernel mechanism for
> revalidating/updating the incore inode SIDs upon policy reload.  But
> where does this leave us with regard to being able to meaningfully
> confine rpm in the future, e.g. by moving the real processing into a
> helper and running it in different domains based on package
> trustworthiness and purpose?  

Do you have any patches or information about this helper model in RPM.
If we are looking at moving to a helper anyway should we not be looking
at how to implement modular policy with the helper?  

How is the helper is going to be able to access the pp file before it is
on disk, how does it load policy, how do we ensure that transactions
with scriptlets/triggers on a policy module update that all contexts are
"correct" at time of running.

Paul  

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
