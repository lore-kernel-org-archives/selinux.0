Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94KtW5S000365
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 16:55:32 -0400
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94KsK5l010087
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 20:54:21 GMT
Date: Wed, 4 Oct 2006 15:55:27 -0500
From: Klaus Weidner <klaus@atsec.com>
To: Linda Knippers <linda.knippers@hp.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] enable/disable context translation in libselinux
Message-ID: <20061004205527.GA28525@w-m-p.com>
References: <4523E6D5.1040805@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4523E6D5.1040805@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 04, 2006 at 12:52:37PM -0400, Linda Knippers wrote:
> --- libselinux-1.30.28/src/setrans_client.c     2006-09-13 13:37:04.000000000 -0400
> +++ libselinux-1.30.28.ljk/src/setrans_client.c 2006-10-04 11:35:48.000000000 -0400
> @@ -17,6 +17,7 @@
>  #include "setrans_internal.h"
> 
>  static int mls_enabled = -1;
> +static int trans_enabled = 1;
[...]
> +void selinux_set_translation (int value)
> +{
> +       trans_enabled = value;
> +       return;
> +}

This is unsafe for multithreading - mls_enabled won't change during the
lifetime of a process, but it could cause strange results when a thread
toggling translation affects the results returned by another thread.

Does anyone care? Alternatively, should the interface offer a translation
flag parameter, with a backwards compatible function that sets the
translation flag to "true"?

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
