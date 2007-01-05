Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l053WOxo001127
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 22:32:24 -0500
Received: from mail.atsec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l053XAdp018210
	for <selinux@tycho.nsa.gov>; Fri, 5 Jan 2007 03:33:10 GMT
Date: Thu, 4 Jan 2007 21:33:11 -0600
From: Klaus Weidner <klaus@atsec.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: James Antill <jantill@redhat.com>, Linda Knippers <linda.knippers@hp.com>,
        redhat-lspp <redhat-lspp@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [redhat-lspp] Re: [PATCH 2/3] Re: MLS enforcing PTYs, sshd,	and newrole
Message-ID: <20070105033311.GA24315@w-m-p.com>
References: <1162310652.31104.46.camel@code.and.org> <1162311675.32614.81.camel@moss-spartans.epoch.ncsc.mil> <1162319582.23631.1.camel@code.and.org> <1162384603.32614.163.camel@moss-spartans.epoch.ncsc.mil> <459D72EF.3090707@redhat.com> <459D784C.4090806@hp.com> <459D7D56.1070503@redhat.com> <459D8B71.6060306@hp.com> <20070105010706.GA17478@w-m-p.com> <459DC095.5020001@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <459DC095.5020001@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jan 04, 2007 at 10:05:57PM -0500, Joshua Brindle wrote:
> Hardcoding types into code makes it inflexible to policy changes, this 
> is a bad idea IMO, the tty whitelist, however, is probably the way to 
> go. I don't know if we should use the existing /etc/securetty or  add 
> our own file though.

I'm not sure if the existing /etc/securetty is the right one, since
people may make serial terminals available to users but would not want
direct root login on those. Well, maybe not terribly likely these days.

Instead of hardcoded types, how about a configurable type or a
/etc/securettytypes file that contains the types instead of tty names?

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
