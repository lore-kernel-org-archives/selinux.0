In-Reply-To: <ogtfzfzqa3g.fsf@divan.mitre.org>
To: ramsdell@mitre.org (John D. Ramsdell)
Cc: owner-selinux@tycho.nsa.gov, ramsdell@mitre.org,
   "SE Linux" <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Subject: Re: Information flow models
From: Trent Jaeger <jaegert@us.ibm.com>
Message-ID: <OF253F25BA.07CEED3D-ON85256E05.00682B7D-85256E05.00697942@us.ibm.com>
Date: Tue, 23 Dec 2003 14:12:02 -0500
Content-Type: multipart/alternative; boundary="=_alternative 006972AD85256E05_="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multipart message in MIME format.
--=_alternative 006972AD85256E05_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

Been meaning to discuss this for a while (although it may be stale now). 

The Gokyo tool we are working on at IBM Research for analyzing SELinux 
policies (see paper) uses only the type information.  I have not had a 
chance to read the Tresys docs yet, but I expect that the interpretation 
is similar. 

We do not do information flow analyses at this point, although it would be 
straighforward.  We test for the more conservative Biba integrity 
violations (find all low integrity flows into read/execute permissions of 
high integrity subject types) to find individual integrity issues.  We 
have then focused on supporting the resolution/management of these cases 
as our paper describes.  We have some more recent, more formal analyses 
that I am writing up. 
My intuition is that describing and managing policy at the information 
flow level will be too complex (although certainly worth examination -- 
and I may be proven incorrect).  Thus, we are focusing on simpler 
properties (Biba) and trying to determine how to resolve/manage conflicts. 
 This is similar in spirit to Clark-Wilson, but I don't expect that 
assurance will be practical, so we are examining other approaches.

In general, I expect we will always have a conflict between security goals 
and functionality goals that will need to be balanced.  The SELinux policy 
model provides the flexibility to make these 'balancing' decisions, but we 
have a ways to go to find acceptable approaches for the admins. 

Trent.

PS -- I am finally getting around to open source approval for Gokyo, so 
hopefully this will be available in the late winter, early spring.
----------------------------------
Trent Jaeger
IBM T.J. Watson Research Center
19 Skyline Drive
Hawthorne, NY 10532
jaegert@us.ibm.com
(914) 784-7225, FAX (914) 784-7595




ramsdell@mitre.org (John D. Ramsdell)
Sent by: owner-selinux@tycho.nsa.gov
12/05/2003 03:32 PM
 
        To:     "SE Linux" <selinux@tycho.nsa.gov>
        cc:     ramsdell@mitre.org
        Subject:        Information flow models


Karl MacMillan of Tresys and I were having a discussion about
information flow models used for policy analysis, and thought the
people on this list might like to participate.

The Tresys Setools package and MITRE's SLAT analyze SELinux policy
configurations.  They both extract an abstraction of a policy that
models information flow within the system.  Both models can be
described in terms of graphs.  The nodes of the graph say something
about a security context.  Each edge in the graph is labeled with a
control requirement, i.e. a class-permission pair.  An edge is in the
graph if the policy allows information to flow from one node to
another.  If the edge corresponds to a write-like flow, the source of
the edge is the subject, and if the edge corresponds to a read-like
flow, the target of the edge is the subject.

The two tools differ in what constitutes a node in the model.  In
SLAT, a node is a security context--a triple consisting of a type, a
role, and a user.  In Setools, a node is a type.

Using a security context as a node gives a model that more accurately
reflects the policy being analyzed, however, the graphs are large.  As
a result, the SLAT implementors have had to resort to model checkers
to perform their analysis.

If one ignores role-allow, role-type, user-role, and constraint
statements in a policy configuration file, one is left with a model in
which nodes can simply be types.  The graphs in this model are
obviously much smaller and easier to analyze, however, it may allow
some flows that are not permitted by a more fine grained analysis.
The question is: from an engineering perspective, is a more detailed
analysis worth the overhead of using techniques that handle the large
graphs?  Most likely, there will be times when an analysis based only
on types is appropriate, and others when an analysis based on security
contexts is appropriate, but how does one decide which to use, and when?

John





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
with
the words "unsubscribe selinux" without quotes as the message.

