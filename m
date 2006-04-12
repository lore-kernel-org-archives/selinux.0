Date: Wed, 12 Apr 2006 15:57:53 -0400 (EDT)
From: Gaurav Poothia <gpoothia@cs.sunysb.edu>
To: sds@tycho.nsa.gov
cc: SELinux@tycho.nsa.gov
Subject: Untrusted applications under SELinux
Message-ID: <Pine.GSO.4.53.0604121556280.20146@compserv4>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am researching security infrastructures that protect the TCB (or atleast
some notion of trusted apps) from untrusted code.

In a paper titled "Meeting Critical Security Objectives with
Security-Enhanced" you mention the relevant drawbacks of DAC:
" (Under DAC)....malicious programs are free to change the permissions
associated with all of the user's objects, as well as disclose or alter
the objects themselves."


Lets assume that user acquires an  untrusted application.
Its functionality is not well defined and even if it is the user is not
inclined to type out a confinement policy tailored to this app.

Under this assumption can you please clarify how SELinux :
1.Ensures that the untrusted application doesnt compromise integrity of
data owned by the executing UID.

2.Lets the app access the parts of the filesystem
and other resources (media related devices/net resources)
which the domain it defaulted to (user_t in the strict policy?) might not
have access to. In other words how do I get an unknown/untrusted app to
work safely under the strict policy. This might be one reason for the
targeted policy but what is the approximate solution to this?

Thanks and regards
-Gaurav


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
