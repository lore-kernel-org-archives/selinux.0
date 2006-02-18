Message-ID: <43F73BE4.7090206@cornell.edu>
Date: Sat, 18 Feb 2006 10:23:16 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Genhomedircon - C or Python?
References: <43F56179.3080008@cornell.edu>
In-Reply-To: <43F56179.3080008@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hmm...the reason I don't have HOME_ROOT working yet is more fundamental 
- the algorithm currently operates only on seuser-keyed expansion 
contexts (group of variables that are expanded together, not in 
Cartesian product).

If there's interest in this functionality, try #2 of this patch could 
generalize this to things not keyed on seusers... like HOME_ROOT. Then 
we could add new expansion types that are not seuser related.

========

The function expand_symbol should take arguments:

- a symbol to expand (this will be the regexp, or the context (if there 
is one))
- a context (some data structure of unknown type, possibly polymorphic, 
containing the expansion data)
- a function  ( (context, name) -> expanded_name)
- a list of names to look for:
    Seuser context: USER, SELINUX_USER, ROLE, HOME_DIR
    Home root context: HOME_ROOT
    Fstab context (example): MOUNT_PT, FS_TYPE...etc

Should return:
- the expanded symbol
=========

Really, there's a lot of things that could be improved about 
genhomedircon. I think the whole process of defining new expansions 
could be made configurable, as opposed to hardcoding functionality to 
USER, ROLE, HOME_DIR...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
