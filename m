Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j03KkFIi019842
	for <selinux@tycho.nsa.gov>; Mon, 3 Jan 2005 15:46:15 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j03KiMFS022898
	for <selinux@tycho.nsa.gov>; Mon, 3 Jan 2005 20:44:22 GMT
Date: Mon, 3 Jan 2005 20:56:23 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: modules needed to be compiled in for selinux to work
Message-ID: <20050103205623.GE6631@lkcl.net>
References: <20050102104530.GG6142@lkcl.net> <1104760954.16598.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1104760954.16598.53.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jan 03, 2005 at 09:02:34AM -0500, Stephen Smalley wrote:
> On Sun, 2005-01-02 at 05:45, Luke Kenneth Casson Leighton wrote:
> > hi,
> > 
> > debian's 2.6.9 kernel has selinux - and capabilities - as modules.
> 
> SELinux cannot be built as a module.  

 mwwh?  i hadn't noticed.  four months and i hadn't noticed.  duh.

> > in other words, is CONFIG_CAPABILITY=m stopping selinux from
> > working in debian's 2.6.9 kernel?
> 
> No, it shouldn't be an issue.
 
 ah, then it's a non-selinux issue because udev (0.040 >)doesn't
 work properly without capability loaded.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
