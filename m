Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA12110
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 16:51:57 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA26189
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 20:50:18 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id UAA26185 for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 20:50:16 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>, "M. H." <metalhead00@hotmail.com>
Subject: Re: restrict access by user identity
Date: Thu, 22 Aug 2002 22:51:44 +0200
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0208221358250.29931-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0208221358250.29931-100000@raven>
MIME-Version: 1.0
Message-Id: <20020822205144.E6FAA6B15@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 22 Aug 2002 20:10, Stephen Smalley wrote:
> On Thu, 22 Aug 2002, M. H. wrote:
> > I would like to be able to do the following thing:
> > Let's assume I set the type of a file to type_a.
> > I would like to be able to ensure that users who can read files of type_a
> > can only do so for files which are labeled with their name (so the
> > scontext of the file is <username>:object_r:type_a.) So userA would then
> > not be able to read a file labeled with userB:object_r:type_a.
> > Is this possible?
>
> You could try to implement such a restriction via the policy/constraints
> configuration (see the Configuring the SELinux Policy report).  However, I
> wouldn't recommend this approach.  The preferred approach would be to
> define separate types for userA's objects and userB's objects, with
> separate domains and roles for userA and userB.

Also make sure you use the most recent version of the sample policy that is 
available for this.

Older versions had user_t and user_home_t specified right through the policy 
files.  When I first setup a machine with multiple user roles (the SE demo 
machine at LinuxTag in Germany) I spent about 45 minutes getting it to the 
stage where it was half-usable (barely enough for a demo machine) with 
multiple roles.

Successive policy revisions have improved this considerably.

Any time you see a reference to user_t or user_home_t in a .te file then the 
.te file is buggy and will cause you problems with multiple user roles (IE 
you'll have to re-write that .te file).  I've just done a grep of my policy 
tree, it looks like I've got some work to do in this regard.  :(

If you are using a policy V9 policy DB (kernel 2.4.17 from memory) then this 
will be a problem for you.  It would be quite possible to merge the policy 
file support needed for policy V9 with the newer versions of the macro files 
etc that support multiple user roles, but it would probably be a lot easier 
to upgrade to a newer kernel with a V11 policy DB.

It seems that the major issues with my current policy are:
1)  login and sshd need a user_t for a default transition (if you use a 
non-SE version of login or sshd).  So you can add new user roles but you MUST 
have user_r and user_t.
2) You have to change newrole.te when adding new roles, IFF they are to be 
permitted to change roles.  Of course if you add a new role that isn't to be 
allowed to change to any other role then it's not a problem.  Failure to 
change newrole.te means that the terminal device type doesn't get changed.  
The most noticable symptom of this is that you do "newrole -r sysadm_r" and 
then "su" doesn't work because it transitions to a domain that doesn't have 
the "write almost anything" access of sysadm_t.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
