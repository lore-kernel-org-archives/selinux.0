Subject: Re: Kernel Panics, when start with amendments in SELInux Source
	Code
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <498809.46803.qm@web86907.mail.ukl.yahoo.com>
References: <498809.46803.qm@web86907.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Wed, 21 Mar 2007 16:01:24 -0400
Message-Id: <1174507284.22565.441.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-03-21 at 19:48 +0000, JanuGerman wrote:
> Thanks for the reply.
> 
> > What makes you think there is any file at all on
> > every permission check?
> > Many permission checks are on non-file objects
> > altogether.
> > 
> 
> it means, that a check has to be placed within the
> security server, such that, if and only if, there is
> an av rule of the form:
> 
>  "allow  subject_t object_t :file {Perm_Set}",
> 
> Only then to call this user defined function. That is
> if  "tclass" parameter of the security_compute_av,
> corresponds to object file, only then read the file. 
> Am i right?, secondly what value of the "tclass"
> corresponds to the file object in particular.

Please, spend some time reading the code (and a good book on kernel
development) first.

> 
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

Wrong approach.  You need to measure the actual data used, not
separately read a private copy, and the security server should never
read from a file directly.

> If file_permission() in fs/namei.c is not involved in
> some cases at all, how does fs/namei.c:permission() is
> called.

Read the code and work your way through it.  It isn't that hard.

>  Could you kindly tell me the path, that how
> Security Server can have access to the "struct file",
> if the permission involves a specific "file object".
> Actually, i want to read a particular file within the
> security server.  

You don't want to do it that way.

> What i think, specific files can be identified through
> this way:
> 
> Subject and Object TYPES can be identified through
> attributes such that if there is a constraint
> expression of the form e.g.
> 
>   (u1 = u2 and t2 = sensitivefile ...)
> 
> we can pin down the file TYPE associated with
> "sensitivefile" attribute, and correspondingly, the
> actual file, which is a sensitive file and should be
> read. How to do this what i think: The structure
> constraint_expr within the ss/constraint.h contains an
> attribute called attr, which will then correspond to
> sensitivefile in the
> ss/services.c:constraint_expr_eval() in this
> particular case. Am I right?

Selecting files for measurement based on security label isn't a new
idea; go look at past discussions of integrity measurement on
linux-security-module and linux-kernel mailing lists and talk to the
people involved in such work.  There are certainly issues there, but you
should at least learn from what has already been tried.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
