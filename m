Message-ID: <SNT139-W50B60E4DF5002FD83ECABABB90@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_f2d44def-429a-4736-914a-0cc9c4881705_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: <qingtao.cao@windriver.com>, <jmorris@namei.org>, <eparis@parisplace.org>,
        selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: [v0 PATCH 2/3] SELinux: Compute role in newcontext for all
 classes
Date: Fri, 25 Mar 2011 06:25:53 +0000
In-Reply-To: <1300973126.8157.31.camel@moss-pluto>
References: 
 <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com>,,<1300847325-20308-3-git-send-email-qingtao.cao@windriver.com>,,<1300887112.26747.17.camel@moss-pluto>,<SNT139-w5684DB5D9F65F017A51374ABB60@phx.gbl>,<1300973126.8157.31.camel@moss-pluto>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_f2d44def-429a-4736-914a-0cc9c4881705_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Stephen,

[cut]
> > 
> > Suppose we have below role_transition rule:
> > 
> > role_transition sysadm_r user_home_t : dir sysadm_r;
> > 
> > If roletr->type compared with newcontext.type, then it means that if
> > sysadm_r is creating an directory object with type equals to
> > user_home_t, then the directory object will have a role of sysadm_r.
> > 
> > However, if roletr->type is compared with tcontext->type, then the
> > semantics would be changed to that any objects of any class created by
> > sysadm_r in a directory object of the user_home_t type would have
> > their role set to sysadm_r, since in selinux_inode_init_security(),
> > dir->i_security is passed as tsid always.
> > 
> > I guess the former approach could have much refined control on the
> > objects role, if objects are of different types, then they could
> > assume different roles, not necessarily all f! iles in one directory
> > have to share the same role.
> > 
> > What you thi nk?
> 
> Compare with type_transition or range_transition semantics.
> type_transition sysadm_t tmp_t : sock_file sysadm_tmp_t;
> means when a sysadm_t (scontext->type) process creates a socket file
> (tclass) object in a directory labeled tmp_t (tcontext->type), then
> label the socket file with sysadm_tmp_t (newcontext->type).
> 
> type_transition sysadm_t sshd_exec_t:process sshd_t;
> means when a sysadm_t (scontext->type) process executes a sshd_exec_t
> (tcontext->type) file, then label the new process (tclass) with sshd_t
> (newcontext->type).
> 
> See how they are consistently applied regardless of whether it is a
> process or object class?
> 

Thanks for taking the patience to correct me. Now I've got it - for the newly created objects, the type field in both role_transition and type_transition rules  are always the parent directory type, and we can still use the class field in both rules to specify what class objects would the rule be applied to, so I am now clear that there won't be such a thing that "any object of any class in the same parent directory would have the same role", please find out in the tests I've done.

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
 		 	   		  
--_f2d44def-429a-4736-914a-0cc9c4881705_
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
Hi Stephen,<br><br>[cut]<br>&gt; &gt; <br>&gt; &gt; Suppose we have below role_transition rule:<br>&gt; &gt; <br>&gt; &gt; role_transition sysadm_r user_home_t : dir sysadm_r;<br>&gt; &gt; <br>&gt; &gt; If roletr-&gt;type compared with newcontext.type, then it means that if<br>&gt; &gt; sysadm_r is creating an directory object with type equals to<br>&gt; &gt; user_home_t, then the directory object will have a role of sysadm_r.<br>&gt; &gt; <br>&gt; &gt; However, if roletr-&gt;type is compared with tcontext-&gt;type, then the<br>&gt; &gt; semantics would be changed to that any objects of any class created by<br>&gt; &gt; sysadm_r in a directory object of the user_home_t type would have<br>&gt; &gt; their role set to sysadm_r, since in selinux_inode_init_security(),<br>&gt; &gt; dir-&gt;i_security is passed as tsid always.<br>&gt; &gt; <br>&gt; &gt; I guess the former approach could have much refined control on the<br>&gt; &gt; objects role, if objects are of different types, !
 then they could<br>&gt; &gt; assume different roles, not necessarily all f! iles in one directory<br>&gt; &gt; have to share the same role.<br>&gt; &gt; <br>&gt; &gt; What you thi nk?<br>&gt; <br>&gt; Compare with type_transition or range_transition semantics.<br>&gt; type_transition sysadm_t tmp_t : sock_file sysadm_tmp_t;<br>&gt; means when a sysadm_t (scontext-&gt;type) process creates a socket file<br>&gt; (tclass) object in a directory labeled tmp_t (tcontext-&gt;type), then<br>&gt; label the socket file with sysadm_tmp_t (newcontext-&gt;type).<br>&gt; <br>&gt; type_transition sysadm_t sshd_exec_t:process sshd_t;<br>&gt; means when a sysadm_t (scontext-&gt;type) process executes a sshd_exec_t<br>&gt; (tcontext-&gt;type) file, then label the new process (tclass) with sshd_t<br>&gt; (newcontext-&gt;type).<br>&gt; <br>&gt; See how they are consistently applied regardless of whether it is a<br>&gt; process or object class?<br>&gt; <br><br>Thanks for taking the patience to !
 correct me. Now I've got it - for the newly created objects, the type 
field in both role_transition and type_transition rules&nbsp; are always the parent directory type, and we can still use the class field in both rules to specify what class objects would the rule be applied to, so I am now clear that there won't be such a thing that "any object of any class in the same parent directory would have the same role", please find out in the tests I've done.<br><br>Best regards,<br>Harry<br><br><br>&gt; -- <br>&gt; Stephen Smalley<br>&gt; National Security Agency<br>&gt; <br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  </body>
</html>
--_f2d44def-429a-4736-914a-0cc9c4881705_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
