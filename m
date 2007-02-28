Subject: Re: refpolicy modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: vin@netwosix.org
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1172654815.7570.7.camel@localhost>
References: <1172654815.7570.7.camel@localhost>
Content-Type: text/plain
Date: Wed, 28 Feb 2007 08:05:37 -0500
Message-Id: <1172667937.19041.458.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-28 at 10:26 +0100, Vincenzo Ciaglia wrote:
> Hello, another question.
> 
> Is there any way to get SELinux refpolicy working without not useful
> modules for my system without re-editing the most part of the policies
> once i have done this ?
> 
> It's really and hard work to modify each policy with not-useful lines.
> 
> Excuse me for the dumby question but maybe there's a way that i still
> don't know.

What are you asking?  You should be able to turn off modules that you
don't need and have the rest build, although there likely is a
fundamental core set of modules that are presumed to be present.  If you
have specific cases where you disabled a module and couldn't build the
rest of the policy, then report those.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
