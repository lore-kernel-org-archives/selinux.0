In-Reply-To: <3F662A3A.4010408@iitk.ac.in>
To: kamal <kamalnee@iitk.ac.in>
Cc: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Subject: Re: SELinux project
From: Trent Jaeger <jaegert@us.ibm.com>
Message-ID: <OFC1E76CBA.00FC4FD2-ON85256DA2.0074FE78-85256DA2.00763A94@us.ibm.com>
Date: Mon, 15 Sep 2003 17:31:22 -0400
Content-Type: multipart/alternative; boundary="=_alternative 007638F485256DA2_="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multipart message in MIME format.
--=_alternative 007638F485256DA2_=
Content-Type: text/plain; charset="US-ASCII"

So you have the following reqs:

(1) Some form of Biba/BLP policy  -- SELinux can provide support, but it 
depends on the details of your policy. SELinux does not directly support 
Biba, so you'd probably have to think in TE model and map (or verify as we 
do). 
(2) Use signatures to establish labels and encryption for secrecy -- this 
is mostly outside SELinux, so it should be doable
(3) Multi-domain policies -- not supported explicitly in SELinux.  If you 
have administrative control over the computers in question this could be 
done, but it is an open task.

Trent.
----------------------------------
Trent Jaeger
IBM T.J. Watson Research Center
19 Skyline Drive
Hawthorne, NY 10532
jaegert@us.ibm.com
(914) 784-7225, FAX (914) 784-7595





kamal <kamalnee@iitk.ac.in>
09/15/2003 05:08 PM
 
        To:     Trent Jaeger/Watson/IBM@IBMUS
        cc:     SELinux@tycho.nsa.gov
        Subject:        Re: SELinux project


Thanks a lot for the suggestions!
Our interest related to integrity is slightly different. SELinux seems
to take good care of the security of the system. But consider a military
environment and think about actual users. A high ranking officer has got
lots of documents from juniors and his boss, some of them possibly
copied from their directories, and some sent through email. Now all the
documents should not appear same to him, there should be an easy
classification based on integrity and confidentiality of a document. He
should not unknowingly be able to move information in a way that
violates Biba and BLP constraints. We also want to see how digital
signatures and encryption can be tightly and transparently integrated
with this, e.g. in assigning integrity level to an incoming email
attachment.
Another thing in our mind is decentralization of users'
confidentiality/integrity levels. I mean putting this policy on some
central server. After all, users don't belong to a computer, they belong
to an organization. Decentralizing parts of general TE policy seems more
difficult, levels seem easier to handle.
I wonder whether all this makes sense. Does it?


--=_alternative 007638F485256DA2_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">So you have the following reqs:</font>
<br>
<br><font size=2 face="sans-serif">(1) Some form of Biba/BLP policy &nbsp;--
SELinux can provide support, but it depends on the details of your policy.
SELinux does not directly support Biba, so you'd probably have to think
in TE model and map (or verify as we do). </font>
<br><font size=2 face="sans-serif">(2) Use signatures to establish labels
and encryption for secrecy -- this is mostly outside SELinux, so it should
be doable</font>
<br><font size=2 face="sans-serif">(3) Multi-domain policies -- not supported
explicitly in SELinux. &nbsp;If you have administrative control over the
computers in question this could be done, but it is an open task.</font>
<br>
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
<table width=100%>
<tr valign=top>
<td>
<td><font size=1 face="sans-serif"><b>kamal &lt;kamalnee@iitk.ac.in&gt;</b></font>
<p><font size=1 face="sans-serif">09/15/2003 05:08 PM</font>
<td><font size=1 face="Arial">&nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; To:
&nbsp; &nbsp; &nbsp; &nbsp;Trent Jaeger/Watson/IBM@IBMUS</font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cc:
&nbsp; &nbsp; &nbsp; &nbsp;SELinux@tycho.nsa.gov</font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; Subject:
&nbsp; &nbsp; &nbsp; &nbsp;Re: SELinux project</font></table>
<br>
<br>
<br><font size=2><tt>Thanks a lot for the suggestions!<br>
Our interest related to integrity is slightly different. SELinux seems<br>
to take good care of the security of the system. But consider a military<br>
environment and think about actual users. A high ranking officer has got<br>
lots of documents from juniors and his boss, some of them possibly<br>
copied from their directories, and some sent through email. Now all the<br>
documents should not appear same to him, there should be an easy<br>
classification based on integrity and confidentiality of a document. He<br>
should not unknowingly be able to move information in a way that<br>
violates Biba and BLP constraints. We also want to see how digital<br>
signatures and encryption can be tightly and transparently integrated<br>
with this, e.g. in assigning integrity level to an incoming email<br>
attachment.<br>
Another thing in our mind is decentralization of users'<br>
confidentiality/integrity levels. I mean putting this policy on some<br>
central server. After all, users don't belong to a computer, they belong<br>
to an organization. Decentralizing parts of general TE policy seems more<br>
difficult, levels seem easier to handle.<br>
I wonder whether all this makes sense. Does it?</tt></font>
<br>
<br></div>
--=_alternative 007638F485256DA2_=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
