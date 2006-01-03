Subject: Re: more genhomedircon badness...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Erich Schubert <erich@debian.org>
Cc: Russell Coker <russell@coker.com.au>, SELinux@tycho.nsa.gov
In-Reply-To: <1136146788.27906.65.camel@wintermute.xmldesign.de>
References: <1136133436.27906.56.camel@wintermute.xmldesign.de>
	 <1136146788.27906.65.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 11:56:33 -0500
Message-Id: <1136307393.27632.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-01-01 at 21:19 +0100, Erich Schubert wrote:
> I've now created /etc/selinux/modules/active/modules
> and /etc/selinux/modules/active/seusers...
> 
> genhomedircon:  Warning!  No support yet for expanding ROLE macros in
> the /etc/selinux/./contexts/files/homedir_template file when using
> libsemanage.
> genhomedircon:  You must manually update file_contexts.homedirs for any
> non-user_r users (including root).
> zsh: 19705 segmentation fault  genhomedircon
> 
> Ouch, a segfault!

The warning is correct, and that limitation was noted in the release
announcement.  Should only affect Debian if using modular/managed
policy, which I wouldn't expect since refpolicy doesn't cover all of
strict policy yet.  segfault is odd, and doesn't occur here.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
