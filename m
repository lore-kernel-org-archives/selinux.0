Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA23528
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 10:50:56 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id PAA19169
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 15:49:43 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id PAA19165
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 15:49:42 GMT
Received: from localhost by clipper.gw.tislabs.com (8.9.3/8.9.1) with SMTP id KAA28450
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 10:49:54 -0500 (EST)
Date: Tue, 26 Dec 2000 10:49:53 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: selinux@tycho.nsa.gov
Subject: Re: buffer overflow in libsecure/get_default_type.c
In-Reply-To: <200012260622.BAA14166@theta.bos.bindview.com>
Message-ID: <Pine.SOL.3.95.1001226103538.26114G-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


Thanks for finding and fixing this bug.  Our apologies for not
catching it ourselves.  

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com


On Tue, 26 Dec 2000, Matt Power wrote:

> In the slinux-200012181053-release.tgz distribution, the
> find_default_type function in libsecure/get_default_type.c attempts to
> extract a type field from the file /etc/security/default_type and copy
> it to a result buffer (specifically, to the argument "char **type").
> Memory for this result buffer is allocated using malloc, but the
> argument to malloc is always one character too small.
> 
> For example, the role argument might typically be "sysadm_r" and the
> len argument would then be 8. With the initial installation, the first
> value of buf would be "sysadm_r:sysadm_t\n". There are no leading
> spaces, so i is 0. In the statement
> 
>         (*type) = (char*) malloc (sizeof(char) * (strlen(buf)-i-len-1));
> 
> the argument to malloc is 18 - 0 - 8 - 1, which is 9. Then,
> 
>         strcpy ((*type), &buf[i]+len+1);
> 
> attempts to copy the 10 characters "sysadm_t\n\0" into the 9-character
> buffer.
> 
> This patch should address the issue:
> 
> *** get_default_type.c.old	Thu Nov 30 11:32:58 2000
> --- get_default_type.c	Tue Dec 26 00:19:04 2000
> ***************
> *** 72,74 ****
>           /* malloc space for the type */
> !         (*type) = (char*) malloc (sizeof(char) * (strlen(buf)-i-len-1));
>           if ((*type) == NULL)
> --- 72,74 ----
>           /* malloc space for the type */
> !         (*type) = (char*) malloc (sizeof(char) * (strlen(buf)-i-len));
>           if ((*type) == NULL)
> 
> Matt Power
> BindView Corporation, RAZOR Team
> mhpower@bos.bindview.com
> 
> 
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
