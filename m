Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7RHogcI023076
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 13:50:42 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7RHofQS018976
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 17:50:42 GMT
Subject: Re: [PATCH] refpolicy: services_sendmail changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022038.l72KcW6E032504@redsox.boston.devel.redhat.com>
References: <200708022038.l72KcW6E032504@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Mon, 27 Aug 2007 13:49:39 -0400
Message-Id: <1188236979.6723.27.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:38 -0400, dwalsh@redhat.com wrote:
> postfix sends signals to sendmail

Merged.  Fixed the xml.

> --- nsaserefpolicy/policy/modules/services/sendmail.if  2007-05-30 11:47:29.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/sendmail.if       2007-08-02 11:02:02.000000000 -0400
> @@ -131,3 +131,21 @@
> 
>         logging_log_filetrans($1,sendmail_log_t,file)
>  ')
> +
> +########################################
> +## <summary>
> +##f    allow domain to signal sendmail
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain to not audit.
> +##     </summary>
> +## </param>
> +#
> +interface(`sendmail_signal',`
> +       gen_require(`
> +               type sendmail_t;
> +       ')
> +       allow $1 sendmail_t:process signal;
> +')
> +
> 
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
