Message-ID: <43BC0681.2090403@cornell.edu>
Date: Wed, 04 Jan 2006 12:31:45 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Policycoreutils latest diffs.
References: <43BAC4EA.8020106@redhat.com> <43BAB2D6.4030103@cornell.edu> <43BBF8C6.1070109@cornell.edu> <43BBFA8A.2040601@cornell.edu> <43BC1ECA.1070806@redhat.com>
In-Reply-To: <43BC1ECA.1070806@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> delete
> if does not exist local; error since you can not delete an object from 
> the server?
> Prevent the user from deleting SELinux User "root"
Right.. I would two tests, and then if exists fails say: object does not 
exist
if exists_local fails say: object is built into policy and can't be deleted.

There's still the issue of how the user would know that at all, since 
list does not indicate
what's local and what isn't, but it's a good point to start at.
>
> Add
> if does exist: error
yes, that should be sufficient.
>
> Modify:
> If does not exist local; you are not allowed to modify, see above.
That's tricky. That depends on what you want modify to do.
The libsemanage modify_local function is with respect to the local 
store, but
anything you write in the store at all will modify policy, so you can go 
either way
with your higher level modify. The question is what you're modifying, 
and does
the user understand that.

I think to be consistent with add(), you should modify with respect to 
policy, and not do any checks here.

====
Btw, if there's interest in writing an API that works on policy alone, 
minus local modifications, that can be done - it just requires writing 
down another policy after expand, and before any local things are 
written down.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
