From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: svirt on MLS has strange AVC.
Date: Thu, 25 Mar 2010 17:36:48 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        "Daniel P. Berrange" <berrange@redhat.com>,
        SELinux <selinux@tycho.nsa.gov>, Chad Hanson <chanson@TrustedCS.com>
References: <4BA7E4BF.1040002@redhat.com> <1269542084.1031.52.camel@moss-pluto.epoch.ncsc.mil> <1269542713.2980.14.camel@dhcp231-113.rdu.redhat.com>
In-Reply-To: <1269542713.2980.14.camel@dhcp231-113.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201003251736.48820.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 25 March 2010 02:45:13 pm Eric Paris wrote:
> On Thu, 2010-03-25 at 14:34 -0400, Stephen Smalley wrote:
> > But the behavior for the new connection/server socket was changed for
> > MLS during the LSPP work to reflect the level of the client.  This makes
> > sense when you have a single-level client connecting to a ranged server
> > - the connection is then established at the requesting level and the
> > traffic is labeled and protected accordingly.
> 
> I still don't understand why MLS is some 'other' class citizen of the
> context.  If it makes sense to reflect the level it should make sense to
> reflect the type, and role, and user, if they are available.  Doesn't it?

Yes, to some extent anyway.  For connectionless, uni-directional sockets, e.g. 
UDP, the socket's label is pretty easy to understand: you label it based on 
the task that created it and you're done, nobody argues this and it just plain 
makes sense.  The problem are those connection oriented bi-directional sockets 
that we all love because it brings us our beloved flash videos, yes, I'm 
talking about TCP.

Connection oriented sockets are a pain pretty much any way you look at it, 
although the client side is at least more straightforward so we'll look at 
that first.  The first thing a client does when it wants to establish a 
network connection is create a socket via the socket() syscall; at this point 
the only information we have is the task's label so we have no choice but to 
label the client's socket using the client's label.  The next step is to 
"connect" the client's socket to the server using the connect() syscall, and 
this is where the fun happens.  The connect() syscall kicks off the connection 
handshake, which if successful, results in a new socket (known often as the 
"child" socket) on the server which is connected, via the magic of networking, 
to the client's socket ... now, what do we label these two sockets?  Well, we 
already have a label assigned to the client's socket and we don't want to 
change that so we'll leave that alone, but what about the newly created child 
socket on the server?  This is the tricky bit, we have the following options 
[I may be missing one or two possibilities, but the four below are the only 
options that seem like reasonable choices to me]:

1. Label it based on the server's label
2. Label it based on the client's label
3. Label it based on some fixed combination of the client and server labels
4. Label it based on a type transition rule

Option #1 is nice and consistent with how we label all other sockets, but it 
presents an interesting problem: in SELinux we treat sockets, not processes, 
as communication endpoints (client applications read/write to client sockets 
who read/write to server sockets which are read/written to by server 
applications) and we want to be able to distinguish between connections 
labeled FOO and BAR at the application level, how do we do that if all of the 
server child sockets are labeled using only the application's label?  The 
answer: you can't, or rather I haven't heard of a sane way.  If we want to be 
able to write policy that allows us to control the network traffic entering or 
leaving an application we have to do it by varying the label of network socket 
being used for communication.

Option #2 creates the server's child socket with a label matching the client's 
traffic; this solves the policy problem we saw with option #1 but it 
introduces a new problem we didn't have before.  As mentioned earlier, in 
SELinux it is the sockets, not the applications that communicate across the 
network and they are the subjects/objects used in the per-packet access 
controls; if we label the server's child socket to match the client's label we 
run afoul of the client's network access controls.  The problem is all of the 
network traffic coming from the server is coming from a socket labeled the 
same as the client's own socket; from a policy point of view this shifts the 
problem we saw with option #1 from the server to the client: you can't write 
policy on the client to enforce network access controls on incoming traffic as 
all incoming traffic from the server is labeled the same - the client's own 
label.

Option #3 is what we have today; created by developers with a MLS-centric view 
at a point in time when nobody really cared about any of the network access 
controls and the overriding theme to the development efforts was, "go make 
your changes but make sure you tread lightly and no matter what make sure we 
can turn it off, because that is what we are going to do in all our 
installations."  Okay, that might be harsh criticism for both sides, but I 
think you kinda get the idea and most of you who have read this far were 
likely around then anyway.  Regardless, back to option #3, a derived label 
based on both the client and server labels; the basic idea is that you need to 
be able to vary the label on the server's child socket so that it represents 
both the client's label (so you can write effective server side policy) as 
well as the server's label (so you can write effective client side policy) 
without causing everything to come crashing down.  The solution that we 
settled upon was using the TE attributes (user, role and type) from the 
server's label and the MLS attributes (level and categories) from the client.  
I don't think you'll find anyone who claims this is a perfect solution, I know 
I won't, but it has worked for several years without any complaints (it is 
worth noting that the complaints we are seeing this week are not due to 
traditional IP networking, but rather UNIX socket "networking" which appears 
to have some implementation bugs regardless of the design choices).

Option #4 is an interesting idea, very similar to option #3 but driven more by 
policy rather then a fixed rule for combining the two labels, client and 
server, to create a new label for the server's child socket.  In option #3 we 
used a fixed rule, server's TE attributes and client's MLS attributes, to 
generate the label for the server's child socket; in option #4 we could use 
policy, via transition rules, to generate the label for the server's child 
socket.  Other than the obvious extra policy work required (the policy work 
required for option #3 is largely contained in the MLS constraints which can 
greatly simplify the policy for the traditional MLS policies) the problem is 
that we do not have a good policy construct to set the MLS attributes of a 
label based on the MLS attributes of the two other labels; the 
range_transition rule allows to set the MLS attributes of a label, but only 
based on the type information of the other labels, not their own MLS 
attributes.  While option #4 is likely the most flexible option discussed 
here, it is also the most involved and I don't currently believe the benefits 
over option #3 make it worth the effort at this point.

> I know that some labeling magic (CIPSO) don't deal with anything
> but the level and thus the only thing we can/should do is play with the
> level, but when we have the info (unix domain sockets and I think some
> IPSec labeling right), why do we discard that additional info that makes
> these things 'make sense'?

Hopefully if you understood the stuff above this is evident, but I want to 
make it this point again just so there is no confusion - CIPSO, or any other 
networking protocol that only conveys MLS attributes, it not the reason why we 
have the derived labels we have today.  Have the client's full label doesn't 
make the problem any easier; you'll note in options #1 and #2 above there is 
no talk of TE or MLS attributes, it simply doesn't matter.

If you need to blame something, blame the SELinux network access control 
architecture or the SELinux policy but also recognize that there isn't a magic 
solution to make everything sane using what we currently have - although if 
you have an idea, I'm all ears.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
