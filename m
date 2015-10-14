Date: Wed, 14 Oct 2015 19:51:21 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: does load_policy default to loading the lowest polvers available?
Message-ID: <20151014175121.GC15883@x250>
References: <561E63E0.1080609@tycho.nsa.gov> <20151014142952.GC5222@x250>
 <561E7840.50903@tycho.nsa.gov> <20151014154828.GA2909@x250>
 <561E7D47.7090306@tycho.nsa.gov> <20151014164145.GA11363@x250>
 <561E8872.3090404@tycho.nsa.gov> <20151014173416.GA15883@x250>
 <20151014173839.GB15883@x250> <561E937A.9080909@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <561E937A.9080909@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, Oct 14, 2015 at 01:40:10PM -0400, Stephen Smalley wrote:
> On 10/14/2015 01:38 PM, Dominick Grift wrote:
> >On Wed, Oct 14, 2015 at 07:34:16PM +0200, Dominick Grift wrote:
> >
> >>Setools(4) doesnt work with my policy (it can't deal with cil namespaces
> >>seemingly, and returns non-sense)
> >
> >
> >Besides. did you know that setools (4) does not use
> >/sys/fs/selinux/policy? It uses /etc/selinux/SELINUXTYPE/policy/policy.X
> >instead. This sounded to me like a bad idea. Mainly because you don't
> >know if the /etc/selinux/SELINUXTYPE/policy/policy.X is the policy that
> >is currently actually loaded into the system.
> 
> It should use selinux_current_policy_path() to find the policy.
> 
> In any event, did you try compute_av from libselinux on the system in
> question?
> 

# compute_av sys.id:sys.role:sd_machined.subj:s0
  sys.id:sys.role:sd.subj:s0 system
  allowed= { status start stop }

So yes, the rules are there (but again that is obvious to me because it
works sometimes but not most of the time) If the rules were absent then
it would fail all the time.



- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWHpYUAAoJENAR6kfG5xmcxhAL/18KZYziduq0hsUwo9kf/Vne
puNoyO7kXgD7iKyMP1r4RSRZViacffnTIsdM1l8VreWMEeL5XugPdwQvNAnOyCMX
hQVmEqpWXbCE636lsa7XLqkpskTDhTxJh3Cz74az7hQFmdMG7DMZm6qy1fMlo8hg
cvAThoj79Kda1I7OodcvRRy2QuR0Q8XZZdREsH22hIT2GdiyR3dhVkGovyWIKKew
cccSnj0G6uXUEQFm/d82zBlPCwz38jvpxse8FLrCFIyfS4VMK/PUO9207K/xfUjB
IVjlVsfUGgFpz8yKTrU7cHhuKn6FafcLZJH/lOwXRTMIfjwYae/goBLfBQyrCjma
yzqeH07xqXMke+9roU1lKSrjCiG1CTbeK5xCzykllP866qHOE8Xj399SpJqr7vb2
LBNSE+AoLXKoVXBMsByBexOK8+iyHwWaKptU6ScemN38U0Mu1tpjHwOe5McMnFez
h+m2KKF3Z8S12OlSHFO1dpeUUqPJeElZrpvJyA+G1w==
=qwgA
-----END PGP SIGNATURE-----
