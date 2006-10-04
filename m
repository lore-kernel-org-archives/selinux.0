Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94Kx7cN000481
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 16:59:07 -0400
Received: from atlrel6.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94KwVUx004620
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 20:58:31 GMT
Message-ID: <4524208A.7080500@hp.com>
Date: Wed, 04 Oct 2006 16:58:50 -0400
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: Klaus Weidner <klaus@atsec.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] enable/disable context translation in libselinux
References: <4523E6D5.1040805@hp.com> <20061004205527.GA28525@w-m-p.com>
In-Reply-To: <20061004205527.GA28525@w-m-p.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Klaus Weidner wrote:
> On Wed, Oct 04, 2006 at 12:52:37PM -0400, Linda Knippers wrote:
> 
>>--- libselinux-1.30.28/src/setrans_client.c     2006-09-13 13:37:04.000000000 -0400
>>+++ libselinux-1.30.28.ljk/src/setrans_client.c 2006-10-04 11:35:48.000000000 -0400
>>@@ -17,6 +17,7 @@
>> #include "setrans_internal.h"
>>
>> static int mls_enabled = -1;
>>+static int trans_enabled = 1;
> 
> [...]
> 
>>+void selinux_set_translation (int value)
>>+{
>>+       trans_enabled = value;
>>+       return;
>>+}
> 
> 
> This is unsafe for multithreading - mls_enabled won't change during the
> lifetime of a process, but it could cause strange results when a thread
> toggling translation affects the results returned by another thread.
> 
> Does anyone care? Alternatively, should the interface offer a translation
> flag parameter, with a backwards compatible function that sets the
> translation flag to "true"?
> 
> -Klaus

I think this whole thing is being reworked by Darrel so maybe you want
to wait until he posts something.

-- ljk

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
