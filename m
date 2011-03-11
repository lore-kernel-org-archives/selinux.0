Message-ID: <SNT139-W22B6E0E79E71EE3A16A471ABCB0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_a1d22ff0-49a8-44af-b7f0-30ebaaa35b43_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <russell@coker.com.au>, <qingtao.cao@windriver.com>,
        Stephen Smalley
	<sds@tycho.nsa.gov>, <jmorris@namei.org>,
        <eparis@parisplace.org>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: [v2 PATCH 0/3] SELinux: separate socket type than its creator
Date: Fri, 11 Mar 2011 03:16:04 +0000
In-Reply-To: <18621088-2ec8-4092-ab48-427393598479@email.android.com>
References: <1299044768-22058-1-git-send-email-qingtao.cao@windriver.com>
 <SNT139-w538F8D8118C077D8E94F34ABC00@phx.gbl>,<18621088-2ec8-4092-ab48-427393598479@email.android.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_a1d22ff0-49a8-44af-b7f0-30ebaaa35b43_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Russell,

I have not got your idea. We could have an attribute for all unix_stream_socket types, but all types in this attribute would still be the domain type too. What I have been trying to do with these patches it have a chance to make socket object have a different type than its creator.

Could you kindly further elaborate a bit more about your intention for such attribute?

Thanks,
Harry


> Subject: Re: [v2 PATCH 0/3] SELinux: separate socket type than its creator
> From: russell@coker.com.au
> Date: Wed, 9 Mar 2011 19:30:57 +1100
> To: harrytaurus2002@hotmail.com; qingtao.cao@windriver.com; sds@tycho.nsa.gov; jmorris@namei.org; eparis@parisplace.org
> CC: selinux@tycho.nsa.gov
> 
> Why not have a separate attribute for unix domain sockets?
> -- 
> My blog    http://etbe.coker.com.au
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_a1d22ff0-49a8-44af-b7f0-30ebaaa35b43_
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
Hi Russell,<br><br>I have not got your idea. We could have an attribute for all unix_stream_socket types, but all types in this attribute would still be the domain type too. What I have been trying to do with these patches it have a chance to make socket object have a different type than its creator.<br><br>Could you kindly further elaborate a bit more about your intention for such attribute?<br><br>Thanks,<br>Harry<br><br><br>&gt; Subject: Re: [v2 PATCH 0/3] SELinux: separate socket type than its creator<br>&gt; From: russell@coker.com.au<br>&gt; Date: Wed, 9 Mar 2011 19:30:57 +1100<br>&gt; To: harrytaurus2002@hotmail.com; qingtao.cao@windriver.com; sds@tycho.nsa.gov; jmorris@namei.org; eparis@parisplace.org<br>&gt; CC: selinux@tycho.nsa.gov<br>&gt; <br>&gt; Why not have a separate attribute for unix domain sockets?<br>&gt; -- <br>&gt; My blog    http://etbe.coker.com.au<br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>!
 &gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  </body>
</html>
--_a1d22ff0-49a8-44af-b7f0-30ebaaa35b43_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
