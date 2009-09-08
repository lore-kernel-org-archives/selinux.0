Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n88E9oqp023082
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 10:09:50 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n88E9C8j005393
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 14:09:12 GMT
Subject: Re: [policy] post a message to logged in users
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1252245920.20898.12.camel@vogon.seekline.net>
References: <1252180244.2707.6.camel@vogon.seekline.net>
	 <1252245920.20898.12.camel@vogon.seekline.net>
Content-Type: text/plain
Date: Tue, 08 Sep 2009 10:09:21 -0400
Message-Id: <1252418961.17700.14.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2009-09-06 at 16:05 +0200, Stefan Schulze Frielinghaus wrote:
> On Sat, 2009-09-05 at 21:50 +0200, Stefan Schulze Frielinghaus wrote:
> > is there an interface available to post a message to every logged in
> > user, for example generated via /usr/bin/wall?
> 
> OK I'm pretty sure there is no interface for just writing to every
> logged in user, the attached patch solves this.
> I could use the "term_use_all_terms" interface but this is not really
> what I wanted because /usr/bin/wall does not need to read all the
> consoles/ptys/ttys. Write access is enough.
> 
> Chris, is this patch OK?

Yes.  Merged.

> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (terminal.if.patch)
> 
> --- kernel/terminal.if  2009-09-06 15:04:36.000000000 +0200
> +++ kernel/terminal.if  2009-09-06 15:09:19.000000000 +0200
> @@ -178,6 +178,29 @@
>  
>  ########################################
>  ## <summary>
> +##      Write the console, all
> +##      ttys and all ptys.
> +## </summary>
> +## <param name="domain">
> +##      <summary>
> +##      Domain allowed access.
> +##      </summary>
> +## </param>
> +## <rolecap/>
> +#
> +interface(`term_write_all_terms',`
> +       gen_require(`
> +               attribute ttynode, ptynode;
> +               type console_device_t, devpts_t, tty_device_t;
> +       ')
> +
> +       dev_list_all_dev_nodes($1)
> +       allow $1 devpts_t:dir list_dir_perms;
> +       allow $1 { console_device_t tty_device_t ttynode ptynode }:chr_file write_chr_file_perms;
> +')
> +
> +########################################
> +## <summary>
>  ##     Write to the console.
>  ## </summary>
>  ## <param name="domain">
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
