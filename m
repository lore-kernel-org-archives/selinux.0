Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i81EaWrT021455
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 10:36:32 -0400 (EDT)
Received: from web51505.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i81EZgY2004056
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 14:35:43 GMT
Message-ID: <20040901143631.18080.qmail@web51505.mail.yahoo.com>
Date: Wed, 1 Sep 2004 07:36:31 -0700 (PDT)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Interpret security context
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1521672489-1094049391=:16018"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1521672489-1094049391=:16018
Content-Type: text/plain; charset=us-ascii

Hi,

In subsection 5.2.1 Object Labeling of <<The Flask Security Architecture: System Support for Diverse Security Policies>>, it says:
   A security context, the first policy-independent data type, is a variable-length string which can be interpreted by any application or user with an understanding of the security policy.
 
        While, In subsection 2.1.Flask Concepts of <<Configuring the SELinux Policy>>, it says:
   The content and format of a security context depends on the particular security model, so a security context is only interpreted by the security server.
 
        Then, Who can interpret the security context except security server? Can any application or user with an understanding of the security policy interpret the security context in the end?
 


--
Best Regards,
Park Lee <parklee_sel@yahoo.com> 
 






		
---------------------------------
Do you Yahoo!?
Win 1 of 4,000 free domain names from Yahoo! Enter now.
--0-1521672489-1094049391=:16018
Content-Type: text/html; charset=us-ascii

<DIV>Hi,</DIV>
<DIV><BR>In <EM>subsection 5.2.1 Object Labeling</EM> of &lt;&lt;The Flask Security Architecture: System Support for Diverse Security Policies&gt;&gt;, it says:<BR>&nbsp;&nbsp; A <STRONG>security context</STRONG>, the first policy-independent data type, is a variable-length string <STRONG>which can be interpreted by any application or user with an understanding of the security policy.</STRONG></DIV>
<DIV><STRONG></STRONG>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; While, In <EM>subsection 2.1.Flask Concepts</EM> of &lt;&lt;Configuring the SELinux Policy&gt;&gt;, it says:<BR>&nbsp;&nbsp; The content and format of a security context depends on the particular security model, so a <STRONG>security context is only interpreted by the security server</STRONG>.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Then, Who can interpret the security context except security server? Can any application or user with an understanding of the security policy interpret the security context in the end?</DIV>
<DIV>&nbsp;</DIV><BR><BR><DIV>
<DIV>
<DIV>
<DIV>
<DIV>
<DIV>--<BR>Best Regards,<BR>Park Lee &lt;<A href="http://us.f515.mail.yahoo.com/ym/Compose?To=parklee_sel@yahoo.com&amp;YY=1156&amp;order=down&amp;sort=date&amp;pos=0"><FONT color=#003399>parklee_sel@yahoo.com</FONT></A>&gt; </DIV>
<DIV>&nbsp;</DIV></DIV></DIV></DIV></DIV></DIV><p>
		<hr size=1>Do you Yahoo!?<br>
Win 1 of 4,000 free domain names from Yahoo! <a
href="http://us.rd.yahoo.com/evt=26640/*http://promotions.yahoo.com/goldrush">Enter now</a>.
--0-1521672489-1094049391=:16018--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
