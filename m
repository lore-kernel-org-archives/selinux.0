Subject: Re: Modifications to the local.users file
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <420BD28E.6090006@redhat.com>
References: <420BD28E.6090006@redhat.com>
Content-Type: text/plain
Message-Id: <1108070964.22172.265.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 10 Feb 2005 16:29:25 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-02-10 at 16:30, Daniel J Walsh wrote:
> You made changes to the local.users file to no longer run m4 on it. 
> We were doing that to get the ifdef(direct_sysadm_daemon) comment right
> I think you need these comments for the user to have an idea of how to 
> configure this
> file.

Applying m4 to it (with the tunables and program used flags) made it
unreadable.  If you like, we can just directly put in a comment that
gives examples, but I don't think we want to run this file through m4 if
we expect users to edit it.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
