Message-ID: <SNT139-w11D21A34A17D1865F37785AB760@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_2bbb2527-2a1e-4373-afe9-eade7371016c_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <qingtao.cao@windriver.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        <jmorris@namei.org>, <eparis@parisplace.org>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: [PATCH 1/1] Fix arguments when expanding user_datum_t.roles
Date: Fri, 27 May 2011 02:13:45 +0000
In-Reply-To: <1306315569-5432-2-git-send-email-qingtao.cao@windriver.com>
References: 
 <1306315569-5432-1-git-send-email-qingtao.cao@windriver.com>,<1306315569-5432-2-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_2bbb2527-2a1e-4373-afe9-eade7371016c_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Please ignore this patch, I have integrated it in those patches to add role attribute support.

Thanks,
Harry

> From: qingtao.cao@windriver.com
> To: sds@tycho.nsa.gov; jmorris@namei.org; eparis@parisplace.org
> CC: selinux@tycho.nsa.gov
> Subject: [PATCH 1/1] Fix arguments when expanding user_datum_t.roles
> Date: Wed, 25 May 2011 17:26:09 +0800
> 
> When expanding user_datum_t.roles role_set_t, the policydb_t of
> the out module should be passed rather than that of the base module!
> 
> Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
> ---
>  libsepol/src/expand.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index da084ec..3308c3f 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -977,7 +977,7 @@ static int user_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
>  	ebitmap_init(&tmp_union);
>  
>  	/* get global roles for this user */
> -	if (role_set_expand(&user->roles, &tmp_union, state->base, state->rolemap)) {
> +	if (role_set_expand(&user->roles, &tmp_union, state->out, state->rolemap)) {
>  		ERR(state->handle, "Out of memory!");
>  		ebitmap_destroy(&tmp_union);
>  		return -1;
> -- 
> 1.7.0.4
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_2bbb2527-2a1e-4373-afe9-eade7371016c_
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
Please ignore this patch, I have integrated it in those patches to add role attribute support.<br><br>Thanks,<br>Harry<br><br>&gt; From: qingtao.cao@windriver.com<br>&gt; To: sds@tycho.nsa.gov; jmorris@namei.org; eparis@parisplace.org<br>&gt; CC: selinux@tycho.nsa.gov<br>&gt; Subject: [PATCH 1/1] Fix arguments when expanding user_datum_t.roles<br>&gt; Date: Wed, 25 May 2011 17:26:09 +0800<br>&gt; <br>&gt; When expanding user_datum_t.roles role_set_t, the policydb_t of<br>&gt; the out module should be passed rather than that of the base module!<br>&gt; <br>&gt; Signed-off-by: Harry Ciao &lt;qingtao.cao@windriver.com&gt;<br>&gt; ---<br>&gt;  libsepol/src/expand.c |    2 +-<br>&gt;  1 files changed, 1 insertions(+), 1 deletions(-)<br>&gt; <br>&gt; diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c<br>&gt; index da084ec..3308c3f 100644<br>&gt; --- a/libsepol/src/expand.c<br>&gt; +++ b/libsepol/src/expand.c<br>&gt; @@ -977,7 +977,7 @@ static int user_copy_callback(hashtab!
 _key_t key, hashtab_datum_t datum,<br>&gt;  	ebitmap_init(&amp;tmp_union);<br>&gt;  <br>&gt;  	/* get global roles for this user */<br>&gt; -	if (role_set_expand(&amp;user-&gt;roles, &amp;tmp_union, state-&gt;base, state-&gt;rolemap)) {<br>&gt; +	if (role_set_expand(&amp;user-&gt;roles, &amp;tmp_union, state-&gt;out, state-&gt;rolemap)) {<br>&gt;  		ERR(state-&gt;handle, "Out of memory!");<br>&gt;  		ebitmap_destroy(&amp;tmp_union);<br>&gt;  		return -1;<br>&gt; -- <br>&gt; 1.7.0.4<br>&gt; <br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  </body>
</html>
--_2bbb2527-2a1e-4373-afe9-eade7371016c_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
