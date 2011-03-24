Message-ID: <SNT139-w2405160FA71333F031B90AABB60@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_d02137c9-0e04-4213-b37c-0b589b08895d_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <method@manicmethod.com>, <eparis@redhat.com>
CC: <qingtao.cao@windriver.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        <jmorris@namei.org>, <eparis@parisplace.org>,
        selinux-mailing-list
	<selinux@tycho.nsa.gov>
Subject: RE: [v0 PATCH 3/3] SELinux: Write class field in role_trans_write.
Date: Thu, 24 Mar 2011 10:02:54 +0000
In-Reply-To: <4D8A4308.80400@manicmethod.com>
References: <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com>
	 <1300847325-20308-4-git-send-email-qingtao.cao@windriver.com>
 <1300891710.28871.10.camel@unknown001a4b0c2895>,<4D8A4308.80400@manicmethod.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_d02137c9-0e04-4213-b37c-0b589b08895d_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Joshua and Eric,

> Date: Wed, 23 Mar 2011 14:59:20 -0400
> From: method@manicmethod.com
> To: eparis@redhat.com
> CC: qingtao.cao@windriver.com; sds@tycho.nsa.gov; jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov
> Subject: Re: [v0 PATCH 3/3] SELinux: Write class field in role_trans_write.
> 
> Eric Paris wrote:
> > On Wed, 2011-03-23 at 10:28 +0800, Harry Ciao wrote:
> >> From: Harry Ciao<harrytaurus2002@hotmail.com>
> >>
> >> If kernel policy version is>= 25, then write the class field of the
> >> role_trans structure into the binary reprensentation.
> >>
> >> Signed-off-by: Harry Ciao<qingtao.cao@windriver.com>
> >
> > Looking at this patch (and the first one) I really start to feel like
> > putting the class after the newrole on disk.  It really would clean up
> > the patches and the code to not insert the conditional in the middle of
> > reading/writing and instead do it at the end....
> 
> He doesn't have to put it after new_role to clean up the conditional, just break 
> the buffer in 2. range_write() does this in userspace, I'm not sure what the 
> kernel interface looks like.


I'd followed range_write() logic and used new_roletr in role_trans_write() similar to new_rangetr used in range_write().

Anyway, it won't take much extra effort to put the classes field after new_role in the binary representation, which does can make the code simpler :-) I will commit such change in the next version patches.

Thanks,
Harry

> 
> >
> >> ---
> >>   security/selinux/ss/policydb.c |   18 +++++++++++++-----
> >>   1 files changed, 13 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> >> index b660f08..a6be0f5 100644
> >> --- a/security/selinux/ss/policydb.c
> >> +++ b/security/selinux/ss/policydb.c
> >> @@ -2450,10 +2450,11 @@ static int cat_write(void *vkey, void *datum, void *ptr)
> >>   	return 0;
> >>   }
> >>
> >> -static int role_trans_write(struct role_trans *r, void *fp)
> >> +static int role_trans_write(struct policydb *p, void *fp)
> >>   {
> >> +	struct role_trans *r = p->role_tr;
> >>   	struct role_trans *tr;
> >> -	u32 buf[3];
> >> +	u32 buf[4];
> >>   	size_t nel;
> >>   	int rc;
> >>
> >> @@ -2467,8 +2468,15 @@ static int role_trans_write(struct role_trans *r, void *fp)
> >>   	for (tr = r; tr; tr = tr->next) {
> >>   		buf[0] = cpu_to_le32(tr->role);
> >>   		buf[1] = cpu_to_le32(tr->type);
> >> -		buf[2] = cpu_to_le32(tr->new_role);
> >> -		rc = put_entry(buf, sizeof(u32), 3, fp);
> >> +		if (p->policyvers>= POLICYDB_VERSION_ROLETRANS) {
> >> +			buf[2] = cpu_to_le32(tr->cclass);
> >> +			buf[3] = cpu_to_le32(tr->new_role);
> >> +			rc = put_entry(buf, sizeof(u32), 4, fp);
> >> +		} else {
> >> +			buf[2] = cpu_to_le32(tr->new_role);
> >> +			rc = put_entry(buf, sizeof(u32), 3, fp);
> >> +		}
> >> +
> >>   		if (rc)
> >>   			return rc;
> >>   	}
> >> @@ -3145,7 +3153,7 @@ int policydb_write(struct policydb *p, void *fp)
> >>   	if (rc)
> >>   		return rc;
> >>
> >> -	rc = role_trans_write(p->role_tr, fp);
> >> +	rc = role_trans_write(p, fp);
> >>   	if (rc)
> >>   		return rc;
> >>
> >
> >
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> >
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_d02137c9-0e04-4213-b37c-0b589b08895d_
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
Hi Joshua and Eric,<br><br>&gt; Date: Wed, 23 Mar 2011 14:59:20 -0400<br>&gt; From: method@manicmethod.com<br>&gt; To: eparis@redhat.com<br>&gt; CC: qingtao.cao@windriver.com; sds@tycho.nsa.gov; jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov<br>&gt; Subject: Re: [v0 PATCH 3/3] SELinux: Write class field in role_trans_write.<br>&gt; <br>&gt; Eric Paris wrote:<br>&gt; &gt; On Wed, 2011-03-23 at 10:28 +0800, Harry Ciao wrote:<br>&gt; &gt;&gt; From: Harry Ciao&lt;harrytaurus2002@hotmail.com&gt;<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; If kernel policy version is&gt;= 25, then write the class field of the<br>&gt; &gt;&gt; role_trans structure into the binary reprensentation.<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; Signed-off-by: Harry Ciao&lt;qingtao.cao@windriver.com&gt;<br>&gt; &gt;<br>&gt; &gt; Looking at this patch (and the first one) I really start to feel like<br>&gt; &gt; putting the class after the newrole on disk.  It really would clean up<br>&gt; &gt; the patches an!
 d the code to not insert the conditional in the middle of<br>&gt; &gt; reading/writing and instead do it at the end....<br>&gt; <br>&gt; He doesn't have to put it after new_role to clean up the conditional, just break <br>&gt; the buffer in 2. range_write() does this in userspace, I'm not sure what the <br>&gt; kernel interface looks like.<br><br><br>I'd followed range_write() logic and used new_roletr in role_trans_write() similar to new_rangetr used in range_write().<br><br>Anyway, it won't take much extra effort to put the classes field after new_role in the binary representation, which does can make the code simpler :-) I will commit such change in the next version patches.<br><br>Thanks,<br>Harry<br><br>&gt; <br>&gt; &gt;<br>&gt; &gt;&gt; ---<br>&gt; &gt;&gt;   security/selinux/ss/policydb.c |   18 +++++++++++++-----<br>&gt; &gt;&gt;   1 files changed, 13 insertions(+), 5 deletions(-)<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; diff --git a/security/selinux/ss/policydb.c b/secur!
 ity/selinux/ss/policydb.c<br>&gt; &gt;&gt; index b660f08..a6be0f5 1006
