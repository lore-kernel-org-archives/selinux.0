Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4NHi6gA009367
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2005 13:44:06 -0400 (EDT)
Received: from web60412.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j4NHdVMj028167
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2005 17:39:31 GMT
Message-ID: <20050523173932.26073.qmail@web60412.mail.yahoo.com>
Date: Mon, 23 May 2005 10:39:32 -0700 (PDT)
From: Roger Brunell <rog_brunell@yahoo.com>
Subject: Re: Time estimate to create Debian enforceable policy 
To: Valdis.Kletnieks@vt.edu
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200505231621.j4NGL5pS016223@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Valdis.Kletnieks@vt.edu wrote:

> On Mon, 23 May 2005 06:26:11 PDT, Roger Brunell said:
> > Folk;
> >   I am looking for some SWAGs in [days|weeks|months]
> > for:
> > Given moderately smart person, w/:
> ...
> >       appropiate resources (SELinux running on system)
> > 
> > To create, test and verify a meaningful, workable and enforceable
> >    policy for a <<elided>> (Mish-Mash of Debian parts)
> >    system.
> 
> You *have* omitted "step 0" - creating a "meaningful" policy requires that
> you have some *goals* of what the policy does and does not even attempt to
> address (the difference of 'strict' and 'targeted' policies are an
> indication of how much the goals impact the end product - similar issues will
> arise for things like "should XYZ have a boolean or not?").

  Actually I do have an objective.
     But before I can try that I have to modify the policy so that
   the machine will work as a general purpose machine. Old school, have to
   start with the basics. "A fool with a tool is still a fool".

  After I understand all the mechanics and interactions, then what I want
  is:

   the policy we need has just two requirements.
     1. Only ifconfig writes to any network interface.
     2. No one writes to any hard drive.

   anything else if fine. DOS is not a concern.


> 
> Assuming that you can use 'strict' or 'targeted' as a rough baseline, the
> biggest time consumer there will be "getting a Debian system with SELinux
> running".  Once you actually *get* all the pieces (the policy, the policy
> utils, the hooks for 'init' to load it at boot, setools so you can create
> labelled users, and so on), 

    that part is done, to the extent that I am able to test it. sestatus
    gives expected results; apol and seaudit don't complain, ...

    After installing that, I still have 150 unique avc messages during the
    boot process alone. These are the things that need to be cleaned up.
    I did build the initrd with labeled files, so the audit messages are
    other actions that are not accounted for in the policy.



> you're probably looking at "several long
> afternoons
> fixing the file_contexts for things Debian installs in places different from
> Fedora", and probably a day for each package that needs SELinux support that
> doesn't already (although a few, such as "stuff run from httpd", are a bigger
> challenge).



> 
> (No, I don't know what state the Debian support is currently - I'm merely
> providing
> feedback on the specifications themselves....)
> 


Roger Brunell

Infosec Engineer (retired)
"Born 20 years too early"


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Find what you need with new enhanced search. 
http://info.mail.yahoo.com/mail_250

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
