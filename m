Message-ID: <SNT139-w4262CE7D8648745E218FFABB60@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_c331e035-6854-4a54-8711-1e5c766b1f62_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <method@manicmethod.com>, <qingtao.cao@windriver.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, <jmorris@namei.org>,
        <eparis@parisplace.org>, selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: [v0 PATCH 3/5] Handle the class in role_trans structure
Date: Thu, 24 Mar 2011 10:36:11 +0000
In-Reply-To: <4D8A4462.7010404@manicmethod.com>
References: <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com>
 <1300847325-20308-7-git-send-email-qingtao.cao@windriver.com>,<4D8A4462.7010404@manicmethod.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_c331e035-6854-4a54-8711-1e5c766b1f62_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


I've got your point, for lower version policy non-process class object won't be supported in the role_transition rule, so it makes sense to discard all such rules.

Thanks a lot!

Best regards,
Harry


> Date: Wed, 23 Mar 2011 15:05:06 -0400
> From: method@manicmethod.com
> To: qingtao.cao@windriver.com
> CC: sds@tycho.nsa.gov; jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov
> Subject: Re: [v0 PATCH 3/5] Handle the class in role_trans structure
> 
> Harry Ciao wrote:
> > From: Harry Ciao<harrytaurus2002@hotmail.com>
> <snip>
> 
> > --- a/libsepol/src/write.c
> > +++ b/libsepol/src/write.c
> > @@ -462,11 +462,14 @@ static int cat_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
> >   	return POLICYDB_SUCCESS;
> >   }
> >
> > -static int role_trans_write(role_trans_t * r, struct policy_file *fp)
> > +static int role_trans_write(policydb_t *p, struct policy_file *fp)
> >   {
> > +	role_trans_t *r = p->role_tr;
> >   	role_trans_t *tr;
> >   	uint32_t buf[3];
> >   	size_t nel, items;
> > +	int new_roletr = (p->policy_type == POLICY_KERN&&
> > +			  p->policyvers>= POLICYDB_VERSION_ROLETRANS);
> >
> >   	nel = 0;
> >   	for (tr = r; tr; tr = tr->next)
> > @@ -478,9 +481,18 @@ static int role_trans_write(role_trans_t * r, struct policy_file *fp)
> >   	for (tr = r; tr; tr = tr->next) {
> >   		buf[0] = cpu_to_le32(tr->role);
> >   		buf[1] = cpu_to_le32(tr->type);
> > -		buf[2] = cpu_to_le32(tr->new_role);
> > -		items = put_entry(buf, sizeof(uint32_t), 3, fp);
> > -		if (items != 3)
> > +		items = put_entry(buf, sizeof(uint32_t), 2, fp);
> > +		if (items != 2)
> > +			return POLICYDB_ERROR;
> > +		if (new_roletr) {
> > +			buf[0] = cpu_to_le32(tr->cclass);
> > +			items = put_entry(buf, sizeof(uint32_t), 1, fp);
> > +			if (items != 1)
> > +				return POLICYDB_ERROR;
> > +		}
> > +		buf[0] = cpu_to_le32(tr->new_role);
> > +		items = put_entry(buf, sizeof(uint32_t), 1, fp);
> > +		if (items != 1)
> >   			return POLICYDB_ERROR;
> >   	}
> >
> 
> You need to do something like range_write if you end up having a class set from 
> the parser but you are building a lower version of the policy. The range write 
> warning is:
> 
>          for (rt = p->range_tr; rt; rt = rt->next) {
>                  if (!new_rangetr && rt->target_class != SECCLASS_PROCESS) {
>                          if (!warning_issued)
>                                  WARN(fp->handle, "Discarding range_transition "
>                                       "rules for security classes other than "
>                                       "\"process\"");
>                          warning_issued = 1;
>                          continue;
>                  }
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_c331e035-6854-4a54-8711-1e5c766b1f62_
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
I've got your point, for lower version policy non-process class object won't be supported in the role_transition rule, so it makes sense to discard all such rules.<br><br>Thanks a lot!<br><br>Best regards,<br>Harry<br><br><br>&gt; Date: Wed, 23 Mar 2011 15:05:06 -0400<br>&gt; From: method@manicmethod.com<br>&gt; To: qingtao.cao@windriver.com<br>&gt; CC: sds@tycho.nsa.gov; jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov<br>&gt; Subject: Re: [v0 PATCH 3/5] Handle the class in role_trans structure<br>&gt; <br>&gt; Harry Ciao wrote:<br>&gt; &gt; From: Harry Ciao&lt;harrytaurus2002@hotmail.com&gt;<br>&gt; &lt;snip&gt;<br>&gt; <br>&gt; &gt; --- a/libsepol/src/write.c<br>&gt; &gt; +++ b/libsepol/src/write.c<br>&gt; &gt; @@ -462,11 +462,14 @@ static int cat_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)<br>&gt; &gt;   	return POLICYDB_SUCCESS;<br>&gt; &gt;   }<br>&gt; &gt;<br>&gt; &gt; -static int role_trans_write(role_trans_t * r, struct policy_file *fp)!
 <br>&gt; &gt; +static int role_trans_write(policydb_t *p, struct policy_file *fp)<br>&gt; &gt;   {<br>&gt; &gt; +	role_trans_t *r = p-&gt;role_tr;<br>&gt; &gt;   	role_trans_t *tr;<br>&gt; &gt;   	uint32_t buf[3];<br>&gt; &gt;   	size_t nel, items;<br>&gt; &gt; +	int new_roletr = (p-&gt;policy_type == POLICY_KERN&amp;&amp;<br>&gt; &gt; +			  p-&gt;policyvers&gt;= POLICYDB_VERSION_ROLETRANS);<br>&gt; &gt;<br>&gt; &gt;   	nel = 0;<br>&gt; &gt;   	for (tr = r; tr; tr = tr-&gt;next)<br>&gt; &gt; @@ -478,9 +481,18 @@ static int role_trans_write(role_trans_t * r, struct policy_file *fp)<br>&gt; &gt;   	for (tr = r; tr; tr = tr-&gt;next) {<br>&gt; &gt;   		buf[0] = cpu_to_le32(tr-&gt;role);<br>&gt; &gt;   		buf[1] = cpu_to_le32(tr-&gt;type);<br>&gt; &gt; -		buf[2] = cpu_to_le32(tr-&gt;new_role);<br>&gt; &gt; -		items = put_entry(buf, sizeof(uint32_t), 3, fp);<br>&gt; &gt; -		if (items != 3)<br>&gt; &gt; +		items = put_entry(buf, sizeof(uint32_t), 2, fp);<br>&gt; &gt; +		if (items !
 != 2)<br>&gt; &gt; +			return POLICYDB_ERROR;<br>&gt; &gt; +		if (new_
roletr) {<br>&gt; &gt; +			buf[0] = cpu_to_le32(tr-&gt;cclass);<br>&gt; &gt; +			items = put_entry(buf, sizeof(uint32_t), 1, fp);<br>&gt; &gt; +			if (items != 1)<br>&gt; &gt; +				return POLICYDB_ERROR;<br>&gt; &gt; +		}<br>&gt; &gt; +		buf[0] = cpu_to_le32(tr-&gt;new_role);<br>&gt; &gt; +		items = put_entry(buf, sizeof(uint32_t), 1, fp);<br>&gt; &gt; +		if (items != 1)<br>&gt; &gt;   			return POLICYDB_ERROR;<br>&gt; &gt;   	}<br>&gt; &gt;<br>&gt; <br>&gt; You need to do something like range_write if you end up having a class set from <br>&gt; the parser but you are building a lower version of the policy. The range write <br>&gt; warning is:<br>&gt; <br>&gt;          for (rt = p-&gt;range_tr; rt; rt = rt-&gt;next) {<br>&gt;                  if (!new_rangetr &amp;&amp; rt-&gt;target_class != SECCLASS_PROCESS) {<br>&gt;                          if (!warning_issued)<br>&gt;                                  WARN(fp-&gt;handle, "Discarding range_transition "<br>&gt;            !
                            "rules for security classes other than "<br>&gt;                                       "\"process\"");<br>&gt;                          warning_issued = 1;<br>&gt;                          continue;<br>&gt;                  }<br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  </body>
</html>
--_c331e035-6854-4a54-8711-1e5c766b1f62_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
