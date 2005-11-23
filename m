Message-ID: <4384CCC7.5090605@cornell.edu>
Date: Wed, 23 Nov 2005 15:10:47 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] wrappers for writing users and seusers
References: <1132763281.3714.3.camel@twoface.columbia.tresys.com>
In-Reply-To: <1132763281.3714.3.camel@twoface.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> This patch adds wrappers necessary to write users and seusers using
> libsemanage. It also includes the wrappers for ports, but they are
> commented out since the port functions are not exported via
> libsemanage.map. Examples of how to write users and seusers (and tests)
> are in pywrap-test.py as usual. Let me know if there are any problems
> with this patch.
>
>   
Writers should probably be using modify_local, instead of add_local? 
Actually now's as good a time as any to re-examine whether we want to 
keep all of those (both internally, and in the interface).

add -> add new object, fail if it exists (should not be used to test 
existence)
set -> modify old object, fail if it does not exist (should not be used 
to text existence)
modify -> add or modify new object, depending on whether it exists

Yes, modify() can be implemented in terms of exists(), add(), and set(), 
but I don't want to see all of those called outside a transaction with 
no lock held. Similarly, set() can be implemented in terms of exists() 
and modify(). add can be implemented in terms of exists() and modify().

The existence test is with respect to local modifications only. The way 
the objects are eventually loaded into policy is fixed, and right now 
it's (set) for booleans, and (modify) for everything else. Actually, 
those are the only ones implemented..


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
