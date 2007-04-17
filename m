Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3HCsWwW032054
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 08:54:32 -0400
Received: from ba20-0105.ordina.nl (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3HCsSpA019113
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 12:54:29 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C780EF.86FD237D"
Subject: RE: FCGlob (does someone have the time to generate a special purpose machine)
Date: Tue, 17 Apr 2007 14:54:25 +0200
Message-ID: <FBCF6D728F62D6448FEB5140F0EA07943BDD44@BA12-0046.work.local>
References: <200704172007.54844.russell@coker.com.au> <ogtslaz5jnj.fsf@oolong.mitre.org>
From: "Zwartsenberg, Remmolt" <remmolt.zwartsenberg@ordina.nl>
To: "John D. Ramsdell" <ramsdell@mitre.org>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C780EF.86FD237D
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello John,
=20
Having some experience with designing and implementing finite state machi=
nes and implementing these in datastructures matching the expected behavi=
our in algorithms running on high-performance computers i have some quest=
ions regarding your thought-patterns that are by the way very well writte=
n:

1.=09
	Regular expressions typically behave as expected in linear computations =
('vintage von Neumann ones') but tend to be unable to define relationship=
s between intra-set elements within unstructured sets. I would vote for a=
 datastructure known as 'Undirected Graph' for input and the expected out=
put should be a 'Directed Graph' designating the relationship between the=
 elements within the set. This would enhance the 'reject or accept' state=
 with a 3d one, being an image of the intraset relationship between the e=
lements within the set without superimposing a preconveived 'anthropomorp=
hic' structure. Of course we would have to watch out for spending too muc=
h processor time by starting a watchdog deamon that will kill the process=
 after a preset deltatime interval has elapsed. My question to you is: do=
 we need to do this just for generating a security policy? (set of securi=
ty context rules)
2.=09
	I would not mind implementing this requirement on the 64 processor Linux=
 Cluster at the University of Utrecht, but do any of you guys have any id=
ea of how we could fund this?

I hope this helps,

Remmolt

"In research you uncover the unknown. In application of the results you w=
ill have to cover the known." -parafrase of Sir Thomas Pickering-



________________________________

From: owner-selinux@tycho.nsa.gov on behalf of John D. Ramsdell
Sent: Tue 4/17/2007 1:23 PM
To: russell@coker.com.au
Cc: SE-Linux
Subject: Re: FCGlob



Russell Coker <russell@coker.com.au> writes:

> Why would it be desirable to compile FCGlob to regular expressions?
> Once the performance benefits are proven we might as well go
> full-speed ahead.

I too spent some time thinking about the FCGlob paper.  I believe the
reason one wants to be able to translate FCGlob patterns into regular
expressions is so that one can implement the comparison function
described in the paper as follows:

   A comparison function that receives two patterns as parameters and
   returns the set relationship. Possible set relationships between
   the set of paths pattern A matches and the set of paths pattern B
   matches are: subset, superset, disjoint and ambiguous.

It seems to me that finite automata theory is called for.  The FCGlob
pattern language as described can easily be translated into a regular
expression.  A regular expression can be translated into a
deterministic finite automata without epsilon transitions.  It is easy
to convert this machine into one that recognizes the complement of its
language by complementing the set of final states of the machine.  A
machine that computes the intersection of two languages can be
produced by taking the cross product of the states of the machine for
each language.  Finally, it is easy to test if a machine accepts no
strings.  These primitives can be used to implement the comparison
function as specified.

Finite state machines can be designed so they have more interesting
outputs other than just accept or reject.  In particular, each state
can be associated with a set of security contexts.  A rejecting state
would be associated with the empty set, and an unambiguous state would
be associated with a singleton set.

If you look at the problem as a whole, it seems to me it is possible
to build one finite state machine for a file context that tests if a
pathname matches all the patterns at the same time, and produces a set
of security contexts as its answer.  Given a large number of patterns,
this approach should be very efficient as the input would be traversed
just once.  The only down side is one would have to invest the time to
generate this special purpose machine.

I happened to notice a relevant paper.  The translation of a regular
expression to a deterministic finite automata, typically starts by
translating it to a non-deterministic finite automata with epsilon
transitions.  For this step, the following paper may be helpful: "A
Simple Way to Construct NFA with Fewer States and Transitions" by
Guangming Xing.

Finally, I noticed that the library gfsm appears to export functions
that perform the operations described above.  I have never used the
gfsm library, so I cannot attest to its quality.

John



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov =
with
the words "unsubscribe selinux" without quotes as the message.


Disclaimer

Dit bericht met eventuele bijlagen is vertrouwelijk en uitsluitend bestem=
d voor de geadresseerde. Indien u niet de bedoelde ontvanger bent, wordt =
u verzocht de afzender te waarschuwen en dit bericht met eventuele bijlag=
en direct te verwijderen en/of te vernietigen. Het is niet toegestaan dit=
 bericht en eventuele bijlagen te vermenigvuldigen, door te sturen, openb=
aar te maken, op te slaan of op andere wijze te gebruiken. Ordina N.V. en=
/of haar groepsmaatschappijen accepteren geen verantwoordelijkheid of aan=
sprakelijkheid voor schade die voortvloeit uit de inhoud en/of de verzend=
ing van dit bericht.

This e-mail and any attachments are confidential and is solely intended f=
or the addressee only. If you are not the intended recipient, please noti=
fy the sender and delete and/or destroy this message and any attachments =
immediately. It is prohibited to copy, to distribute, to disclose or to u=
se this e-mail and any attachments in any other way. Ordina N.V. and/or i=
ts group companies do not accept any responsibility nor liability for any=
 damage resulting from the content of and/or the transmission of this mes=
sage.

------_=_NextPart_001_01C780EF.86FD237D
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>Re: FCGlob</TITLE>=0A<META http-equiv=3DCont=
ent-Type content=3D"text/html; charset=3Dunicode">=0A<META content=3D"MSH=
TML 6.00.6000.16414" name=3DGENERATOR></HEAD>=0A<BODY>=0A<DIV dir=3Dltr><=
FONT face=3DArial color=3D#000000 size=3D2>Hello John,</FONT></DIV>=0A<DI=
V dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A<DIV dir=3D=
ltr><FONT face=3DArial size=3D2>Having some experience with designing and=
 implementing finite state machines and implementing these in datastructu=
res matching the expected behaviour in algorithms running on high-perform=
ance computers i have some questions regarding your thought-patterns that=
 are by the way very well written:</FONT></DIV>=0A<OL dir=3Dltr>=0A<LI>=0A=
<DIV><FONT face=3DArial size=3D2>Regular expressions typically behave as =
expected in linear computations ('vintage von Neumann ones') but tend to =
be unable to define relationships between intra-set elements within unstr=
uctured sets. I would vote for a datastructure known as 'Undirected Graph=
' for input and the expected output should be a 'Directed Graph' designat=
ing the relationship between the elements within the set. This would enha=
nce the 'reject or accept' state with a 3d one, being an image of the int=
raset relationship between the elements within the set without superimpos=
ing a preconveived 'anthropomorphic' structure. Of course we would have t=
o watch out&nbsp;for spending&nbsp;too much processor time by&nbsp;starti=
ng a watchdog deamon that will kill the&nbsp;process after a preset delta=
time interval has elapsed.&nbsp;My question to you is: do we need to do t=
his just for generating a security policy?&nbsp;(set of security context =
rules)</FONT></DIV></LI>=0A<LI>=0A<DIV>I would not mind implementing this=
 requirement on the 64 processor Linux Cluster at the University of Utrec=
ht, but do any of you guys&nbsp;have any idea of how we could fund this?<=
/DIV></LI></OL>=0A<P>I hope this helps,</P>=0A<P>Remmolt</P>=0A<P><EM><FO=
NT face=3DArial size=3D2>"In research you uncover the unknown. In&nbsp;ap=
plication of the results you will have to cover the known." -parafrase of=
 Sir&nbsp;Thomas Pickering-</FONT><BR></EM></P>=0A<DIV dir=3Dltr><BR></DI=
V>=0A<DIV dir=3Dltr>=0A<HR tabIndex=3D-1>=0A</DIV>=0A<DIV dir=3Dltr><FONT=
 face=3DTahoma size=3D2><B>From:</B> owner-selinux@tycho.nsa.gov on behal=
f of John D. Ramsdell<BR><B>Sent:</B> Tue 4/17/2007 1:23 PM<BR><B>To:</B>=
 russell@coker.com.au<BR><B>Cc:</B> SE-Linux<BR><B>Subject:</B> Re: FCGlo=
b<BR></FONT><BR></DIV>=0A<DIV>=0A<P><FONT size=3D2>Russell Coker &lt;russ=
ell@coker.com.au&gt; writes:<BR><BR>&gt; Why would it be desirable to com=
pile FCGlob to regular expressions?<BR>&gt; Once the performance benefits=
 are proven we might as well go<BR>&gt; full-speed ahead.<BR><BR>I too sp=
ent some time thinking about the FCGlob paper.&nbsp; I believe the<BR>rea=
son one wants to be able to translate FCGlob patterns into regular<BR>exp=
ressions is so that one can implement the comparison function<BR>describe=
d in the paper as follows:<BR><BR>&nbsp;&nbsp; A comparison function that=
 receives two patterns as parameters and<BR>&nbsp;&nbsp; returns the set =
relationship. Possible set relationships between<BR>&nbsp;&nbsp; the set =
of paths pattern A matches and the set of paths pattern B<BR>&nbsp;&nbsp;=
 matches are: subset, superset, disjoint and ambiguous.<BR><BR>It seems t=
o me that finite automata theory is called for.&nbsp; The FCGlob<BR>patte=
rn language as described can easily be translated into a regular<BR>expre=
ssion.&nbsp; A regular expression can be translated into a<BR>determinist=
ic finite automata without epsilon transitions.&nbsp; It is easy<BR>to co=
nvert this machine into one that recognizes the complement of its<BR>lang=
uage by complementing the set of final states of the machine.&nbsp; A<BR>=
machine that computes the intersection of two languages can be<BR>produce=
d by taking the cross product of the states of the machine for<BR>each la=
nguage.&nbsp; Finally, it is easy to test if a machine accepts no<BR>stri=
ngs.&nbsp; These primitives can be used to implement the comparison<BR>fu=
nction as specified.<BR><BR>Finite state machines can be designed so they=
 have more interesting<BR>outputs other than just accept or reject.&nbsp;=
 In particular, each state<BR>can be associated with a set of security co=
ntexts.&nbsp; A rejecting state<BR>would be associated with the empty set=
, and an unambiguous state would<BR>be associated with a singleton set.<B=
R><BR>If you look at the problem as a whole, it seems to me it is possibl=
e<BR>to build one finite state machine for a file context that tests if a=
<BR>pathname matches all the patterns at the same time, and produces a se=
t<BR>of security contexts as its answer.&nbsp; Given a large number of pa=
tterns,<BR>this approach should be very efficient as the input would be t=
raversed<BR>just once.&nbsp; The only down side is one would have to inve=
st the time to<BR>generate this special purpose machine.<BR><BR>I happene=
d to notice a relevant paper.&nbsp; The translation of a regular<BR>expre=
ssion to a deterministic finite automata, typically starts by<BR>translat=
ing it to a non-deterministic finite automata with epsilon<BR>transitions=
=2E&nbsp; For this step, the following paper may be helpful: "A<BR>Simple=
 Way to Construct NFA with Fewer States and Transitions" by<BR>Guangming =
Xing.<BR><BR>Finally, I noticed that the library gfsm appears to export f=
unctions<BR>that perform the operations described above.&nbsp; I have nev=
er used the<BR>gfsm library, so I cannot attest to its quality.<BR><BR>Jo=
hn<BR><BR><BR><BR>--<BR>This message was distributed to subscribers of th=
e selinux mailing list.<BR>If you no longer wish to subscribe, send mail =
to majordomo@tycho.nsa.gov with<BR>the words "unsubscribe selinux" withou=
t quotes as the message.<BR></FONT></P></DIV>Disclaimer<br><br>Dit berich=
t met eventuele bijlagen is vertrouwelijk en uitsluitend bestemd voor de =
geadresseerde. Indien u niet de bedoelde ontvanger bent, wordt u verzocht=
 de afzender te waarschuwen en dit bericht met eventuele bijlagen direct =
te verwijderen en/of te vernietigen. Het is niet toegestaan dit bericht e=
n eventuele bijlagen te vermenigvuldigen, door te sturen, openbaar te mak=
en, op te slaan of op andere wijze te gebruiken. Ordina N.V. en/of haar g=
roepsmaatschappijen accepteren geen verantwoordelijkheid of aansprakelijk=
heid voor schade die voortvloeit uit de inhoud en/of de verzending van di=
t bericht.<br><br>This e-mail and any attachments are confidential and is=
 solely intended for the addressee only. If you are not the intended reci=
pient, please notify the sender and delete and/or destroy this message an=
d any attachments immediately. It is prohibited to copy, to distribute, t=
o disclose or to use this e-mail and any attachments in any other way. Or=
dina N.V. and/or its group companies do not accept any responsibility nor=
 liability for any damage resulting from the content of and/or the transm=
ission of this message.</BODY></HTML>=

------_=_NextPart_001_01C780EF.86FD237D--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
