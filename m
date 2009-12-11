Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBBLiadR004992
	for <selinux@tycho.nsa.gov>; Fri, 11 Dec 2009 16:44:36 -0500
Received: from mail-pw0-f55.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nBBLhQou019644
	for <selinux@tycho.nsa.gov>; Fri, 11 Dec 2009 21:43:26 GMT
Received: by pwj2 with SMTP id 2so836742pwj.34
        for <selinux@tycho.nsa.gov>; Fri, 11 Dec 2009 13:44:34 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 11 Dec 2009 13:44:33 -0800
Message-ID: <dd18b0c30912111344j65436d86h85f8d74e752e19af@mail.gmail.com>
Subject: avc's generated causes the system to freeze up
From: Justin Mattock <justinmattock@gmail.com>
To: tresys <refpolicy@oss1.tresys.com>, xorg@freedesktop.org,
        SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm running X.Org X Server 1.7.99.2
not sure if this is fixed with the latest
but after building the latest refpolicy
and defining my allow rules, both
regularly, and with make enableaudit
I still get avc's being generated here and there,
but for some they seem to just spamm Xorg.0.log
causing my system to freeze up.
heres an example:


(--) Synaptics Touchpad: touchpad found
(**) Option "SendCoreEvents" "true"
(**) Synaptics Touchpad: always reports core events
(II) XINPUT: Adding extended input device "Synaptics Touchpad" (type: TOUCHPAD)
(**) Synaptics Touchpad: (accel) keeping acceleration scheme 1
(**) Synaptics Touchpad: (accel) acceleration profile 0
(--) Synaptics Touchpad: touchpad found
(WW) avc:  denied  { getattr } for request=X11:QueryPointer
comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
tclass=x_drawable
(WW) avc:  denied  { getattr } for request=X11:QueryPointer
comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
tclass=x_drawable
(WW) avc:  denied  { getattr } for request=X11:QueryPointer
comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
tclass=x_drawable
(WW) avc:  denied  { getattr } for request=X11:QueryPointer
comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
tclass=x_drawable
(WW) avc:  denied  { getattr } for request=X11:QueryPointer
comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
tclass=x_drawable
(WW) avc:  denied  { getattr } for request=X11:QueryPointer
comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
tclass=x_drawable
(WW) avc:  denied  { getattr } for request=X11:QueryPointer
comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
tclass=x_drawable
(WW) avc:  denied  { getattr } for request=X11:QueryPointer
comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
tclass=x_drawable
(WW) avc:  denied  { getattr } for request=X11:QueryPointer
comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
tclass=x_drawable
(WW) avc:  denied  { getattr } for request=X11:QueryPointer
comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
tclass=x_drawable


same avc's but just keeps generating.
is there an option for this like
printk_ratelimit?


-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
