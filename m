Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p31LIkKE003868
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2011 17:18:46 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p31LIisP022642
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2011 21:18:45 GMT
Subject: Re: [PATCH] selinux: add type_transition with name extension
 support for selinuxfs
From: Eric Paris <eparis@redhat.com>
To: Kohei Kaigai <Kohei.Kaigai@EU.NEC.COM>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <A9F5079BABDEE646AEBDB6831725762C52B55BD751@EUEXCLU01.EU.NEC.COM>
References: 
	 <A9F5079BABDEE646AEBDB6831725762C52B55BD751@EUEXCLU01.EU.NEC.COM>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Apr 2011 17:18:35 -0400
Message-ID: <1301692715.6798.20.camel@unknown001a4b0c2895>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-04-01 at 15:39 +0100, Kohei Kaigai wrote:
> The attached patch allows /selinux/create takes optional 4th argument
> to support TYPE_TRANSITION with name extension for userspace object
> managers.
> If 4th argument is not supplied, it shall perform as existing kernel.
> In fact, the regression test of SE-PostgreSQL works well on the patched
> kernel.
> 
> Thanks,
> --
>  Signed-off-by: KaiGai Kohei <kohei.kaigai@eu.nec.com>
> 
>  security/selinux/include/security.h |    4 ++--
>  security/selinux/selinuxfs.c        |   16 ++++++++++++++--
>  security/selinux/ss/services.c      |   17 +++++++++--------
>  3 files changed, 25 insertions(+), 12 deletions(-)

Applied to http://git.infradead.org/users/eparis/selinux.git

In the future please put "---" (3 of them instead of 2) after the
'Signed-off-by:' but before the diffstat.  Git grabs everything before a
--- as a changelog.  This message caused git to include the diffstat IN
the changelog

Thank you for the patch!

-Eric

> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 348eb00..75ff3a0 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -111,8 +111,8 @@ void security_compute_av_user(u32 ssid, u32 tsid,
>  int security_transition_sid(u32 ssid, u32 tsid, u16 tclass,
>  			    const struct qstr *qstr, u32 *out_sid);
>  
> -int security_transition_sid_user(u32 ssid, u32 tsid,
> -				 u16 tclass, u32 *out_sid);
> +int security_transition_sid_user(u32 ssid, u32 tsid, u16 tclass,
> +				 const char *objname, u32 *out_sid);
>  
>  int security_member_sid(u32 ssid, u32 tsid,
>  	u16 tclass, u32 *out_sid);
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index ea39cb7..973f5a4 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -753,11 +753,13 @@ out:
>  static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
>  {
>  	char *scon = NULL, *tcon = NULL;
> +	char *namebuf = NULL, *objname = NULL;
>  	u32 ssid, tsid, newsid;
>  	u16 tclass;
>  	ssize_t length;
>  	char *newcon = NULL;
>  	u32 len;
> +	int nargs;
>  
>  	length = task_has_security(current, SECURITY__COMPUTE_CREATE);
>  	if (length)
> @@ -773,9 +775,17 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
>  	if (!tcon)
>  		goto out;
>  
> +	length = -ENOMEM;
> +	namebuf = kzalloc(size + 1, GFP_KERNEL);
> +	if (!namebuf)
> +		goto out;
> +
>  	length = -EINVAL;
> -	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
> +	nargs = sscanf(buf, "%s %s %hu %s", scon, tcon, &tclass, namebuf);
> +	if (nargs < 3 || nargs > 4)
>  		goto out;
> +	if (nargs == 4)
> +		objname = namebuf;
>  
>  	length = security_context_to_sid(scon, strlen(scon) + 1, &ssid);
>  	if (length)
> @@ -785,7 +795,8 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
>  	if (length)
>  		goto out;
>  
> -	length = security_transition_sid_user(ssid, tsid, tclass, &newsid);
> +	length = security_transition_sid_user(ssid, tsid, tclass,
> +					      objname, &newsid);
>  	if (length)
>  		goto out;
>  
> @@ -804,6 +815,7 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
>  	length = len;
>  out:
>  	kfree(newcon);
> +	kfree(namebuf);
>  	kfree(tcon);
>  	kfree(scon);
>  	return length;
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index ea7c01f..2f0f9f4 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1360,14 +1360,14 @@ out:
>  
>  static void filename_compute_type(struct policydb *p, struct context *newcontext,
>  				  u32 scon, u32 tcon, u16 tclass,
> -				  const struct qstr *qstr)
> +				  const char *objname)
>  {
>  	struct filename_trans *ft;
>  	for (ft = p->filename_trans; ft; ft = ft->next) {
>  		if (ft->stype == scon &&
>  		    ft->ttype == tcon &&
>  		    ft->tclass == tclass &&
> -		    !strcmp(ft->name, qstr->name)) {
> +		    !strcmp(ft->name, objname)) {
>  			newcontext->type = ft->otype;
>  			return;
>  		}
> @@ -1378,7 +1378,7 @@ static int security_compute_sid(u32 ssid,
>  				u32 tsid,
>  				u16 orig_tclass,
>  				u32 specified,
> -				const struct qstr *qstr,
> +				const char *objname,
>  				u32 *out_sid,
>  				bool kern)
>  {
> @@ -1479,9 +1479,9 @@ static int security_compute_sid(u32 ssid,
>  	}
>  
>  	/* if we have a qstr this is a file trans check so check those rules */
> -	if (qstr)
> +	if (objname)
>  		filename_compute_type(&policydb, &newcontext, scontext->type,
> -				      tcontext->type, tclass, qstr);
> +				      tcontext->type, tclass, objname);
>  
>  	/* Check for class-specific changes. */
>  	if  (tclass == policydb.process_class) {
> @@ -1541,13 +1541,14 @@ int security_transition_sid(u32 ssid, u32 tsid, u16 tclass,
>  			    const struct qstr *qstr, u32 *out_sid)
>  {
>  	return security_compute_sid(ssid, tsid, tclass, AVTAB_TRANSITION,
> -				    qstr, out_sid, true);
> +				    qstr ? qstr->name : NULL, out_sid, true);
>  }
>  
> -int security_transition_sid_user(u32 ssid, u32 tsid, u16 tclass, u32 *out_sid)
> +int security_transition_sid_user(u32 ssid, u32 tsid, u16 tclass,
> +				 const char *objname, u32 *out_sid)
>  {
>  	return security_compute_sid(ssid, tsid, tclass, AVTAB_TRANSITION,
> -				    NULL, out_sid, false);
> +				    objname, out_sid, false);
>  }
>  
>  /**
> 
> --
> NEC Europe Ltd, SAP Global Competence Center
> KaiGai Kohei <kohei.kaigai@eu.nec.com>
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
