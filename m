Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mALJf80v029333
	for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2008 14:41:09 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mALJf8MA006074
	for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2008 19:41:08 GMT
Message-ID: <49270ECE.4010300@redhat.com>
Date: Fri, 21 Nov 2008 14:41:02 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: erahul29@yahoo.com
CC: selinux@tycho.nsa.gov
Subject: Re: Problem Setting Policy To Enforcing Mode
References: <459507.37401.qm@web50206.mail.re2.yahoo.com>
In-Reply-To: <459507.37401.qm@web50206.mail.re2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rahul Jain wrote:
> Hi All,
>  
> This is the first time I am writing to this mailing list in hope of receiving help. I am trying to port reference policy by tresys on Montavista. I am able to run the policy well in permmisive mode with no avc messages in audit log, kern.log or messages. But when I put the policy into enforcing mode my system fails to boot, reason seems to be problem with init process. I am not able to debug the problem because no avc messages are generated for the same, probably because the issue comes up even before logging deamons start. Is there anyway I can debug my policy and log the avc messages from the very beginning of the system startup.
>  
> Rahul Jain
> Rahul Jain  
> 
> 
>       
AVC Messages should come to the screen.

Try semodule -DB to turn off dontaudit rules.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkknDs4ACgkQrlYvE4MpobMW1wCfXWKS0t678aMoumM3izMLMhEk
RPEAn25rhlfbw8Opq3FZymzRsUKsShFi
=DlJu
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
