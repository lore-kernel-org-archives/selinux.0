Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6LCmESg014321
	for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2008 08:48:14 -0400
Received: from n2.bullet.mail.re3.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m6LCmDId001422
	for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2008 12:48:13 GMT
From: "Joe_Wulf" <Joe_Wulf@yahoo.com>
To: "'Murray McAllister'" <mmcallis@redhat.com>, <selinux@tycho.nsa.gov>
References: <48803B08.1030205@redhat.com>
Subject: RE: SELinux User Guide
Date: Mon, 21 Jul 2008 08:41:30 -0400
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAI0mbVq38OtHvIfYWTLmtk3CgAAAEAAAAOmKrWbzsLBBnydahhNdd5MBAAAAAA==@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <48803B08.1030205@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Murray,

This is a fantastic idea.  I too work (a little bit) with SELinux, and struggle
with it.
I've looked at the detailed reply maximilianbianco@gmail.com gave and concur as
I'd very
much love to learn more and in a structured way.  What I recommend is:
-  Integrating in a pretty comprehensive overview section with a bare minimum
reference
   to traditional security (but just enough to connect the two).  I myself would
need
   the picture painted of what is the scope, breadth and depth of SELinux, what
it does,
   and what it doesn't do.
-  Show some methodical and practical examples of exactly what SELinux does, and
explain
   in English HOW it does it (maybe why, too).
-  Also, what are the impacts achieved with and without SELinux, and various
contexts.
   So, for instance, when a variety of common mistakes (IRT SELinux) are made,
what is
   the security-related result? 
   An example might be a file (/a/b/c) that has some form of SELinux protection
context,
   that is moved, updated and rebuilt with some end-SysAdmin's desired
configuration.
   What is the resulting security context?---maybe this is overly simple, but its
about
   all I do understand at the moment, and I'm sure there are more involved and
way better
   examples to use.
-  Maybe have a single chapter devoted to elemental basics.  Along the lines of:
"If you
   don't do anything else with SELinux, at least do these things, and here's
why." type
   of rationale.
-  I do also recommend a balanced and coordinated approach with the Center for
Internet
   Security.  They've a number of benchmarks in development, with recent
publication of
   one for RHEL5.


R,
-Joe Wulf, CISSP, USN(RET)
 Senior IA Engineer
 ProSync Technology Group, LLC
 www.prosync.com
 (410) 772-7969  office
 (410) 772-7967  fax
 (443) 801-5597  personal cell


-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On Behalf
Of Murray McAllister
Sent: Friday, July 18, 2008 02:41
To: selinux@tycho.nsa.gov
Subject: SELinux User Guide

Hi,

Apologies if this doubles up for anyone.

My name is Murray McAllister and I am working as a content author for Red Hat. I
have recently started a new project -- an SELinux User Guide
-- with Daniel Walsh, Michael Smith, and a few other people from Red Hat.

There are a few SELinux books, but these are very technical. We want to create a
guide that people with no previous SELinux experience can use, to allow them to
do what they want without turning SELinux off.

I have started a rough information plan that includes the current schedule,
information sources, and some ideas for the content that may be included. The
information plan is located at
<https://fedoraproject.org/wiki/Docs/Drafts/SELinux_User_Guide/SELinux_Informatio
n_Plan>. 
The main project page is located at
<https://fedoraproject.org/wiki/Docs/Drafts/SELinux_User_Guide>.

Among other things, we are going to try to cover the following topics from the
current SELinux project documentation todo list
(http://selinuxproject.org/page/Documentation_TODO):

* "Explain how to interpret an AVC message and how to get additional information
via SYSCALL audit, including how to add a simple syscall audit filter to enable
collection of PATH information".
* Document Confined Users".
* "Update FC5 FAQ".
* "Document the use of the mount command for overriding file context".
* "Describe Audit2allow and how it can just Fix the machine".
* "Update and organize the Fedora SELinux FAQ".

If anyone has any ideas about what they would like to see in the guide, or any
corrections to the current topics we would like to include, please let us know.
As well, user feedback and comments can be left at
<https://fedoraproject.org/wiki/Docs/Drafts/SELinux_User_Guide/SELinux_Feedback>.

A Fedora account (https://admin.fedoraproject.org/accounts/) is required to use
the Wiki - if you do not have one, please do not hesitate to mail me directly, or
respond to this thread.

Thanks for your time,

Murray.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with the
words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
