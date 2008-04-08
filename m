Subject: Re: selinux support in cron withou system_u
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Marcela Maslanova <mmaslano@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <47FB771A.50305@redhat.com>
References: <47FB771A.50305@redhat.com>
Content-Type: text/plain
Date: Tue, 08 Apr 2008 09:50:26 -0400
Message-Id: <1207662626.21223.291.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-04-08 at 15:46 +0200, Marcela Maslanova wrote:
> There was a proposal to get rid off system_u from selinux support in cron.
> https://bugzilla.redhat.com/show_bug.cgi?id=426704#c19
> 
> Do you have any ideas how it should be done?

My proposal was in the next comment,
https://bugzilla.redhat.com/show_bug.cgi?id=426704#c20

I assumed that you had actually implemented that change given later
comments and the update to vixie-cron in Fedora 8 that followed.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
