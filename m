Subject: Re: Change fixfiles to use file_context.local if it exists.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41F5332C.3050604@redhat.com>
References: <41F521F0.7090108@redhat.com>
	 <1106584190.19246.72.camel@moss-spartans.epoch.ncsc.mil>
	 <41F5332C.3050604@redhat.com>
Content-Type: text/plain
Message-Id: <1106679132.21318.269.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 25 Jan 2005 13:52:12 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-01-24 at 12:41, Daniel J Walsh wrote:
> Ah good point, change to
> 
> /etc/selinux/${SELINUXTYPE}/contexts/files

Thanks, merged into sourceforge CVS as of policycoreutils 1.21.4.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
