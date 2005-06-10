Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5AICxgA021064
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 14:12:59 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5AI4t1O014736
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 18:04:56 GMT
Subject: Re: Restorecon script
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Steve G <linux_4ever@yahoo.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050610135235.35540.qmail@web51508.mail.yahoo.com>
References: <20050610135235.35540.qmail@web51508.mail.yahoo.com>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 14:04:48 -0400
Message-Id: <1118426689.3720.21.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-10 at 06:52 -0700, Steve G wrote:
> Hi,
> 
> >Creating folders ahead of time is the most acceptable solution so far.
> 
> What if the machine doesn't have X installed? (Such as a server.)

Then folders related to X have no need to be there.
That's unfortunate, but it is a simple solution for now.
The alternative would be to break up the directories we want
to create in different rpm packages, and then reassemble them
in a single call to restorecon (since we can't afford to call
restorecon for each app - it takes forever). 

> >I'm not sure how exactly this should be done, but some sort of simple 
> >script like this is one possibility. 
> 
> How about walking the list of dirs and if they exist, do a restorecon? I'm
> assuming this script is going to be called via /etc/bashrc?

One of the goals of this script is to create the directories
if they do not exist. If not, the applications themselves create them,
and create them with the wrong context.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
