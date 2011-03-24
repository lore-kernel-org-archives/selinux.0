Message-ID: <SNT139-w5684DB5D9F65F017A51374ABB60@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_c75d4ab6-1ba6-463e-aab2-3f21583fa6f0_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, <qingtao.cao@windriver.com>
CC: <jmorris@namei.org>, <eparis@parisplace.org>,
        selinux-mailing-list
	<selinux@tycho.nsa.gov>
Subject: RE: [v0 PATCH 2/3] SELinux: Compute role in newcontext for all
 classes
Date: Thu, 24 Mar 2011 09:56:50 +0000
In-Reply-To: <1300887112.26747.17.camel@moss-pluto>
References: 
 <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com>,<1300847325-20308-3-git-send-email-qingtao.cao@windriver.com>,<1300887112.26747.17.camel@moss-pluto>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_c75d4ab6-1ba6-463e-aab2-3f21583fa6f0_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Stephen,

> Subject: Re: [v0 PATCH 2/3] SELinux: Compute role in newcontext for all classes
> From: sds@tycho.nsa.gov
> To: qingtao.cao@windriver.com
> CC: jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov
> Date: Wed, 23 Mar 2011 09:31:52 -0400
> 
> On Wed, 2011-03-23 at 10:28 +0800, Harry Ciao wrote:
> > From: Harry Ciao <harrytaurus200@hotmail.com>
> > 
> > For the process class, the role_trans.type is compared with
> > tcontext->type, that is, the program executable type.
> > 
> > For all the rest classes, the role_trans.type is compared with
> > newcontext.type, that is, the type for the newly created object
> > of that class.
> 
> I don't understand why you aren't applying the logic consistently for
> all classes.  Compare with range_trans handling.  Also, if we think
> there will be any significant number of these role_trans rules, you
> might want to go ahead and start using a hashtab as was later done for
> range_trans for efficient lookup.

Suppose we have below role_transition rule:

role_transition sysadm_r user_home_t : dir sysadm_r;

If roletr->type compared with newcontext.type, then it means that if sysadm_r is creating an directory object with type equals to user_home_t, then the directory object will have a role of sysadm_r.

However, if roletr->type is compared with tcontext->type, then the semantics would be changed to that any objects of any class created by sysadm_r in a directory object of the user_home_t type would have their role set to sysadm_r, since in selinux_inode_init_security(), dir->i_security is passed as tsid always.

I guess the former approach could have much refined control on the objects role, if objects are of different types, then they could assume different roles, not necessarily all files in one directory have to share the same role.

What you think?

BTW, I came to the idea to use hashtab structure to manage range_tr too, and this could be a separate development activity that I could do later.

Thanks a lot!

Best regards,
Harry

