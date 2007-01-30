Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0U2kSbJ009542
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 21:46:28 -0500
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0U2lTME003397
	for <selinux@tycho.nsa.gov>; Tue, 30 Jan 2007 02:47:30 GMT
Date: Mon, 29 Jan 2007 20:47:21 -0600
From: Klaus Weidner <klaus@atsec.com>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: redhat-lspp@redhat.com, dwalsh@redhat.com, Tomas Mraz <tmraz@redhat.com>,
        selinux@tycho.nsa.gov
Subject: Re: [redhat-lspp] Problem SSH-ing into LSPP system with multiple categories
Message-ID: <20070130024721.GA6671@w-m-p.com>
References: <1169842300.6956.129.camel@localhost.localdomain> <1169843274.3194.10.camel@perun.kabelta.loc> <1169844884.6956.132.camel@localhost.localdomain> <20070129174214.GA9224@w-m-p.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070129174214.GA9224@w-m-p.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jan 29, 2007 at 11:42:15AM -0600, Klaus Weidner wrote:
> On Fri, Jan 26, 2007 at 12:54:44PM -0800, Kylene Jo Hall wrote:
> > More test data:
> > 
> > ssh testuer/user_r/s#:c0,c1@localhost works for every value of # between
> > 0 and 15 except 2.
> 
> I can reproduce this, and it appears to be related to label translations.

I've posted a bug:

	https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=225355

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
