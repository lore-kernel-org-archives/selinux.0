Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1ALoEL9014924
	for <selinux@tycho.nsa.gov>; Thu, 10 Feb 2005 16:50:14 -0500 (EST)
Subject: Re: Rewrite of genhomedircon
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <420BC588.4@redhat.com>
References: <420BC588.4@redhat.com>
Content-Type: text/plain
Message-Id: <1108071785.22172.270.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 10 Feb 2005 16:43:05 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-02-10 at 15:35, Daniel J Walsh wrote:
> genhomedircon will generate only one HOME_ROOT based off the location in 
> the /etc/default/useradd.

Is this limitation (to a single HOME_ROOT) going to be a problem in
practice?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
