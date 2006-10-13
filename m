Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9DJhTfE012930
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 15:43:29 -0400
Received: from web36612.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k9DJgA2X010253
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 19:42:11 GMT
Message-ID: <20061013194330.72618.qmail@web36612.mail.mud.yahoo.com>
Date: Fri, 13 Oct 2006 12:43:29 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: context_sensitivity_{get|set}
To: selinux@tycho.nsa.gov
In-Reply-To: <1160765234.14346.138.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Stephen Smalley <sds@tycho.nsa.gov> wrote:


> No, usage is decidedly mixed.  "Security level" is
> often used to mean
> the entire label, while "sensitivity" is often used
> to mean the
> hierarchical component only (and this fits more with
> the natural
> language meaning of sensitivity).  Look around a
> bit.

Bah. (waves paw).

> In any event, in SELinux, each context has a MLS
> range consisting of a
> low level and a high level (reduced to a single
> level when they are
> equal), and each level consists of a sensitivity
> value and an optional
> category set.

Then your use of the terms is inconsistant
with historical practice and will contribute
to the overall confusion.

Kids.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
