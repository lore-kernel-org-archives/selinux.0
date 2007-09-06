Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l86JN0he017787
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 15:23:00 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l86JMxOd026827
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 19:22:59 GMT
Subject: Re: [refpolicy] terminal.if patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <C1E2C57A-C33B-42DC-9544-06CAAA6AAA35@sf-net.com>
References: <C1E2C57A-C33B-42DC-9544-06CAAA6AAA35@sf-net.com>
Content-Type: text/plain
Date: Thu, 06 Sep 2007 15:21:40 -0400
Message-Id: <1189106500.3664.42.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-09-04 at 13:19 -0400, Stefan Schulze Frielinghaus wrote:
> This patch adds an interface like term_write_all_user_ttys but this 
> time for ptys

Merged; moved it up a few lines.
> 
> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (terminal.if.patch), "terminal.if.patch"
> 
> --- /usr/src/refpolicy-20070629/policy/modules/kernel/terminal.if       2007-06-12 15:06:13.000000000 +0200
> +++ policy/modules/kernel/terminal.if   2007-09-04 17:52:13.000000000
> +0200
> @@ -755,6 +755,25 @@
>  ')
>  
>  ########################################
> +### <summary>
> +###      Write to all user ptys.
> +### </summary>
> +### <param name="domain">
> +###      <summary>
> +###      Domain allowed access.
> +###      </summary>
> +### </param>
> +##
> +interface(`term_write_all_user_ptys',`
> +       gen_require(`
> +               attribute ptynode;
> +       ')
> +
> +       dev_list_all_dev_nodes($1)
> +       allow $1 ptynode:chr_file write_chr_file_perms;
> +')
> +
> +########################################
>  ## <summary>
>  ##     Get the attributes of all unallocated
>  ##     tty device nodes.
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
