Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBSLQ7wU020354
	for <selinux@tycho.nsa.gov>; Fri, 28 Dec 2007 16:26:07 -0500
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBSLQ6Sj026544
	for <selinux@tycho.nsa.gov>; Fri, 28 Dec 2007 21:26:07 GMT
Received: by fg-out-1718.google.com with SMTP id 16so1648864fgg.40
        for <selinux@tycho.nsa.gov>; Fri, 28 Dec 2007 13:26:05 -0800 (PST)
Message-ID: <cadfc0e40712281326k31e9238ci8604298596ade04d@mail.gmail.com>
Date: Fri, 28 Dec 2007 15:26:05 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "Eamon Walsh" <ewalsh@tycho.nsa.gov>
Subject: Re: X avcs
Cc: "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <47754FCB.1070307@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40712261301l3765f85fyc813a6ccfb262e3b@mail.gmail.com>
	 <cadfc0e40712280854i586aae43ya9e602fd56a984ab@mail.gmail.com>
	 <47754FCB.1070307@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks I'll check it out.

On Dec 28, 2007 1:34 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
>
> Xavier Toth wrote:
> > What about labeling notification-daemon as other gnome apps have been
> > labeled (user_xpriv_t)?
> >
> > On Dec 26, 2007 3:01 PM, Xavier Toth <txtoth@gmail.com> wrote:
> >
> >> swo_u who is running ranged (systemlow-systemhigh) uses newrole to
> >> launch an X windows app at systemhigh and then I get avcs like the
> >> following:
> >>
> >> avc:  denied  { receive } for request=X11:ChangeWindowAttributes
> >> comm=/usr/libexec/notification-daemon resid=3800036 restype=WINDOW
> >> scontext=swo_u:user_r:user_t:s0-s15:c0.c1023
> >> tcontext=swo_u:object_r:user_t:s15:c0.c1023 tclass=x_drawable
> >> avc:  denied  { get_property } for request=X11:GetProperty
> >> comm=/usr/libexec/notification-daemon resid=3800036 restype=WINDOW
> >> scontext=swo_u:user_r:user_t:s0-s15:c0.c1023
> >> tcontext=swo_u:object_r:user_t:s15:c0.c1023 tclass=x_drawable
> >> avc:  denied  { receive } for  comm=/usr/libexec/notification-daemon
> >> event=X11:MapNotify scontext=swo_u:user_r:user_t:s0-s15:c0.c1023
> >> tcontext=swo_u:object_r:user_manage_xevent_t:s15:c0.c1023
> >> tclass=x_event
> >> avc:  denied  { receive } for  comm=/usr/libexec/notification-daemon
> >> event=X11:VisibilityNotify
> >> scontext=swo_u:user_r:user_t:s0-s15:c0.c1023
> >> tcontext=swo_u:object_r:user_default_xevent_t:s15:c0.c1023
> >> tclass=x_event
> >> avc:  denied  { receive } for  comm=/usr/libexec/notification-daemon
> >> event=X11:PropertyNotify scontext=swo_u:user_r:user_t:s0-s15:c0.c1023
> >> tcontext=swo_u:object_r:user_property_xevent_t:s15:c0.c1023
> >> tclass=x_event
> >> avc:  denied  { receive } for  comm=/usr/libexec/notification-daemon
> >> event=X11:FocusIn scontext=swo_u:user_r:user_t:s0-s15:c0.c1023
> >> tcontext=swo_u:object_r:user_focus_xevent_t:s15:c0.c1023
> >> tclass=x_event
> >> avc:  denied  { getattr } for request=X11:GetGeometry
> >> comm=/usr/libexec/notification-daemon resid=3800036 restype=WINDOW
> >> scontext=swo_u:user_r:user_t:s0-s15:c0.c1023
> >> tcontext=swo_u:object_r:user_t:s15:c0.c1023 tclass=x_drawable
> >> avc:  denied  { read } for request=X11:GetProperty
> >> comm=/usr/libexec/notification-daemon property=WM_NAME
> >> scontext=swo_u:user_r:user_t:s0-s15:c0.c1023
> >> tcontext=swo_u:object_r:user_default_xproperty_t:s15:c0.c1023
> >> tclass=x_property
> >>
>
> These are all allowed by the TE rules.  So I think this is a MLS issue.
>
> I committed read-to-clearance and write-to-clearance interfaces and went
> ahead and granted read-to-clearance in the per-role template.  The patch
> I committed is below.  So update from SVN and see if that solves the
> problem.
>
> Index: policy/modules/kernel/mls.if
> ===================================================================
> --- policy/modules/kernel/mls.if        (revision 2565)
> +++ policy/modules/kernel/mls.if        (working copy)
> @@ -612,6 +612,26 @@
>  ########################################
>  ## <summary>
>  ##     Make specified domain MLS trusted
> +##     for reading from X objects up to its clearance.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +## <rolecap/>
> +#
> +interface(`mls_xwin_read_to_clearance',`
> +       gen_require(`
> +               attribute mlsxwinreadtoclr;
> +       ')
> +
> +       typeattribute $1 mlsxwinreadtoclr;
> +')
> +
> +########################################
> +## <summary>
> +##     Make specified domain MLS trusted
>  ##     for reading from X objects at any level.
>  ## </summary>
>  ## <param name="domain">
> @@ -632,6 +652,26 @@
>  ########################################
>  ## <summary>
>  ##     Make specified domain MLS trusted
> +##     for write to X objects up to its clearance.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +## <rolecap/>
> +#
> +interface(`mls_xwin_write_to_clearance',`
> +       gen_require(`
> +               attribute mlsxwinwritetoclr;
> +       ')
> +
> +       typeattribute $1 mlsxwinwritetoclr;
> +')
> +
> +########################################
> +## <summary>
> +##     Make specified domain MLS trusted
>  ##     for writing to X objects at any level.
>  ## </summary>
>  ## <param name="domain">
> Index: policy/modules/services/xwindows.if
> ===================================================================
> --- policy/modules/services/xwindows.if (revision 2565)
> +++ policy/modules/services/xwindows.if (working copy)
> @@ -374,6 +374,7 @@
>         #
>
>         xwindows_domain_template($1,$1,$2,$3)
> +       mls_xwin_read_to_clearance($2)
>
>         # FIXME: this domain should be removed
>         xwindows_domain_template($1,$1_xpriv,$1_xpriv_t,$3)
>
>
>
> --
> Eamon Walsh <ewalsh@tycho.nsa.gov>
> National Security Agency
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
