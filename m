Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9JDc9FU004767
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 09:38:09 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9JDbQwO024249
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 13:37:26 GMT
From: Steve Grubb <sgrubb@redhat.com>
To: redhat-lspp@redhat.com
Subject: Re: [redhat-lspp] Re: MLS enforcing PTYs, sshd, and newrole
Date: Thu, 19 Oct 2006 09:32:11 -0400
Cc: Daniel J Walsh <dwalsh@redhat.com>, casey@schaufler-ca.com,
        russell@coker.com.au, selinux@tycho.nsa.gov
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com> <45377BF0.6010403@redhat.com>
In-Reply-To: <45377BF0.6010403@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610190932.12006.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 19 October 2006 09:21, Daniel J Walsh wrote:
> If we then remove -l from newrole we are done?

And would doing this also mean we do not need to add pam_namespace to newrole?

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
