Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA26157
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2001 18:41:36 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id XAA12315
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2001 23:40:11 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id XAA12311
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2001 23:40:11 GMT
Received: from coalstack.epoch.ncsc.mil (coalstack [144.51.25.12])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA05170
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2001 18:41:35 -0500 (EST)
Date: Tue, 9 Jan 2001 18:41:33 -0500 (EST)
From: pal@epoch.ncsc.mil (Pete Loscocco)
Message-Id: <200101092341.SAA21924@coalstack.epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Subject: Acceptabilty of Security-enhanced Linux
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

I posted the following to the Robust Open Source mailing list in
response to a comment about industry not being able to take advantage
of Security-enhanced Linux. I thought it might be interesting to this
list too. My apologies to any one who received it twice.

Casey Schaufler of SGI wrote:
...
> 
> Unfortunately, I see no way that the industry can take
> advantage of [Security-enhanced Linux]. We've been pushing B1 (now
> LSPP) as the
  [Labeled Security Protection Profile of the Common Criteria, see
  http://www.radium.ncsc.mil/tpep/library/protection_profiles/index.html]

> ultimate COTS security solution since the late 1980's
> and we're not going to drop that investment any time
> soon. The engineering investment is only a part of the
> issue; we've trained customers, sales staff, support
> staff, and management on the value and necessity of
> meeting that particular criteria. We are not going to
> throw that away, even for a vastly superior technology
> (Hey! I *AM* Dilbert's Boss!) which DE does not appear
> to be.
> 
> We will continue our efforts toward an LSPP Linux system.
> That includes application and networking changes, and
> the whole derned evaluation process. DE has some nice
> attributes, but it's not sufficient without the complete
> solution wrapped around it.

I am not sure that I understand the point that industry can't take
advantage of Security-enhanced Linux. We believe that it's architecture
is a general solution to providing mandatory security to Linux. By
mandatory security, I mean that there is central enforcement of a
system security policy rather than simply the ability to support
multilevel security. In the "Inevitability of Failure: The Flawed
Assumption of Security in Modern Computing"
(http://www.nsa.gov/selinux/inevit-abs.html), we argued the importance
of mandatory access controls to system security. Security-enhanced
Linux is our attempt to demonstrate the feasability and effectiveness
of these access controls in a widely-used system.

It is important to remember that Security-enhanced Linux is not simply
Type Enforcement brought to Linux. There is a well-defined architecture
that provides a clean separation of the enforcement of a mandatory
security policy in the kernel (or to user space object managers) and
the access computations and labeling decisions in the security server
by a well-defined general interface that is capable of supporting a
wide variety of security policies, including MLS. It provides
fine-grained controls over kernel abstractions. The architecture
provides policy flexibility by allowing the specification of security
policy through configuration files or the relatively easy
modification/replacement of the security server's decision engine in
the event that the security server implementation is unable to support
a needed policy.  Detailed studies have been performed on the ability
of the architecture to support a wide variety of security policies and
are available on the DTOS and Flask web pages accessible via the
Background page (http://www.nsa.gov/selinux/background.html).  A
published paper about the Flask architecture is also available on the
Background page.  The architecture and its implementation in Linux are
described in detail in the documentation
(http://www.nsa.gov/selinux/docs.html). It is precisely because of this
general architecture that we believe industry could take advantage of
Security-enhanced Linux.
  
The security server included in the release is a generalization of Type
Enforcement. We chose this because we believe that it has the broadest
appeal. It provides a means of specifying a large number of useful
security policies that can be used to counter system vulnerabilities
and is powerful enough to meet many security needs. In comparison to
traditional lattice-based models like BLP and Biba, Type Enforcement is
better suited to providing integrity protection, especially due to its
support for intransitive relationships and its controls over program
execution. Type Enforcement is often used to ensure that applications
are unbypassable and tamperproof.  It is also often used to ensure that
processes with any sort of privileges cannot execute untrustworthy
code.  Additionally, Type Enforcement offers better support for least
privilege.  Nonetheless, it is only an example of one possible security
server.

Security-enhanced Linux does not need to be inconsistent with the LSPP
security target because the architecture can support MLS security. In
fact, the release does include some minimal support for MLS in the
security server in addition to the type enforcement and role-based
access control policies. It would be excellent if that MLS support
could be augmented by capable contributors. Also, meeting the LSPP
requirements certainly does not preclude the addition of type
enforcement in the system.

A major benefit of our architecture is that it allows for such security
policies to be supported without dictating that they be supported in
all systems. A primary reason why we concentrated on policy flexibility
in the architecture was to address what we believe to have been a major
reason why mandatory controls have yet to make it into widely used
systems - one security policy is not general enough to meet all
security needs.  The adoption of a flexible architecture such as ours
enables common policy enforcement with customizations of security
policies as needed per installation.

As stated on the NSA web pages, Security-enhanced Linux is not a
complete secutiy solution. We have focused on a critical missing
feature - mandatory access controls. It is definitely "not sufficient
without a complete solution wrapped around it." Additional security
features such as auditing and trusted path called for in the LSPP and
other security targets must be addressed. Although the LSPP can meet
certain security needs it can never be the "ulimate COTS security
solution." It will never meet every security need. I think we are
better served as a community to work together to build a system that
can support the many definitions of security, including that described
in the LSPP. Security-enhanced Linux is our initial contribution to do
just that.

-- 

Peter Loscocco
Security-enhanced Linux Project Leader
Information Assurance Research Office
National Security Agency

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
