Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0MHX7C1007170
 for <selinux@tycho.nsa.gov>; Thu, 22 Jan 2015 12:33:07 -0500
Received: by mail-ob0-f169.google.com with SMTP id va8so624554obc.0
 for <selinux@tycho.nsa.gov>; Thu, 22 Jan 2015 09:33:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150122085150.GB1268@kroah.com>
References: <1421855650-22522-1-git-send-email-sds@tycho.nsa.gov>
 <20150122085150.GB1268@kroah.com>
Date: Thu, 22 Jan 2015 09:33:05 -0800
Message-ID: <CABXk95DR7CYj65E6bSbsRdPxKyiw-_e02+-9qqq+o8Mb-tix_Q@mail.gmail.com>
Subject: Re: [PATCH] Add security hooks to binder and implement the hooks for
 SELinux.
From: Jeffrey Vander Stoep <jeffv@google.com>
To: Greg KH <gregkh@linuxfoundation.org>
Content-Type: multipart/alternative; boundary=047d7bf0e95e8e4632050d4110e3
Cc: linux-security-module@vger.kernel.org, arve@android.com,
 Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org,
 SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7bf0e95e8e4632050d4110e3
Content-Type: text/plain; charset=UTF-8

ACK.

This has been in the android tree since Nov 2012.

Forward port of commit: 6639e3d91a05bafa2a85c24c211c43fcaa1b17c5 in
https://android.googlesource.com/kernel/common.git

Thanks,
Jeff

On Thu, Jan 22, 2015 at 12:51 AM, Greg KH <gregkh@linuxfoundation.org>
wrote:

> On Wed, Jan 21, 2015 at 10:54:10AM -0500, Stephen Smalley wrote:
> > Add security hooks to the binder and implement the hooks for SELinux.
> > The security hooks enable security modules such as SELinux to implement
> > controls over binder IPC.  The security hooks include support for
> > controlling what process can become the binder context manager
> > (binder_set_context_mgr), controlling the ability of a process
> > to invoke a binder transaction/IPC to another process
> (binder_transaction),
> > controlling the ability of a process to transfer a binder reference to
> > another process (binder_transfer_binder), and controlling the ability
> > of a process to transfer an open file to another process
> (binder_transfer_file).
> >
> > These hooks have been included in the Android kernel trees since Android
> 4.3.
>
> Very interesting, I missed the fact that these were added in that tree,
> thanks for digging it out and submitting it.
>
> I'd like some acks from some Android developers before I take these.
> Or, if it's easier for them to go through the security tree, that's fine
> with me as well.
>
> thanks,
>
> greg k-h
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--047d7bf0e95e8e4632050d4110e3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ACK.<div><br></div><div>This has been in the android tree =
since Nov 2012.</div><div><br></div><div>Forward port of commit:=C2=A06639e=
3d91a05bafa2a85c24c211c43fcaa1b17c5 in=C2=A0<a href=3D"https://android.goog=
lesource.com/kernel/common.git" target=3D"_blank">https://android.googlesou=
rce.com/kernel/common.git</a></div><div><br></div><div>Thanks,</div><div>Je=
ff</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On =
Thu, Jan 22, 2015 at 12:51 AM, Greg KH <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:gregkh@linuxfoundation.org" target=3D"_blank">gregkh@linuxfoundation.or=
g</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">=
On Wed, Jan 21, 2015 at 10:54:10AM -0500, Stephen Smalley wrote:<br>
&gt; Add security hooks to the binder and implement the hooks for SELinux.<=
br>
&gt; The security hooks enable security modules such as SELinux to implemen=
t<br>
&gt; controls over binder IPC.=C2=A0 The security hooks include support for=
<br>
&gt; controlling what process can become the binder context manager<br>
&gt; (binder_set_context_mgr), controlling the ability of a process<br>
&gt; to invoke a binder transaction/IPC to another process (binder_transact=
ion),<br>
&gt; controlling the ability of a process to transfer a binder reference to=
<br>
&gt; another process (binder_transfer_binder), and controlling the ability<=
br>
&gt; of a process to transfer an open file to another process (binder_trans=
fer_file).<br>
&gt;<br>
&gt; These hooks have been included in the Android kernel trees since Andro=
id 4.3.<br>
<br>
</span>Very interesting, I missed the fact that these were added in that tr=
ee,<br>
thanks for digging it out and submitting it.<br>
<br>
I&#39;d like some acks from some Android developers before I take these.<br=
>
Or, if it&#39;s easier for them to go through the security tree, that&#39;s=
 fine<br>
with me as well.<br>
<br>
thanks,<br>
<br>
greg k-h<br>
<div class=3D"HOEnZb"><div class=3D"h5">___________________________________=
____________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</div></div></blockquote></div><br></div>

--047d7bf0e95e8e4632050d4110e3--
