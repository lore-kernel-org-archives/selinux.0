Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA3M4LQ5008818
	for <selinux@tycho.nsa.gov>; Fri, 3 Nov 2006 17:04:21 -0500
Received: from mail5.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA3M2kIN007985
	for <selinux@tycho.nsa.gov>; Fri, 3 Nov 2006 22:02:47 GMT
Date: Fri, 3 Nov 2006 17:04:24 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Chad Sellers <csellers@tresys.com>
cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH 4/4] SELinux: validate kernel object classes and permissions
In-Reply-To: <20061103203430.759007300@tresys.com>>
Message-ID: <Pine.LNX.4.64.0611031703220.12217@d.namei>
References: <20061103203354.331494899@tresys.com>> <20061103203430.759007300@tresys.com>>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 3 Nov 2006, Chad Sellers wrote:

> +	for (i = 0; i < defined_classes_perms.av_perm_to_string_len; i++) {
> +		if (defined_classes_perms.av_perm_to_string[i].tclass > p->p_classes.nprim)
> +			continue;
> +		cladatum = hashtab_search(p->p_classes.table,
> +		                          p->p_class_val_to_name[defined_classes_perms.av_perm_to_string[i].tclass-1]);

These lines are too long.  Limit is 80 characters for the function body.

See Documentation/CodingStyle




- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
