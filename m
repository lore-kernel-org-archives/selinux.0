Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l34HO3hU019870
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2007 13:24:04 -0400
Received: from mail4.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l34HNx60009148
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2007 17:24:00 GMT
Date: Wed, 4 Apr 2007 13:23:57 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: James Carter <jwcart2@tycho.nsa.gov>
cc: SELinux <selinux@tycho.nsa.gov>, Steve Smalley <sds@epoch.ncsc.mil>,
        Eric Paris <eparis@parisplace.org>, Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: [patch] selinux:  export initial SID contexts via selinuxfs (v2)
In-Reply-To: <1175695889.14463.13.camel@moss-lions.epoch.ncsc.mil>
Message-ID: <Line.LNX.4.64.0704041323340.25132@d.namei>
References: <1175695889.14463.13.camel@moss-lions.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 4 Apr 2007, James Carter wrote:

> Make the initial SID contexts accessible to userspace via selinuxfs.
> An initial use of this support will be to make the unlabeled context
> available to libselinux for use for invalidated userspace SIDs.
> 
> This version fixes the problem with the for loop that Steve pointed out,
> and changes the flow of security_get_initial_sid_context so that the if
> clause checks for the error condition and uses unlikely().
> 
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-akpm


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
