Message-ID: <E2462F68A99DB74D8AEDF13B261B1BDD02A69522@Larry.widevine.com>
From: =?iso-8859-1?Q?Tom=E1s_Palmer?= <Tpalmer@widevine.com>
To: "'Bill Laut'" <wlsel@verizon.net>, russell@coker.com.au,
   SELinux
	 <SELinux@tycho.nsa.gov>
Subject: RE: X-Windows and Client-side Buffer Overruns (was Re: Updated Re
	lease)
Date: Fri, 1 Aug 2003 16:50:59 -0700 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C35887.C1CBE420"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C35887.C1CBE420
Content-Type: text/plain;
	charset="iso-8859-1"

Hi,
Although one should never speak in absolutes, one can make the cost to an
exploiter so high that this type of attack will be too expensive to pursue.
You can prevent applications from snooping windows (screen scraping or API
capture), reading the keyboard buffer etc. In a closed system, you can event
prevent unrecognized apps from running. 
Kernel modifications, hidden shims that monitor stacks, device driver
extension, system fingerprinting or parasite thread monitors can handle
these exploits. 
By having crosschecking and DigSig you can help insure your modules stay
functional and respond appropriately to an attack. 

I speak with some authority on this subject as I hold a few patents in this
area. This type of active defense technology has passed very stringent
security audits by both governments and international industry. 

This technology has been deployed internationally for Windows, Linux, Mac,
FreeBSD and various proprietary OSes. Active defense responses have ranged
from a delayed warning to hardware destruction. Fun stuff but hell to test
cost effectively ;-)

Trying to secure with just the OS isn't the answer. You must move closer to
the hardware and into the hardware if possible...
After a few years of security work you become OS agnostic ;-)


I learn a lot by listening to all of you....thank you!
Tomas



-----Original Message-----
From: Bill Laut [mailto:wlsel@verizon.net] 
Sent: Friday, August 01, 2003 10:21 AM
To: russell@coker.com.au; SELinux
Subject: Re: X-Windows and Client-side Buffer Overruns (was Re: Updated
Release)

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
> capabilities it has which are of note are sys_rawio and sys_admin.  I'm
not
> sure why sys_admin is needed, and sys_rawio should not be needed for
> framebuffer (but the X server wants it anyway - probably a bug in the X
> server).
>

*light bulb suddenly turns on*   Hmm.....

>
> If we fix these issues then a compromise of the X server should not grant
> any access other than the ability to have total control over the screen
and
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

Of particular interest is the Transport layer, as it implements the Event
and 
Request Queues for X.  Among others, it -can- expand to:

   [client-side Transport] <--> [TCP stream] <--> [server-side Transport]

On some implementations, such as under OpenVMS, this "functional layering"
is 
strictly enforced such that multiple Transports are allowed to accomodate X 
sessions over nearly any networking protocol (ie, TCP/IP, DECnet, LAT,
etc.), 
as well as having a "local" Transport optimized for clients that are running

on the same box as the server.  As I understand it, however, in the 
Linux/Unix world allegedly there are some ugly hacks which violate this
clean 
separation of layers/functions.

All of that notwithstanding, it would seem to me that X could be made at
least 
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
running Sendmail and Qpopper on some a personal web/email server, but
without 
the overkill those two apps represent because we would be "shrinking" them 
down to "personal-sized" proxy versions that can run on the same machine as 
the MUA.  This would also "re-direct" any buffer overflow exploits away from

the MUA and onto the sendmail/qpopper pairing who could be hardened against 
such, while simultaneously extending the effort to the maximum number of
MUAs 
available.  Correct?

>
> Also something similar needs to be done for GPG.  Currently
> MUA's get the POP/IMAP passwords and the GPG pass-phrase in normal
> operation...
>

That wouldn't be too hard to do.  In fact, it's something I've been toying 
with since late 2001.  I suggest the idea of using an SELinux-powered PDA
for 
that purpose (such as a Sharp Zarus) in which the keyrings and all-important

