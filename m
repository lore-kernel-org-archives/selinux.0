Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id BAA24676
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 01:43:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id FAA11780
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 05:41:57 GMT
Received: from mail.lemuria.org ([213.191.74.130])
	by jazzswing.ncsc.mil  with ESMTP id FAA11771
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 05:41:55 GMT
Received: from unicorn.lemuria.org (b067114.adsl.hansenet.de [62.109.67.114])
	by mail.lemuria.org (Postfix) with ESMTP id 1D049BB8B
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 07:37:05 +0200 (CEST)
Date: Tue, 23 Apr 2002 07:40:55 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: boot loader
Message-ID: <20020423074055.B14880@lemuria.org>
References: <20020422220826.EF5F645C95@lyta.coker.com.au> <Pine.GSO.4.33.0204221825010.5657-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0204221825010.5657-100000@raven>; from sds@tislabs.com on Mon, Apr 22, 2002 at 06:27:54PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Apr 22, 2002 at 06:27:54PM -0400, Stephen Smalley wrote:
> There is one other potential issue.  If an administrator directly edits
> /etc/lilo.conf, it will revert to etc_t (and become inaccessible to lilo
> unless it is then relabeled by the administrator).  Is there any strong
> reason to maintain a separate type on this file?  It is problematic to
> keep it in a separate type from other /etc files, since it may be directly
> modified by the administrator and it doesn't live in its own separate
> subdirectory.

It may be more tricky even. I'm thinking about split administrator access 
here. Say you have one network and one system admin. Network admin needs 
to access stuff in /etc (such as interface configs, maybe some or all 
network daemons, depending on where authorities are split) while system 
admin needs access to other /etc files (cron and startup files, among 
others).


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
