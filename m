Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBDGgXDw026774
	for <selinux@tycho.nsa.gov>; Sun, 13 Dec 2009 11:42:34 -0500
Received: from cp-out12.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nBDGisev002345
	for <selinux@tycho.nsa.gov>; Sun, 13 Dec 2009 16:44:55 GMT
Received: from [192.168.2.2] (151.64.21.76) by cp-out12.libero.it (8.5.119)
        id 4B0BAAC204C1740D for selinux@tycho.nsa.gov; Sun, 13 Dec 2009 17:42:31 +0100
Subject: Re: avc's generated causes the system to freeze up
From: Guido Trentalancia <guido@trentalancia.com>
To: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <dd18b0c30912111344j65436d86h85f8d74e752e19af@mail.gmail.com>
References: <dd18b0c30912111344j65436d86h85f8d74e752e19af@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 13 Dec 2009 17:42:30 +0100
Message-Id: <1260722550.2858.13.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Justin,

your question seems more of an audit question.

Why don't you use audit2allow to sort this out from a SELinux point of
view instead than trying to shut up audit ?

Audit2allow can generate custom rules for you from the analysis of your
audit log messages. The rules can then be compiled into a custom policy
module, that you can install with semodule.

On Fri, 2009-12-11 at 13:44 -0800, Justin Mattock wrote:
> I'm running X.Org X Server 1.7.99.2
> not sure if this is fixed with the latest
> but after building the latest refpolicy
> and defining my allow rules, both
> regularly, and with make enableaudit
> I still get avc's being generated here and there,
> but for some they seem to just spamm Xorg.0.log
> causing my system to freeze up.
> heres an example:
> 
> 
> (--) Synaptics Touchpad: touchpad found
> (**) Option "SendCoreEvents" "true"
> (**) Synaptics Touchpad: always reports core events
> (II) XINPUT: Adding extended input device "Synaptics Touchpad" (type: TOUCHPAD)
> (**) Synaptics Touchpad: (accel) keeping acceleration scheme 1
> (**) Synaptics Touchpad: (accel) acceleration profile 0
> (--) Synaptics Touchpad: touchpad found
> (WW) avc:  denied  { getattr } for request=X11:QueryPointer
> comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
> scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
> tclass=x_drawable
> (WW) avc:  denied  { getattr } for request=X11:QueryPointer
> comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
> scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
> tclass=x_drawable
> (WW) avc:  denied  { getattr } for request=X11:QueryPointer
> comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
> scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
> tclass=x_drawable
> (WW) avc:  denied  { getattr } for request=X11:QueryPointer
> comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
> scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
> tclass=x_drawable
> (WW) avc:  denied  { getattr } for request=X11:QueryPointer
> comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
> scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
> tclass=x_drawable
> (WW) avc:  denied  { getattr } for request=X11:QueryPointer
> comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
> scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
> tclass=x_drawable
> (WW) avc:  denied  { getattr } for request=X11:QueryPointer
> comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
> scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
> tclass=x_drawable
> (WW) avc:  denied  { getattr } for request=X11:QueryPointer
> comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
> scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
> tclass=x_drawable
> (WW) avc:  denied  { getattr } for request=X11:QueryPointer
> comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
> scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
> tclass=x_drawable
> (WW) avc:  denied  { getattr } for request=X11:QueryPointer
> comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
> scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
> tclass=x_drawable
> 
> 
> same avc's but just keeps generating.
> is there an option for this like
> printk_ratelimit?
> 
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
