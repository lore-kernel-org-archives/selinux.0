Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2LJn4xC032098
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2007 15:49:04 -0400
Received: from web86907.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2LJmxRY005842
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2007 19:49:00 GMT
Date: Wed, 21 Mar 2007 19:48:40 +0000 (GMT)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: Re: Kernel Panics, when start with amendments in SELInux Source Code
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1174502296.22565.426.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <498809.46803.qm@web86907.mail.ukl.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for the reply.

> What makes you think there is any file at all on
> every permission check?
> Many permission checks are on non-file objects
> altogether.
> 

it means, that a check has to be placed within the
security server, such that, if and only if, there is
an av rule of the form:

 "allow  subject_t object_t :file {Perm_Set}",

Only then to call this user defined function. That is
if  "tclass" parameter of the security_compute_av,
corresponds to object file, only then read the file. 
Am i right?, secondly what value of the "tclass"
corresponds to the file object in particular.

> What is count used for?

The actuall thing which i am doing at the moment is
that, whenever a specific "file object" comes in the
security server for permission decision, say a file
which contains sensitive data, I want to read that
file fully, within the security server. The purpose of
the count variable is two fold. It is actually used in
memcpy() for copying the file name into a dummy file
object. Secondly, it is used for reading from the data
from the file using:

 count (testfile ->f_op -> read) (testfile, (char
_user *) bufp, PAGE_SIZE, &offset)
....

> That's nice, except that:
> a) file_permission() in fs/namei.c doesn't get
> called at all for
> non-file checks,
> b) file_permisison() in fs/namei.c doesn't even get
> called at all for
> many file checks.
> c) you need to provide locking on that global
> variable.

If file_permission() in fs/namei.c is not involved in
some cases at all, how does fs/namei.c:permission() is
called. Could you kindly tell me the path, that how
Security Server can have access to the "struct file",
if the permission involves a specific "file object".
Actually, i want to read a particular file within the
security server.  

What i think, specific files can be identified through
this way:

Subject and Object TYPES can be identified through
attributes such that if there is a constraint
expression of the form e.g.

  (u1 = u2 and t2 = sensitivefile ...)

we can pin down the file TYPE associated with
"sensitivefile" attribute, and correspondingly, the
actual file, which is a sensitive file and should be
read. How to do this what i think: The structure
constraint_expr within the ss/constraint.h contains an
attribute called attr, which will then correspond to
sensitivefile in the
ss/services.c:constraint_expr_eval() in this
particular case. Am I right?


Thanks,
MA




> 
> > The intention is to get the file information
> > associated with particular inodes. If some body
> can
> > help me in sorting out this, i will be very
> thankful.
> 
> SELinux avc auditing or the syscall auditing will
> happily provide you
> with such information.  No need to add printk's to
> SELinux for it.
> 
> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the
> selinux mailing list.
> If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as
> the message.
> 



	
	
		
___________________________________________________________ 
New Yahoo! Mail is the ultimate force in competitive emailing. Find out more at the Yahoo! Mail Championships. Plus: play games and win prizes. 
http://uk.rd.yahoo.com/evt=44106/*http://mail.yahoo.net/uk 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
