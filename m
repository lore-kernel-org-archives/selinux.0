Subject: Re: Patch to restorecon to add -R switch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41584DCA.7030006@redhat.com>
References: <41584DCA.7030006@redhat.com>
Content-Type: text/plain
Message-Id: <1096904808.32008.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 04 Oct 2004 11:46:49 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-09-27 at 13:28, Daniel J Walsh wrote:
> This will allow us to
> 
> restorecon -R /dev in the initscripts.
> 
> Also patch adds some fixed for fixfiles.

So, how does this differ from just running setfiles on /dev instead?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
