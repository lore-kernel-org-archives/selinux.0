Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBRD3qxJ030988
	for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2008 08:03:52 -0500
Received: from yw-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mBRD1LbK016812
	for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2008 13:01:22 GMT
Received: by yw-out-1718.google.com with SMTP id 6so1340513ywa.84
        for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2008 05:03:51 -0800 (PST)
Message-ID: <707f057d0812270503g269bce94tb6f1c3ba072792b7@mail.gmail.com>
Date: Sat, 27 Dec 2008 21:03:51 +0800
From: "xing li" <lixing.1006@gmail.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: when and how the selinux label all file system according to "file_contexts"?
In-Reply-To: <49561584.7020907@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_33820_1695176.1230383031271"
References: <707f057d0812270055r153efe73nd5649d3bc0c4fe0c@mail.gmail.com>
	 <4955F335.6030404@gmail.com> <49561584.7020907@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_33820_1695176.1230383031271
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2008/12/27 Daniel J Walsh <dwalsh@redhat.com>

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Justin P. Mattock wrote:
>
Thanks, i have found it: in the /etc/init.d/selinux(ubuntu 8.04) such as:
   .....
    log_warning_msg "Relabeling could take a very long time, depending"
  log_warning_msg "on file system size and speed of hard drives."
  /bin/sed -i -f $statusfile /etc/selinux/config
  log_action_begin_msg "Relabeling files"
  ${SETFILES} /etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts
${FILESYSTEMS}
  ....
  It invoke "setfiles" to label all file system.

>  > xing li wrote:
> >> I have confused by the question:
> >> when and how the selinux label all file system according to
> >> "file_contexts"?
> >> and i found the clue that when we "touch /.autorelabel",the system
> >> would invoke
> >> "fixfiles relabel" to relabel the file system. but i could't find the
> >> relevant source code.
> >> Maybt somebody has investigated that and could share infomation?
> > From what I remember,
> > .autorelabel is called by a daemon,
> > (selinux-basic package); but am unclear with
> > what the name might be with the different distros.
> > I normally make policy; make install; make relabel;
> > that is if anybody uses the commands "make"
> > anymore.
> >
> > regards;
> >
> > Justin P. Mattock
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> > with
> > the words "unsubscribe selinux" without quotes as the message.
> /etc/rc.sysinit includes a line that looks for /.autorelabel and then
> executes /sbin/fixfiles restore.
>
> # grep autorelabel /etc/rc.sysinit
>        rm -f  /.autorelabel
>        rm -f  /.autorelabel
>    if [ -f /.autorelabel ] || strstr "$cmdline" autorelabel ; then
>    if [ -f /.autorelabel ] || strstr "$cmdline" autorelabel ; then
>        [ -f /.autorelabel ] || touch /.autorelabel
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>
> iEYEARECAAYFAklWFYQACgkQrlYvE4MpobM97QCg2mpa8DBMHXbFlJilQUbt/O0F
> 6oUAn1aU0QcICcEiZ+B7ImIvF6VFP9nI
> =h8ji
> -----END PGP SIGNATURE-----
>

------=_Part_33820_1695176.1230383031271
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br>
<div class="gmail_quote">2008/12/27 Daniel J Walsh <span dir="ltr">&lt;<a href="mailto:dwalsh@redhat.com">dwalsh@redhat.com</a>&gt;</span><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">-----BEGIN PGP SIGNED MESSAGE-----<br>Hash: SHA1<br>
<div>
<div></div>
<div class="Wj3C7c"><br>Justin P. Mattock wrote:<br></div></div></blockquote>
<div>Thanks, i have found it: in the /etc/init.d/selinux(ubuntu 8.04) such as:</div>
<div>&nbsp;&nbsp; .....</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;log_warning_msg &quot;Relabeling could take a very long time, depending&quot;<br>&nbsp;&nbsp;log_warning_msg &quot;on file system size and speed of hard drives.&quot;<br>&nbsp;&nbsp;/bin/sed -i -f $statusfile /etc/selinux/config<br>
&nbsp;&nbsp;log_action_begin_msg &quot;Relabeling files&quot;<br>&nbsp;&nbsp;${SETFILES} /etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts ${FILESYSTEMS}<br>&nbsp; ....</div>
<div>&nbsp; It invoke &quot;setfiles&quot; to&nbsp;label all file system.&nbsp;</div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div class="Wj3C7c"><span id=""></span>&gt; xing li wrote:<br>&gt;&gt; I have confused by the question:<br>&gt;&gt; when and how the selinux label all file system according to<br>&gt;&gt; &quot;file_contexts&quot;?<br>&gt;&gt; and i found the clue that when we &quot;touch /.autorelabel&quot;,the system<br>
&gt;&gt; would invoke<br>&gt;&gt; &quot;fixfiles relabel&quot; to relabel the file system. but i could&#39;t find the<br>&gt;&gt; relevant source code.<br>&gt;&gt; Maybt somebody has investigated that and could share infomation?<br>
&gt; From what I remember,<br>&gt; .autorelabel is called by a daemon,<br>&gt; (selinux-basic package); but am unclear with<br>&gt; what the name might be with the different distros.<br>&gt; I normally make policy; make install; make relabel;<br>
&gt; that is if anybody uses the commands &quot;make&quot;<br>&gt; anymore.<br>&gt;<br>&gt; regards;<br>&gt;<br>&gt; Justin P. Mattock<br>&gt;<br></div></div>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>
&gt; If you no longer wish to subscribe, send mail to <a href="mailto:majordomo@tycho.nsa.gov">majordomo@tycho.nsa.gov</a><br>&gt; with<br>&gt; the words &quot;unsubscribe selinux&quot; without quotes as the message.<br>/etc/rc.sysinit includes a line that looks for /.autorelabel and then<br>
executes /sbin/fixfiles restore.<br><br># grep autorelabel /etc/rc.sysinit<br>&nbsp; &nbsp; &nbsp; &nbsp;rm -f &nbsp;/.autorelabel<br>&nbsp; &nbsp; &nbsp; &nbsp;rm -f &nbsp;/.autorelabel<br>&nbsp; &nbsp;if [ -f /.autorelabel ] || strstr &quot;$cmdline&quot; autorelabel ; then<br>&nbsp; &nbsp;if [ -f /.autorelabel ] || strstr &quot;$cmdline&quot; autorelabel ; then<br>
&nbsp; &nbsp; &nbsp; &nbsp;[ -f /.autorelabel ] || touch /.autorelabel<br><br>-----BEGIN PGP SIGNATURE-----<br>Version: GnuPG v1.4.9 (GNU/Linux)<br>Comment: Using GnuPG with Fedora - <a href="http://enigmail.mozdev.org/" target="_blank">http://enigmail.mozdev.org</a><br>
<br>iEYEARECAAYFAklWFYQACgkQrlYvE4MpobM97QCg2mpa8DBMHXbFlJilQUbt/O0F<br>6oUAn1aU0QcICcEiZ+B7ImIvF6VFP9nI<br>=h8ji<br>-----END PGP SIGNATURE-----<br></blockquote></div><br>

------=_Part_33820_1695176.1230383031271--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
