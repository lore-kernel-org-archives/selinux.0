Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBSGsl6A032714
	for <selinux@tycho.nsa.gov>; Fri, 28 Dec 2007 11:54:47 -0500
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBSGskdt017004
	for <selinux@tycho.nsa.gov>; Fri, 28 Dec 2007 16:54:47 GMT
Received: by fg-out-1718.google.com with SMTP id 16so1611090fgg.40
        for <selinux@tycho.nsa.gov>; Fri, 28 Dec 2007 08:54:45 -0800 (PST)
Message-ID: <cadfc0e40712280854i586aae43ya9e602fd56a984ab@mail.gmail.com>
Date: Fri, 28 Dec 2007 10:54:45 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>, "Eamon Walsh" <ewalsh@tycho.nsa.gov>
Subject: Re: X avcs
In-Reply-To: <cadfc0e40712261301l3765f85fyc813a6ccfb262e3b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40712261301l3765f85fyc813a6ccfb262e3b@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What about labeling notification-daemon as other gnome apps have been
labeled (user_xpriv_t)?

On Dec 26, 2007 3:01 PM, Xavier Toth <txtoth@gmail.com> wrote:
> swo_u who is running ranged (systemlow-systemhigh) uses newrole to
> launch an X windows app at systemhigh and then I get avcs like the
> following:
>
> avc:  denied  { receive } for request=X11:ChangeWindowAttributes
> comm=/usr/libexec/notification-daemon resid=3800036 restype=WINDOW
> scontext=swo_u:user_r:user_t:s0-s15:c0.c1023
> tcontext=swo_u:object_r:user_t:s15:c0.c1023 tclass=x_drawable
> avc:  denied  { get_property } for request=X11:GetProperty
> comm=/usr/libexec/notification-daemon resid=3800036 restype=WINDOW
> scontext=swo_u:user_r:user_t:s0-s15:c0.c1023
> tcontext=swo_u:object_r:user_t:s15:c0.c1023 tclass=x_drawable
> avc:  denied  { receive } for  comm=/usr/libexec/notification-daemon
> event=X11:MapNotify scontext=swo_u:user_r:user_t:s0-s15:c0.c1023
> tcontext=swo_u:object_r:user_manage_xevent_t:s15:c0.c1023
> tclass=x_event
> avc:  denied  { receive } for  comm=/usr/libexec/notification-daemon
> event=X11:VisibilityNotify
> scontext=swo_u:user_r:user_t:s0-s15:c0.c1023
> tcontext=swo_u:object_r:user_default_xevent_t:s15:c0.c1023
> tclass=x_event
> avc:  denied  { receive } for  comm=/usr/libexec/notification-daemon
> event=X11:PropertyNotify scontext=swo_u:user_r:user_t:s0-s15:c0.c1023
> tcontext=swo_u:object_r:user_property_xevent_t:s15:c0.c1023
> tclass=x_event
> avc:  denied  { receive } for  comm=/usr/libexec/notification-daemon
> event=X11:FocusIn scontext=swo_u:user_r:user_t:s0-s15:c0.c1023
> tcontext=swo_u:object_r:user_focus_xevent_t:s15:c0.c1023
> tclass=x_event
> avc:  denied  { getattr } for request=X11:GetGeometry
> comm=/usr/libexec/notification-daemon resid=3800036 restype=WINDOW
> scontext=swo_u:user_r:user_t:s0-s15:c0.c1023
> tcontext=swo_u:object_r:user_t:s15:c0.c1023 tclass=x_drawable
> avc:  denied  { read } for request=X11:GetProperty
> comm=/usr/libexec/notification-daemon property=WM_NAME
> scontext=swo_u:user_r:user_t:s0-s15:c0.c1023
> tcontext=swo_u:object_r:user_default_xproperty_t:s15:c0.c1023
> tclass=x_property
>
> I'm not familiar with /usr/libexec/notification-daemon and what it
> does and I'm thinking that it's probably not the best idea to use
> mls_xwin_read_all_levels for user_t.. Any suggestions?
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
