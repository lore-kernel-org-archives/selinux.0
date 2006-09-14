Subject: Re: Latest patch for policycoreutils, reworked from previous.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20060914201351.79586.qmail@web51501.mail.yahoo.com>
References: <20060914201351.79586.qmail@web51501.mail.yahoo.com>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 16:25:16 -0400
Message-Id: <1158265516.25629.235.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-14 at 13:13 -0700, Steve G wrote:
> >The -v output seems to be a superset of the -o output.  So why do you
> >need them to be run simultaneously and fed to two separate streams?
> 
> What I was wanting out of all this is a way to collect just the full path of
> files that have a labelling problem and nothing else. If you send it to a file,
> you get avcs.

Sure, so why can't you use -o - (with this patch) but not pass -v,
thereby avoiding the need to change -v handling altogether?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