asymmetric crypto functions are off-loaded from the PC and moved to the PDA,

and which the PC and PDA then communicate using an encrypted path through
its 
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

Now, if Stephen knows anyone "down the hall" who could offer us some
friendly 
suggestions and/or critique some potential ciphers for us...  ;-)

(Sorry about that, Stephen.  It's Friday and I couldn't resist that obvious 
plumb.)

>
> > > From what I've seen, KDE is
> > > way too integrated with itself to behave nicely with SE without
changes
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

my base, with the objective of producing xdelta patches to the tgz files
that 
interested parties can download and apply to the official XFree86 distro.

Does this sound like a game plan to everyone?

Bill



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

------_=_NextPart_001_01C35887.C1CBE420
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2653.12">
<TITLE>RE: X-Windows and Client-side Buffer Overruns (was Re: Updated =
Release)</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Hi,</FONT>
<BR><FONT SIZE=3D2>Although one should never speak in absolutes, one =
can make the cost to an exploiter so high that this type of attack will =
be too expensive to pursue. You can prevent applications from snooping =
windows (screen scraping or API capture), reading the keyboard buffer =
etc. In a closed system, you can event prevent unrecognized apps from =
running. </FONT></P>

<P><FONT SIZE=3D2>Kernel modifications, hidden shims that monitor =
stacks, device driver extension, system fingerprinting or parasite =
thread monitors can handle these exploits. </FONT></P>

<P><FONT SIZE=3D2>By having crosschecking and DigSig you can help =
insure your modules stay functional and respond appropriately to an =
attack. </FONT></P>

<P><FONT SIZE=3D2>I speak with some authority on this subject as I hold =
a few patents in this area. This type of active defense technology has =
passed very stringent security audits by both governments and =
international industry. </FONT></P>

<P><FONT SIZE=3D2>This technology has been deployed internationally for =
Windows, Linux, Mac, FreeBSD and various proprietary OSes. Active =
defense responses have ranged from a delayed warning to hardware =
destruction. Fun stuff but hell to test cost effectively ;-)</FONT></P>

<P><FONT SIZE=3D2>Trying to secure with just the OS isn't the answer. =
You must move closer to the hardware and into the hardware if =
possible...</FONT></P>

<P><FONT SIZE=3D2>After a few years of security work you become OS =
agnostic ;-)</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>I learn a lot by listening to all of you....thank =
you!</FONT>
<BR><FONT SIZE=3D2>Tomas</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: Bill Laut [<A =
HREF=3D"mailto:wlsel@verizon.net">mailto:wlsel@verizon.net</A>] </FONT>
<BR><FONT SIZE=3D2>Sent: Friday, August 01, 2003 10:21 AM</FONT>
<BR><FONT SIZE=3D2>To: russell@coker.com.au; SELinux</FONT>
<BR><FONT SIZE=3D2>Subject: Re: X-Windows and Client-side Buffer =
Overruns (was Re: Updated Release)</FONT>
</P>

<P><FONT SIZE=3D2>On Thursday 31 July 2003 07:41 pm, Russell Coker =
wrote:</FONT>
<BR><FONT SIZE=3D2>&gt; On Fri, 1 Aug 2003 02:26, Bill Laut =
wrote:</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; [My discussion of X's potential kernel =
access deleted]</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; I think that you misunderstood my =
message.&nbsp; I was referring to the fact</FONT>
<BR><FONT SIZE=3D2>&gt; that it is impossible to restrict an =
application which has X access from</FONT>
<BR><FONT SIZE=3D2>&gt; snooping the windows of other X programs or =
reading the keyboard buffer.</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
</P>

<P><FONT SIZE=3D2>Or, in the case of remotely-executing clients, a =
simple packet sniffer </FONT>
<BR><FONT SIZE=3D2>somewhere on the network.</FONT>
</P>

<P><FONT SIZE=3D2>I see your point now.&nbsp; I'll discuss what I think =
may be a solution below.</FONT>
</P>

