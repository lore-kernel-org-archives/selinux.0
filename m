Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j36CQPDo016759
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 08:26:25 -0400 (EDT)
Subject: Re: More patches
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4253CD52.1090206@redhat.com>
References: <200502032350.40924.russell@coker.com.au>
	 <1108048794.10328.14.camel@moss-lions.epoch.ncsc.mil>
	 <4253CD52.1090206@redhat.com>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 08:25:17 -0400
Message-Id: <1112790317.4187.1.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-04-06 at 07:51 -0400, Daniel J Walsh wrote:
> Ivan has some more cleanup of x_client apps.
> Also added execmod to httpd for php
> Moved +r_dir_file(httpd_t, httpd_$1_content_t) outside boolean
> so you should be able to serve pages with httpd with all booleans turned 
> off.
> 
> You are missing NetworkManager from your latest pool, even though 
> comment says it is there.

Forgot to cvs add it on sourceforge.  It is committed now.


-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
