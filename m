Message-ID: <SNT139-w377E7616678A35BE40A56BABB90@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_b9de920c-ba83-40b9-8730-854ec1a23c2a_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: <eparis@redhat.com>, <qingtao.cao@windriver.com>, <jmorris@namei.org>,
        <eparis@parisplace.org>, selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: [v0 PATCH 1/3] SELinux: Add class support to the role_trans
 structure
Date: Fri, 25 Mar 2011 06:28:26 +0000
In-Reply-To: <1300972861.8157.26.camel@moss-pluto>
References: 
 <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com>,,<1300847325-20308-2-git-send-email-qingtao.cao@windriver.com>,,<1300891222.28871.6.camel@unknown001a4b0c2895>,<SNT139-w107AB9BF9E6715B2B318ECABB60@phx.gbl>,<1300972861.8157.26.camel@moss-pluto>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_b9de920c-ba83-40b9-8730-854ec1a23c2a_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit




> Subject: RE: [v0 PATCH 1/3] SELinux: Add class support to the role_trans structure
> From: sds@tycho.nsa.gov
> To: harrytaurus2002@hotmail.com
> CC: eparis@redhat.com; qingtao.cao@windriver.com; jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov
> Date: Thu, 24 Mar 2011 09:21:01 -0400
> 
> On Thu, 2011-03-24 at 09:43 +0000, HarryCiao wrote:
> > > Why "cclass"? most of the code uses tclass (which might mean 'target
> > > class' but I'm not sure)
> > 
> > Well, I intended to use "class" but it is a reserved GCC identifier.
> > 
> > The class could be the subject class, that is, the "process" class, or
> > could be the newly object class, so tclass(target class) won't fit
> > much here.
> > 
> > I will update it to "classes" which I think will be better than
> > "cclass" :-)
> 
> tclass is more consistent with existing code, and it does mean "target
> class", where target can be a subject or an object.  

Sure, I will correct it in the v2 patches.

Thanks!

Harry

> 
> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_b9de920c-ba83-40b9-8730-854ec1a23c2a_
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
<br><br>&gt; Subject: RE: [v0 PATCH 1/3] SELinux: Add class support to the role_trans structure<br>&gt; From: sds@tycho.nsa.gov<br>&gt; To: harrytaurus2002@hotmail.com<br>&gt; CC: eparis@redhat.com; qingtao.cao@windriver.com; jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov<br>&gt; Date: Thu, 24 Mar 2011 09:21:01 -0400<br>&gt; <br>&gt; On Thu, 2011-03-24 at 09:43 +0000, HarryCiao wrote:<br>&gt; &gt; &gt; Why "cclass"? most of the code uses tclass (which might mean 'target<br>&gt; &gt; &gt; class' but I'm not sure)<br>&gt; &gt; <br>&gt; &gt; Well, I intended to use "class" but it is a reserved GCC identifier.<br>&gt; &gt; <br>&gt; &gt; The class could be the subject class, that is, the "process" class, or<br>&gt; &gt; could be the newly object class, so tclass(target class) won't fit<br>&gt; &gt; much here.<br>&gt; &gt; <br>&gt; &gt; I will update it to "classes" which I think will be better than<br>&gt; &gt; "cclass" :-)<br>&gt; <br>&gt; tclass is more consist!
 ent with existing code, and it does mean "target<br>&gt; class", where target can be a subject or an object.  <br><br>Sure, I will correct it in the v2 patches.<br><br>Thanks!<br><br>Harry<br><br>&gt; <br>&gt; -- <br>&gt; Stephen Smalley<br>&gt; National Security Agency<br>&gt; <br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  </body>
</html>
--_b9de920c-ba83-40b9-8730-854ec1a23c2a_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
