Subject: Re: Need testers for Modules policicy on RHEL4
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: selinux@tycho.nsa.gov
Cc: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <442B7848.8060406@hotmail.com>
References: <442B182D.9060104@redhat.com>  <442B7848.8060406@hotmail.com>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 08:20:06 -0500
Message-Id: <1143724806.24555.121.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-03-30 at 07:18 +0100, James de Lurker wrote:
> I'll likely become an active and thorough tester again on a community basis
> when the selinux project decides to base its work on a genuine community
> based Linux distro that would also be treated seriously in the enterprise
> by commercial entities. With FC the poor relation.
> 
> I already find it distasteful that Redhat are effectively gaining
> commercial advantage from a project support by a US government body.
> 
> The separation of FC and RHEL is mere sophistry IMHO.

I think you are confused.  Red Hat trail-blazed the path of integrating
SELinux into a full distribution and enabling it by default for all
users.  Their work yielded major improvements in SELinux, including:
- significant expansion of the userland modifications,
- expansion and refinement of the policy,
- maturing of the SELinux kernel and userland code,
- getting SELinux into a state where it could be enabled by default for
typical users.

They did a lot of hard work, and they made all of their enhancements
open source, contributing them to the upstream SELinux where there is an
upstream component and otherwise making them available in the Fedora
Core tree for reference by other distros.

Meanwhile, the Debian and Gentoo SELinux folks have been hard at work
likewise integrating SELinux into their respective distros, and they
have leveraged the contributions made by Red Hat while making
contributions of their own.  And people have been packaging SELinux on
the side for SuSE and Slackware among others for quite some time,
although sadly the SuSE-related efforts have been stalled by Novell's
choice.

Also, if you look at the minutes from the SELinux developer summit,
you'll see that there are plans to improve pan-distribution support and
create a more viable upstream SELinux development community that is not
so closely coupled to Fedora, see:
http://www.selinux-symposium.org/2006/summit.php

> Novell are struggling as competitors to RedHat to gain certifications for
> enterprise level products, and I dont see the US Govt offering them the
> equivalent assistance for community based projects.

We would have been glad to have worked with Novell/SuSE on SELinux
integration (and did talk with them), and still would be glad to do so
in the future if the opportunity presents itself.  Our goal has always
been the mainstreaming of the technology.  But Novell/SuSE chose to not
pursue it.  Their choice.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
