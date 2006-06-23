Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5NExVfr006208
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 10:59:31 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5NExUZW001404
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 14:59:30 GMT
Received: by nf-out-0910.google.com with SMTP id b2so486895nfe
        for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 07:59:30 -0700 (PDT)
Message-ID: <7b5ba3cd0606230759t3fa8317frcd7c88fcef3830b5@mail.gmail.com>
Date: Fri, 23 Jun 2006 10:59:29 -0400
From: "Miguel Fernandes" <esmiguelfc@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Selinux Sources
In-Reply-To: <1151073136.16104.3.camel@tiffy.tuxgeek.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_21073_5868836.1151074769885"
References: <7b5ba3cd0606230706p7775ab9cx4dcc4ba1d70798c1@mail.gmail.com>
	 <1151073136.16104.3.camel@tiffy.tuxgeek.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_21073_5868836.1151074769885
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Thorsten, thanks for your quick reply,

I'm trying to make the modification mention here:
http://article.gmane.org/gmane.network.nagios.user/33586/match=selinux

But I don't know where to make the moditications recommended there because
there are not such files on my distro. Any advice on this? Thanks!

On 6/23/06, Thorsten Scherf <tscherf@redhat.com> wrote:
>
> On Fri, 2006-06-23 at 10:06 -0400, Miguel Fernandes wrote:
> > Hi, I'm using FC5 with SELinux enable, but I'm unable to find the
> > ploicy sources that should be located in /etc/selinux/targeted/src.
> > The src folder doesn't exist on /etc/selinux/targeted. In
> > /etc/security doesn't exist a selinux directory either. I dont know
> > which package I have to install to obtain this files. Thanks in
> > advance!
>
> There is no longer a selinux-policy-<targeted/strict/mls>-sources RPM
> available in FC5. All Policies are build from a selinux-policy.srpm
> package, which contains all of the policy source files.
>
> Happy Day.
> Thorsten
>
> --
> Thorsten Scherf <tscherf@redhat.com>
> Red Hat GmbH
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.3 (GNU/Linux)
>
> iD8DBQBEm/tvwfkoLTuSgLsRAkVUAJ9b/8Yos4t6PvYrUh8oAW3JhU948QCeMCZd
> yyLGAareaiwGXzzrlhsN31w=
> =yXOo
> -----END PGP SIGNATURE-----
>
>
>

------=_Part_21073_5868836.1151074769885
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Thorsten, thanks for your quick reply,<br><br>I'm trying to make the modification mention here: <br><a href="http://article.gmane.org/gmane.network.nagios.user/33586/match=selinux">http://article.gmane.org/gmane.network.nagios.user/33586/match=selinux
</a><br><br>But I don't know where to make the moditications recommended there because there are not such files on my distro. Any advice on this? Thanks!<br><br><div><span class="gmail_quote">On 6/23/06, <b class="gmail_sendername">
Thorsten Scherf</b> &lt;<a href="mailto:tscherf@redhat.com">tscherf@redhat.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Fri, 2006-06-23 at 10:06 -0400, Miguel Fernandes wrote:<br>&gt; Hi, I'm using FC5 with SELinux enable, but I'm unable to find the<br>&gt; ploicy sources that should be located in /etc/selinux/targeted/src.<br>&gt; The src folder doesn't exist on /etc/selinux/targeted. In
<br>&gt; /etc/security doesn't exist a selinux directory either. I dont know<br>&gt; which package I have to install to obtain this files. Thanks in<br>&gt; advance!<br><br>There is no longer a selinux-policy-&lt;targeted/strict/mls&gt;-sources RPM
<br>available in FC5. All Policies are build from a selinux-policy.srpm<br>package, which contains all of the policy source files.<br><br>Happy Day.<br>Thorsten<br><br>--<br>Thorsten Scherf &lt;<a href="mailto:tscherf@redhat.com">
tscherf@redhat.com</a>&gt;<br>Red Hat GmbH<br><br><br>-----BEGIN PGP SIGNATURE-----<br>Version: GnuPG v1.4.3 (GNU/Linux)<br><br>iD8DBQBEm/tvwfkoLTuSgLsRAkVUAJ9b/8Yos4t6PvYrUh8oAW3JhU948QCeMCZd<br>yyLGAareaiwGXzzrlhsN31w=<br>
=yXOo<br>-----END PGP SIGNATURE-----<br><br><br></blockquote></div><br>

------=_Part_21073_5868836.1151074769885--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
