Message-ID: <SNT139-W15EA748D92DCFAA0280F21AB240@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_cbec2155-351c-4f51-a13a-4c4bd9c3847d_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <sds@tycho.nsa.gov>, <qingtao.cao@windriver.com>
CC: <cpebenito@tresys.com>, <slawrence@tresys.com>, <selinux@tycho.nsa.gov>
Subject: RE: [v0 PATCH 1/1] Skip writing role attributes for policy.X.
Date: Sat, 13 Aug 2011 08:42:42 +0000
In-Reply-To: <1313150384.19123.5.camel@moss-pluto>
References: 
 <1313129923-23763-1-git-send-email-qingtao.cao@windriver.com>,<1313129923-23763-2-git-send-email-qingtao.cao@windriver.com>,<1313150384.19123.5.camel@moss-pluto>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_cbec2155-351c-4f51-a13a-4c4bd9c3847d_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Stephen,

> 
> Looks like this is wrong for type attributes as well, but shouldn't we
> uncount the attributes before we convert endianness?  
>

Yep, you are right! I think we should uncount attributes number first then convert endianness.

I will send v1 patch to fix this. Thanks!

Best regards,
Harry
 
> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_cbec2155-351c-4f51-a13a-4c4bd9c3847d_
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
<body class='hmmessage'><div dir='ltr'>
Hi Stephen,<br><br><div>&gt; <br>&gt; Looks like this is wrong for type attributes as well, but shouldn't we<br>&gt; uncount the attributes before we convert endianness?  <br>&gt;<br><br>Yep, you are right! I think we should uncount attributes number first then convert endianness.<br><br>I will send v1 patch to fix this. Thanks!<br><br>Best regards,<br>Harry<br>&nbsp;<br>&gt; -- <br>&gt; Stephen Smalley<br>&gt; National Security Agency<br>&gt; <br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br></div> 		 	   		  </div></body>
</html>
--_cbec2155-351c-4f51-a13a-4c4bd9c3847d_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