<P><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2>&gt; As for the access that the X server program =
gets, I run X with the</FONT>
<BR><FONT SIZE=3D2>&gt; FrameBuffer driver and it has no access to =
kernel memory and the only</FONT>
<BR><FONT SIZE=3D2>&gt; capabilities it has which are of note are =
sys_rawio and sys_admin.&nbsp; I'm not</FONT>
<BR><FONT SIZE=3D2>&gt; sure why sys_admin is needed, and sys_rawio =
should not be needed for</FONT>
<BR><FONT SIZE=3D2>&gt; framebuffer (but the X server wants it anyway - =
probably a bug in the X</FONT>
<BR><FONT SIZE=3D2>&gt; server).</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
</P>

<P><FONT SIZE=3D2>*light bulb suddenly turns on*&nbsp;&nbsp; =
Hmm.....</FONT>
</P>

<P><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2>&gt; If we fix these issues then a compromise of the =
X server should not grant</FONT>
<BR><FONT SIZE=3D2>&gt; any access other than the ability to have total =
control over the screen and</FONT>
<BR><FONT SIZE=3D2>&gt; keyboard (which is still quite bad).</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
</P>

<P><FONT SIZE=3D2>Here's my hypothetical solution to the =
window/keyboard snooping issue.&nbsp; As a </FONT>
<BR><FONT SIZE=3D2>disclaimer, it's been awhile since I seriously =
hacked inside of X and it </FONT>
<BR><FONT SIZE=3D2>wasn't within Linux, so what I'm about to propose =
may be obsolete and/or </FONT>
<BR><FONT SIZE=3D2>irrelevant.&nbsp; If so, please correct me.</FONT>
</P>

<P><FONT SIZE=3D2>Also, as a second disclaimer, up until now I've only =
had about two weeks to </FONT>
<BR><FONT SIZE=3D2>devote to learning SELinux.&nbsp; I'm still =
digesting the syntax and capabilities </FONT>
<BR><FONT SIZE=3D2>of the various policy elements, let alone trying to =
write my first </FONT>
<BR><FONT SIZE=3D2>security-aware test application.&nbsp; Therefore, if =
I make any assumptions about </FONT>
<BR><FONT SIZE=3D2>SELinux that are false, please point them out to me =
as I get myself up to </FONT>
<BR><FONT SIZE=3D2>speed.</FONT>
</P>

<P><FONT SIZE=3D2>As I remember it, X resembles something like =
this:</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;&nbsp; [client and/or toolkit] &lt;--&gt; =
[xlib] &lt;--&gt; [transport] &lt;--&gt; [X server]</FONT>
</P>

<P><FONT SIZE=3D2>Of particular interest is the Transport layer, as it =
implements the Event and </FONT>
<BR><FONT SIZE=3D2>Request Queues for X.&nbsp; Among others, it -can- =
expand to:</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;&nbsp; [client-side Transport] &lt;--&gt; [TCP =
stream] &lt;--&gt; [server-side Transport]</FONT>
</P>

<P><FONT SIZE=3D2>On some implementations, such as under OpenVMS, this =
&quot;functional layering&quot; is </FONT>
<BR><FONT SIZE=3D2>strictly enforced such that multiple Transports are =
allowed to accomodate X </FONT>
<BR><FONT SIZE=3D2>sessions over nearly any networking protocol (ie, =
TCP/IP, DECnet, LAT, etc.), </FONT>
<BR><FONT SIZE=3D2>as well as having a &quot;local&quot; Transport =
optimized for clients that are running </FONT>
<BR><FONT SIZE=3D2>on the same box as the server.&nbsp; As I understand =
it, however, in the </FONT>
<BR><FONT SIZE=3D2>Linux/Unix world allegedly there are some ugly hacks =
which violate this clean </FONT>
<BR><FONT SIZE=3D2>separation of layers/functions.</FONT>
</P>

