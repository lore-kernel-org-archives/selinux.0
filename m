Message-ID: <417D3F32.5030902@redhat.com>
Date: Mon, 25 Oct 2004 14:00:18 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
Subject: Re: Proposed patch for libselinux
References: <41782BBA.9090101@redhat.com>	 <1098449318.7614.13.camel@moss-spartans.epoch.ncsc.mil>	 <20041022155639.GA4986@lkcl.net>  <41796C01.4060909@redhat.com> <1098715957.13491.157.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1098715957.13491.157.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>Let's step back for a moment from the implementation details and talk
>about the concept/usage of this customized flag for SELinux attributes.
>
>The file_contexts configuration and setfiles were only intended to
>initialize the system, as previously noted.  After installation, one
>should only do a make relabel upon a major policy upgrade, and even in
>that case, it would be better to selectively relabel based on the
>differences between the policies.  At runtime, the file attributes will
>be set based on policy and in some cases refined by application and/or
>user knowledge subject to policy (setfscreatecon(3) or setfilecon(3)),
>reflecting the actual security properties of the objects.
>
>At any given time, you can find all files that are no longer consistent
>with the file_contexts configuration via setfiles -nv.  You don't need a
>separate file attribute for that purpose, and the proposed flags
>attribute will only show files relabeled via chcon(1).  Why should we
>treat such files differently than a file whose security context was set
>by any other application using setfilecon(3) or created after an
>explicit setfscreatecon(3) or even created in accordance with a file
>type transition rule?  Typically, we don't want any of those files to be
>relabeled by a subsequent make relabel; we would only want them
>relabeled if there was a policy bug or application bug that had allowed
>those files to become mis-labeled in the first place at runtime, or if
>there has been a change in policy that affects those files/types.
>
>I'm inclined more towards the idea of alternatives in the file_contexts
>configuration, e.g. you specify a "primary" security context to be
>applied upon initialization, and you optionally specify alternatives
>(either individually or via equivalence classes) that are equally
>permissible.  setfiles then defaults to applying the primary context,
>but will allow the file to remain unchanged if it has been set to any of
>the alternatives.
>
>  
>
This is true.  But we still need an easy way for users to add additional 
security contexts to the environment.
without installing policy-*sources
IE I setup an alternate build environment under /opt/working that I want 
owned by dwalsh. 
To do that presently you would need to install sources and add a file 
under file_context/misc

We need to change setfiles or some tool to look in 
/etc/selinux/*/context/files/* and load all policy files in the directory.
Starting with file_context.


Dan

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
