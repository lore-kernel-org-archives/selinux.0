Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l77EgiUr030068
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 10:42:44 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l77EgcmT026193
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 14:42:38 GMT
Subject: Re: [PATCH] refpolicy: kernel_kernel changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022004.l72K4Ome029700@redsox.boston.devel.redhat.com>
References: <200708022004.l72K4Ome029700@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Tue, 07 Aug 2007 10:42:01 -0400
Message-Id: <1186497721.18881.27.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:04 -0400, dwalsh@redhat.com wrote:
> Additional interfaces for kernel access
> 
> @@ -1848,6 +1866,27 @@
> 
>  ########################################
>  ## <summary>
> +##     Read the process state (/proc/pid) of all unlabeled_t.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +#
> +interface(`kernel_read_unlabeled_state',`
> +       gen_require(`
> +               type unlabeled_t;
> +       ')
> +
> +       allow $1 unlabeled_t:dir list_dir_perms;
> +       read_files_pattern($1,unlabeled_t,unlabeled_t)
> +       read_lnk_files_pattern($1,unlabeled_t,unlabeled_t)
> +')

I'm concerned about this interface since unlabled_t is used for domains
and objects.  Someone using this interface might not realize the
specified domain can now also read other unlabeled files.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
