Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA13821
	for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2002 16:08:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA05853
	for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2002 20:07:28 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id UAA05847
	for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2002 20:07:27 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Simon Han <simonhan@ee.ucla.edu>, selinux@tycho.nsa.gov
Subject: Re: type_transition_rule
Date: Fri, 5 Jul 2002 00:27:46 -0400
References: <Pine.GSO.4.10.10207031514490.13831-100000@centauri.ee.ucla.edu>
In-Reply-To: <Pine.GSO.4.10.10207031514490.13831-100000@centauri.ee.ucla.edu>
MIME-Version: 1.0
Message-Id: <20020706200822.78D3A78EC@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 3 Jul 2002 18:15, Simon Han wrote:
> 	I am new to selinux.  Please forgive me if the question is stupid.
> 	I am playing with the example security server included in selinux.
> I wonder if there is a way to do domain transition based on the file
> current domain is reading.  Please allow me to explain why I need this.
> Consider Java VM,
>
> I define a type 'java_t' for java domain.
> Now, I would like to transition to another domain when java_t is reading
> a_file.class file since java_t is about to load this class to the VM, and
> I don't trust this class.  It will be desirable to be able to transition
> to new domain, say java_insecure_t.  Then, I can config java_insecure_t to
> have very strict access rule.

The current model of SE Linux involves domain only changing at exec() time, 
this does offer benefits for security as it's easier to control domain 
transitions.

However I have also considered situations where a domain transition would be 
useful on situations other than exec(), chroot() is one example that springs 
to mind (for the GR Security functionality).

If we just add this extra method of changing domain then it makes it more 
complex to determine whether a policy is sensible (people are working on 
automated tools for validating policy).

My next thought was to restrict it to changing to a domain that has less 
privs than the parent domain (so we are only restricting privs and therefore 
not at risk).  However the SE Linux kernel code does not contain the concept 
of a sub-domain.

A potential solution to this would be to have checkpolicy validate that the 
target domain to be entered by means other than exec() would have a sub-set 
of the privs of the source domain.

To get Java fully integrating with MAC would require more than this though, 
probably some new research would need to be done on ways of extending the SE 
model.

Couldn't you just have two Java domains, one which can't execute untrusted 
code and another which can't read secret data?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
