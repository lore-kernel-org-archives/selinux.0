Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3SEOpnD025225
 for <selinux@tycho.nsa.gov>; Thu, 28 Apr 2016 10:24:51 -0400
Received: by mail-wm0-f44.google.com with SMTP id e201so78857370wme.0
 for <selinux@tycho.nsa.gov>; Thu, 28 Apr 2016 07:24:26 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id b12sm31909267wmb.0.2016.04.28.07.24.24
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Thu, 28 Apr 2016 07:24:24 -0700 (PDT)
Subject: Re: Trying to setup a type bounds from unconfined_t and docekr_t to
 svirt_lxc_net_t
To: selinux@tycho.nsa.gov
References: <805268ee-75d6-4c43-7014-2dc7dd5ae01e@redhat.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <6df4f1f1-0bc5-1511-dcf3-f67024045554@gmail.com>
Date: Thu, 28 Apr 2016 16:24:24 +0200
MIME-Version: 1.0
In-Reply-To: <805268ee-75d6-4c43-7014-2dc7dd5ae01e@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 04/28/2016 03:15 PM, Daniel J Walsh wrote:
<snip>

> 
> Why does typebounds care about when a domain is the target of an
> access, I think it should only remove options when it is the
> source.
> 

I think the answer to your question is in this thread:

https://www.spinics.net/lists/selinux/msg16262.html

- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXIh0UAAoJECV0jlU3+UdpAvkL/RFPlH4Dwt/+cmVer8+FdGFo
wW9cFKQWCmHJBL/epwytSvhqkOJpG7oOuTVT4Iw01FaehPfmui0PRXrjc6Zfn3FA
VT+nyVtqnPt8Ai0IWoaewLl3F8y/BkgUEifQNJ+rgLz069ZDuxVPdjfP5SHgF6cT
q3tCfUH5FSV+gSK9fN9XPOP3FZQUG37IsQS14flOapbm0xXI8BaueyhV8STlgbTt
q0CBntL3vR4+qGz//E6GB/idsfpKmGnD9AJiPM35uvEnRc7XDk3SkNBGuK63eiKJ
B0UXjsLw1L6TcT83vmWDmWOvhKEFTfpPN5XlbHajtpq/YMR4YTzFGs+lU3gXvxJu
WTxPO2Kio8YLrnHcABgbZKRxo+0UCQdTCo5doMCL9SPdvUFQVOG04DGsPg3EOw1Q
pz6blAM9VHqgT/0oli1vSgP0+rgYwy9Y5d9APao90F1qil0gL9bac0K6btcfStD+
Ibs1ZjHtFpdgreX0oB5vnJWIDFJE/3W1apfbd3j8lQ==
=bfoh
-----END PGP SIGNATURE-----