> 
> > 
> > Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
> > ---
> >  security/selinux/ss/services.c |   23 ++++++++++++-----------
> >  1 files changed, 12 insertions(+), 11 deletions(-)
> > 
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index a03cfaf..01fc3d5 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -1443,17 +1443,18 @@ static int security_compute_sid(u32 ssid,
> >  	}
> >  
> >  	/* Check for class-specific changes. */
> > -	if  (tclass == policydb.process_class) {
> > -		if (specified & AVTAB_TRANSITION) {
> > -			/* Look for a role transition rule. */
> > -			for (roletr = policydb.role_tr; roletr;
> > -			     roletr = roletr->next) {
> > -				if (roletr->role == scontext->role &&
> > -				    roletr->type == tcontext->type) {
> > -					/* Use the role transition rule. */
> > -					newcontext.role = roletr->new_role;
> > -					break;
> > -				}
> > +	if (specified & AVTAB_TRANSITION) {
> > +		/* Look for a role transition rule. */
> > +		for (roletr = policydb.role_tr; roletr; roletr = roletr->next) {
> > +			if ((roletr->role == scontext->role) &&
> > +			    (roletr->cclass == tclass) &&
> > +			    ((roletr->cclass == policydb.process_class &&
> > +			      roletr->type == tcontext->type) ||
> > +			     (roletr->cclass != policydb.process_class &&
> > +			      roletr->type == newcontext.type))){
> > +				/* Use the role transition rule. */
> > +				newcontext.role = roletr->new_role;
> > +				break;
> >  			}
> >  		}
> >  	}
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
 		 	   		  
--_c75d4ab6-1ba6-463e-aab2-3f21583fa6f0_
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
Hi Stephen,<br><br>&gt; Subject: Re: [v0 PATCH 2/3] SELinux: Compute role in newcontext for all classes<br>&gt; From: sds@tycho.nsa.gov<br>&gt; To: qingtao.cao@windriver.com<br>&gt; CC: jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov<br>&gt; Date: Wed, 23 Mar 2011 09:31:52 -0400<br>&gt; <br>&gt; On Wed, 2011-03-23 at 10:28 +0800, Harry Ciao wrote:<br>&gt; &gt; From: Harry Ciao &lt;harrytaurus200@hotmail.com&gt;<br>&gt; &gt; <br>&gt; &gt; For the process class, the role_trans.type is compared with<br>&gt; &gt; tcontext-&gt;type, that is, the program executable type.<br>&gt; &gt; <br>&gt; &gt; For all the rest classes, the role_trans.type is compared with<br>&gt; &gt; newcontext.type, that is, the type for the newly created object<br>&gt; &gt; of that class.<br>&gt; <br>&gt; I don't understand why you aren't applying the logic consistently for<br>&gt; all classes.  Compare with range_trans handling.  Also, if we think<br>&gt; there will be any significant numbe!
 r of these role_trans rules, you<br>&gt; might want to go ahead and start using a hashtab as was later done for<br>&gt; range_trans for efficient lookup.<br><br>Suppose we have below role_transition rule:<br><br>role_transition sysadm_r user_home_t : dir sysadm_r;<br><br>If roletr-&gt;type compared with newcontext.type, then it means that if sysadm_r is creating an directory object with type equals to user_home_t, then the directory object will have a role of sysadm_r.<br><br>However, if roletr-&gt;type is compared with tcontext-&gt;type, then the semantics would be changed to that any objects of any class created by sysadm_r in a directory object of the user_home_t type would have their role set to sysadm_r, since in selinux_inode_init_security(), dir-&gt;i_security is passed as tsid always.<br><br>I guess the former approach could have much refined control on the objects role, if objects are of different types, then they could assume different roles, not necessarily all f!
 iles in one directory have to share the same role.<br><br>What you thi
nk?<br><br>BTW, I came to the idea to use hashtab structure to manage range_tr too, and this could be a separate development activity that I could do later.<br><br>Thanks a lot!<br><br>Best regards,<br>Harry<br><br>&gt; <br>&gt; &gt; <br>&gt; &gt; Signed-off-by: Harry Ciao &lt;qingtao.cao@windriver.com&gt;<br>&gt; &gt; ---<br>&gt; &gt;  security/selinux/ss/services.c |   23 ++++++++++++-----------<br>&gt; &gt;  1 files changed, 12 insertions(+), 11 deletions(-)<br>&gt; &gt; <br>&gt; &gt; diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c<br>&gt; &gt; index a03cfaf..01fc3d5 100644<br>&gt; &gt; --- a/security/selinux/ss/services.c<br>&gt; &gt; +++ b/security/selinux/ss/services.c<br>&gt; &gt; @@ -1443,17 +1443,18 @@ static int security_compute_sid(u32 ssid,<br>&gt; &gt;  	}<br>&gt; &gt;  <br>&gt; &gt;  	/* Check for class-specific changes. */<br>&gt; &gt; -	if  (tclass == policydb.process_class) {<br>&gt; &gt; -		if (specified &amp; AVTAB_TRANSITION) !
 {<br>&gt; &gt; -			/* Look for a role transition rule. */<br>&gt; &gt; -			for (roletr = policydb.role_tr; roletr;<br>&gt; &gt; -			     roletr = roletr-&gt;next) {<br>&gt; &gt; -				if (roletr-&gt;role == scontext-&gt;role &amp;&amp;<br>&gt; &gt; -				    roletr-&gt;type == tcontext-&gt;type) {<br>&gt; &gt; -					/* Use the role transition rule. */<br>&gt; &gt; -					newcontext.role = roletr-&gt;new_role;<br>&gt; &gt; -					break;<br>&gt; &gt; -				}<br>&gt; &gt; +	if (specified &amp; AVTAB_TRANSITION) {<br>&gt; &gt; +		/* Look for a role transition rule. */<br>&gt; &gt; +		for (roletr = policydb.role_tr; roletr; roletr = roletr-&gt;next) {<br>&gt; &gt; +			if ((roletr-&gt;role == scontext-&gt;role) &amp;&amp;<br>&gt; &gt; +			    (roletr-&gt;cclass == tclass) &amp;&amp;<br>&gt; &gt; +			    ((roletr-&gt;cclass == policydb.process_class &amp;&amp;<br>&gt; &gt; +			      roletr-&gt;type == tcontext-&gt;type) ||<br>&gt; &gt; +			     (roletr-&gt;cclass != policydb.process_cl!
 ass &amp;&amp;<br>&gt; &gt; +			      roletr-&gt;type == newcontext.ty
pe))){<br>&gt; &gt; +				/* Use the role transition rule. */<br>&gt; &gt; +				newcontext.role = roletr-&gt;new_role;<br>&gt; &gt; +				break;<br>&gt; &gt;  			}<br>&gt; &gt;  		}<br>&gt; &gt;  	}<br>&gt; <br>&gt; -- <br>&gt; Stephen Smalley<br>&gt; National Security Agency<br>&gt; <br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  </body>
</html>
--_c75d4ab6-1ba6-463e-aab2-3f21583fa6f0_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
