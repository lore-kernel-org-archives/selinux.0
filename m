Subject: Re: What policy is the system running?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Steve G <linux_4ever@yahoo.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <20041103185116.24681.qmail@web50606.mail.yahoo.com>
References: <20041103185116.24681.qmail@web50606.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1099510701.1213.200.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 03 Nov 2004 14:38:21 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-03 at 13:51, Steve G wrote:
> >This would be case for setting boolean states on policy load, correct?
> 
> I made a typo in my reply..I meant overwrite what's on disk. Sorry.

I think the in-memory modification of the policy for the boolean
settings is the larger concern, as it means that the binary policy seen
by the kernel may not match any file on disk, not even the one that was
"loaded".

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
