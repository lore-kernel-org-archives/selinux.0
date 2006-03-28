Message-ID: <4428867A.8040904@cornell.edu>
Date: Mon, 27 Mar 2006 19:42:34 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Kevin Carr <kcarr@tresys.com>
CC: sds@tycho.nsa.gov, selinux@tycho.nsa.gov, SELinux-dev@tresys.com
Subject: Re: [RFC][PATCH] extending the libsepol API
References: <200603231923.k2NJNMNq014574@gotham.columbia.tresys.com>
In-Reply-To: <200603231923.k2NJNMNq014574@gotham.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



>>> Also iterators can be used consistently across the
>>> entire API and every usage is the same as far as the user is concerned.
>>>       
So, that's essentially an "Iterable" interface that you want to create, 
which is implemented by all records.
I like OOP ideas, and inheritance/interfaces... otoh I don't like void* 
and casting from it.

I think OOP ideas help when you want to put multiple object types in the 
same framework - is this necessary here?
I don't think it increases readability otherwise.

By the way, this argument extends to the dbase interface in libsemanage.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
