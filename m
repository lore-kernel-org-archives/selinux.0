Message-ID: <4A806D3C.1070407@tycho.nsa.gov>
Date: Mon, 10 Aug 2009 14:55:56 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Justin Mattock <justinmattock@gmail.com>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: compiling SELinux in xserver seems to not find /lib64
References: <dd18b0c30908101127m38999d83h655a0e58751138cf@mail.gmail.com>
In-Reply-To: <dd18b0c30908101127m38999d83h655a0e58751138cf@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/10/2009 02:27 PM, Justin Mattock wrote:
> seems I'm hitting this error while building
> the xserver:(with enabling selinux)
>
> make[4]: *** No rule to make target `-lselinux', needed by `Xorg'.  Stop.
>
> here's how I compiled the xserver:
>
>
>   ./configure --enable-install-setuid
> --with-dri-driver-path="/usr/lib64/xorg/modules/dri"
> --with-fontdir="/usr/share/fonts"  --with-log-dir=/var/log
> --enable-secure-rpc --enable-xcsecurity --enable-xselinux
> --enable-config-dbus --prefix=/usr --libdir=/usr/lib64
> --sysconfdir=/etc --localstatedir=/var LDFLAGS=-L/lib64 LIBS=-L/lib64
> CFLAGS=" -m64 -mtune=core2 -march=core2 -mfpmath=both  -O2 -pipe
> -fomit-frame-pointer -fstack-protector" CXXFLAGS="${CFLAGS}"
> MAKEOPTS="{-j3}" PKG_CONFIG_PATH=/usr/lib64/pkgconfig LDFLAGS=-L/lib64
> LIBS=-L/lib64
>
> even giving this twice seems to make no difference.
> LDFLAGS=-L/lib64 LIBS=-L/lib64
>
> any ideas?
>
>    


Can you save the build output to a file and send it as an attachment?
Configure with --disable-shave or use "V=1" on the make command line to 
disable the abbreviated kernel-style output.

-- 
Eamon Walsh<ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
