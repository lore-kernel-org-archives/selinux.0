Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA18501
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2001 11:04:41 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA09880
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2001 15:04:20 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id PAA09876
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2001 15:04:19 GMT
Date: Fri, 6 Apr 2001 11:03:51 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Simone =?iso-8859-1?Q?Fischer-H=FCbner?= <Simone.Fischer-Huebner@kau.se>
cc: selinux@tycho.nsa.gov, rsbac@compuniverse.de
Subject: Re: Rule Set Based Access Control (RSBAC)
In-Reply-To: <4.3.2.7.2.20010406102905.00d6cc80@mail.cs.kau.se>
Message-ID: <Pine.SOL.3.95.1010406103520.19297A-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 6 Apr 2001, Simone [iso-8859-1] Fischer-Hübner wrote:

> I have followed some of the discussions over the lists. As one of the main 
> authors of the Privacy Model (PM), which is implemented in RSBAC, it was 
> interesting to read that you think that PM can be easily expressed with TE. 
> However, I doubt that you can really express all necessary details and 
> security properties.

In my recent response to Amon, I discussed n-person control and time
limits, and I raised the question of the right place for enforcing some
of the privacy model restrictions (application vs. OS).  Naturally,
I'll be interested in your views on that as well.  I'll try to
answer your additional questions below...

> In particular, you have not discussed how the information flow property can 
> be expressed to prevent illegal information flow(see also example in our 
> NISS´98 paper: in a hospital, medical data accessible for medical treatment 
> purposes could be illegally copied to admission data accessible for 
> administration purposes, or another example: personal data could be copied 
> to data classified as non-personal) :
> In order to prevent illegal information flow , subject (processes) have two 
> further security attributes: Input-purposes and output-purposes.
<some text deleted>
> I do not see how this information flow control can be easily expressed with 
> RBAC/TE ?

You've chosen a particular approach for preventing illegal information
flow in your model.  But that isn't the only way to achieve the same
high-level security requirement.  Rather than dynamically adjusting
the purpose attributes of the process as it performs reads and writes,
you can simply set the purpose attributes when the process is created
based on your intended task, and conservatively prohibit reads or writes
that would violate your information flow restrictions.  The same
is true for Multi-Level Security restrictions.

> Besides, in order to implement operational separation of duties and to 
> prevent misuse, all security attributes can only be defined and set by two 
> authorized person in cooperation. One is the user in the role data 
> protection officer (appointed according to German/European privacy 
> legislation), who creates a ticket to define the security attribute 
> value/allocation, and one is the user in the role security-officer, who can 
> then use the ticket to set the respective attribute.
> Besides, there is another condition that only users in the role TP-manager 
> can define transformation procedures (TPs), but only the security officer 
> in cooperation with the data protection officer is allowed to authorize 
> users for the execution of TPs.
> I do not think that you have such a functionality in RBAC/TE so far ?

As I've said in my response to Amon Ott, you can model n-person control
through pipelines.  But I also suspect that some of these requirements
will end up being enforced by applications in real-world environments,
because they will deal with application services and abstractions such as
database queries and database records that do not map directly onto
individual OS services and abstractions.  In such cases, the OS
can still provide support by protecting the applications against
bypass or tampering, and by confining the potential damage that
can be caused by an errant application.  But such protections
do not require the same logic in the OS security policy.

> Can you also implement access 4-tuples (as we have them in PM), expressing 
> with what task by performing what TP you can access what object class in 
> what mode ?

In the RBAC/TE model of SELinux, a task could either be a role
or a particular domain within a role.  A TP could either be a
domain or a derived domain (subdomain) that can be entered by
the task through the execution of a program type.  You would
then define permissions from the TP domain to the desired objects,
based on the type and class of the objects.

> Well, this seems to be possible, but then you wont have any easy and 
> transparent administration of access rights any longer (which should be one 
> of the advantage of Role Based Access Control -RBAC).
> Just imagine that you model in your system 10 different purposes. This 
> means that you have to model with TE 1024 different types (for all possible 
> subsets of purposes).

It seems unlikely that all combinations of purposes are needed or
that a large number of purposes must be associated with any object
at any given point in time.

> Besides, by relabeling the personal data to include another purpose to 
> which the data subjects have agreed, you change the real semantic of the 
> O-purposes attribute of data, which should only stand for the purposes for 
> which data for initially collected. Relabeling data in case of a consent 
> would in this case also require that you have to change the type (encoding 
> purposes) in the list of necessary accesses as well.

I suppose you could encode two purpose sets in each type to
represent both the original purposes and the current purposes.
But I'm not sure how critical these characteristics are to meeting
the high-level security requirements, as opposed to just being
aspects of your approach.


--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
