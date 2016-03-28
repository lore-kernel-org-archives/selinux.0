Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2SDMwxE008053
 for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2016 09:22:58 -0400
Received: by mail-wm0-f45.google.com with SMTP id p65so98496836wmp.1
 for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2016 06:22:57 -0700 (PDT)
Subject: Re: CIL: invalid protocol (dccp portcon)
To: Paul Moore <paul@paul-moore.com>
References: <56F9293A.6090902@gmail.com>
 <CAHC9VhRmUz0tJs9ZNKrV8wgrOoSNokoLz2UhVM8yArRQpjztOg@mail.gmail.com>
Cc: selinux@tycho.nsa.gov
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <56F9302F.2060002@gmail.com>
Date: Mon, 28 Mar 2016 15:22:55 +0200
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRmUz0tJs9ZNKrV8wgrOoSNokoLz2UhVM8yArRQpjztOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 03/28/2016 03:21 PM, Paul Moore wrote:
> On Mon, Mar 28, 2016 at 8:53 AM, Dominick Grift
> <dac.override@gmail.com> wrote:
>> I was adding support for syslog ports, and /etc/services
>> indicated to me that syslog(_tls) has support for dccp protocol.
>> So tried to add that support in.
>> 
>> However when trying to specify a portcon, secilc tells me dccp is
>> an invalid protocol.
>> 
>> e.g.
>> 
>> (portcon "dccp" 6514 port_obj_context)
> 
> I'm not sure if the CIL toolchain checks /etc/protocols or if it
> uses hardcoded values, but did you check to make sure "dccp" is
> listed in /etc/protocols?
> 

did'nt check, but did now. it is in there.

- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJW+TArAAoJECV0jlU3+UdpCToL/RJ7/gTd41XwLiSj3Zn7WVim
XoNXj27ULqaF2wpODpPQEtRT3ugE8VfWHbu86n25Hx1INahkd4ec0ufmZd1IDrFH
amIirVx7vVlVWQIZswAqp6Q0+rWAmaU3CegzIfqoENZnxDUmSAKsU5AuNbcA4WVL
AcZh6CiwwffgMC5buxiV3cgKT2k5gaTXa+pSe3quFU0hzHNxJMiNQJR7Qps0TSB2
QFhzFJMiYOyhbo04mLpknOaKY2G3W3HNaR5Uum/C8RR8QZemHwGaZbg51QLKCkT5
eyHbu/qdXJLZS+Hw0UCY5HqJTdHKaZVF4Pf25P3ImjpATtnmeYNH+WtLSdyxtLrs
BdvLjdl5br48mBBLJtUuIUYwCBETYWZRbiNYshQ2AjrTrHTcc/MgaILbdurJBq4c
776kr2yFODrhdwEfd0JsJJ8/AaB1DRFaGmKu/R4DxVdRIzM0ttki0LViaok5AnQ2
D/nW/jkIqJ9s1BC1AIxezN4vbWv03xTLpQZfo1R5aQ==
=EDvL
-----END PGP SIGNATURE-----
