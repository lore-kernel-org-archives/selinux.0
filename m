Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA00547
	for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2001 08:18:36 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA06631
	for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2001 12:18:13 GMT
Received: from cassini.dc.kau.se (cassini.dc.kau.se [193.10.220.37])
	by jazzswing.ncsc.mil  with ESMTP id MAA06627
	for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2001 12:18:12 GMT
Message-Id: <4.3.2.7.2.20010409133234.00d72b70@mail.cs.kau.se>
Date: Mon, 09 Apr 2001 13:33:17 +0200
To: Stephen Smalley <sds@tislabs.com>
From: Simone =?iso-8859-1?Q?Fischer-H=FCbner?=
  <Simone.Fischer-Huebner@kau.se>
Subject: Re: Rule Set Based Access Control (RSBAC)
Cc: selinux@tycho.nsa.gov, rsbac@compuniverse.de
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
here is a quick reply before I leave for the weekend:

At 11:03 2001-04-06 -0400, you wrote:

>On Fri, 6 Apr 2001, Simone [iso-8859-1] Fischer-Hübner wrote:
>
> > I have followed some of the discussions over the lists. As one of the main
> > authors of the Privacy Model (PM), which is implemented in RSBAC, it was
> > interesting to read that you think that PM can be easily expressed with 
> TE.
> > However, I doubt that you can really express all necessary details and
> > security properties.
>In my recent response to Amon, I discussed n-person control and time
>limits, and I raised the question of the right place for enforcing some
>of the privacy model restrictions (application vs. OS).  Naturally,
>I'll be interested in your views on that as well.

It may be appropriate to enforce the privacy policy at database level as 
well. However, for a secure system implementation, the PM security policy 
should also be enforced/supported at a lower system level and the 
application should rely on the operating system to enforce the PM policy. 
We decided that it is helpful to have a complete model implementation in 
the operating system.


>I'll try to
>answer your additional questions below...
>
> > In particular, you have not discussed how the information flow property 
> can
> > be expressed to prevent illegal information flow(see also example in our
> > NISS´98 paper: in a hospital, medical data accessible for medical 
> treatment
> > purposes could be illegally copied to admission data accessible for
> > administration purposes, or another example: personal data could be copied
> > to data classified as non-personal) :
> > In order to prevent illegal information flow , subject (processes) have 
> two
> > further security attributes: Input-purposes and output-purposes.
><some text deleted>
> > I do not see how this information flow control can be easily expressed 
> with
> > RBAC/TE ?
>
>You've chosen a particular approach for preventing illegal information
>flow in your model.  But that isn't the only way to achieve the same
>high-level security requirement.  Rather than dynamically adjusting
>the purpose attributes of the process as it performs reads and writes,
>you can simply set the purpose attributes when the process is created
>based on your intended task, and conservatively prohibit reads or writes
>that would violate your information flow restrictions.  The same
>is true for Multi-Level Security restrictions.


Well, this approach will be more restrictive. According to our approach, 
the allowed read and write accesses for a process performing a certain task 
can vary depending on what data the process has read and what data it has 
currently write-access to. A simple example: the process is allowed to 
write to non-personal data (for which most of the security properties do 
not apply) unless it had already read access to personal data (because then 
it could illegally write personal data to unprotected non-personal data).
Thus, if you decide on read and write accesses before process execution, 
you will be more restrictive than necessary.


> > Well, this seems to be possible, but then you wont have any easy and
> > transparent administration of access rights any longer (which should be 
> one
> > of the advantage of Role Based Access Control -RBAC).
> > Just imagine that you model in your system 10 different purposes. This
> > means that you have to model with TE 1024 different types (for all 
> possible
> > subsets of purposes).
>
>It seems unlikely that all combinations of purposes are needed or
>that a large number of purposes must be associated with any object
>at any given point in time.

Well, if you want to include relabeling in case that data subjects have 
given their consents for a usage of their data for potentially any possible 
purpose sets, you have to define types for all possible subsets of 
purposes, because all of them could be potentially needed  (Example: Assume 
there is a personal data object with only one purpose. The data subject of 
this object could potentially give his/her consent that this object could 
be used for any possible subset of the set of the remaining purposes).


> > Besides, by relabeling the personal data to include another purpose to
> > which the data subjects have agreed, you change the real semantic of the
> > O-purposes attribute of data, which should only stand for the purposes for
> > which data for initially collected. Relabeling data in case of a consent
> > would in this case also require that you have to change the type (encoding
> > purposes) in the list of necessary accesses as well.
>
>I suppose you could encode two purpose sets in each type to
>represent both the original purposes and the current purposes.
>But I'm not sure how critical these characteristics are to meeting
>the high-level security requirements, as opposed to just being
>aspects of your approach.

Still, a change of the type in the list of necessary accesses would be 
necessary.


Best regards,
Simone Fischer-Huebner.


-----------------------------------------------------------------------
Prof. Dr. Simone Fischer-Huebner
Karlstad University
Department of Computer Science
Universitetsgatan 1
S 651 88 Karlstad / Sweden
Tel: +46  54 700 1723
Fax: +46  54 700 1828
http://www.cs.kau.se/~simone/
simone.fischer-huebner@kau.se




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
