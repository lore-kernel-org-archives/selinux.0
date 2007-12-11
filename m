Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBBHpZgW022055
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 12:51:35 -0500
Received: from web36609.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id lBBHpXrO007695
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 17:51:33 GMT
Date: Tue, 11 Dec 2007 09:51:18 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Network flow controls and subj/obj ordering
To: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
In-Reply-To: <200712111202.20074.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <203434.50468.qm@web36609.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Paul Moore <paul.moore@hp.com> wrote:

> Hello everybody,
> 
> After a discussion with Venkat last week we decided that it was probably best
> 
> if I took responsibility for the flow control patches and ported/cleaned them
> 
> up for inclusion in the labeled networking patches for 2.6.25.  In the course
> 
> of doing so I ran across the problem of subject/object "ordering" (probably 
> not the best term, but it's all I can think of right now).  In both the "flow
> 
> in" and "flow out" cases I'm tempted to use the packet's peer label as the 
> object just for the sake of consistency and the ability to use the new "peer"
> 
> object class for all network peer label access checks.  However, I wanted to 
> make sure that is what everyone had in mind from a conceptual point of view. 
> 
> See the two simple policy examples below:
> 
>  * Packet "flows" into the system, peer label is the object
> 
>    allow netif_t peerlbl_t:peer flow_in;
> 
>  * Packet "flows" out of the system, peer label is the object
> 
>    allow netif_t peerlbl_t:peer flow_out;
> 
> Thoughts, opinions?

Networking policy is always fun to debate. I've gotten it wrong
so many times I've lost count. Let's see if I can add anything of
value.

A packet appears out of the ether and is attached to a flow. If the
packet is a labeled object and the flow is a labeled object, what
is the subject? If the packet moves on out of the system (it is
being forwarded) and the packet is a labeled object, what is the
subject? Do you even have a subject/object relationship in this case?
I think that if you can identify the subject involved in flow
processing the policy implications ought to be pretty clear. If
you don't, and you have nothing but objects to deal with, it gets
painfully difficult to produce a security model that can be described
using traditional methods.

I will point out that it is pretty difficult to associate a subject
with an action on a packet object in all cases, and that is one reason
the model of a packet as an object never caught on. Perhaps the flow
is your subject, performing read and write operations on the packets.
I don't know that it makes a lot of sense to consider a flow as a
subject, but I've made arguments from shakier premises myself.

Think about the notion that the flow is the object, and that the
subject is whatever created the packet, and the label on the packet
describes the subject. This makes the operation a write from the
packet creator to the flow. It makes the outflow a read from the
flow by whatever active entity (task? kthread? daemon?) sends the
packet along, and a write to the destination with the label on the
packet again describing that subject.

In any case, if you don't bring a subject into the picture you may
have processing to do, but you're not making access control decisions.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
