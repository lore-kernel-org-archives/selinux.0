Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4MGc5I4022373
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 12:38:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4MGc4tV021809
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 16:38:04 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h4MGbwal021800 for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 16:38:00 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Giorgio Zanin <selinux_list@yahoo.it>, selinux@tycho.nsa.gov
Subject: Re: about security contexts for objects
Date: Fri, 23 May 2003 02:35:50 +1000
References: <3ECCDA52.5010802@yahoo.it>
In-Reply-To: <3ECCDA52.5010802@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305230235.50512.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 23 May 2003 00:10, Giorgio Zanin wrote:
> A security context has three components: a "user", a "role" and a
> "type". Not all of the combinations of values for these components are

The definition you give for the allowed combinations is accurate.

Also you should note that when a machine is in "permissive mode" processes can 
run in security contexts that are not permitted.  Toggling the machine to 
"enforcing mode" will destroy those security contexts and make the processes 
unlabelled (and unable to do anything useful).

> What I need now is something similar for object security contexts. The
> "role" component of such a security context is trivially "object_r".
> What about "user" and "type" components?

"user" is by default the identity of the user who created the object.  However 
certain processes are allowed to change the identity.  Eventually I will 
patch setfiles so that when it applies contexts to user home directories it 
will assign the "user" field correctly.  If the user field in the object 
security contexts matches that of a process then the process may be permitted 
to change the type of the object (see the constraints file - things are 
actually more complex than this).

> I thought it would be useful to define a set of valid security contexts
> with respect to a given object class.
> For example, O(file) could be the set of all the valid security contexts
> for files,

Which is all possible users and all possible types.  Although the policy may 
prohibit a certain user from having a process in a domain that can create a 
file of a particular type (it may even prohibit any domain from creating or 
writing to such a file) that does not prevent the file from keeping it's 
label.  For example if I change the user "john" from the role staff_r to the 
role user_r then the files with label john:object_r:staff_home_t will keep 
their label (and be inaccessible to John).

> Is it possible to define O(c) (c=a given object class different from
> "process") just looking at some configuration rules?
> If I look at the file context configuration, I can get some elements of
> O(file) and O(dir), but I think I can't catch all of them.

Look at the policy for all types that have the attribute file_type, that 
should catch all of them.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
