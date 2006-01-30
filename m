Message-ID: <43DE68BF.5060201@tresys.com>
Date: Mon, 30 Jan 2006 14:27:59 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: [PATCH] libsepol - cond_expr mapping and package num_sections
 bugs
References: <43DA88D1.5000408@tresys.com>	<1138396578.3728.6.camel@moss-spartans.epoch.ncsc.mil> <1138647067.7076.160.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1138647067.7076.160.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-01-27 at 16:16 -0500, Stephen Smalley wrote:
> 
>>This seems prone to similar bugs later.  Suppose I call
>>sepol_module_package_set_file_contexts multiple times; each time it
>>frees the old one and replaces it, so I shouldn't be incrementing the
>>number of sections here.
>>
>>Possibly num_sections shouldn't be part of the state of the struct at
>>all; it should just be a local variable.  In the read case, we pull it
>>from the image/file and use it locally (just need to pass it back from
>>read_offsets to the caller).  For write, we always start with a count of
>>1 and increment it if we have a p->file_contexts.
> 
> 
> How about the patch below instead?

ah! this is very close to a patch I was getting ready to send you, looks 
good to me, should solve the problem.

Btw, also getting ready to send a patch that adds 2 new sections to the 
package format so we'll see how flexible this really is then.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
