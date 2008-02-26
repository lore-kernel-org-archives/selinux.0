Subject: Re: Problem compiling SELinux poilcy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: kihamba nengo <knengo@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <434750.73491.qm@web90405.mail.mud.yahoo.com>
References: <434750.73491.qm@web90405.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Tue, 26 Feb 2008 13:32:07 -0500
Message-Id: <1204050727.2804.321.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-02-26 at 00:33 -0800, kihamba nengo wrote:
> Hi,
> I tried compiling the policy on Fedora 5 and i received the following
> error message:
> 
> WARNING: Policy version mismatch! Is your OUTPUT_POLICY set correctly?
> 
>     /USR/BIN/CHECKPOLICY POLICY.CONF -O POLICY
> make: *** [policy.] Floating point exception

You didn't mention what policy or checkpolicy you were using above.

Regardless, Fedora 5 is obsolete; you'd be advised to install the latest
Fedora release, presently Fedora 8.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
