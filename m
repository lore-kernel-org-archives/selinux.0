Message-ID: <SNT139-w62C8D0A475883C71AD50F9ABC20@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_a9cbd031-fc99-4627-8f09-8cdeeadbe879_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley
	<sds@tycho.nsa.gov>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>, <refpolicy@oss1.tresys.com>
Subject: Further questions about configuring contexts differently for
 variant classes
Date: Fri, 4 Mar 2011 10:38:33 +0000
In-Reply-To: <4D667EBA.3060205@tresys.com>
References: <SNT139-w42F5BDB103916DC8160624ABDA0@phx.gbl>
 <1298554512.31953.38.camel@moss-pluto>,<4D667EBA.3060205@tresys.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_a9cbd031-fc99-4627-8f09-8cdeeadbe879_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Stephen and Chris,

I would like to dig deeper on this topic and I have started thinking below questions as a starting point, it definitively would help me to get warmed up quickly if you could help pointing me at the background story :-)

[cut]
> > ... Maybe we can come up with some generalized
> > solution that will be more flexible going forward for configuring how
> > different parts of the context are assigned for different classes.  We
> > have talked previously about using the role field even for files rather
> > than just making them all object_r.
> 

1. Would it work simply to make the newly created objects have the role of "scontext->role" than "object_r" in security_compute_sid?
2. If files' role is not "object_r" anymore, what changes in refpolicy and SELinux kernel space would have to be done accordingly?
3. Where can I find our previously talks on such topic?

> It certainly would be nice to have all objects get the role of their
> creator so we can bring role-based policy separations back using RBAC
> features and not rely on 1:1 user:role mapping + UBAC.

4. It seems that we used to have RBAC, then why we have to have dropped it?
5. Does the "1:1 user:role mapping" mean the mapping from linux user to selinux user, and the mapping from selinux user to the roles that he/she could assume?
6. Any discussion email thread about how UBAC works and why we would want "1:1 user:role mapping + UBAC"?

I know I've asked a lot of silly questions, thanks a lot for your time and patience!

Best regards,
Harry
 		 	   		  
--_a9cbd031-fc99-4627-8f09-8cdeeadbe879_
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
Hi Stephen and Chris,<br><br>I would like to dig deeper on this topic and I have started thinking below questions as a starting point, it definitively would help me to get warmed up quickly if you could help pointing me at the background story :-)<br><br><font style="" color="#000000"><font style="" face="'Î¢ÈíÑÅºÚ'">[cut]</font></font><br>&gt; &gt; ... Maybe we can come up with some generalized<br>&gt; &gt; solution that will be more flexible going forward for configuring how<br>&gt; &gt; different parts of the context are assigned for different classes.  We<br>&gt; &gt; have talked previously about using the role field even for files rather<br>&gt; &gt; than just making them all object_r.<br>&gt; <br><br>1. Would it work simply to make the newly created objects have the role of "scontext-&gt;role" than "object_r" in security_compute_sid?<br>2. If files' role is not "object_r" anymore, what changes in refpolicy and SELinux kernel space would have to be done accordingly?<br>!
 3. Where can I find our previously talks on such topic?<br><br>&gt; It certainly would be nice to have all objects get the role of their<br>&gt; creator so we can bring role-based policy separations back using RBAC<br>&gt; features and not rely on 1:1 user:role mapping + UBAC.<br><br>4. It seems that we used to have RBAC, then why we have to have dropped it?<br>5. Does the "1:1 user:role mapping" mean the mapping from linux user to selinux user, and the mapping from selinux user to the roles that he/she could assume?<br>6. Any discussion email thread about how UBAC works and why we would want "1:1 user:role mapping + UBAC"?<br><br>I know I've asked a lot of silly questions, thanks a lot for your time and patience!<br><br>Best regards,<br>Harry<br> 		 	   		  </body>
</html>
--_a9cbd031-fc99-4627-8f09-8cdeeadbe879_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
