Subject: Re: awk, isatty(), libc and ioctl()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Erich Schubert <erich@debian.org>
Cc: russell@coker.com.au, selinux@tycho.nsa.gov
In-Reply-To: <1158410236.10929.8.camel@wintermute.xmldesign.de>
References: <1158185710.1594.94.camel@wintermute.xmldesign.de>
	 <200609162208.13198.russell@coker.com.au>
	 <1158410236.10929.8.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 12:59:40 -0400
Message-Id: <1158598780.18951.254.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-09-16 at 14:37 +0200, Erich Schubert wrote:
> Hello Russel,
> > One thing to note is that Perl has the same issue in regard to ioctl() on all 
> > files.
> 
> What can ioctl() on *regular* files do?
> The "ioctl" manpage just mentions "special files".

For all files, you have FIBMAP, FIGETBZ, FIONREAD.
Then the individual filesystem types implement their own operations,
like ext3 has [gs]etflags, [gs]etversion, etc.

There has been past discussion of altering the SELinux ioctl checking,
including some rfc/patches [1], but the main problem is someone taking
the time to not only implement such a patch but also to thoroughly test
its effect on applications, update current policy, provide a graceful
way to migrate from the old checks to the new [2], etc.

[1] http://marc.theaimsgroup.com/?l=selinux&m=113519095102526&w=2
[2] https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=195238

> I mean... we'll probably have to add ioctl dontaudits for so many
> domains, we might want to go with something like
> "dontaudit domain file_type:file ioctl;"
> at least for any user domain (I mean, most admins will allow their users
> to use awk or perl in one way or another).


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
