Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0THfPaN021035
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 12:41:25 -0500
Received: from mail.atsec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0THgQUJ022623
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 17:42:27 GMT
Date: Mon, 29 Jan 2007 11:42:15 -0600
From: Klaus Weidner <klaus@atsec.com>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: Tomas Mraz <tmraz@redhat.com>, redhat-lspp@redhat.com, dwalsh@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: [redhat-lspp] Problem SSH-ing into LSPP system with multiple categories
Message-ID: <20070129174214.GA9224@w-m-p.com>
References: <1169842300.6956.129.camel@localhost.localdomain> <1169843274.3194.10.camel@perun.kabelta.loc> <1169844884.6956.132.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1169844884.6956.132.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jan 26, 2007 at 12:54:44PM -0800, Kylene Jo Hall wrote:
> More test data:
> 
> ssh testuer/user_r/s#:c0,c1@localhost works for every value of # between
> 0 and 15 except 2.

I can reproduce this, and it appears to be related to label translations.

This is in the /etc/selinux/mls/setrans.conf file:

	# Secret level with compartments
	s2=Secret
	s2:c0=A
	s2:c1=B

Commenting out these entries makes login work again.

Failed login:

type=USER_ROLE_CHANGE msg=audit(1170092360.977:951): user pid=2498 uid=0 auid=4294967295 subj=system_u:system_r:sshd_t:s0-s15:c0.c1023 msg='sshd: default-context=staff_u:staff_r:staff_t:s0-s15:c0.c1023 selected-context=staff_u:staff_r:staff_t:Secret:A,B: exe="/usr/sbin/sshd" (hostname=?, addr=?, terminal=? res=failed)'

Successful login (translation commented out):

type=USER_ROLE_CHANGE msg=audit(1170092403.742:991): user pid=2553 uid=0 auid=4294967295 subj=system_u:system_r:sshd_t:s0-s15:c0.c1023 msg='sshd: default-context=staff_u:staff_r:staff_t:s0-s15:c0.c1023 selected-context=staff_u:staff_r:staff_t:s2:c0,c1: exe="/usr/sbin/sshd" (hostname=?, addr=?, terminal=? res=success)'

Is "Secret:A,B" correct syntax?

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
