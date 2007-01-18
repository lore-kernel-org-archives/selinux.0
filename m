Message-ID: <45AFD027.9070007@mentalrootkit.com>
Date: Thu, 18 Jan 2007 14:53:11 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux Mail List <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [PATCH] add selpolgen
References: <45ACEE9E.7000709@mentalrootkit.com> <1169135113.22731.285.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1169135113.22731.285.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2007-01-16 at 10:26 -0500, Karl MacMillan wrote:
>> This is a patch (available for download because of size - see url below) 
>> to add a python library named selpolgen and a new version of audit2allow 
>> that uses this library. This is a minimally changed version of what I 
>> have been calling madison.
>>
>> I am submitting this for inclusion as part of the main selinux 
>> distribution. I believe that inclusion here will help make good policy 
>> generation tools develop sooner and give a common base for creating new 
>> tools.
>>
>> Questions:
>> * I have the library at the top-level of the project - like the C 
>> libraries. Is this the best location? What about the name?
> 
> The top-level location seems sane, but the naming and structure diverges
> from the C libraries (e.g. one might expect a libsepolgen with man,
> include, src, and tests subdirectories and ChangeLog, COPYING, Makefile,
> and VERSION files).

* libsepolgen would not match python practice (this is a module not a 
library in python terms). I don't feel strongly either way, though, and 
the new patch changes this libselgen (see below).

* For python src / include are the same thing, which is why they are in 
a single directory. I put both the module directory and share under src.

* There shouldn't be man pages since doc strings and the built-in 
help(modulename) in python replace those (and the current code contains 
a fair amount of that documentation).

* I added a COPYING file and ChangeLog (empty for now).

* There is already a Makefile and VERSION and the Makefile follows the 
current conventions.

   I don't know what python libraries generally look
> like.  selpolgen is also a bit confusing with MITRE's tool, although
> that may not be important as it seems OBE.  You could just call it
> libmadison unless there is a conflict.
> 

I was trying to use a name that described its use without confusing it 
with polgen. What about 'selgen'? Any other ideas (I'd really prefer a 
meaningful name).

>> * Should the old audit2allow be retained in any form? I've tried to make 
>> this a drop-in replacement, but there are likely regressions / changes. 
>> There are also a few options still missing that I will add soon.
> 
> Unless there is a significant regression, I'd advocate just dropping the
> old one (and also finally removing audit2allow.perl, the original perl
> version that was moved aside when the python rewrite was merged).
> 

Ok. Updated patch can be found at 
http://people.redhat.com/kmacmill/patches/selinux/selgen-initial-submission.patch.gz

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
