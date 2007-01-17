Subject: Re: [RFC] Add list and iter data types to libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <45AD3F51.9070005@mentalrootkit.com>
References: <45AD3F51.9070005@mentalrootkit.com>
Content-Type: text/plain
Date: Wed, 17 Jan 2007 07:15:39 -0500
Message-Id: <1169036139.22731.159.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-01-16 at 16:10 -0500, Karl MacMillan wrote:
> As part of some work to improve the parser in checkpolicy and module 
> data structures in libsepol, I have implemented doubly-linked list and 
> iterator data types. The attached patch adds these to libsepol.
> 
> I would appreciate feedback on these before I submit larger patches that 
> make use of them. In particular:
> 
> * Is the iterator concept acceptable (I plan to add iterator support to 
> other data types including hashtabs)?

How does this compare with Kevin Carr's previous iterator proposal?  How
does it compare with the existing _iterate functions in libsepol?

> * We've discussed dropping the use of typedefs on structs (which I do in 
> this patch). Is this what we want to do, or should I add typedefs?

Omitting typedefs is preferred I think.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
