Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h918U5sJ023559
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 04:30:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h918U5CG024380
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 08:30:05 GMT
Received: from out011.verizon.net (out011pub.verizon.net [206.46.170.135])
        by jazzband.ncsc.mil  with ESMTP id h918U4qJ024377 for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 08:30:04 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Bill Laut <wlsel@verizon.net>
To: russell@coker.com.au
Subject: Re: X Windows discussion
Date: Wed, 1 Oct 2003 04:32:21 -0400
Cc: selinux@tycho.nsa.gov
References: <1064880029.5342.349.camel@moss-tarheels.epoch.ncsc.mil> <200309301631.12831.wlsel@verizon.net> <200310011534.09826.russell@coker.com.au>
In-Reply-To: <200310011534.09826.russell@coker.com.au>
MIME-Version: 1.0
Message-Id: <200310010432.21576.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 01 October 2003 01:34 am, Russell Coker wrote:
> On Wed, 1 Oct 2003 06:31, Bill Laut wrote:
> > I do have a concern about the effects on system performance.  Unlike
> > general policy enforcement decisions, the X system presents a scenario
> > where multiple tests may have to be made before a decision can be
> > rendered and/or where multiple tests may have to be interleaved to reach
> > a "composite" decision (a screen snapshot, for example, comes immediately
> > to mind in both cases).
>
> Are many people running systems where screen capture speed is a bottleneck?
>

No.  My citation of the screen capture was intended to illustrate where 
multiple decisions would have to be made before a "composite" decision could 
be reached.  EG, which windows is the screen capture allowed to record.  That 
sort of thing.

A more realistic system overhead comparison would be to ask the question, "how 
much overhead would X impose versus, say, copying a large file where every 
file-I/O operation is being vetted by the kernel AVC?"  Just that question by 
itself answers my concerns.  But, as I said previously, these concerns are 
purely speculative at this point.

>
> > > The existing SELinux policy in the kernel controls who can connect to
> > > the X server.
> >
> > I was under the impression that the existing SELinux policy only had
> > granularity to the IP/port address, not to the client's source context
> > (unless labeled networking is in effect).  Has this changed?
>
> For local connections we control access to the Unix domain socket and to
> the TCP port.  For remote connections the only sensible thing to do is to
> use ssh tunneling.  You just have to avoid doing "ssh -X untrusted-host"
> (you would be amazed how many people try to do X forwarding from my play
> machine).
>

While ssh tunneling would (thankfully) encrypt the TCP stream (and *should* be 
employed for that purpose), it has no means of passing the client's security 
context to the server.  Let alone pass it to the server in a form that a 
malicious client couldn't spoof.

>
> As for labeled networking, requiring IPSEC is a difficult issue, many
> people have deployed networks with other systems and are not in a hurry to
> change.
>

Whoa, back up!  I didn't say we should mandate IPSEC.  That is something 
entirely different.  What I said was:

     "I suppose what I'm proposing is something like Labeled Networking with
     IPSec-like key negotiation, etc., but without it actually becoming a
     formal VPN."

What I'm envisioning is an enhanced version of the labeled networking support 
already extant within the SELinux suite.  It would transparently negotiate a 
session key with its counterpart on the peer as needed, and then exchange 
encrypted (with the session key) security contexts within the Options field 
of the IP header as the client and server communicate with one another, so 
that a security-aware server (X, in this case) would know -which- application 
on the client _via_the_security_system_calls_ was trying to connect to it, so 
that it could decide whether to accept that incoming connection request and 
if so then what access to grant the client.

In effect, we are "tunneling" (so to speak) security/authentication data from 
one kernel AVC to another within the IP Options field, and thereby know 
*nonreputably* WHICH client is truly attempting to connect with us.

Finally, let me *emphatically* state that SE-N (Security Enhanced Networking) 
is an -optional- convenience the user/administrator/whoever may or may not 
choose to build into their system.  Furthermore, it would not as yet rank 
very highly on my priority list, as we're still ironing out implementation 
issues on SE-X itself, before (maybe) jumping into SE-N.

Notwithstanding, as I'm proposing stuff I'm looking way, way down the road to 
what features and options would really be useful.  To that end, what I'm 
seeing in SELinux *in its current form* is the premiere security system for 
securing -existential- Linux boxes:  Boxes whose world exists only within 
themselves.  But what happens when you want to link multiple boxes together, 
but spread the security power of SELinux across all of them?  This is where 
SE-N comes in.

Let's use SE-X as an example.  To use SE-N with SE-X, I'm conjecturing that 
you would exchange public keys between your X workstation and the various 
boxes whose clients will be connecting to your Xserver, so that they can 
mutually authenticate each other to its counterpart when session keys need to 
be created to support networked communication (IE, a client wants to 
establish a stream to a server.  The SE-N layer on the client machine 
determines that a session key is needed with the server machine, so before 
the client's SYN is sent the client SE-N negotiates a session key with the 
server SE-N.  Now, the client's SYN is sent, with the appropriate security 
context encrypted within the IP Options field.  If there is no public key on 
file for the server, then the client SYN is sent as "unlabeled traffic.").  

