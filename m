Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0BE0C05028730
	for <selinux@tycho.nsa.gov>; Fri, 11 Jan 2008 09:00:12 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m0BE0BIP024781
	for <selinux@tycho.nsa.gov>; Fri, 11 Jan 2008 14:00:11 GMT
Subject: Re: [refpolicy patch] add setfcap to list of capabilities
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20080110163449.GA2738@sergelap.austin.ibm.com>
References: <20080110163449.GA2738@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 11 Jan 2008 08:58:41 -0500
Message-Id: <1200059921.21523.8.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-01-10 at 10:34 -0600, Serge E. Hallyn wrote:
> The setfcap capability is needed to be allowed to assign file
> capabilities.  Define the capability in access_vectors.
> 
> Of course I'll need to go through the modules and actually
> assign the capability to those where it makes sense, i.e.
> presumably admin/rpm.te...
> 
> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> ---
>  policy/flask/access_vectors |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/policy/flask/access_vectors b/policy/flask/access_vectors
> index c986778..45d9773 100644
> --- a/policy/flask/access_vectors
> +++ b/policy/flask/access_vectors
> @@ -381,6 +381,7 @@ class capability
>  	lease
>  	audit_write
>  	audit_control
> +	setfcap
>  }

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
