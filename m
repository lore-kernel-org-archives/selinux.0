Message-ID: <526ECF62.6040007@tycho.nsa.gov>
Date: Mon, 28 Oct 2013 16:56:02 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: eparis@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 01/17] Do not return error if system is in permissive
 mode.
References: <526EBE56.6010901@redhat.com>
In-Reply-To: <526EBE56.6010901@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/28/2013 03:43 PM, Daniel J Walsh wrote:
> This is an updated patch with Steven's suggestions on making sure we audit bad
> data.
> 
>    This patch looks good to me. acked.

I applied my v1 patch instead as it ensured that we only do this if
security_compute_av* fails with EINVAL, not for any other case.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