--=_alternative 006972AD85256E05_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">Been meaning to discuss this for a while
(although it may be stale now). &nbsp;</font>
<br>
<br><font size=2 face="sans-serif">The Gokyo tool we are working on at
IBM Research for analyzing SELinux policies (see </font><a href=www.research.ibm.com/vali/usenix2003.pdf><font size=2 color=blue face="sans-serif">paper</font></a><font size=2 face="sans-serif">)
uses only the type information. &nbsp;I have not had a chance to read the
Tresys docs yet, but I expect that the interpretation is similar. &nbsp;</font>
<br>
<br><font size=2 face="sans-serif">We do not do information flow analyses
at this point, although it would be straighforward. &nbsp;We test for the
more conservative Biba integrity violations (find all low integrity flows
into read/execute permissions of high integrity subject types) to find
individual integrity issues. &nbsp;We have then focused on supporting the
resolution/management of these cases as our paper describes. &nbsp;We have
some more recent, more formal analyses that I am writing up. </font>
<br><font size=2 face="sans-serif">My intuition is that describing and
managing policy at the information flow level will be too complex (although
certainly worth examination -- and I may be proven incorrect). &nbsp;Thus,
we are focusing on simpler properties (Biba) and trying to determine how
to resolve/manage conflicts. &nbsp;This is similar in spirit to Clark-Wilson,
but I don't expect that assurance will be practical, so we are examining
other approaches.</font>
<br>
<br><font size=2 face="sans-serif">In general, I expect we will always
have a conflict between security goals and functionality goals that will
need to be balanced. &nbsp;The SELinux policy model provides the flexibility
to make these 'balancing' decisions, but we have a ways to go to find acceptable
approaches for the admins. &nbsp;</font>
<br>
<br><font size=2 face="sans-serif">Trent.</font>
<br>
<br><font size=2 face="sans-serif">PS -- I am finally getting around to
open source approval for Gokyo, so hopefully this will be available in
the late winter, early spring.</font>
<div>
<br><font size=2 face="sans-serif">----------------------------------<br>
Trent Jaeger<br>
IBM T.J. Watson Research Center<br>
19 Skyline Drive<br>
Hawthorne, NY 10532<br>
jaegert@us.ibm.com<br>
(914) 784-7225, FAX (914) 784-7595</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td>
<td><font size=1 face="sans-serif"><b>ramsdell@mitre.org (John D. Ramsdell)</b></font>
<br><font size=1 face="sans-serif">Sent by: owner-selinux@tycho.nsa.gov</font>
<p><font size=1 face="sans-serif">12/05/2003 03:32 PM</font>
<td><font size=1 face="Arial">&nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; To:
&nbsp; &nbsp; &nbsp; &nbsp;&quot;SE Linux&quot; &lt;selinux@tycho.nsa.gov&gt;</font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cc:
&nbsp; &nbsp; &nbsp; &nbsp;ramsdell@mitre.org</font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; Subject:
&nbsp; &nbsp; &nbsp; &nbsp;Information flow models</font></table>
<br>
<br>
<br><font size=2><tt>Karl MacMillan of Tresys and I were having a discussion
about<br>
information flow models used for policy analysis, and thought the<br>
people on this list might like to participate.<br>
</tt></font>
<br><font size=2><tt>The Tresys Setools package and MITRE's SLAT analyze
SELinux policy<br>
configurations. &nbsp;They both extract an abstraction of a policy that<br>
models information flow within the system. &nbsp;Both models can be<br>
described in terms of graphs. &nbsp;The nodes of the graph say something<br>
about a security context. &nbsp;Each edge in the graph is labeled with
a<br>
control requirement, i.e. a class-permission pair. &nbsp;An edge is in
the<br>
graph if the policy allows information to flow from one node to<br>
another. &nbsp;If the edge corresponds to a write-like flow, the source
of<br>
the edge is the subject, and if the edge corresponds to a read-like<br>
flow, the target of the edge is the subject.<br>
</tt></font>
<br><font size=2><tt>The two tools differ in what constitutes a node in
the model. &nbsp;In<br>
SLAT, a node is a security context--a triple consisting of a type, a<br>
role, and a user. &nbsp;In Setools, a node is a type.<br>
</tt></font>
<br><font size=2><tt>Using a security context as a node gives a model that
more accurately<br>
reflects the policy being analyzed, however, the graphs are large. &nbsp;As<br>
a result, the SLAT implementors have had to resort to model checkers<br>
to perform their analysis.<br>
</tt></font>
<br><font size=2><tt>If one ignores role-allow, role-type, user-role, and
constraint<br>
statements in a policy configuration file, one is left with a model in<br>
which nodes can simply be types. &nbsp;The graphs in this model are<br>
obviously much smaller and easier to analyze, however, it may allow<br>
some flows that are not permitted by a more fine grained analysis.<br>
The question is: from an engineering perspective, is a more detailed<br>
analysis worth the overhead of using techniques that handle the large<br>
graphs? &nbsp;Most likely, there will be times when an analysis based only<br>
on types is appropriate, and others when an analysis based on security<br>
contexts is appropriate, but how does one decide which to use, and when?<br>
</tt></font>
<br><font size=2><tt>John<br>
</tt></font>
<br>
<br>
<br>
<br>
<br><font size=2><tt>--<br>
This message was distributed to subscribers of the selinux mailing list.<br>
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with</tt></font>
<br><font size=2><tt>the words &quot;unsubscribe selinux&quot; without
quotes as the message.</tt></font>
<br></div>
--=_alternative 006972AD85256E05_=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
