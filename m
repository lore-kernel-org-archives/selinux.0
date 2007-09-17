Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8HEkROs007501
	for <selinux@tycho.nsa.gov>; Mon, 17 Sep 2007 10:46:27 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l8HEkPwJ002008
	for <selinux@tycho.nsa.gov>; Mon, 17 Sep 2007 14:46:26 GMT
Subject: Re: [refpolicy] policy & patch for bitlbee
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Devin Carraway <selinux-list@devin.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <20070826224516.GA32414@atlantic.devin.com>
References: <20070819045707.GJ18641@atlantic.devin.com>
	 <46D00510.80608@redhat.com>  <20070826224516.GA32414@atlantic.devin.com>
Content-Type: text/plain
Date: Mon, 17 Sep 2007 14:44:48 +0000
Message-Id: <1190040288.17544.4.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-08-26 at 18:45 -0400, Devin Carraway wrote:
> On Sat, Aug 25, 2007 at 06:31:44AM -0400, Daniel J Walsh wrote:
> > So I would remove
> [...]
> > type bitlbee_share_t;
> > files_type(bitlbee_share_t)
> 
> After talking a bit about this on #selinux, I went ahead with your suggestion
> to remove bitlbee_share_t, and allow a usr_t read.  I kept bitlbee_conf_t,
> since it can have an authentication secret in it.
> 
> Here's an updated version.  It adds (and uses) an interface
> bitlbee_read_config() to permit reading bitlbee_conf_t.

Merged, with some reorganization.  Added an interface for tcp wrapper
services.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
