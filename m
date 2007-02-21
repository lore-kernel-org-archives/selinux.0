Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1LDaQZw008525
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 08:36:26 -0500
Received: from web51506.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l1LDbhMD021880
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 13:37:43 GMT
Message-ID: <20070221133743.85727.qmail@web51506.mail.yahoo.com>
Date: Wed, 21 Feb 2007 05:37:43 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: libselinux patch
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1172064015.14363.266.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>At present, libselinux dynamically determines where selinuxfs is mounted
>via /proc/mounts in init_selinuxmnt() and uses that path for all calls
>that operate on selinuxfs.

I guess that path could be used for statfs?

>Also, statfs'ing /selinux requires selinuxfs to already be mounted before
>you can call is_selinux_enabled(),

Is selinux really enabled if its not available for use (mounted)?

-Steve


 
____________________________________________________________________________________
It's here! Your new message!  
Get new email alerts with the free Yahoo! Toolbar.
http://tools.search.yahoo.com/toolbar/features/mail/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
