Message-ID: <44183A48.7010005@tresys.com>
Date: Wed, 15 Mar 2006 11:01:12 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "rcok >> Russell Coker" <rcoker@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Problem with semodule mls policy
References: <44182410.1030003@redhat.com> <1142434901.29737.63.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1142434901.29737.63.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2006-03-15 at 09:26 -0500, Daniel J Walsh wrote:
>> How do I get semodule to create policy.20 at SystemHigh and everything 
>> other files at SystemLow?
> 
Why do we want policy.20 at SystemHigh again? The only scenerio I can 
think of is the user->role mappings but who will be using those rather 
than seuser mappings? For that matter, seuser file should probably be at 
SystemHigh...

> Options:
> 1) As with the devpts problem, if we had range_transitions for object
> classes supported by checkpolicy and the kernel, then we could do this
> via a range_transition rule, as policy.20 is created in a separate
> directory.  Good idea for a kernel enhancement, not a short term option.
> 2) Modify libsemanage to explicitly set the context on the installed
> files based on some configuration.  Using matchpathcon/file_contexts is
> a potential concern for bootstrapping, although it can likely be worked
> around.  Putting additional entries into semanage.conf, similar to the
> existing entry for specifying the file-mode, would be another option.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
