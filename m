Subject: Re: [PATCH] checkpolicy - nodecon ordering
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>,
   Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <36282A1733C57546BE392885C06185924D8EEF@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C06185924D8EEF@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Message-Id: <1099682019.6373.240.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 05 Nov 2004 14:13:39 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-10-29 at 10:07, Chad Hanson wrote:
> I have created a patch which orders nodecon rules from most specific to
> least specific.  We think this functionality can be useful for ease of
> administration and to protect against accidental misconfiguration.

Thanks, a simplified version of this patch has been committed, available
in sourceforge CVS.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
