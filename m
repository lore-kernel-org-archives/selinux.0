Subject: Re: minor structure usage bug
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chad Hanson <chanson@tcs-sec.com>
Cc: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <36282A1733C57546BE392885C0618592080BFA@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C0618592080BFA@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Message-Id: <1080739457.22514.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 31 Mar 2004 08:24:17 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-03-30 at 15:56, Chad Hanson wrote:
> We found the sk_free_security() function incorrectly types ssec to a
> task_security_struct instead of sk_security_struct. This has no current
> impact as the magic element is the top of each structure.

Thanks.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
