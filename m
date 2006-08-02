Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k72ECWZP029256
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 10:12:32 -0400
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k72ECPeA001156
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 14:12:26 GMT
Subject: Re: [PATCH 3/6] netfilter integration take 2: module store support
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1154457789.31522.149.camel@sgc.columbia.tresys.com>
References: <1154457789.31522.149.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 10:12:27 -0400
Message-Id: <1154527947.27457.52.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-01 at 14:43 -0400, Christopher J. PeBenito wrote:

<snip>

>  
> +		/* Netfilter Contexts */
> +		/* Write the contexts to a single file.  The buffer returned by
> +		 * the sort function has a trailing \0 character, which we do
> +		 * NOT want to write out to disk, so we pass sorted_fc_buffer_len-1. */
> +		ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_NC);
> +		if (ofilename == NULL)
> +			goto cleanup;
> +
> +		if (write_file
> +		    (sh, ofilename, sorted_nc_buffer,
> +		     sorted_nc_buffer_len - 1) < 0)
> +			goto cleanup;
> +

I know that this is lindent, but if you would use a variable for the
return code and check the variable it wouldn't mangle the formatting
like this. This is very difficult to parse.

<snip>

Otherwise fine.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
