Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6GFDSrT029871
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 11:13:29 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6GFD4bx017106
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 15:13:04 GMT
Subject: Re: SELinux Policy patches
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Erich Schubert <erich@debian.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20040716115729.GC25607@legolas.drinsama.de>
References: <20040716002210.GA1081@wintermute.xmldesign.de>
	 <20040716115729.GC25607@legolas.drinsama.de>
Content-Type: text/plain
Message-Id: <1089990799.9566.75.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 16 Jul 2004 11:13:19 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-07-16 at 07:57, Erich Schubert wrote:
> > allow nsupdate_t self:netlink_socket create_socket_perms;
> 
> Maybe due to changes from policy 17 to 18 this could be
> "netlink_route_socket" by now. Was this class split?

Yes.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
