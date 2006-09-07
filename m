Subject: Re: IPC security context
From: Stephen Smalley <sds@tycho.nsa.gov>
To: andy.suchoski@comcast.net
Cc: selinux@tycho.nsa.gov
In-Reply-To: <090720061952.1961.4500787F000360CF000007A9220702155307059C01080C9A9CD2970B020E@comcast.net>
References: 
	 <090720061952.1961.4500787F000360CF000007A9220702155307059C01080C9A9CD2970B020E@comcast.net>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 16:13:01 -0400
Message-Id: <1157659981.22197.121.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-07 at 19:52 +0000, andy.suchoski@comcast.net wrote:
> Hello,
> 
> Is there any way to see the security context of semaphores, message queues and shared memory areas? I would have expected to see a "-Z" option on the ipcs command since this command reports DAC information.
> 
> Also, are there any library routines to access the security attributes of IPC objects?

Not presently, no.  That support was lost when the SELinux API had to be
overhauled for Linux 2.6.  To re-add, we would need a specific
application that required such support.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
