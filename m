Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6OIMu6i000721
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 14:22:56 -0400
Received: from mail153.messagelabs.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m6OIMt0l019538
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 18:22:55 GMT
Received: from il27exr02.cig.mot.com (il27exr02.mot.com [10.17.196.71])
	by motgate3.mot.com (8.12.11/Motorola) with ESMTP id m6OIMraK016615
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 11:22:53 -0700 (MST)
Received: from az10vts02.mot.com (il27vts02.cig.mot.com [10.17.196.86])
	by il27exr02.cig.mot.com (8.13.1/Vontu) with SMTP id m6OIMrt3020784
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 13:22:53 -0500 (CDT)
Received: from de01exm68.ds.mot.com (de01exm68.am.mot.com [10.176.8.24])
	by il27exr02.cig.mot.com (8.13.1/8.13.0) with ESMTP id m6OIMqA9020778
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 13:22:53 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Mapping Linux GROUP to an SELinux user ?...
Date: Thu, 24 Jul 2008 14:22:51 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D04BF337D@de01exm68.ds.mot.com>
In-Reply-To: <1216898673.3881.4.camel@sulphur>
References: <48881546.6070903@ak.jp.nec.com> <1216898673.3881.4.camel@sulphur>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <stephen.smalley@gmail.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

Is there any way at all to map an entire Linux GROUP to an SELinux_user
??

For example if Linux User accounts (Admin1, Admin2, and Admin3), all
belong to the Linux group  "wadm".

Is there a simple or tricky way to map the entire Linux group    wadm ->
to staff_u ?

This way, any Linux user account that happens to be part of the "wadm"
group would automatically be mapped to staff_u  ? This way we don't have
to execute several semanage commands to create all those individual
mappings ?

Thanks as always.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
