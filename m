Message-ID: <3F3AD1D5.3000606@cpcug.org>
Date: Wed, 13 Aug 2003 20:03:33 -0400
From: James Griffin <agriffin@cpcug.org>
MIME-Version: 1.0
To: Joseph A Nagy Jr <joseph_a_nagy_jr@charter.net>
CC: "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
Subject: OT: Re: Linux Wipe Disk Utility
References: <E2462F68A99DB74D8AEDF13B261B1BDD02A69594@Larry.widevine.com> <200308131757.18235.joseph_a_nagy_jr@charter.net>
In-Reply-To: <200308131757.18235.joseph_a_nagy_jr@charter.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joseph A Nagy Jr wrote:
> <snip>
> 
> Unless I'm mistaken, files on ext3 have their inodes automatically 
> zeroed out upon file deletion. If this is the case, the above solutions 
> are entirely unneccessary (at least the linux ones).

You are correct about the ext3 inodes, but you are mistaken about the 
protection this offers.  google for the Sleuth Kit and Autopsy for 
information on file recovery tools.

This thread is getting off topic for the SELinux list.

> - -- 
[snip]


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
