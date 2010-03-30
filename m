From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: svirt on MLS has strange AVC.
Date: Tue, 30 Mar 2010 14:23:13 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        "Daniel P. Berrange" <berrange@redhat.com>,
        SELinux <selinux@tycho.nsa.gov>, Chad Hanson <chanson@TrustedCS.com>
References: <4BA7E4BF.1040002@redhat.com> <201003291600.06024.paul.moore@hp.com> <1269959533.2941.9.camel@dhcp235-240.rdu.redhat.com>
In-Reply-To: <1269959533.2941.9.camel@dhcp235-240.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201003301423.13417.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 30 March 2010 10:32:13 am Eric Paris wrote:
> On Mon, 2010-03-29 at 16:00 -0400, Paul Moore wrote:
> > On Monday 29 March 2010 02:29:24 pm Eric Paris wrote:
> > > Client Process:	Client Socket:	Client Sock:		Server Sock:	
Server
> > > Socket:	Server Process: C1		C1		C1			S2		S2
> > 
> > S2
> > 
> > > [Client calls connect]					[Server call accept]
> > > [The client struct socket is relabeled]			[new child socket 
below, I
> > 
> > ignore
> > 
> > > original socket] C1		S2		C1			S2		C1		
S2
> > > 
> > > Now we have multiple types of checks wich I know off the top of my head
> > > we want to deal with, namely:  {read/write:socket} {recv:peer}
> > > {recv:packet}
> > 
> > Ungh, put me down as "not a fan".  The relabeling looks like a bit of a
> > hack and makes me nervous about race conditions, policy issues and all
> > sorts of things.  I haven't thought about it completely yet, but what
> > happens if a client wants to set a socket option after it has connected
> > to a remote host? Wouldn't that mean that you would need the following
> > allow rule?
> > 
> >  allow C1 S2:socket { setopt }
> 
> Well that's sorta what we do today with ONLY the MLS component ONLY on
> the server side of the connection.  This makes me sad.

Not really ... at least I hope we don't allow one domain to set the socket 
options of another.

> > I appreciate that you're trying to make a complex thing less so, but
> > sometimes you have to tell Dan "no".
> 
> Believe me, Dan is more surprised when I decide to argue FOR his
> harebrained schemes than when I tell him "no."   *smile*

 ;)

> > I would need to think about this a bit more, but we could have both a
> > "local_label" and a "peer_label" (I'm just picking easy, descriptive
> > names right now) on both a socket and a sock, much like the "sid" and
> > "peer_sid" labels we have now.  All traffic leaving a sock would be
> > wire-labeled based on the "local_label" and all traffic being queued to
> > a sock would be checked against the "local_label" as well.  Applications
> > trying to read and write data to and from a sock queue would be checked
> > against the "peer_label" and the rest of the socket operations,
> > create/connect/listen/setsockopt/getsockopt/etc., would use the
> > "local_label".
> 
> It's the same basic idea I was thinking of, only it looks a bit less
> like using an implementation detail and more like making sense  :)
> 
> getting rid of security_sid_mls_copy() while maintaining (or growing)
> our ability to control traffic would be a great step forward....
> 
> /me tries to find some time to play....

I know we're big fans of code first, design later around here but I think 
there are a few issues that need to be discussed a bit first (and I don't 
consider this an exhaustive list):

1. How do we label the socket's corresponding inode?

2. We would want to ensure the socket's directional labels are handled 
correctly with the SA labels, i.e. label the also directional SAs correctly 
and make sure we don't create useless SAs due to label mis-match (pretty sure 
we have this problem today, at least we did at some point).

3. Policy implications; beware that by making this change policy is going to 
get a lot more involved for TCP based network applications.

4. Is Stephen/NSA on board, in other words, what do the real security geeks 
(no offense intended) have to say about this approach?

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
