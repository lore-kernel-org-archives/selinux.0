In-Reply-To: <1063629744.13311.47.camel@moss-spartans.epoch.ncsc.mil>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: kamal <kamalnee@iitk.ac.in>, owner-selinux@tycho.nsa.gov,
   SELinux@tycho.nsa.gov
MIME-Version: 1.0
Subject: Re: SELinux project
From: Trent Jaeger <jaegert@us.ibm.com>
Message-ID: <OFF5A0ED70.9B405226-ON85256DA2.00673487-85256DA2.006B8345@us.ibm.com>
Date: Mon, 15 Sep 2003 15:34:18 -0400
Content-Type: multipart/alternative; boundary="=_alternative 006B815B85256DA2_="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multipart message in MIME format.
--=_alternative 006B815B85256DA2_=
Content-Type: text/plain; charset="US-ASCII"

Yes, I agree with Stephen that implementing the Biba integrity policy on 
SELinux would not be very practical. 

The analysis in our paper demonstrates that many trusted tasks in UNIX 
systems use low integrity data in ways that would violate Biba.  However, 
many of the cases should not compromise security (the system depends on 
high integrity tasks properly using this data), and the others are best 
addressed by outright denial or policy changes.  But, they must be 
examined on a case-by-case basis (we cannot simply assume that a reader is 
trusted to handle all low integrity data).

Thus, I do not think that you could implement a Biba policy that would 
support any interesting UNIX system.

The question we are trying to answer now is: how can we present Biba 
integrity violations and related info to the admin, such that they can 
effectively manage Biba violations?  For example, our Gokyo tool can: (1) 
identify Biba violations in an SELinux policy; (2) enable the admin to 
scan the sources of the violations (policy assignments); and (3) express 
resolutions to the violations (albeit at a low level).  I am not happy 
with the usability of such an approach, yet. 

As far as an undergrad project related to SELinux policy and Biba, you may 
want to consider looking at the causes of the Biba integrity violations in 
an SELinux policy (a list is in our paper) and their proposed resolutions 
(also in the paper).  Some classes of violations using network data and 
fifos have not been examined in depth.  For some trusted applications, how 
is the low integrity data used?  Can you prove that it will not be a 
problem?  Do these applications need to be modified to ensure that the low 
data usage is safe?  Do the applications still run after modification?

Hope this helps,
Trent.
----------------------------------
Trent Jaeger
IBM T.J. Watson Research Center
19 Skyline Drive
Hawthorne, NY 10532
jaegert@us.ibm.com
(914) 784-7225, FAX (914) 784-7595






Stephen Smalley <sds@epoch.ncsc.mil>
Sent by: owner-selinux@tycho.nsa.gov
09/15/2003 08:42 AM
 
        To:     kamal <kamalnee@iitk.ac.in>
        cc:     SELinux@tycho.nsa.gov, Trent Jaeger/Watson/IBM@IBMUS
        Subject:        Re: SELinux project


On Sat, 2003-09-13 at 05:45, kamal wrote:
> We are two final year under-graduate students in Computer Science. We
> are doing our year long project in the field of Linux security. We have
> studied SELinux and various access control models.  As a first step, we
> are thinking of implementing Biba integrity model in SELinux, along the
> lines of MLS implementation. Because we are new in the field, we want to
> have your views on how useful it will be, and maybe some guidelines too.
> Thanks.

Since TE provides a more general integrity mechanism, I don't see it as
overly useful to implement a Biba integrity model for SELinux.  It is
likely more useful to work on policy analysis tools for the TE
configuration that can check it against specified higher level policy
constraints, including Biba-style constraints, and identify violations
of those constraints.  Trent Jaeger has done some work in this area, so
I've cc'd him.  See http://www.usenix.org/events/sec03/tech/jaeger.html
for a published paper on his work.

Rather than building a new tool from scratch, you might want to consider
building extensions to existing open source tools, such as the Tresys
tools, available from http://www.tresys.com/selinux.  I think that they
are working on improved information flow analysis capabilities, so that
would help in such work.

--
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
with
the words "unsubscribe selinux" without quotes as the message.

