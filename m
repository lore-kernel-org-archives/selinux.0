Content-Type: text/plain;
  charset="iso-8859-1"
From: Bill Laut <wlsel@verizon.net>
To: russell@coker.com.au, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: X-Windows and Client-side Buffer Overruns (was Re: Updated Release)
Date: Fri, 1 Aug 2003 13:20:55 -0400
References: <1057952464.5561.322.camel@moss-sooners.epoch.ncsc.mil> <200307311226.14299.wlsel@verizon.net> <200308010941.55431.russell@coker.com.au>
In-Reply-To: <200308010941.55431.russell@coker.com.au>
MIME-Version: 1.0
Message-Id: <200308011320.55409.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 31 July 2003 07:41 pm, Russell Coker wrote:
> On Fri, 1 Aug 2003 02:26, Bill Laut wrote:
>
> > [My discussion of X's potential kernel access deleted]
> 
> I think that you misunderstood my message.  I was referring to the fact
> that it is impossible to restrict an application which has X access from
> snooping the windows of other X programs or reading the keyboard buffer.
>

Or, in the case of remotely-executing clients, a simple packet sniffer 
somewhere on the network.

I see your point now.  I'll discuss what I think may be a solution below.

>
> As for the access that the X server program gets, I run X with the
> FrameBuffer driver and it has no access to kernel memory and the only
> capabilities it has which are of note are sys_rawio and sys_admin.  I'm not
> sure why sys_admin is needed, and sys_rawio should not be needed for
> framebuffer (but the X server wants it anyway - probably a bug in the X
> server).
>

*light bulb suddenly turns on*   Hmm.....

>
> If we fix these issues then a compromise of the X server should not grant
> any access other than the ability to have total control over the screen and
> keyboard (which is still quite bad).
>

Here's my hypothetical solution to the window/keyboard snooping issue.  As a 
disclaimer, it's been awhile since I seriously hacked inside of X and it 
wasn't within Linux, so what I'm about to propose may be obsolete and/or 
irrelevant.  If so, please correct me.

Also, as a second disclaimer, up until now I've only had about two weeks to 
devote to learning SELinux.  I'm still digesting the syntax and capabilities 
of the various policy elements, let alone trying to write my first 
security-aware test application.  Therefore, if I make any assumptions about 
SELinux that are false, please point them out to me as I get myself up to 
speed.

As I remember it, X resembles something like this:

   [client and/or toolkit] <--> [xlib] <--> [transport] <--> [X server]

Of particular interest is the Transport layer, as it implements the Event and 
Request Queues for X.  Among others, it -can- expand to:

   [client-side Transport] <--> [TCP stream] <--> [server-side Transport]

On some implementations, such as under OpenVMS, this "functional layering" is 
strictly enforced such that multiple Transports are allowed to accomodate X 
sessions over nearly any networking protocol (ie, TCP/IP, DECnet, LAT, etc.), 
as well as having a "local" Transport optimized for clients that are running 
on the same box as the server.  As I understand it, however, in the 
Linux/Unix world allegedly there are some ugly hacks which violate this clean 
separation of layers/functions.

All of that notwithstanding, it would seem to me that X could be made at least 
partially security-aware where the server interfaces with its transport 
layer(s), because that would be the logical place to insert a "gatehouse" 
that not only inspects all incoming X protocol requests from the clients but 
can also distinguish between local and remote clients.

For local clients, the gatehouse could trivially determine the request's 
originating PID and then invoke the appropriate security service to inquire 
if that process' domain is authorized to issue those requests.

For remote clients, the gatehouse could pass along whatever relevant data it 
can collect (IP address, source socket #, etc.).  In the case of labelled 
networking, I'm guessing the gatehouse would have to extend into the 
Transport as well to retrieve that information?

Does this approach sound rational?  Unless I'm overlooking something, it 
should be possible to make X rather fine-grained.

>
> >
> > Or, perhaps, what is needed all along is a security-aware mail client
> > that's been properly designed and tested against buffer overruns, [...]
>
> If we're going to do such things then the best first step would be to have
> an external program establish the POP/IMAP connection and then pass the
> file handle back to the main MUA.  Then the MUA would not have the
> passwords.
>

To express it a different way, what you are proposing is something akin to 
running Sendmail and Qpopper on some a personal web/email server, but without 
the overkill those two apps represent because we would be "shrinking" them 
down to "personal-sized" proxy versions that can run on the same machine as 
the MUA.  This would also "re-direct" any buffer overflow exploits away from 
the MUA and onto the sendmail/qpopper pairing who could be hardened against 
such, while simultaneously extending the effort to the maximum number of MUAs 
available.  Correct?

>
> Also something similar needs to be done for GPG.  Currently
> MUA's get the POP/IMAP passwords and the GPG pass-phrase in normal
> operation...
>

That wouldn't be too hard to do.  In fact, it's something I've been toying 
with since late 2001.  I suggest the idea of using an SELinux-powered PDA for 
that purpose (such as a Sharp Zarus) in which the keyrings and all-important 
asymmetric crypto functions are off-loaded from the PC and moved to the PDA, 
and which the PC and PDA then communicate using an encrypted path through its 
Hotsync cradle.

Furthermore, this functionality could be extended into PAM so that the PDA 
could be used to authenticate the user's access to the PC.  Additionally, to 
appeal to larger organizations we could further leverage the PDA as the 
user's authenticator to the corporate firewall for determining what traffic, 
if any, is allowed access to the outside world, and to any servers for 
determining what access the user is authorized to have.

This may be something to keep in mind as labelled networking evolves beyond 
the experimental stage.

In summary, what I'm seeing is the potential for SELinux to quickly evolve 
into THE premiere security paradigm for Linux.

Obviously, the PDA now becomes the single point of failure in this security 
paradigm.  Accordingly, the only problem remaining is coming up with some 
form of encryption to protect its keyrings, etc. that is more secure than 
that "civilian-grade" AES.

Now, if Stephen knows anyone "down the hall" who could offer us some friendly 
suggestions and/or critique some potential ciphers for us...  ;-)

(Sorry about that, Stephen.  It's Friday and I couldn't resist that obvious 
plumb.)

>
> > > From what I've seen, KDE is
> > > way too integrated with itself to behave nicely with SE without changes
> > > in the KDE code itself.
> >
> > I've been looking for an excuse to learn the internals of KDE, so it
> > looks like I've found one.  Perhaps the first thing to do is tackle X
> > before going after KDE?
>
> KDE is a much easier thing to work on...
>

Interesting.  I had the impression that it's the other way around.

Well, let me finish coming up to speed on SELinux and then I'll tackle the X 
server mods.  Please advise on the design review procedure used by the team 
so that I can be in compliance.

For now, I'm tentatively planning to use the current XFree86 kit (v4.3.0) as 
my base, with the objective of producing xdelta patches to the tgz files that 
interested parties can download and apply to the official XFree86 distro.

Does this sound like a game plan to everyone?

Bill



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
