Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA04430
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 13:35:20 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA24613
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 17:35:13 GMT
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.101])
	by jazzswing.ncsc.mil  with ESMTP id RAA24607
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 17:35:13 GMT
Subject: RE: Policy creation RFC
To: Stephen Smalley <sds@tislabs.com>
Cc: selinux@tycho.nsa.gov
Message-ID: <OFD6534F22.F90FEF82-ON85256BC7.006018B1@us.ibm.com>
From: "Trent Jaeger" <jaegert@us.ibm.com>
Date: Tue, 28 May 2002 13:35:01 -0400
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=0ABBE154DFF39E218f9e8a93df938690918c0ABBE154DFF39E21"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0__=0ABBE154DFF39E218f9e8a93df938690918c0ABBE154DFF39E21
Content-type: text/plain; charset=US-ASCII

                                                                                                               
                                                                                                               
                                                                                                               


By simpler model, I mean (abstractly) one that uses fewer, simpler, or more
domain-specific concepts than SELinux RBAC+TE+Identity model.  What those
concepts are and for what circumstances are they sufficient is what I am
working towards now.

Unfortunately, I do not have a specific case or recommendation at this
point.  Hope to have some ideas soon.

On the other hand, I do expect that such policies will have to be
transformed into a SELinux policy for enforcement (i.e., I do not believe
that any new things that we really need to enforce cannot be represented by
the RBAC+TE+Identity model at present).  Also, fixed policies should be
expressed in the SELinux model.

Regards,
Trent.
----------------------------------
Trent Jaeger
IBM T.J. Watson Research Center
19 Skyline Drive
Hawthorne, NY 10532
jaegert@watson.ibm.com
(914) 784-7225, FAX (914) 784-7595



Stephen Smalley <sds@tislabs.com> on 05/28/2002 11:24:57 AM

To:    Trent Jaeger/Watson/IBM@IBMUS
cc:    Frank Mayer <mayerf@tresys.com>, <selinux@tycho.nsa.gov>, Ian
       Sollars <ian.sollars@gmx.net>
Subject:    RE: Policy creation RFC




On Tue, 21 May 2002, Trent Jaeger wrote:

> --- Default versus "operational dynamic" policy -- My opinion is that any
> legitimately modifiable policy needs a simpler model (not just interface)
> than the SELinux model.  As Tom pointed out, the level of expertise of
the
> folks making changes is less than those who established the original
> policy.   Policies that are likely to be changed by folks with less
> expertise require a simpler model (simpler policies will result).

Can you clarify what you mean by a simpler model?  By "SELinux model", are
you referring to the combined RBAC+TE+Identity security model implemented
by the example security server (described in the new policy technical
report)?  Are you suggesting a simpler model (e.g. Biba rather than TE) or
just a fixed base TE configuration?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--0__=0ABBE154DFF39E218f9e8a93df938690918c0ABBE154DFF39E21
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p>By simpler model, I mean (abstractly) one that uses fewer, simpler, or more domain-specific concepts than SELinux RBAC+TE+Identity model.  What those concepts are and for what circumstances are they sufficient is what I am working towards now.  <br>
<br>
Unfortunately, I do not have a specific case or recommendation at this point.  Hope to have some ideas soon.<br>
<br>
On the other hand, I do expect that such policies will have to be transformed into a SELinux policy for enforcement (i.e., I do not believe that any new things that we really need to enforce cannot be represented by the RBAC+TE+Identity model at present).  Also, fixed policies should be expressed in the SELinux model.<br>
<br>
Regards,<br>
Trent.<br>
----------------------------------<br>
Trent Jaeger<br>
IBM T.J. Watson Research Center<br>
19 Skyline Drive<br>
Hawthorne, NY 10532<br>
jaegert@watson.ibm.com<br>
(914) 784-7225, FAX (914) 784-7595<br>
<br>
<br>

<p><font size="2" color="#800080">To:	</font><font size="2">Trent Jaeger/Watson/IBM@IBMUS</font><br>
<font size="2" color="#800080">cc:	</font><font size="2">Frank Mayer &lt;mayerf@tresys.com&gt;, &lt;selinux@tycho.nsa.gov&gt;, Ian Sollars &lt;ian.sollars@gmx.net&gt;</font><font size="2" color="#800080"> </font><br>
<font size="2" color="#800080">Subject:	</font><font size="2">RE: Policy creation RFC</font><br>
<br>
<br>
<br>
<br>
<tt>On Tue, 21 May 2002, Trent Jaeger wrote:<br>
</tt><br>
<tt>&gt; --- Default versus &quot;operational dynamic&quot; policy -- My opinion is that any<br>
&gt; legitimately modifiable policy needs a simpler model (not just interface)<br>
&gt; than the SELinux model. &nbsp;As Tom pointed out, the level of expertise of the<br>
&gt; folks making changes is less than those who established the original<br>
&gt; policy. &nbsp; Policies that are likely to be changed by folks with less<br>
&gt; expertise require a simpler model (simpler policies will result).<br>
</tt><br>
<tt>Can you clarify what you mean by a simpler model? &nbsp;By &quot;SELinux model&quot;, are<br>
you referring to the combined RBAC+TE+Identity security model implemented<br>
by the example security server (described in the new policy technical<br>
report)? &nbsp;Are you suggesting a simpler model (e.g. Biba rather than TE) or<br>
just a fixed base TE configuration?<br>
</tt><br>
<tt>--<br>
Stephen D. Smalley, NAI Labs<br>
ssmalley@nai.com<br>
</tt><br>
<br>
<br>
<br>
</body></html>
--0__=0ABBE154DFF39E218f9e8a93df938690918c0ABBE154DFF39E21--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
