Subject: Re: problem about boot
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Nick <nagray@austin.rr.com>
Cc: Richard Herbert Wanner <richard.wanner@cgi.com>,
   SELINUX <SELinux@tycho.nsa.gov>
In-Reply-To: <1068839235.3058.731.camel@marquesas>
References: <376013375d87.375d87376013@wshs>
	 <1068839235.3058.731.camel@marquesas>
Content-Type: text/plain
Message-Id: <1068841563.18402.201.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 14 Nov 2003 15:26:03 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-11-14 at 14:47, Nick wrote:
> Why do I have to do this! I understand the mechanics of what is
> happening. I am just unclear as to why the SELinux kernel can't handle
> the label or why it doesn't install as /dev/hdxx or appropriate.

It isn't a kernel issue; it is an initrd issue.  You can boot with
root=LABEL=/ with SELinux if you are using an initrd.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
