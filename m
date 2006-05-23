Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4NMFMwp025890
	for <selinux@tycho.nsa.gov>; Tue, 23 May 2006 18:15:22 -0400
Received: from mail8.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4NMFL9T020954
	for <selinux@tycho.nsa.gov>; Tue, 23 May 2006 22:15:21 GMT
Date: Tue, 23 May 2006 18:15:18 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Michael D Lemay <mdlemay2@cs.uiuc.edu>
cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] keys: Kernel access key retention support for SELinux
In-Reply-To: <9FD2C54661D3494AB6F269E0D4A74E83894570@DSBEXCLUSTER.ad.uiuc.edu>
Message-ID: <Pine.LNX.4.64.0605231759580.4091@d.namei>
References: <9FD2C54661D3494AB6F269E0D4A74E83894570@DSBEXCLUSTER.ad.uiuc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

You should run this by David Howells to make sure it's covering 
everything correctly.

There are many coding style violations and inconsistencies.

Please include a diffstat next time.

> + * Produce a formatted explanation of a key permission value
> + */
> +void key_perm_expn (key_perm_t pm, char * buf) {
> +  buf[0] = '\0';
> +  if (pm & KEY_VIEW) {
> +    strcat(buf, "view,");

You don't need to copy this data around all the time, just return pointers 
to the strings.

> +	/* no permissions requested, don't need to consult LSM */
> +	if (perm == 0)
> +	  return 0;

You've added code to the kernel which is now unconditionally called even 
if CONFIG_SECURITY=n.  Let the LSM do this.

> -/* Check permission betweeen a pair of tasks, e.g. signal checks,
> +/* Check permission between a pair of tasks, e.g. signal checks,

Don't fix spelling mistakes (or anything cosmetic) in existing code 
while adding new code.  

> +
> +	rc = secondary_ops->key_permission(key_ref, ctx, perm);

You don't need to add a secondary ops call unless the capability LSM has a 
hook defined for the permission.

> +#define RETAINED_KEY__VIEW                        0x00000001UL

> +    S_("retained_key")

This naming is ugly, just call it 'key', which is what the key subsystem 
does.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
