Subject: Re: X server won't start using MLS policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mark Webb <elihusmails@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <9f066ee90704111136w5e98b87bxf2463754621cf6fb@mail.gmail.com>
References: <9f066ee90704111136w5e98b87bxf2463754621cf6fb@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 11 Apr 2007 14:49:51 -0400
Message-Id: <1176317391.3986.44.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-11 at 14:36 -0400, Mark Webb wrote:
> I have followed the instructions at
> http://fedoraproject.org/wiki/SELinux/FedoraMLSHowto on how to install
> the MLS policy.  I have it working under Fedora Core 6, but when I
> boot to runlevel 5, I get an error saying that the X server cannot be
> started. 
> 
> Does anyone know how to fix this problem?

The MLS work has focused on servers to date since we need XACE/XSELinux
fully mainstreamed before we can provide proper support on the desktop.
So it isn't surprising that the MLS policy doesn't work with X at
present.

Do you get avc denials in your /var/log/audit/audit.log
or /var/log/messages?

If not, try installing enableaudit.pp and retrying to collect audit
messages.

I thiink there was also a post to fedora-selinux-list circa 28 Dec 2006
by a user with a copy of changes he found necessary to the strict policy
to get X working fully, so that might be helpful.  Not sure how many of
those were legitimate or how many found their way into the upstream
policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
