Message-ID: <SNT139-w55C9557D5680CAFF568605AB7B0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_6a8da3a7-826d-4f90-8ff5-df497ac858d3_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <method@manicmethod.com>, <qingtao.cao@windriver.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley
	<sds@tycho.nsa.gov>, <jmorris@namei.org>,
        <eparis@parisplace.org>, selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: [v1 PATCH 1/6] Add role attribute support when compiling
 modules.
Date: Mon, 30 May 2011 06:59:41 +0000
In-Reply-To: <4DE2CF62.4060909@manicmethod.com>
References: <1306643819-30374-1-git-send-email-qingtao.cao@windriver.com>
 <1306643819-30374-2-git-send-email-qingtao.cao@windriver.com>,<4DE2CF62.4060909@manicmethod.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_6a8da3a7-826d-4f90-8ff5-df497ac858d3_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Joshua,

> Date: Sun, 29 May 2011 18:57:38 -0400
> From: method@manicmethod.com
> To: qingtao.cao@windriver.com
> CC: cpebenito@tresys.com; sds@tycho.nsa.gov; jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov
> Subject: Re: [v1 PATCH 1/6] Add role attribute support when compiling modules.
> 
> Harry Ciao wrote:
> > 1. Add a uint32_t "flavor" field and an ebitmap "roles" to the
> > role_datum_t structure;
> >
> > 2. Modify the attribute declaration rule to add support to declare
> > role attribute as well as type attribute;
> 
> Lets just use a different token to declare role attributes and use 
> separate parser functions. I strongly dislike the char *kind in 
> define_attrib(). Overloading tokens has caused much pain in the past.
> 
> >
> > 3. Modify declare_role() to setup role_datum_t.flavor according
> > to the isattr argument;
> >
> > 4. Add a new roleattribute rule and its handler, which will record
> > the regular role's (policy value - 1) into the role attribute's
> > role_datum_t.roles ebitmap;
> >
> > 5. Modify the syntax for the role_types rule only to define the
> > role-type associations;
> >
> > 6. Add a new role_attr rule to support the declaration of a single
> > role, and the role attribute that the role belongs to;
> >
> > 7. Check if the new_role used in role transition is a regular role;
> >
> > 8. Make the role-types rule no longer used to declare a regular role
> > but solely aimed for declaring role-types associations;
> >
> > FIXME:
> > How to pass a second argument to require_attribute(), to indicate
> > if the attribute is of role or type ?
> 
> My suggestion on #2 should resolve this.
> 
> I'll look at the other patches soon.

Yep, turns out it is such a neat idea to use a separate token to declare a role attribute, which would make it very obvious and easy to require a role attribute!

I have been testing on the new token, I would send out v2 patches to endorse any of your further comments.

Thanks a lot!

Best regards,
Harry

> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_6a8da3a7-826d-4f90-8ff5-df497ac858d3_
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
Hi Joshua,<br><br>&gt; Date: Sun, 29 May 2011 18:57:38 -0400<br>&gt; From: method@manicmethod.com<br>&gt; To: qingtao.cao@windriver.com<br>&gt; CC: cpebenito@tresys.com; sds@tycho.nsa.gov; jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov<br>&gt; Subject: Re: [v1 PATCH 1/6] Add role attribute support when compiling modules.<br>&gt; <br>&gt; Harry Ciao wrote:<br>&gt; &gt; 1. Add a uint32_t "flavor" field and an ebitmap "roles" to the<br>&gt; &gt; role_datum_t structure;<br>&gt; &gt;<br>&gt; &gt; 2. Modify the attribute declaration rule to add support to declare<br>&gt; &gt; role attribute as well as type attribute;<br>&gt; <br>&gt; Lets just use a different token to declare role attributes and use <br>&gt; separate parser functions. I strongly dislike the char *kind in <br>&gt; define_attrib(). Overloading tokens has caused much pain in the past.<br>&gt; <br>&gt; &gt;<br>&gt; &gt; 3. Modify declare_role() to setup role_datum_t.flavor according<br>&gt; &gt; to th!
 e isattr argument;<br>&gt; &gt;<br>&gt; &gt; 4. Add a new roleattribute rule and its handler, which will record<br>&gt; &gt; the regular role's (policy value - 1) into the role attribute's<br>&gt; &gt; role_datum_t.roles ebitmap;<br>&gt; &gt;<br>&gt; &gt; 5. Modify the syntax for the role_types rule only to define the<br>&gt; &gt; role-type associations;<br>&gt; &gt;<br>&gt; &gt; 6. Add a new role_attr rule to support the declaration of a single<br>&gt; &gt; role, and the role attribute that the role belongs to;<br>&gt; &gt;<br>&gt; &gt; 7. Check if the new_role used in role transition is a regular role;<br>&gt; &gt;<br>&gt; &gt; 8. Make the role-types rule no longer used to declare a regular role<br>&gt; &gt; but solely aimed for declaring role-types associations;<br>&gt; &gt;<br>&gt; &gt; FIXME:<br>&gt; &gt; How to pass a second argument to require_attribute(), to indicate<br>&gt; &gt; if the attribute is of role or type ?<br>&gt; <br>&gt; My suggestion on #2 should resol!
 ve this.<br>&gt; <br>&gt; I'll look at the other patches soon.<br><br>
Yep, turns out it is such a neat idea to use a separate token to declare a role attribute, which would make it very obvious and easy to require a role attribute!<br><br>I have been testing on the new token, I would send out v2 patches to endorse any of your further comments.<br><br>Thanks a lot!<br><br>Best regards,<br>Harry<br><br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  </body>
</html>
--_6a8da3a7-826d-4f90-8ff5-df497ac858d3_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
