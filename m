Date: Thu, 15 Oct 2015 14:08:17 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: does load_policy default to loading the lowest polvers available?
Message-ID: <20151015120816.GA19471@x250>
References: <20151014203418.GA7159@x250>
 <942047750.1202558.1444910296027.JavaMail.yahoo@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <942047750.1202558.1444910296027.JavaMail.yahoo@mail.yahoo.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Thu, Oct 15, 2015 at 11:58:16AM +0000, Richard Haines wrote:
> I'm not sure if this will resolve the problem but you say it only happens
> on the workstation build. I assume then you may be loading X windows, therefore
> try setting up a /etc/X11/xorg.conf.d file with the following:
> 
> Section "Module"
>         SubSection "extmod"
>                 Option "SELinux mode disabled"
>         EndSubSection
> EndSection
> 
> If this works then the problems are:
> 1) Your policy does not have an x_contexts file (I didn't see one in your CIL policy)
> 2) The X windows object manager probably still looks for the xserver_object_manager
> boolean to enable/disable X. If you add this to your policy and default to false
> you will not need the above entry in xorg.conf.d.
> 

Thanks for the suggestion, I already have that snippet, so this is not
the issue. It would not make sense either because without the above
things would consistently fail.

This issue I have is inconsistent. One boot everything is fine , and the next
the issue can happen.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWH5csAAoJENAR6kfG5xmcWh4L/0tZXzsAzk28D8blZeX+lp7O
EraCItPr/chIIJ2Cq4nUtCOgYq5ebGR4InZZufsaT9JvOW+GqV3ktGydnfo9+odN
wPcU+/jNW2vYNzVoTBy35E6bUSBWTzDSEUlyhJysQZEzmodf4VmiSRaLEUhaQxci
EwDet5RQEQ3xBq9LXgw2YHKUkbiPGA35Rkz1atwLBVVJuHnbSeSAWwTx3AbQaKrF
zK1OkqmwdPWgQ5b2Jq6nVgWjbCkjiaNvmTZjLCKJRx6tPWlAucsI9SVihO4vUL7n
lKh2dK/Vci7GRtfP23VEh9p97phxNborXcvrGA6JQWOV0aAgL8pbg2t4ecMJw9qt
RZSsyehWW1I1M7SKcFj5vRAwE/UDycK0uriHrgx2vvVhx8rtHE2HU/DFxKWDhi9Y
bTE1olMTQH0cUZoePvymbsKVS6XKLKYPgL5lgiCu8mgTAdPJMZQGvrgg1l3H1Xv7
G740LSaRbCMr+Mh2GV+auBK8ykjq3nrbWSJquQD+gQ==
=NW+R
-----END PGP SIGNATURE-----
