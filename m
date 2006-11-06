Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA6KZRee012183
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 15:35:27 -0500
Received: from mail4.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA6KYgiG012070
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 20:34:43 GMT
Date: Mon, 6 Nov 2006 15:35:34 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Chad Sellers <csellers@tresys.com>
cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH 4/4] SELinux: validate kernel object classes and permissions
In-Reply-To: <20061106173950.246905998@tresys.com>>
Message-ID: <Pine.LNX.4.64.0611061533320.4553@d.namei>
References: <20061106173814.457967976@tresys.com>> <20061106173950.246905998@tresys.com>>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 6 Nov 2006, Chad Sellers wrote:

> +	/* Verify that the kernel defined classes are correct. */
> +	if (validate_classes(&newpolicydb)) {
> +		printk(KERN_ERR
> +		       "security:  the definition of a class is incorrect\n");
> +		rc = -EINVAL;

Anothe minor issue (not worth a resend) is that you should propagate the 
actual error from validate_classes() back to the caller.  Currently, the 
errors are all -EINVAL, which means this reassignment is superfluous, and 
may lead to problems if future changes to validate_classes() cause 
different errors to be returned.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
