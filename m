Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAOK9GIi022545
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 15:09:16 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAOK7egi008880
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 20:07:41 GMT
Date: Wed, 24 Nov 2004 20:19:50 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Colin Walters <walters@verbum.org>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: xen 2.0 - adding selinux permissions
Message-ID: <20041124201950.GA15740@lkcl.net>
References: <20041123220352.GF5146@lkcl.net> <1101303556.22014.56.camel@moss-spartans.epoch.ncsc.mil> <20041124150927.GP5146@lkcl.net> <1101308769.22014.136.camel@moss-spartans.epoch.ncsc.mil> <20041124154936.GB14100@lkcl.net> <1101319995.30763.11.camel@nexus.verbum.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1101319995.30763.11.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Nov 24, 2004 at 01:13:15PM -0500, Colin Walters wrote:
> On Wed, 2004-11-24 at 15:49 +0000, Luke Kenneth Casson Leighton wrote:
> 
> >  okay, regarding the second argument to avc_has_perm(),
> >  i asked the nice xen developers if it'd be possible to
> >  associate a sid with each virtual machine.
> 
> When would you want a process to be able to control one Xen machine but
> not another?
 
 i described such a scenario in an earlier message today to stephen:
 giving an operator-admin the right to reboot a VM running a SQL server
 but NOT giving that same operator the right to reboot the master OS
 which, if you rebooted that, would take down every single VM with it.

 l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
