Date: Wed, 1 Feb 2006 14:08:11 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: Desktop integration
Message-ID: <20060201130811.GA26269@europium.cip.ifi.lmu.de>
References: <43DE6244.5010100@cornell.edu> <43DE6578.9050302@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <43DE6578.9050302@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Daniel J Walsh <dwalsh@redhat.com> [2006-01-30 20:33]:
> Ivan Gyurdiev wrote:
> >For the type field, it makes sense to me to have a drop-down box with 
> >the customizable types in there (as the user shouldn't relabeling to 
> >any other types). I also think we should translate those types into 
> >something more user friendly, possibly in multiple languages. I 
> >imagine a box that you can choose from "Office Document", "Music 
> >File", "Image FIle", "Sensitive Data", "Untrusted Content", things 
> >like that. Any other suggestions?
> 
> Changing types is a tougher problem.  First you are making two bad 
> assumptions.
> 
> 1. That a user can relabel to all of the customizable types.  In most 
> policies he will not be allowed to .
> 
> 2. That the only types he can relabel to are customizable.

Wouldn't it be better to look up the allowed relabels directly? 
You'd first have to check if the user has "relabelfrom" rights on the
file and then collect all the file types for which the user has
"relabelto" rights.
This is could be done with compute_av, but I don't think we want to
allow users to do this.

IMHO it would be best to create a new interface to query the policy for
this type of information. Maybe not in the kernel, but the policy server
surely could provide it.

Thomas

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
