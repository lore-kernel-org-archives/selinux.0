Date: Wed, 10 Oct 2001 15:32:25 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Frank Mayer <mayerf@tresys.com>
cc: <SELinux@tycho.nsa.gov>
Subject: RE: Security policy analysis
In-Reply-To: <ACEHIKGIGFEDAIKEMMMIGENIJPAA.mayerf@tresys.com>
Message-ID: <Pine.GSO.4.33.0110101530440.16839-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 10 Oct 2001, Frank Mayer wrote:

>We looked quickly at checkpolicy and came to the same conclusion, i.e., that
>it compiles policies for a different reason and has a policy DB not
>suited for our purpose.  That's not a strong opinion.

So perhaps checkpolicy needs to be revised to generate an intermediate set
of data structures that are more suitable for policy analysis tools prior
to generating the final set of data structures for the kernel security
server?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
