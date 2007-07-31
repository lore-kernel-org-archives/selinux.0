MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Problem with semanage, looks like we don't handle the <<none>> context type?
Date: Tue, 31 Jul 2007 16:59:36 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588DE2258@exchange.columbia.tresys.com>
In-Reply-To: <46AFA242.1010903@redhat.com>
References: <46AF3C5E.8080700@redhat.com> <46AFA0C8.90608@tresys.com> <46AFA242.1010903@redhat.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Cc: "SE Linux" <selinux@tycho.nsa.gov>, "Stephen Smalley" <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Joshua Brindle wrote:
>> Daniel J Walsh wrote:
>>> cat /tmp/test.py
>>> #!/usr/bin/python
>>> from semanage import *
>>> sh = semanage_handle_create()
>>> rc, con = semanage_context_from_string(sh, "<<none>>") rc,fcontext =
>>> semanage_fcontext_create(sh) semanage_fcontext_set_con(sh,
>>> fcontext, con) 
>>> 
>>> 
>>> # python /tmp/test.py
>>> Segmentation fault
>> 
>> Granted the segfault needs to be fixed but what exactly are you
>> trying to accomplish? <<none>> is not a type, its just something
>> matchpathcon uses to short circuit its labeling behavior.
>> 
> I have a request from someone who wants to setup a directory
> that shortcuts the labeling behaviour.  IE wants restorecon
> and friends to do nothing in the directory.

Hrm... Interesting. We probably need to add special logic to libsemanage
to handle this case. 

In the mean time he can just add it to a .fc file in a policy package
and insert that.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
