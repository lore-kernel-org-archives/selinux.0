Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n54LEL2k028149
	for <selinux@tycho.nsa.gov>; Thu, 4 Jun 2009 17:14:21 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n54LEdjE020398
	for <selinux@tycho.nsa.gov>; Thu, 4 Jun 2009 21:14:39 GMT
Date: Thu, 04 Jun 2009 17:14:20 -0400
Subject: Re: SELinux context patch
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C64DB16C.A7B20%csellers@tresys.com>
In-Reply-To: <4A11A5EC.9000904@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 5/18/09 2:16 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> This patch adds context files for virtual_domain and virtual_image,
> these are both being used to locat the default context to be executed by
> svirt.
> 
> I also included the subs patch which I submitted before.  This patch
> allows us to substitute prefixes to matchpathcon.
> 
> So we can say /export/home == /home
> 
> and
> 
> /web == /var/www

The only problem I see with the patch is:

+                       sub->dst=strdup(dst);
+                       if (! sub->dst) {
+                               free(sub);
+                               free(sub->src);
+                               return -1;
+                       }

the free()'s should be reversed in order. Other than that the patch looks
fine. I'll fix this in the merge.

Acked-by: Chad Sellers <csellers@tresys.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
