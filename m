Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8DNJqrT006818
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 19:19:52 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8DNJoSW003225
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 23:19:51 GMT
Date: Tue, 14 Sep 2004 00:31:02 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: James Carter <jwcart2@epoch.ncsc.mil>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy patch against latest CVS
Message-ID: <20040913233102.GC30524@lkcl.net>
References: <200409111954.15823.russell@coker.com.au> <1095106801.2161.19.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1095106801.2161.19.camel@moss-lions.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Sep 13, 2004 at 04:20:01PM -0400, James Carter wrote:
> Merged.
> 
> On Sat, 2004-09-11 at 05:54, Russell Coker wrote:
> > The attached patch adds the dev_fs attribute in a few places where it was 
> > missed before and uses the dev_fs attribute for tmpfs_t:filesystem associate.
> > 
> > It puts all the tmpfs /dev stuff inside distro_redhat because currently no 
> > other distribution seems to be even considering doing this sort of thing (the 
 
 is this tmpfs /dev in an initrd, or is this tmpfs /dev stuff in udev?

 because yes, my distro - debian-based - _is_ doing a tmpfs udev.

 and no it isn't doing tmpfs /dev in an initrd.

 i trust that that has been taken into account.

 thanks,

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
