Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82JODrT002321
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 15:24:13 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82JNM3w006873
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 19:23:22 GMT
Date: Thu, 2 Sep 2004 18:12:59 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: what to do with matchpathcon on S_IFCHR, S_IFBLK, hard links and fifos
Message-ID: <20040902171259.GF5745@lkcl.net>
References: <20040901174909.GF4400@lkcl.net> <1094126565.17265.9.camel@moss-spartans.epoch.ncsc.mil> <20040902134454.GC5745@lkcl.net> <1094132316.17265.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094132316.17265.53.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 02, 2004 at 09:38:36AM -0400, Stephen Smalley wrote:
> On Thu, 2004-09-02 at 09:44, Luke Kenneth Casson Leighton wrote:
> >  okay, second question, if i may.
> > 
> >  if i have set up file contexts on some files in a temporary
> >  directory (of course, using matchpathcon to set the context
> >  of where the file is _going_ to be not where it _is_), then
> >  will the "/bin/mv" command preserve those file contexts
> >  even across filesystem boundaries - without any extra arguments?
> 
> With a SELinux-patched coreutils, yes; mv attempts to preserve the
> security context on the file even when moving across filesystem
> boundaries.  But it cannot always succeed, e.g. the filesystem may not
> support xattrs or the policy may deny access due to file create
> permission or filesystem associate permission.
 
 ... okay [this is for what i am considering for dpkg].
 
 so in that case, dpkg's policy file may need updating:
 unlikely as it already allows files to be mv'd.

 ta.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
