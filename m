Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j34JYdDo003183
	for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2005 15:34:39 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j34JTliu009015
	for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2005 19:29:54 GMT
Subject: Re: New Policy Patch
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: jwcart2@epoch.ncsc.mil, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <42518C8A.7040200@redhat.com>
References: <41E57081.4090500@redhat.com>
	 <1106339767.25125.31.camel@moss-lions.epoch.ncsc.mil>
	 <42518C8A.7040200@redhat.com>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 15:38:35 -0400
Message-Id: <1112643515.31122.3.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> +can_getsecurity(hald_t)

check_context was sufficient for me.. does it
need the rest of the things in can_getsecurity?

+# For /usr/libexec/hald-add-selinux-mount-option
+allow hald_t security_t:dir search;
+allow hald_t security_t:file { read write };
+allow hald_t security_t:security check_context;

> +# For /usr/sbin/dmidecode
> +# Violates assertion
> +#allow hald_t memory_device_t:chr_file read;
> +allow hald_t self:capability sys_rawio;

Hold on - this should go into its own domain for dmidecode...

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
