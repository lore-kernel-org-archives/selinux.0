Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mB1GH1NX001263
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2008 11:17:01 -0500
Received: from QMTA09.emeryville.ca.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mB1GH13d002406
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2008 16:17:01 GMT
Date: Mon, 1 Dec 2008 16:17:01 GMT
Message-Id: <200812011617.mB1GH13d002406@mummy.ncsc.mil>
From: Dave Feustel <dfeustel@mindspring.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policy for Konqueror
In-Reply-To: <4934044E.5010404@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 01, 2008 at 10:35:42AM -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Dave Feustel wrote:
> > A question from a newbie:
> > Has anyone developed a selinux policy for konqueror?
> > 
> > Thanks.
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> NO although the policy for firefox/mozilla would probably work.  Writing
> a general purpose policy for a web browser that can do everything a web
> browser is designed to do, is probably a waste of time, and will not
> work the way you want.  If you have good Security Goals about the only
> things you want the Browser to do, you might have a better shot.  But
> the web browser being able to launch helper apps (ooffice, evince,
> realplayer, mplayer, and hundreds of others make writing a good policy
> near impossible.

Thanks for the response. After I posted the question I found the
following passages in the book _SELINUX: NASA'a Opensource Security Enhanced Linux_:

(p.40)

"The KDE Desktop has so far proven more resistant to interoperation with
SELinux than its rival desktop, GNOME. The central problem is that
various KDE programs run as identically named processes. Thus SELinux
cannot assign these KDE processes to distinct domains. One result of
this inability is that KDE's temporary files sometimes cannot be labeled
with appropriate domains. Thus with respect to KDE,
SELinux policies tend either to be too restrictive or too lax. We can
hope that a future release of KDE or SELinux will somehow address this
propblem. In the meantime, for those using SELinux, GNOME is generally a
better desktop choice than KDE."

(and on p.94)

"When using KDE, you may find that several graphical applications or
features don't work properly. This occurs because KDE starts a variety
of execuables with the same process name, kdeinit. No simple fix exists
for such problems, since a simple fix would entail loosening security to
an unacceptable extent. You may find it more convenient to use a desktop
other than KDE - such as GNOME - when running SELinux.

"A workaround is to log out of KDE and remove all KDE-related temporary
files from /var/tmp. Then log into KDE and see if the problems persist."

My interest in SELinux was tweaked by the thought that perhaps a policy
for KDE or Konqueror could be developed that would cut down on the
problems I have recently been experiencing with Konqueror. Such a policy
looks pretty unlikely unless KDE and Konqueror code is recast to a more
SELinux-friendly form.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
