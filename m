Subject: Re: libselinux python binding segfault patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <45B79D42.9030103@redhat.com>
References: <45B7968E.8040106@redhat.com>
	 <1169659880.15390.121.camel@moss-spartans.epoch.ncsc.mil>
	 <45B79D42.9030103@redhat.com>
Content-Type: text/plain
Date: Wed, 24 Jan 2007 13:02:15 -0500
Message-Id: <1169661735.15390.131.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-01-24 at 12:54 -0500, Daniel J Walsh wrote:
> Stephen Smalley wrote:
> > On Wed, 2007-01-24 at 12:25 -0500, Daniel J Walsh wrote:
> >   
> >> This patch fixes a segfault in the python binding when getfilecon is 
> >> called with a non existant file.
> >>     
> >
> > Is the bug actually in the python binding or just in the callers?  The
> > actual bug report on fedora-selinux-list was for chcat, and chcat wasn't
> > checking the return code from selinux.getfilecon and just dereferencing
> > the string.
> >
> >   
> It is in the binding.  Basically we we not setting the security context 
> to NULL before calling setfilecon, and then checking if it was null, to 
> figure out success.  The real change is in selinuxswig.i
> 
> #python
>  >import selinux
>  >selinux.getfilecon("/notafile")
> Segmentation Fault

In that case, I think the same issue may apply to other typemaps, e.g.
in semanage.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
