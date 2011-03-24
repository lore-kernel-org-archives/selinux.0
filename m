Message-ID: <SNT139-w107AB9BF9E6715B2B318ECABB60@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_c030f900-6977-4501-b191-81867a97fb0f_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <eparis@redhat.com>, <qingtao.cao@windriver.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, <jmorris@namei.org>,
        <eparis@parisplace.org>, selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: [v0 PATCH 1/3] SELinux: Add class support to the role_trans
 structure
Date: Thu, 24 Mar 2011 09:43:26 +0000
In-Reply-To: <1300891222.28871.6.camel@unknown001a4b0c2895>
References: 
 <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com>,<1300847325-20308-2-git-send-email-qingtao.cao@windriver.com>,<1300891222.28871.6.camel@unknown001a4b0c2895>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_c030f900-6977-4501-b191-81867a97fb0f_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit




> Subject: Re: [v0 PATCH 1/3] SELinux: Add class support to the role_trans structure
> From: eparis@redhat.com
> To: qingtao.cao@windriver.com
> CC: sds@tycho.nsa.gov; jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov
> Date: Wed, 23 Mar 2011 10:40:22 -0400
> 
> On Wed, 2011-03-23 at 10:28 +0800, Harry Ciao wrote:
> > From: Harry Ciao <harrytaurus200@hotmail.com>
> > 
> > If kernel policy version is >= 25, then the binary representation of
> > the role_trans structure supports specifying the class for the current
> > subject or the newly created object.
> > 
> > If kernel policy version is < 25, then the class field would be default
> > to the process class.
> > 
> > Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
> > ---
> >  security/selinux/include/security.h |    3 ++-
> >  security/selinux/ss/policydb.c      |   24 +++++++++++++++++++++---
> >  security/selinux/ss/policydb.h      |    7 ++++---
> >  3 files changed, 27 insertions(+), 7 deletions(-)
> > 
> > diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> > index 671273e..a9d9e2b 100644
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -28,13 +28,14 @@
> >  #define POLICYDB_VERSION_POLCAP		22
> >  #define POLICYDB_VERSION_PERMISSIVE	23
> >  #define POLICYDB_VERSION_BOUNDARY	24
> > +#define POLICYDB_VERSION_ROLETRANS	25
> 
> Grab a newer kernel.  POLICYDB_VERSION_FILENAME_TRANS == 25.  You're
> going to need 26  (although I haven't gotten the userspace
> implementation of 26 done so we are going to have to work together to
> make sure we don't trample on each other there)

No problem!

I will rebase to the latest SELinux kernel tree and reserve 25 for you in the userspace.

>  
> >  /* Range of policy versions we understand*/
> >  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
> >  #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
> >  #define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
> >  #else
> > -#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_BOUNDARY
> > +#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_ROLETRANS
> >  #endif
> >  
> >  /* Mask for just the mount related flags */
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > index 5736356..b660f08 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -123,6 +123,11 @@ static struct policydb_compat_info policydb_compat[] = {
> >  		.sym_num	= SYM_NUM,
> >  		.ocon_num	= OCON_NUM,
> >  	},
> > +	{
> > +		.version	= POLICYDB_VERSION_ROLETRANS,
> > +		.sym_num	= SYM_NUM,
> > +		.ocon_num	= OCON_NUM,
> > +	},
> >  };
> >  
> >  static struct policydb_compat_info *policydb_lookup_compat(int version)
> > @@ -2209,16 +2214,29 @@ int policydb_read(struct policydb *p, void *fp)
> >  			ltr->next = tr;
> >  		else
> >  			p->role_tr = tr;
> > -		rc = next_entry(buf, fp, sizeof(u32)*3);
> > +		rc = next_entry(buf, fp, sizeof(u32)*2);
> >  		if (rc)
> >  			goto bad;
> >  
> > -		rc = -EINVAL;
> >  		tr->role = le32_to_cpu(buf[0]);
> >  		tr->type = le32_to_cpu(buf[1]);
> > -		tr->new_role = le32_to_cpu(buf[2]);
> > +		if (p->policyvers >= POLICYDB_VERSION_ROLETRANS) {
> > +			rc = next_entry(buf, fp, sizeof(u32));
> > +			if (rc)
> > +				goto bad;
> > +			tr->cclass = le32_to_cpu(buf[0]);
> > +		} else
> > +			tr->cclass = p->process_class;
> > +
> > +		rc = next_entry(buf, fp, sizeof(u32));
> > +		if (rc)
> > +			goto bad;
> > +		tr->new_role = le32_to_cpu(buf[0]);
> > +
> > +		rc = -EINVAL;
> >  		if (!policydb_role_isvalid(p, tr->role) ||
> >  		    !policydb_type_isvalid(p, tr->type) ||
> > +		    !policydb_class_isvalid(p, tr->cclass) ||
> >  		    !policydb_role_isvalid(p, tr->new_role))
> >  			goto bad;
> >  		ltr = tr;
> > diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> > index 4e3ab9d..ba08fb4 100644
> > --- a/security/selinux/ss/policydb.h
> > +++ b/security/selinux/ss/policydb.h
> > @@ -71,9 +71,10 @@ struct role_datum {
> >  };
> >  
> >  struct role_trans {
> > -	u32 role;		/* current role */
> > -	u32 type;		/* program executable type */
> > -	u32 new_role;		/* new role */
> > +	u32 role;	/* current role */
> > +	u32 type;	/* program executable type, or new object type */
> > +	u32 cclass;	/* process class, or new object class */
> 
> Why "cclass"?  most of the code uses tclass (which might mean 'target
> class' but I'm not sure)

Well, I intended to use "class" but it is a reserved GCC identifier.

The class could be the subject class, that is, the "process" class, or could be the newly object class, so tclass(target class) won't fit much here.

I will update it to "classes" which I think will be better than "cclass" :-)