You can decide which hosts are authorized to connect to your box's services (X 
being one of possibly many) based on such criteria as:  (1) Unlabeled vs 
labeled traffic, and if labeled (2) which policy-defined clients are allowed 
to connect to which services.  And all of this can be defined within policy.

You posted this question in a different email this evening/morning:

   "The problem we need to solve is how to manage different X connections
     having different privs.  If I login to a trusted-host and want to run a
     trusted application and an IRC client, then how do I make sure that my
     trusted application's X window is protected from my IRC client?"

SE-N is the answer to your question.  The exchanging of keys is what defines 
the client host as being trusted, because when you run the "trusted 
application" ("trusted" as defined in the trusted-host's policy) and then run 
the IRC client, the trusted host's SE-N will establish a "tunnel" of sorts 
within the IP Options field with your workstation so that the Xserver on your 
workstation can distinguish the differing incoming Xclients.

In fact, you wouldn't even need SSH to establish the initial connections.  For 
example, let's conceptualize a client/server suite:  The server clones off 
whatever Xclients are requested of it, pointing them to the correct Xserver 
workstations they should connect to (your workstation, in this example); and 
the server is installed on all the trusted hosts whose Xclients you want 
connecting to your workstation's Xserver.

The client is a simple program on your workstation that establishes a TCP 
stream to the server installed on the target trusted host; and all it does is 
tell the server to clone the requested Xclient, pointing its DISPLAY to your 
workstation.

The client and server have their own domains within policy, so when you 
locally run the client (1) your workstation's SE-N first negotiates a session 
key with the trusted host's SE-N before passing the SYN--with the local 
client's security context encrypted in the IP Options field--to the trusted 
host's TCP layer (and from there to the port the server is listening on).  

(2) The server receives the SYN, examines your client's security context (as 
relayed in the IP Options field), determines your client is authorized to 
access it, and so issues the ACCEPT to your SYN.

(3) Your client requests the server to clone the target Xclient.  The server 
determines your client is authorized to request it, and proceeds to clone it.

(4) The Xclient tries to establish a TCP stream to port 6000 on your 
workstation.  A session key has already been established from (1), so the 
Xclient's source context is encrypted into the IP Options field along with 
SYN.  

(5)  The Xserver receives the SYN, determines via policy that the trusted 
host's Xclient is authorized to connect to it, and so permits the connection 
to be made.  All resources created by the Xclient (such as windows, widgets, 
gadgets, glyphs, whatever ad infinitum) are labeled with that Xclient's 
source security context.

(6)  Now, should the remote IRC client try to access your trusted remote 
application, the Xserver can make policy-based decisions on whether or not to 
allow the trusted Xclient's resources to be examined by another Xclient. 

Anyway, I could go on and on, but it's 4:15am over here and I'm ready to keel 
over.  I'll answer your other post in the morning.  In short, (imo) SE-N has 
-tremendous- potential to leverage the power of SELinux beyond its current 
existential limitations to include Beowulf clusters, load-balancing arrays, 
etc., etc., etc.  

And SE-X is the likely "killer app" to -gently introduce- this power to the 
Linux community.

>
> The incompatabilities for administration tools for the different
> implementations of IPSEC in the Linux kernel make this more difficult. 
> Also there's the issue of firewalls that block IPSEC.
>

What I'm envisioning is a facility that borrows techniques from IPSec without 
actually becoming a formal IPSec.  In practice what ultimately we would see 
is a well-known port reserved to SELinux that SE-N's userland extension would 
listen on.  If (and I emphasize -IF-) the Linux community wishes to use this 
facility, they would individually have to configure their firewalls to allow 
SE-N to listen on that port.  They would also have to exchange/install pubic 
keys between cooperating boxes, as well as identify them within their 
policies.  Any resemblance to IPSEC ends at that point.

All that would be seen is the occasional traffic to SE-N's listener port.  
Everthing else would be "buried" in the Options field of the IP Header.

>
> If we demand that all networked SE-X users have IPSEC and labeled
> networking running then we'll greatly delay any use of the technology.
>

Not at all.  They can choose to run -unlabeled- traffic, which then they are 
left to figure out for themselves which incoming Xclient connection requests 
are trustworthy.  Or, they can bring up SE-N and configure their policies to 
decide which Xclients on which trusted hosts to allow connection to their 
Xservers, and what those Xclients can do.

     "Oh, and by the way, you can also use SE-N to let your security-aware
     servers decide nonreputably which clients can connect to them, and what
     resources the server will grant access to."

After the Linux community gets SE-N working with SE-X (and which I'll insure 
won't be hard to do), they'll also see how easily they can integrate SE-N 
with their own soon-to-be security-aware servers (which is, after all, the 
end-game) to spread the power of SELinux across clusters and traditional 
client/server arrangements.  In fact, my example of the client/server suite 
to launch your "trusted app and IRC client" citation could be a useful 
example program to include with SE-N so as to illustrate SE-N's power to the 
Linux community. 

Anyway, it's now 4:31am and I'm probably becoming incoherent (again), so I 
will end this post now and resume with your other post in the morning.

Bill


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
