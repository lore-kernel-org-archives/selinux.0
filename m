Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OMM2rT001369
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 18:22:02 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OMLxCV021845
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 22:22:00 GMT
Date: Tue, 24 Aug 2004 23:33:13 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: kde 3.3's kdm creating /var/run/xdmctl
Message-ID: <20040824223313.GF12140@lkcl.net>
References: <20040823205404.GC7540@lkcl.net> <1093345329.1800.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1093345329.1800.2.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 24, 2004 at 07:02:09AM -0400, Stephen Smalley wrote:
> On Mon, 2004-08-23 at 16:54, Luke Kenneth Casson Leighton wrote:
> > also i find that on creation of this directory, its permission
> > is set to var_run_t not xdm_var_run_t.
> > 
> > i'm not entirely sure what to do.
> > 
> > at the moment as a preliminary measure i've added permissions
> > for xdm_t to create, access and delete sockets in both var_run_t
> > _and_ xdm_var_run_t in order to deal with the mess.
> 
> What creates the directory?  

 i believe it's kdm.

> If it is kdm itself, then extend the
> file_type_auto_trans(xdm_t, var_run_t, xdm_var_run_t, fifo_file) rule to
> also cover dir (replace fifo_file with { dir fifo_file}).

 okay, great, i'll try that out.

 *whew*, there's a possible solution.

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
