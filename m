Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i83G3brT008684
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 12:03:37 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i83G3aUQ024082
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 16:03:36 GMT
Date: Fri, 3 Sep 2004 15:38:08 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Colin Walters <walters@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: Proposed Hardware File Context file.
Message-ID: <20040903143808.GA26568@lkcl.net>
References: <1094153919.17265.375.camel@moss-spartans.epoch.ncsc.mil> <41377927.3080703@redhat.com> <1094155198.17265.389.camel@moss-spartans.epoch.ncsc.mil> <41377DD5.8010500@redhat.com> <1094155749.17265.392.camel@moss-spartans.epoch.ncsc.mil> <41377F4B.3010608@redhat.com> <1094167821.24091.25.camel@nexus.verbum.private> <1094210883.19206.2.camel@moss-spartans.epoch.ncsc.mil> <20040903131751.GC30562@lkcl.net> <1094218416.19206.116.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094218416.19206.116.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Sep 03, 2004 at 09:33:36AM -0400, Stephen Smalley wrote:
> On Fri, 2004-09-03 at 09:17, Luke Kenneth Casson Leighton wrote:
> >  ironically, it's scripted - with regexps matching nodes :)
> > 
> >  and then the owner, group and permissions are specified.
> > 
> >  there's also a system for dealing with classes of devices.
> > 
> >  so ide and scsi and also cd symbolic links are dealt with separately,
> >  with scripts.
> 
> It seems desirable to keep the SELinux context mapping approach for udev
> consistent with the base udev permissions approach.  Using a separate
> config file is reasonable (and allows us to keep it as part of the
> policy package), but the syntax should mirror the existing udev
> permission syntax as much as possible, I think, and we may even want
> udev itself to directly interpret it, just as dbusd is handling its
> service->context mapping (iirc).  How does that sound?  Not sure how to
> integrate SELinux labeling with the scripts.
  
  what do you think of the idea of
  "run-time enabling of alternative file contexts"?

  because i still think that extending the existing
  file_contexts syntax to have an optional keyword at the
  end, and then providing extended versions of the existing
  libselinux file context related functions, would provide
  the simplest from-here-to-there approach.

  it's a cut/paste job in libselinux.

  it's generic enough to be used by programs other than udev should
  it prove necessary.

  udev can determine what the type of the device is and can simply
  pass the keyword representing that device type to the extended-syntax
  versions of the libselinux fscontext functions.

  for simplicity of coding (in udev), the behaviour of the
  extended-libselinux-fscontext could be that if there doesn't
  happen to _be_ a line matching the keyword, the keyword is ignored
  [and the filecontext matching the regexp, mode_t are used as is
   presently normal].

  alternatively if that could result in undesirable side-effects,
  return an error code if the keyword is not available.

  for example... oh, i dunno... you could set the "default" keyword
  to something different.

  what about postfix's chroot-labelled files: you don't want those
  to be in there under certain circumstances: you certainly don't
  want them activated if the admin decides they don't want to chroot
  postfix.

  ... but they have to _be_ there because at present there's no
  flexibility to disable them - without editing
  file_contexts/programs/postfix.te.

  if you had a keyword "postfix" on the end of the chroot lines
  in file_contexts, you could enable those as required
  (setfiles --keyword "postfix" /etc/selinux/contexts/file_contexts
   /var/lib/postfix/chroot/)

  more if i think of it.

  if you add the keyword argument to setfiles and restorecon, it's
  possible to entirely change, at runtime, all or any part of the
  filesystem to a different configuration - without recompiling the
  policy.

  l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
