Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4BDSURb021586
	for <selinux@tycho.nsa.gov>; Tue, 11 May 2004 09:28:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4BDSOYW015437
	for <selinux@tycho.nsa.gov>; Tue, 11 May 2004 13:28:24 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4BDSOBf015434 for <selinux@tycho.nsa.gov>; Tue, 11 May 2004 13:28:24 GMT
Subject: Re: selopt  &   dsi
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: =?UTF-8?Q?=E6=9D=8E=E4=B8=BD?= =?UTF-8?Q?=E8=90=8D?= <llp@ercist.iscas.ac.cn>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <hoic78cgsptv81w.110520041038@ercist.iscas.ac.cn>
References: <hoic78cgsptv81w.110520041038@ercist.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1084282090.7460.74.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 11 May 2004 09:28:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-05-10 at 22:36, 李丽萍 wrote:
> Is there any working still continue to develop SeLopt on distributed network area?

Selopt was dropped when SELinux was reworked for inclusion into the
mainline Linux 2.6 kernel, since the sk_buff security field and hooks
and IP security hooks were not accepted into the mainline kernel.  Our
plan is to investigate the use of the native 2.6 IPSEC implementation
for implicit labeling of packets based on security association in the
future, but we aren't likely to start working on that until the fall
(unless someone else gets to it first).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