Thanks,
Harry

> 
> Otherwise the patch looks good to me.  If you fix those you can add an
> ACK on your next submission.
> 
> > +	u32 new_role;	/* new role */
> >  	struct role_trans *next;
> >  };
> >  
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_c030f900-6977-4501-b191-81867a97fb0f_
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
<br><br>&gt; Subject: Re: [v0 PATCH 1/3] SELinux: Add class support to the role_trans structure<br>&gt; From: eparis@redhat.com<br>&gt; To: qingtao.cao@windriver.com<br>&gt; CC: sds@tycho.nsa.gov; jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov<br>&gt; Date: Wed, 23 Mar 2011 10:40:22 -0400<br>&gt; <br>&gt; On Wed, 2011-03-23 at 10:28 +0800, Harry Ciao wrote:<br>&gt; &gt; From: Harry Ciao &lt;harrytaurus200@hotmail.com&gt;<br>&gt; &gt; <br>&gt; &gt; If kernel policy version is &gt;= 25, then the binary representation of<br>&gt; &gt; the role_trans structure supports specifying the class for the current<br>&gt; &gt; subject or the newly created object.<br>&gt; &gt; <br>&gt; &gt; If kernel policy version is &lt; 25, then the class field would be default<br>&gt; &gt; to the process class.<br>&gt; &gt; <br>&gt; &gt; Signed-off-by: Harry Ciao &lt;qingtao.cao@windriver.com&gt;<br>&gt; &gt; ---<br>&gt; &gt;  security/selinux/include/security.h |    3 ++-<br>&gt; &gt;!
   security/selinux/ss/policydb.c      |   24 +++++++++++++++++++++---<br>&gt; &gt;  security/selinux/ss/policydb.h      |    7 ++++---<br>&gt; &gt;  3 files changed, 27 insertions(+), 7 deletions(-)<br>&gt; &gt; <br>&gt; &gt; diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h<br>&gt; &gt; index 671273e..a9d9e2b 100644<br>&gt; &gt; --- a/security/selinux/include/security.h<br>&gt; &gt; +++ b/security/selinux/include/security.h<br>&gt; &gt; @@ -28,13 +28,14 @@<br>&gt; &gt;  #define POLICYDB_VERSION_POLCAP		22<br>&gt; &gt;  #define POLICYDB_VERSION_PERMISSIVE	23<br>&gt; &gt;  #define POLICYDB_VERSION_BOUNDARY	24<br>&gt; &gt; +#define POLICYDB_VERSION_ROLETRANS	25<br>&gt; <br>&gt; Grab a newer kernel.  POLICYDB_VERSION_FILENAME_TRANS == 25.  You're<br>&gt; going to need 26  (although I haven't gotten the userspace<br>&gt; implementation of 26 done so we are going to have to work together to<br>&gt; make sure we don't trample on each other the!
 re)<br><br>No problem!<br><br>I will rebase to the latest SELinux kern
