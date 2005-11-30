Subject: Re: Another small issue on Debian
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Erich Schubert <erich@debian.org>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1133365971.8467.39.camel@wintermute.xmldesign.de>
References: <1133365971.8467.39.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 11:06:56 -0500
Message-Id: <1133366816.26593.348.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-30 at 16:52 +0100, Erich Schubert wrote:
> Hi,
> Debian currently uses a "strict" policy, but uses "SELINUXTYPE=." and
> has the sources in /etc/selinux/src, not /etc/selinux/strict/src
> Since the Makefile I got has "strict" somewhere hardcoded in there, I
> set up a symlink "strict -> ." causing the following violation:
> avc:  denied  { read } for  pid=8075 comm="checkpolicy" name="strict"
> dev=ida/c0d0p5 ino=49769 scontext=root:sysadm_r:checkpolicy_t
> tcontext=system_u:object_r:selinux_config_t tclass=lnk_file
> 
> Any objections to allowing this?

The "hardcoded" strict is a definition, so you should be able to do:
	make TYPE=. [all|install|load|relabel]

But allowing the reading of a selinux_config_t:lnk_file is likely
harmless too.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
