MIME-Version: 1.0
In-Reply-To: <4B2677DF.6060801@tycho.nsa.gov>
References: <dd18b0c30912111344j65436d86h85f8d74e752e19af@mail.gmail.com>
	 <4B2677DF.6060801@tycho.nsa.gov>
Date: Mon, 14 Dec 2009 12:39:49 -0600
Message-ID: <cadfc0e40912141039p663a94aenf7094946736a834c@mail.gmail.com>
Subject: Re: avc's generated causes the system to freeze up
From: Xavier Toth <txtoth@gmail.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Justin Mattock <justinmattock@gmail.com>,
        tresys <refpolicy@oss1.tresys.com>, xorg@freedesktop.org,
        SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 14, 2009 at 11:37 AM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
> On 12/11/2009 04:44 PM, Justin Mattock wrote:
>> I'm running X.Org X Server 1.7.99.2
>> not sure if this is fixed with the latest
>> but after building the latest refpolicy
>> and defining my allow rules, both
>> regularly, and with make enableaudit
>> I still get avc's being generated here and there,
>> but for some they seem to just spamm Xorg.0.log
>> causing my system to freeze up.
>> heres an example:
>>
>
>
> If the denials are not causing a problem other than log spam, just use a
> dontaudit rule to silence them.
>
>
>
>>
>> (--) Synaptics Touchpad: touchpad found
>> (**) Option "SendCoreEvents" "true"
>> (**) Synaptics Touchpad: always reports core events
>> (II) XINPUT: Adding extended input device "Synaptics Touchpad" (type: TOUCHPAD)
>> (**) Synaptics Touchpad: (accel) keeping acceleration scheme 1
>> (**) Synaptics Touchpad: (accel) acceleration profile 0
>> (--) Synaptics Touchpad: touchpad found
>> (WW) avc:  denied  { getattr } for request=X11:QueryPointer
>> comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
>> scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
>> tclass=x_drawable
>> (WW) avc:  denied  { getattr } for request=X11:QueryPointer
>> comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
>> scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
>> tclass=x_drawable
>> (WW) avc:  denied  { getattr } for request=X11:QueryPointer
>> comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
>> scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
>> tclass=x_drawable
>> (WW) avc:  denied  { getattr } for request=X11:QueryPointer
>> comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
>> scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
>> tclass=x_drawable
>> (WW) avc:  denied  { getattr } for request=X11:QueryPointer
>> comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
>> scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
>> tclass=x_drawable
>> (WW) avc:  denied  { getattr } for request=X11:QueryPointer
>> comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
>> scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
>> tclass=x_drawable
>> (WW) avc:  denied  { getattr } for request=X11:QueryPointer
>> comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
>> scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
>> tclass=x_drawable
>> (WW) avc:  denied  { getattr } for request=X11:QueryPointer
>> comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
>> scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
>> tclass=x_drawable
>> (WW) avc:  denied  { getattr } for request=X11:QueryPointer
>> comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
>> scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
>> tclass=x_drawable
>> (WW) avc:  denied  { getattr } for request=X11:QueryPointer
>> comm=/usr/bin/pidgin resid=10001fc restype=WINDOW
>> scontext=justin:user_r:user_t tcontext=justin:object_r:mplayer_t
>> tclass=x_drawable
>>
>>
>> same avc's but just keeps generating.
>> is there an option for this like
>> printk_ratelimit?
>>
>>
>>
>
>
> --
>
> Eamon Walsh
> National Security Agency
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

Sounds to me like Justin needs the QueryPointer spoofing code.

Ted


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
