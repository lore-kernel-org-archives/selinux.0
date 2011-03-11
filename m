Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p2B6Yod3025724
	for <selinux@tycho.nsa.gov>; Fri, 11 Mar 2011 01:34:50 -0500
Received: from snt0-omc1-s41.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p2B6YnYx018331
	for <selinux@tycho.nsa.gov>; Fri, 11 Mar 2011 06:34:49 GMT
Message-ID: <SNT139-w62326B9D06022CD1C0302ABCB0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_a28fcc0e-898e-43dd-b7c7-5d89258bc35a_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <russell@coker.com.au>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: [v2 PATCH 0/3] SELinux: separate socket type than its creator
Date: Fri, 11 Mar 2011 06:34:48 +0000
In-Reply-To: <a0516b20-8dcd-4dd5-9f19-7207888e0575@email.android.com>
References: <1299044768-22058-1-git-send-email-qingtao.cao@windriver.com>
 <SNT139-w538F8D8118C077D8E94F34ABC00@phx.gbl>,<18621088-2ec8-4092-ab48-427393598479@email.android.com>
 <SNT139-W22B6E0E79E71EE3A16A471ABCB0@phx.gbl>,<a0516b20-8dcd-4dd5-9f19-7207888e0575@email.android.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_a28fcc0e-898e-43dd-b7c7-5d89258bc35a_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Russell,

> Subject: RE: [v2 PATCH 0/3] SELinux: separate socket type than its creator
> From: russell@coker.com.au
> Date: Fri, 11 Mar 2011 15:10:32 +1100
> To: harrytaurus2002@hotmail.com
> CC: selinux@tycho.nsa.gov
> 
> The constraints for MLS can have rules excluding specified types or attributes.  We could have an attribute for domins whos unix sockets should be excluded from MLS. 

Well, I think the current mlstrustedobject attribute serves nothing but this purpose, does it :-)

> It seems to me that the only real benefit to allowing a Unix socket to have a different type to the domain that created it is for a domain that creates multiple sockets with different types.
> 
> Maybe this would be good for systemd.

Yes, you are right on this point, socket labeling could allow sockets of different classes created by the same one domain have different types if that is desirable, which is a desirable flexibility I think.

Thanks for your comments!

Best regards,
Harry


> -- 
> My blog    http://etbe.coker.com.au
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_a28fcc0e-898e-43dd-b7c7-5d89258bc35a_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Î¢ÈíÑÅºÚ
}
--></style>
</head>
<body class='hmmessage'>
Hi Russell,<br><br>&gt; Subject: RE: [v2 PATCH 0/3] SELinux: separate socket type than its creator<br>&gt; From: russell@coker.com.au<br>&gt; Date: Fri, 11 Mar 2011 15:10:32 +1100<br>&gt; To: harrytaurus2002@hotmail.com<br>&gt; CC: selinux@tycho.nsa.gov<br>&gt; <br>&gt; The constraints for MLS can have rules excluding specified types or attributes.  We could have an attribute for domins whos unix sockets should be excluded from MLS. <br><br>Well, I think the current mlstrustedobject attribute serves nothing but this purpose, does it :-)<br><br>&gt; It seems to me that the only real benefit to allowing a Unix socket to have a different type to the domain that created it is for a domain that creates multiple sockets with different types.<br>&gt; <br>&gt; Maybe this would be good for systemd.<br><br>Yes, you are right on this point, socket labeling could allow sockets of different classes created by the same one domain have different types if that is desirable, which is a desir!
 able flexibility I think.<br><br>Thanks for your comments!<br><br>Best regards,<br>Harry<br><br><br>&gt; -- <br>&gt; My blog    http://etbe.coker.com.au<br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  </body>
</html>
--_a28fcc0e-898e-43dd-b7c7-5d89258bc35a_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