44<br>&gt; &gt;&gt; --- a/security/selinux/ss/policydb.c<br>&gt; &gt;&gt; +++ b/security/selinux/ss/policydb.c<br>&gt; &gt;&gt; @@ -2450,10 +2450,11 @@ static int cat_write(void *vkey, void *datum, void *ptr)<br>&gt; &gt;&gt;   	return 0;<br>&gt; &gt;&gt;   }<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; -static int role_trans_write(struct role_trans *r, void *fp)<br>&gt; &gt;&gt; +static int role_trans_write(struct policydb *p, void *fp)<br>&gt; &gt;&gt;   {<br>&gt; &gt;&gt; +	struct role_trans *r = p-&gt;role_tr;<br>&gt; &gt;&gt;   	struct role_trans *tr;<br>&gt; &gt;&gt; -	u32 buf[3];<br>&gt; &gt;&gt; +	u32 buf[4];<br>&gt; &gt;&gt;   	size_t nel;<br>&gt; &gt;&gt;   	int rc;<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; @@ -2467,8 +2468,15 @@ static int role_trans_write(struct role_trans *r, void *fp)<br>&gt; &gt;&gt;   	for (tr = r; tr; tr = tr-&gt;next) {<br>&gt; &gt;&gt;   		buf[0] = cpu_to_le32(tr-&gt;role);<br>&gt; &gt;&gt;   		buf[1] = cpu_to_le32(tr-&gt;type);<br>&gt; &gt;&gt; -		buf[2] = !
 cpu_to_le32(tr-&gt;new_role);<br>&gt; &gt;&gt; -		rc = put_entry(buf, sizeof(u32), 3, fp);<br>&gt; &gt;&gt; +		if (p-&gt;policyvers&gt;= POLICYDB_VERSION_ROLETRANS) {<br>&gt; &gt;&gt; +			buf[2] = cpu_to_le32(tr-&gt;cclass);<br>&gt; &gt;&gt; +			buf[3] = cpu_to_le32(tr-&gt;new_role);<br>&gt; &gt;&gt; +			rc = put_entry(buf, sizeof(u32), 4, fp);<br>&gt; &gt;&gt; +		} else {<br>&gt; &gt;&gt; +			buf[2] = cpu_to_le32(tr-&gt;new_role);<br>&gt; &gt;&gt; +			rc = put_entry(buf, sizeof(u32), 3, fp);<br>&gt; &gt;&gt; +		}<br>&gt; &gt;&gt; +<br>&gt; &gt;&gt;   		if (rc)<br>&gt; &gt;&gt;   			return rc;<br>&gt; &gt;&gt;   	}<br>&gt; &gt;&gt; @@ -3145,7 +3153,7 @@ int policydb_write(struct policydb *p, void *fp)<br>&gt; &gt;&gt;   	if (rc)<br>&gt; &gt;&gt;   		return rc;<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; -	rc = role_trans_write(p-&gt;role_tr, fp);<br>&gt; &gt;&gt; +	rc = role_trans_write(p, fp);<br>&gt; &gt;&gt;   	if (rc)<br>&gt; &gt;&gt;   		return rc;<br>&gt; &gt;&gt;<br>&gt; &gt;<!
 br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; --<br>&gt; &gt; This message wa
s distributed to subscribers of the selinux mailing list.<br>&gt; &gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; &gt; the words "unsubscribe selinux" without quotes as the message.<br>&gt; &gt;<br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  </body>
</html>
--_d02137c9-0e04-4213-b37c-0b589b08895d_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
