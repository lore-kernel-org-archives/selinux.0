Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k86F2pj8011249
	for <selinux@tycho.nsa.gov>; Wed, 6 Sep 2006 11:02:51 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k86F25jo003506
	for <selinux@tycho.nsa.gov>; Wed, 6 Sep 2006 15:02:06 GMT
Message-ID: <44FEE306.1060404@trustedcs.com>
Date: Wed, 06 Sep 2006 10:02:30 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: LC Bruzenak <lenny@bruzenak.com>
CC: selinux@tycho.nsa.gov
Subject: Re: mls policy problem
References: <1157481701.4164.13.camel@fryspc>
In-Reply-To: <1157481701.4164.13.camel@fryspc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

LC Bruzenak wrote:
> Trying to yum install the selinux-policy-mls policy I get:
>   
> Installing: selinux-policy-mls           ######################### [1/1]
> libsepol.sepol_module_package_read: unknown magic number at section 4,
> offset: a2ba9e, number: 159186835x
> /var/tmp/rpm-tmp.90280: line 4:  2833 Segmentation fault      semodule -
> b base.pp -s mls
> 
> # uname -a:
> 
> Linux ibm 2.6.17-1.2614.fc6 #1 SMP Sun Sep 3 15:16:56 EDT 2006 x86_64
> x86_64 x86_64 GNU/Linux
> 
> Let me know what info I should send; didn't want to overload the first
> plea for help.

rpm versions for yum, libsepol, policycoreutils, and the policy packages
that you are trying to install would be helpful.

Was this a first install of the package, or an upgrade?

I have been updating daily with the Fedora Core development repositories and
have yet to see anything like this.  Have you tried again (with the newer
packages available)?

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