--=_alternative 006B815B85256DA2_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Yes, I agree with Stephen that implementing
the Biba integrity policy on SELinux would not be very practical. &nbsp;</font>
<br>
<br><font size=2 face="sans-serif">The analysis in our paper demonstrates
that many trusted tasks in UNIX systems use low integrity data in ways
that would violate Biba. &nbsp;However, many of the cases should not compromise
security (the system depends on high integrity tasks properly using this
data), and the others are best addressed by outright denial or policy changes.
&nbsp;But, they must be examined on a case-by-case basis (we cannot simply
assume that a reader is trusted to handle all low integrity data).</font>
<br>
<br><font size=2 face="sans-serif">Thus, I do not think that you could
implement a Biba policy that would support any interesting UNIX system.</font>
<br>
<br><font size=2 face="sans-serif">The question we are trying to answer
now is: how can we present Biba integrity violations and related info to
the admin, such that they can effectively manage Biba violations? &nbsp;For
example, our Gokyo tool can: (1) identify Biba violations in an SELinux
policy; (2) enable the admin to scan the sources of the violations (policy
assignments); and (3) express resolutions to the violations (albeit at
a low level). &nbsp;I am not happy with the usability of such an approach,
yet. &nbsp;</font>
<br>
<br><font size=2 face="sans-serif">As far as an undergrad project related
to SELinux policy and Biba, you may want to consider looking at the causes
of the Biba integrity violations in an SELinux policy (a list is in our
paper) and their proposed resolutions (also in the paper). &nbsp;Some classes
of violations using network data and fifos have not been examined in depth.
&nbsp;For some trusted applications, how is the low integrity data used?
&nbsp;Can you prove that it will not be a problem? &nbsp;Do these applications
need to be modified to ensure that the low data usage is safe? &nbsp;Do
the applications still run after modification?</font>
<br>
<br><font size=2 face="sans-serif">Hope this helps,</font>
<br><font size=2 face="sans-serif">Trent.</font>
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
<br>
<br>
<table width=100%>
<tr valign=top>
<td>
<td><font size=1 face="sans-serif"><b>Stephen Smalley &lt;sds@epoch.ncsc.mil&gt;</b></font>
<br><font size=1 face="sans-serif">Sent by: owner-selinux@tycho.nsa.gov</font>
<p><font size=1 face="sans-serif">09/15/2003 08:42 AM</font>
<td><font size=1 face="Arial">&nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; To:
&nbsp; &nbsp; &nbsp; &nbsp;kamal &lt;kamalnee@iitk.ac.in&gt;</font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cc:
&nbsp; &nbsp; &nbsp; &nbsp;SELinux@tycho.nsa.gov, Trent Jaeger/Watson/IBM@IBMUS</font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; Subject:
&nbsp; &nbsp; &nbsp; &nbsp;Re: SELinux project</font></table>
<br>
<br>
<br><font size=2><tt>On Sat, 2003-09-13 at 05:45, kamal wrote:<br>
&gt; We are two final year under-graduate students in Computer Science.
We<br>
&gt; are doing our year long project in the field of Linux security. We
have<br>
&gt; studied SELinux and various access control models. &nbsp;As a first
step, we<br>
&gt; are thinking of implementing Biba integrity model in SELinux, along
the<br>
&gt; lines of MLS implementation. Because we are new in the field, we want
to<br>
&gt; have your views on how useful it will be, and maybe some guidelines
too.<br>
&gt; Thanks.<br>
</tt></font>
<br><font size=2><tt>Since TE provides a more general integrity mechanism,
I don't see it as<br>
overly useful to implement a Biba integrity model for SELinux. &nbsp;It
is<br>
likely more useful to work on policy analysis tools for the TE<br>
configuration that can check it against specified higher level policy<br>
constraints, including Biba-style constraints, and identify violations<br>
of those constraints. &nbsp;Trent Jaeger has done some work in this area,
so<br>
I've cc'd him. &nbsp;See http://www.usenix.org/events/sec03/tech/jaeger.html<br>
for a published paper on his work.<br>
</tt></font>
<br><font size=2><tt>Rather than building a new tool from scratch, you
might want to consider<br>
building extensions to existing open source tools, such as the Tresys<br>
tools, available from http://www.tresys.com/selinux. &nbsp;I think that
they<br>
are working on improved information flow analysis capabilities, so that<br>
would help in such work.<br>
</tt></font>
<br><font size=2><tt>--<br>
Stephen Smalley &lt;sds@epoch.ncsc.mil&gt;<br>
National Security Agency<br>
</tt></font>
<br>
<br><font size=2><tt>--<br>
This message was distributed to subscribers of the selinux mailing list.<br>
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with</tt></font>
<br><font size=2><tt>the words &quot;unsubscribe selinux&quot; without
quotes as the message.</tt></font>
<br></div>
--=_alternative 006B815B85256DA2_=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
