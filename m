Subject: Re: Kernel Panics, when start with amendments in SELInux Source
	Code
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <20070321194738.6924.qmail@web86913.mail.ukl.yahoo.com>
References: <20070321194738.6924.qmail@web86913.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Wed, 21 Mar 2007 16:13:15 -0400
Message-Id: <1174507995.5556.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-03-21 at 19:47 +0000, JanuGerman wrote:
> Thanks for the reply.

> > What is count used for?
> 
> The actuall thing which i am doing at the moment is
> that, whenever a specific "file object" comes in the
> security server for permission decision, say a file
> which contains sensitive data, I want to read that
> file fully, within the security server. The purpose of
> the count variable is two fold. It is actually used in
> memcpy() for copying the file name into a dummy file
> object. Secondly, it is used for reading from the data
> from the file using:
> 
>  count (testfile ->f_op -> read) (testfile, (char
> _user *) bufp, PAGE_SIZE, &offset)
> ....
> 

>From this description it sounds like you want to intercept access to
certain files and present a processed version of that file to processes
accessing it. You may want to explore doing this from userspace.

You can create a file type accessible only by a single domain and run a
process in that domain that provides access to the files through IPC. If
the access needs to be provided without modifying applications you could
LD_PRELOAD a library to intercept the relevant libc calls.

This will likely be more maintainable and simpler to achieve. Looking
for references to assured pipelines can give you some ideas about this
general approach.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
