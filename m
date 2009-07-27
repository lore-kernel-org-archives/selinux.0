MIME-Version: 1.0
In-Reply-To: <1248702334.3465.45.camel@moss-pluto.epoch.ncsc.mil>
References: <81092d890907251241k5ef56a87p2f6d6f763b25b70@mail.gmail.com>
	 <1248702334.3465.45.camel@moss-pluto.epoch.ncsc.mil>
Date: Mon, 27 Jul 2009 07:49:38 -0700
Message-ID: <81092d890907270749o7cdced5bw434454ec3f5c91a4@mail.gmail.com>
Subject: Re: "Error! Unable to set executable context."
From: Larry Ross <selinux.larry@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0016364c7eeb37f410046fb11036
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016364c7eeb37f410046fb11036
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Mon, Jul 27, 2009 at 6:45 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Sat, 2009-07-25 at 12:41 -0700, Larry Ross wrote:
> > I am trying to create a custom selinux user for the strict policy on
> > RHEL5.3
> > I want logins that are mapped to this user to be able to login via
> > gdm, but when they do I get an error "Error! Unable to set executable
> > context."
> >
> > What does this error message mean?
> >
> > I am able to login via gdm with logins that are mapped to user_u.  I
> > have run the AVCs generated when I login in permissive mode (which
> > succeeds) through audit2allow and gotten to the point where it doesn't
> > seem that I am getting any killer AVCs.  What am I missing that is
> > needed for a custom user to use X-Windows?  Is there some place I can
> > look to determine what is causing the error?
>
> I see that you've resolved the problem now, but could you describe what
> you had to do to get it to work for future reference?  That way the next
> time someone comes along with the same issue, they can find the answer
> in the mailing list archives.


I think (and that is why I didn't say specifically) that it was calling:
userdom_unpriv_user_template(app_user)

I know I needed to add a default context to:
/etc/selinux/strict/contexts/default_contexts
but although I added more per Dominicks suggestion, I think I already had
the ones that were needed.


>
>
> BTW, "executable context" in the error message means that the attempts
> by gdm to invoke setexeccon(3) failed.  setexecon(3) is the libselinux
> interface to set the security context to which the process will
> transition upon the next execve(2) call.  Usually a setexeccon(3) error
> means that the security context was invalid under the current policy.


This didn't seem to be well documented anywhere as to what the above
actually means.
My take is that there has to be an executable context (which is what I think
the userdom_unpriv_user_template gave me) which is listed in the default
contexts in the same row as the "current" context.  But I could be wrong.

  -- Larry


>
>
> --
> Stephen Smalley
> National Security Agency
>
>

--0016364c7eeb37f410046fb11036
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Mon, Jul 27, 2009 at 6:45 AM, Stephen Smalley=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.g=
ov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im">On Sat, 2009-07-25 at 12:41 -0700, Larry Ross wrote:<br><=
/div>
<div class=3D"im">&gt; I am trying to create a custom selinux user for the =
strict policy on<br>&gt; RHEL5.3<br>&gt; I want logins that are mapped to t=
his user to be able to login via<br>&gt; gdm, but when they do I get an err=
or &quot;Error! Unable to set executable<br>
&gt; context.&quot;<br>&gt;<br>&gt; What does this error message mean?<br>&=
gt;<br>&gt; I am able to login via gdm with logins that are mapped to user_=
u. =A0I<br>&gt; have run the AVCs generated when I login in permissive mode=
 (which<br>
&gt; succeeds) through audit2allow and gotten to the point where it doesn&#=
39;t<br>&gt; seem that I am getting any killer AVCs. =A0What am I missing t=
hat is<br>&gt; needed for a custom user to use X-Windows? =A0Is there some =
place I can<br>
&gt; look to determine what is causing the error?<br><br></div>I see that y=
ou&#39;ve resolved the problem now, but could you describe what<br>you had =
to do to get it to work for future reference? =A0That way the next<br>time =
someone comes along with the same issue, they can find the answer<br>
in the mailing list archives.</blockquote>
<div>=A0</div>
<div>I think (and that is why I didn&#39;t say specifically) that it was ca=
lling:</div>
<div>userdom_unpriv_user_template(app_user)</div>
<div>=A0</div>
<div>I know I needed to add=A0a default=A0context to:</div>
<div>/etc/selinux/strict/contexts/default_contexts<br></div>
<div>but although I added more per Dominicks suggestion, I think I already =
had the ones that were needed.</div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><span id=3D""></span><br><br>BTW=
, &quot;executable context&quot; in the error message means that the attemp=
ts<br>
by gdm to invoke setexeccon(3) failed. =A0setexecon(3) is the libselinux<br=
>interface to set the security context to which the process will<br>transit=
ion upon the next execve(2) call. =A0Usually a setexeccon(3) error<br>means=
 that the security context was invalid under the current policy.</blockquot=
e>

<div>=A0</div>
<div>This didn&#39;t seem to be well documented anywhere as to what the abo=
ve actually means.</div>
<div>My take is that there has to be an executable context (which is what I=
 think the userdom_unpriv_user_template gave me) which is listed in the def=
ault contexts in the same row as the &quot;current&quot; context.=A0 But I =
could be wrong.</div>

<div>=A0</div>
<div>=A0 -- Larry</div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><span id=3D""></span><br><font c=
olor=3D"#888888"><br>--<br>Stephen Smalley<br>National Security Agency<br><=
br>
</font></blockquote></div><br>

--0016364c7eeb37f410046fb11036--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
