Message-ID: <46AFA0C8.90608@tresys.com>
Date: Tue, 31 Jul 2007 16:51:20 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Problem with semanage, looks like we don't handle the <<none>>
 context type?
References: <46AF3C5E.8080700@redhat.com>
In-Reply-To: <46AF3C5E.8080700@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> cat /tmp/test.py
> #!/usr/bin/python
> from semanage import *
> sh = semanage_handle_create()
> rc, con = semanage_context_from_string(sh, "<<none>>")
> rc,fcontext = semanage_fcontext_create(sh)
> semanage_fcontext_set_con(sh, fcontext, con)
> 
> 
> # python /tmp/test.py
> Segmentation fault

Granted the segfault needs to be fixed but what exactly are you trying 
to accomplish? <<none>> is not a type, its just something matchpathcon 
uses to short circuit its labeling behavior.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
