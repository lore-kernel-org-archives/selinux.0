Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA14723
	for <selinux@tycho.nsa.gov>; Fri, 22 Dec 2000 17:09:38 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id WAA21769
	for <selinux@tycho.nsa.gov>; Fri, 22 Dec 2000 22:09:08 GMT
Received: from saturn.cs.uml.edu (saturn.cs.uml.edu [129.63.8.2])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id WAA21765
	for <selinux@tycho.nsa.gov>; Fri, 22 Dec 2000 22:09:07 GMT
Date: Fri, 22 Dec 2000 17:09:36 -0500 (EST)
Message-Id: <200012222209.eBMM9ao457986@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: selinux@tycho.nsa.gov
Subject: procps patches
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


Can I find out who wrote the procps (/bin/ps) patches?
That is, without getting killed. :-) I'd be happy to include
security data printing as part of the standard ps program.

Latest source:  http://www.cs.uml.edu/~acahalan/procps/

Note that I have already reserved several option flags
for MAC data... is this not what is needed? If possible
I'd prefer to keep the Linux ps compatible with what is
used on Trusted IRIX, etc.

Reserved for security data:  -M -Z -x -z
You may have seen the -x as -y on other systems;
the -y option is already taken for another purpose.

BTW, I would be interested in output samples from ps running
on various systems with mandatory access controls. I try to
make the Linux ps compatible with every other ps. I also like
man pages, "strings -a /bin/ps" output, and experiments with
undocumented options.

It is strongly preferred that columns of data never contain
whitespace and that unknown or unavailable data print as '-'.
So the "<not authorized>" stuff must become "-" instead.
This is to allow parsing the output of ps by splitting columns
apart based on whitespace. The "-" should always be printed
when using a non-FLASK kernel, instead of the error message.

Um, if someone is not authorized to read security data, then
why are they even allowed to know that the process exists?
Somebody could transmit data by playing with signal masks and
other items found under /proc.

I can't allow the #ifdef inside the list of format specifiers,
because this makes it hard for me to keep the list sorted.

Generating a path to the process in pr_context() is poor.
Really, this should be done in the library code.

I notice that there are two new formats... why? It seems that
there would be plenty of room to put all the data in one format,
like this:

{"FLASK", "pid,secsid,context,command"}, /* FLASK security data */

On a standard 80-column screen you still get 22 characters for
the command name and arguments. It would even be reasonable to
include an extra column or two, like the (unimplemented?) LUID.


You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
