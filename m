Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k19FArXf024442
	for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2006 10:10:53 -0500 (EST)
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k19FAoL4006280
	for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2006 15:10:50 GMT
Message-ID: <43EB5B58.4070005@trustedcs.com>
Date: Thu, 09 Feb 2006 09:10:16 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: James Morris <jmorris@redhat.com>
CC: "Timothy R. Chavez" <tinytim@us.ibm.com>,
   Linux Audit Discussion <linux-audit@redhat.com>,
   James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH] collect security labels on user processes generating
 audit messages
References: <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Wed, 8 Feb 2006, Timothy R. Chavez wrote:
> 
> 
>>1) A new SELinux interface was introduced to give other parts of the
>>kernel the ability to resolve 'sids' into security labels.  
> 
> 
> Please look at the way I intend to export SELinux APIs in:
> http://people.redhat.com/jmorris/selinux/skfilter/kernel/12-skfilter-selinux-exports.patch

This looks good.  I'm also working on some interfaces to export from selinux to
enable efficient audit selection based on SELinux context and I was contemplating
on exactly where to put the goods.  Can we get a consensus on declaration/definition
locations?  "include/linux/selinux.h" and "security/selinux/exports.c" seem good to me.

--

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