<P><FONT SIZE=3D2>All of that notwithstanding, it would seem to me that =
X could be made at least </FONT>
<BR><FONT SIZE=3D2>partially security-aware where the server interfaces =
with its transport </FONT>
<BR><FONT SIZE=3D2>layer(s), because that would be the logical place to =
insert a &quot;gatehouse&quot; </FONT>
<BR><FONT SIZE=3D2>that not only inspects all incoming X protocol =
requests from the clients but </FONT>
<BR><FONT SIZE=3D2>can also distinguish between local and remote =
clients.</FONT>
</P>

<P><FONT SIZE=3D2>For local clients, the gatehouse could trivially =
determine the request's </FONT>
<BR><FONT SIZE=3D2>originating PID and then invoke the appropriate =
security service to inquire </FONT>
<BR><FONT SIZE=3D2>if that process' domain is authorized to issue those =
requests.</FONT>
</P>

<P><FONT SIZE=3D2>For remote clients, the gatehouse could pass along =
whatever relevant data it </FONT>
<BR><FONT SIZE=3D2>can collect (IP address, source socket #, =
etc.).&nbsp; In the case of labelled </FONT>
<BR><FONT SIZE=3D2>networking, I'm guessing the gatehouse would have to =
extend into the </FONT>
<BR><FONT SIZE=3D2>Transport as well to retrieve that =
information?</FONT>
</P>

<P><FONT SIZE=3D2>Does this approach sound rational?&nbsp; Unless I'm =
overlooking something, it </FONT>
<BR><FONT SIZE=3D2>should be possible to make X rather =
fine-grained.</FONT>
</P>

<P><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; Or, perhaps, what is needed all along is a =
security-aware mail client</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; that's been properly designed and tested =
against buffer overruns, [...]</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2>&gt; If we're going to do such things then the best =
first step would be to have</FONT>
<BR><FONT SIZE=3D2>&gt; an external program establish the POP/IMAP =
connection and then pass the</FONT>
<BR><FONT SIZE=3D2>&gt; file handle back to the main MUA.&nbsp; Then =
the MUA would not have the</FONT>
<BR><FONT SIZE=3D2>&gt; passwords.</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
</P>

<P><FONT SIZE=3D2>To express it a different way, what you are proposing =
is something akin to </FONT>
<BR><FONT SIZE=3D2>running Sendmail and Qpopper on some a personal =
web/email server, but without </FONT>
<BR><FONT SIZE=3D2>the overkill those two apps represent because we =
would be &quot;shrinking&quot; them </FONT>
<BR><FONT SIZE=3D2>down to &quot;personal-sized&quot; proxy versions =
that can run on the same machine as </FONT>
<BR><FONT SIZE=3D2>the MUA.&nbsp; This would also &quot;re-direct&quot; =
any buffer overflow exploits away from </FONT>
<BR><FONT SIZE=3D2>the MUA and onto the sendmail/qpopper pairing who =
could be hardened against </FONT>
<BR><FONT SIZE=3D2>such, while simultaneously extending the effort to =
the maximum number of MUAs </FONT>
<BR><FONT SIZE=3D2>available.&nbsp; Correct?</FONT>
</P>

<P><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2>&gt; Also something similar needs to be done for =
GPG.&nbsp; Currently</FONT>
<BR><FONT SIZE=3D2>&gt; MUA's get the POP/IMAP passwords and the GPG =
pass-phrase in normal</FONT>
<BR><FONT SIZE=3D2>&gt; operation...</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
</P>

<P><FONT SIZE=3D2>That wouldn't be too hard to do.&nbsp; In fact, it's =
something I've been toying </FONT>
<BR><FONT SIZE=3D2>with since late 2001.&nbsp; I suggest the idea of =
using an SELinux-powered PDA for </FONT>
<BR><FONT SIZE=3D2>that purpose (such as a Sharp Zarus) in which the =
keyrings and all-important </FONT>
<BR><FONT SIZE=3D2>asymmetric crypto functions are off-loaded from the =
PC and moved to the PDA, </FONT>
<BR><FONT SIZE=3D2>and which the PC and PDA then communicate using an =
encrypted path through its </FONT>
<BR><FONT SIZE=3D2>Hotsync cradle.</FONT>
</P>

