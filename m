Message-ID: <44287C5E.3030307@cornell.edu>
Date: Mon, 27 Mar 2006 18:59:26 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Kevin Carr <kcarr@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Selinux-Dev <selinux-dev@tresys.com>
Subject: Re: [RFC][PATCH] extending the libsepol API
References: <200603212246.k2LMkRNq028071@gotham.columbia.tresys.com>
In-Reply-To: <200603212246.k2LMkRNq028071@gotham.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> the caller is 
> + *  responsible for safely casting this pointer. 

Do you plan to iterate over opaque objects, such as the current record 
implementations?

 > + *  errno will be set and *item will be NULL.

Elsewhere we use a callback to communicate an error condition with the 
caller.
What's the advantage of errno over pre-defined return codes?

+extern int sepol_iterator_get_size(sepol_iterator_t *iter, size_t *size);

Shouldn't this be "unsigned int" instead?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
