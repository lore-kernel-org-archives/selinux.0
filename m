Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA08301
	for <selinux@tycho.nsa.gov>; Fri, 5 Jul 2002 08:24:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA13130
	for <selinux@tycho.nsa.gov>; Fri, 5 Jul 2002 12:23:35 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA13126
	for <selinux@tycho.nsa.gov>; Fri, 5 Jul 2002 12:23:34 GMT
Date: Fri, 5 Jul 2002 08:23:54 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Simon Han <simonhan@ee.ucla.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: type_transition_rule
In-Reply-To: <Pine.GSO.4.10.10207031514490.13831-100000@centauri.ee.ucla.edu>
Message-ID: <Pine.GSO.4.33.0207050813320.29942-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 3 Jul 2002, Simon Han wrote:

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
>
> Could someone please give me a hand?  An answer telling me that this is
> not possible is also appreciated.  Even better answer will be telling me
> where to modify example server so that this approach can happen.  :)

SELinux only supports process SID transitions upon program execution so
that the inheritance of state and the initialization of the process in the
new SID can be controlled.  Hence, a process domain transition based on a
file read operation is not supported.

You would typically use SELinux to confine the entire process running the
JVM to a single domain, and limit that domain to least privilege (e.g. the
existing user_netscape_t domain for confining a user's browser).  If you
want finer-grained confinement within the JVM, you would likely want to
extend the JVM itself to enforce access controls over its abstractions,
possibly using the security server to obtain security decisions.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
