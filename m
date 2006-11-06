Subject: Re: [PATCH 4/4] SELinux: validate kernel object classes and
	permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Sellers <csellers@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <C1712339.19304%csellers@tresys.com>
References: <C1712339.19304%csellers@tresys.com>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 07:47:21 -0500
Message-Id: <1162817241.5519.221.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-11-03 at 16:47 -0500, Chad Sellers wrote:
> On 11/3/06 4:39 PM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
> > This seems redundant, as you checked class_val_to_name and it was
> > generated from the classes symtab.
> > 
> Yes, this would only be triggered by a broken policy. Would you rather I not
> worry about a broken policy at all, as I obviously don't provide complete
> coverage for a broken policy?

If there was some way for class_val_to_name and the classes symtab to
get out of sync (e.g. they were independently provided from the policy
image), then it would make sense in general to provide a consistency
check.  But since the former is generated from the latter, the only way
for them to get out of sync is a bug in the kernel code.  Which you
can't really test for in general within the kernel itself...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
