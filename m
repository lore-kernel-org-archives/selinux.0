Subject: Re: Proposed patch for libselinux
From: Colin Walters <walters@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1098715957.13491.157.camel@moss-spartans.epoch.ncsc.mil>
References: <41782BBA.9090101@redhat.com>
	 <1098449318.7614.13.camel@moss-spartans.epoch.ncsc.mil>
	 <20041022155639.GA4986@lkcl.net>  <41796C01.4060909@redhat.com>
	 <1098715957.13491.157.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 25 Oct 2004 11:31:36 -0400
Message-Id: <1098718296.18089.8.camel@decepticon.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-10-25 at 10:52 -0400, Stephen Smalley wrote:

> I'm inclined more towards the idea of alternatives in the file_contexts
> configuration, e.g. you specify a "primary" security context to be
> applied upon initialization, and you optionally specify alternatives
> (either individually or via equivalence classes) that are equally
> permissible.  setfiles then defaults to applying the primary context,
> but will allow the file to remain unchanged if it has been set to any of
> the alternatives.

I think you're right; this handles the use cases I can think of for the
custom attribute. 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