<P><FONT SIZE=3D2>Furthermore, this functionality could be extended =
into PAM so that the PDA </FONT>
<BR><FONT SIZE=3D2>could be used to authenticate the user's access to =
the PC.&nbsp; Additionally, to </FONT>
<BR><FONT SIZE=3D2>appeal to larger organizations we could further =
leverage the PDA as the </FONT>
<BR><FONT SIZE=3D2>user's authenticator to the corporate firewall for =
determining what traffic, </FONT>
<BR><FONT SIZE=3D2>if any, is allowed access to the outside world, and =
to any servers for </FONT>
<BR><FONT SIZE=3D2>determining what access the user is authorized to =
have.</FONT>
</P>

<P><FONT SIZE=3D2>This may be something to keep in mind as labelled =
networking evolves beyond </FONT>
<BR><FONT SIZE=3D2>the experimental stage.</FONT>
</P>

<P><FONT SIZE=3D2>In summary, what I'm seeing is the potential for =
SELinux to quickly evolve </FONT>
<BR><FONT SIZE=3D2>into THE premiere security paradigm for =
Linux.</FONT>
</P>

<P><FONT SIZE=3D2>Obviously, the PDA now becomes the single point of =
failure in this security </FONT>
<BR><FONT SIZE=3D2>paradigm.&nbsp; Accordingly, the only problem =
remaining is coming up with some </FONT>
<BR><FONT SIZE=3D2>form of encryption to protect its keyrings, etc. =
that is more secure than </FONT>
<BR><FONT SIZE=3D2>that &quot;civilian-grade&quot; AES.</FONT>
</P>

<P><FONT SIZE=3D2>Now, if Stephen knows anyone &quot;down the =
hall&quot; who could offer us some friendly </FONT>
<BR><FONT SIZE=3D2>suggestions and/or critique some potential ciphers =
for us...&nbsp; ;-)</FONT>
</P>

<P><FONT SIZE=3D2>(Sorry about that, Stephen.&nbsp; It's Friday and I =
couldn't resist that obvious </FONT>
<BR><FONT SIZE=3D2>plumb.)</FONT>
</P>

<P><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; &gt; From what I've seen, KDE is</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; &gt; way too integrated with itself to =
behave nicely with SE without changes</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; &gt; in the KDE code itself.</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; I've been looking for an excuse to learn =
the internals of KDE, so it</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; looks like I've found one.&nbsp; Perhaps =
the first thing to do is tackle X</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; before going after KDE?</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2>&gt; KDE is a much easier thing to work on...</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
</P>

<P><FONT SIZE=3D2>Interesting.&nbsp; I had the impression that it's the =
other way around.</FONT>
</P>

<P><FONT SIZE=3D2>Well, let me finish coming up to speed on SELinux and =
then I'll tackle the X </FONT>
<BR><FONT SIZE=3D2>server mods.&nbsp; Please advise on the design =
review procedure used by the team </FONT>
<BR><FONT SIZE=3D2>so that I can be in compliance.</FONT>
</P>

<P><FONT SIZE=3D2>For now, I'm tentatively planning to use the current =
XFree86 kit (v4.3.0) as </FONT>
<BR><FONT SIZE=3D2>my base, with the objective of producing xdelta =
patches to the tgz files that </FONT>
<BR><FONT SIZE=3D2>interested parties can download and apply to the =
official XFree86 distro.</FONT>
</P>

<P><FONT SIZE=3D2>Does this sound like a game plan to everyone?</FONT>
</P>

<P><FONT SIZE=3D2>Bill</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2>--</FONT>
<BR><FONT SIZE=3D2>This message was distributed to subscribers of the =
selinux mailing list.</FONT>
<BR><FONT SIZE=3D2>If you no longer wish to subscribe, send mail to =
majordomo@tycho.nsa.gov with</FONT>
<BR><FONT SIZE=3D2>the words &quot;unsubscribe selinux&quot; without =
quotes as the message.</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C35887.C1CBE420--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
