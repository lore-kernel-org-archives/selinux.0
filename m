Subject: Re: build fixes for selinux-doc-1.18
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andreas Steinmetz <ast@domdv.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <42512DC5.8060102@domdv.de>
References: <42512DC5.8060102@domdv.de>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 16:12:50 -0400
Message-Id: <1112645570.7629.183.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-04-04 at 14:06 +0200, Andreas Steinmetz wrote:
> 1. added simple top level Makefile
> 2. replaced db2html with docbook2html as db2html is not part of
>    docbook-utils but seems to be created by some distro only

Hmmm...well, db2html appears to create a separate directory for the
output files, and copies stylesheet images into it as well.  The use of
db2html was patterned after its use in the kernel
Documentation/DocBook/Makefile.  Hence, I'm hesitant to merge the latter
change without further justification.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
