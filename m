Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0BM7PXf001272
	for <selinux@tycho.nsa.gov>; Wed, 11 Jan 2006 17:07:26 -0500 (EST)
Received: from e33.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0BM6Jm0008523
	for <selinux@tycho.nsa.gov>; Wed, 11 Jan 2006 22:06:20 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k0BM7OfR028863
	for <selinux@tycho.nsa.gov>; Wed, 11 Jan 2006 17:07:24 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k0BM5uCb269364
	for <selinux@tycho.nsa.gov>; Wed, 11 Jan 2006 15:05:56 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k0BM7Exm001807
	for <selinux@tycho.nsa.gov>; Wed, 11 Jan 2006 15:07:14 -0700
Received: from sergelap.hallyn.com (sig-9-65-123-242.mts.ibm.com [9.65.123.242])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id k0BM7EBZ001769
	for <selinux@tycho.nsa.gov>; Wed, 11 Jan 2006 15:07:14 -0700
Date: Wed, 11 Jan 2006 16:07:13 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] sereference: enable local login
Message-ID: <20060111220713.GA30908@sergelap.austin.ibm.com>
References: <20060111213646.GA30428@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060111213646.GA30428@sergelap.austin.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Serge E. Hallyn (serue@us.ibm.com):
> Following is a patch which allows me to log in locally on a gentoo
> system with the reference policy.

Well ok, I lied, I do seem to also have to play games with a
custom homedir_template, but I assume that's something that
will be eventually fixed independent of me?   :)

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