el tree and reserve 25 for you in the userspace.<br><br>&gt;  <br>&gt; &gt;  /* Range of policy versions we understand*/<br>&gt; &gt;  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE<br>&gt; &gt;  #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX<br>&gt; &gt;  #define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE<br>&gt; &gt;  #else<br>&gt; &gt; -#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_BOUNDARY<br>&gt; &gt; +#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_ROLETRANS<br>&gt; &gt;  #endif<br>&gt; &gt;  <br>&gt; &gt;  /* Mask for just the mount related flags */<br>&gt; &gt; diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c<br>&gt; &gt; index 5736356..b660f08 100644<br>&gt; &gt; --- a/security/selinux/ss/policydb.c<br>&gt; &gt; +++ b/security/selinux/ss/policydb.c<br>&gt; &gt; @@ -123,6 +123,11 @@ static struct policydb_compat_info policydb_compat[] = {<br>&gt; &gt;  		.sym_num	= SYM_NUM,<br>&gt; &gt;  		.ocon_num	= !
 OCON_NUM,<br>&gt; &gt;  	},<br>&gt; &gt; +	{<br>&gt; &gt; +		.version	= POLICYDB_VERSION_ROLETRANS,<br>&gt; &gt; +		.sym_num	= SYM_NUM,<br>&gt; &gt; +		.ocon_num	= OCON_NUM,<br>&gt; &gt; +	},<br>&gt; &gt;  };<br>&gt; &gt;  <br>&gt; &gt;  static struct policydb_compat_info *policydb_lookup_compat(int version)<br>&gt; &gt; @@ -2209,16 +2214,29 @@ int policydb_read(struct policydb *p, void *fp)<br>&gt; &gt;  			ltr-&gt;next = tr;<br>&gt; &gt;  		else<br>&gt; &gt;  			p-&gt;role_tr = tr;<br>&gt; &gt; -		rc = next_entry(buf, fp, sizeof(u32)*3);<br>&gt; &gt; +		rc = next_entry(buf, fp, sizeof(u32)*2);<br>&gt; &gt;  		if (rc)<br>&gt; &gt;  			goto bad;<br>&gt; &gt;  <br>&gt; &gt; -		rc = -EINVAL;<br>&gt; &gt;  		tr-&gt;role = le32_to_cpu(buf[0]);<br>&gt; &gt;  		tr-&gt;type = le32_to_cpu(buf[1]);<br>&gt; &gt; -		tr-&gt;new_role = le32_to_cpu(buf[2]);<br>&gt; &gt; +		if (p-&gt;policyvers &gt;= POLICYDB_VERSION_ROLETRANS) {<br>&gt; &gt; +			rc = next_entry(buf, fp, sizeof(u32));<br>!
 &gt; &gt; +			if (rc)<br>&gt; &gt; +				goto bad;<br>&gt; &gt; +			tr-
&gt;cclass = le32_to_cpu(buf[0]);<br>&gt; &gt; +		} else<br>&gt; &gt; +			tr-&gt;cclass = p-&gt;process_class;<br>&gt; &gt; +<br>&gt; &gt; +		rc = next_entry(buf, fp, sizeof(u32));<br>&gt; &gt; +		if (rc)<br>&gt; &gt; +			goto bad;<br>&gt; &gt; +		tr-&gt;new_role = le32_to_cpu(buf[0]);<br>&gt; &gt; +<br>&gt; &gt; +		rc = -EINVAL;<br>&gt; &gt;  		if (!policydb_role_isvalid(p, tr-&gt;role) ||<br>&gt; &gt;  		    !policydb_type_isvalid(p, tr-&gt;type) ||<br>&gt; &gt; +		    !policydb_class_isvalid(p, tr-&gt;cclass) ||<br>&gt; &gt;  		    !policydb_role_isvalid(p, tr-&gt;new_role))<br>&gt; &gt;  			goto bad;<br>&gt; &gt;  		ltr = tr;<br>&gt; &gt; diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h<br>&gt; &gt; index 4e3ab9d..ba08fb4 100644<br>&gt; &gt; --- a/security/selinux/ss/policydb.h<br>&gt; &gt; +++ b/security/selinux/ss/policydb.h<br>&gt; &gt; @@ -71,9 +71,10 @@ struct role_datum {<br>&gt; &gt;  };<br>&gt; &gt;  <br>&gt; &gt;  struct role_trans {<!
 br>&gt; &gt; -	u32 role;		/* current role */<br>&gt; &gt; -	u32 type;		/* program executable type */<br>&gt; &gt; -	u32 new_role;		/* new role */<br>&gt; &gt; +	u32 role;	/* current role */<br>&gt; &gt; +	u32 type;	/* program executable type, or new object type */<br>&gt; &gt; +	u32 cclass;	/* process class, or new object class */<br>&gt; <br>&gt; Why "cclass"?  most of the code uses tclass (which might mean 'target<br>&gt; class' but I'm not sure)<br><br>Well, I intended to use "class" but it is a reserved GCC identifier.<br><br>The class could be the subject class, that is, the "process" class, or could be the newly object class, so tclass(target class) won't fit much here.<br><br>I will update it to "classes" which I think will be better than "cclass" :-)<br><br>Thanks,<br>Harry<br><br>&gt; <br>&gt; Otherwise the patch looks good to me.  If you fix those you can add an<br>&gt; ACK on your next submission.<br>&gt; <br>&gt; &gt; +	u32 new_role;	/* new role */<br>&gt; &gt; !
  	struct role_trans *next;<br>&gt; &gt;  };<br>&gt; &gt;  <br>&gt; <br
>&gt; <br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  </body>
</html>
--_c030f900-6977-4501-b191-81867a97fb0f_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
