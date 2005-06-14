Message-ID: <20050614212359.61423.qmail@web31602.mail.mud.yahoo.com>
Date: Tue, 14 Jun 2005 14:23:59 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Question about integration of IPsec with SELinux?
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20050614181118.75027.qmail@web51506.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Park Lee <parklee_sel@yahoo.com> wrote:

> On Sun, 12 Jun 2005 at 10:46, Casey Schaufler wrote:
> 
> > A system compares ... the decision can be made.
> 
> Now let's suppose that processes are on different
> machines,

Yup.

> Do you mean that attributes of receiving process
> should be sent to the sending machine, which
> contains the sending process?

You'd have to anticipate what attributes
of what objects would be needed before you
could send packets. Beyond current technology.

> and the access control
> are made on the sending machine to decide
> whether the sending process can do interprocess
> communication with its receiving process?

Again, if you could get the attributes of all
the receivers onto the sender in a reliable way
that would be great.

> Can we view the sending process as a subject,
> and view the receiving process as an object
> in the interprocess communication on different
> machines?

Yes, although it is traditional to use
the receiver side socket as the object
rather than the receiving process. This
is done to allow privileged processes
to set socket attributes that allow
delivery of packets with attributes that
would normally be disallowed.

> If it is, let's see another situation:
> We use the attributes of the sending process to
> label
> the packets which are sent by the sending
> process.

This is the typical scenario.

> when the packets are received on receiving
> machine, the receiving machine can use the
> attributes of the receiving process and the
> attributes
> of the packets to determine whether these packets
> can
> be received.

This is the way Unix systems using CIPSO
and/or TSIG SAMP work.

> Here, the receiving process becomes
> subject, and the packets which represent its sending
> process become objects. 

Well, not quite. In this scenario the sending
process is still the subject and the receiving
socket is still the object, as above. The
fact that the action is taking place on the
receiving machine is grossly inconvinient
from an audit perspective, but otherwise
completely reasonable.

> Then, Does this situation become conflict with what
> you wrote above?

It certainly would be, the way you described it.
The big issue here is one of commonality of
policy (y'all knew I'd get to this somehow)
between the two systems. It is essential that
the attributes that get sent provide the right
sort of information for the receiving machine
to make any and all access control decisions.
Of course, the easiest way to do this is to
ensure that the two machines are using the same
attribute set. The next easiest is to provide a
mechanism for mapping (as TSIG SAMP) the
attribute sets. After that, you're on your own.

An interesting background paper (referenced
in some of the early flux material) on the
topic was presented in 1993. It's good reading
if you can find a copy. I know of no surviving
electronic versions, alas. Oh, and the NSA
evaluation Technical Review Board (TRB) had to
go into conclave for three months to find the
fatal flaw in the paper, which was evident once
the TRB "clarified" their definition of an
object.

  S. Romero, C. Schaufler, and N. Bolyard,
  “BSD IPC model and policy,” in Proc. 16th
  National Computer Security Conference,
  pp. 97106, 1993



Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Discover Yahoo! 
Use Yahoo! to plan a weekend, have fun online and more. Check it out! 
http://discover.yahoo.com/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
