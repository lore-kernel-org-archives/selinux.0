Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h82JG8La019148
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 15:16:08 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h82JG7et000516
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 19:16:07 GMT
Received: from etsuex1.etsu.edu (etsuex1.etsu.edu [151.141.8.103])
        by jazzband.ncsc.mil  with ESMTP id h82JG6lq000513 for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 19:16:06 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Type background of SELinux
Date: Tue, 2 Sep 2003 15:16:04 -0400
Message-ID: <C5FA5FEED6F0884E9EB90BB3C010F1EF076F4283@etsuex1.etsu.edu>
From: "Jenkins, Steven" <JENKINSS@mail.etsu.edu>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Thanks -- that's explains what I was seeing in the actual code itself,
but some of the language in the papers made me wonder if I was missing
something.

I'm still not clear how systems that can dynamically call libc (or other
'dangerous' libraries) are handled -- is the development/deployment
process basically:

1- developer writes program
2- security administrator examines program to determine appropriate
    security policy

That cost is very high in administrator time -- wouldn't it be more
compact & efficient to do analyses on the programs themselves vis-a-vis
the system calls they have available to them?  Granted, to do that in
general is Turing-equivalent, but I would think it helpful to provide
developers with a set of calls that they could use safely, without
having to have an administrator 'sign off on' their code.

For example:

main(){
	printf("Hello, world!\n");
}

is safe because it only calls a single safe function, printf().  Note
that I mean safe in terms of integrity -- clearly printf() can be used
to violate confidentiality policies!  As long as code passes a certain
kind of automatic 'safety check', then it could be deployed without
requiring manual inspection on the part of the administrator.

As I look at SELinux, and at the 'Remaining Work', this is what I view
as:

* Improve and simplify the policy configuration system 
* Complete the general purpose policy configuration 

Is that understanding in line with what you're actually doing, or is
that a different direction?

Thanks,
Steven





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
