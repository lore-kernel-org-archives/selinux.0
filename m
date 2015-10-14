Date: Wed, 14 Oct 2015 20:07:44 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: does load_policy default to loading the lowest polvers available?
Message-ID: <20151014180743.GD15883@x250>
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

Demo, proof (only 8 minutes long):

https://www.youtube.com/watch?v=iNOxp2d_ws0

I demonstrates the inconsistency, also it proves that the rules are
loaded

> 
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWHpnrAAoJENAR6kfG5xmcpkUL/jLi74ktX9Fy9uzs1pG3DtKi
67+455YxFjjpLvoZxezeGHQkMKRs16uOv1yb9J4zWzQ+veDUOasfmylmKlJxE8Zx
oO7OcwAYv778Nr7PMPx90IFlYCz2plmk3S1rlx2HsoUyhxQbLh4xPV3apZtjlyle
TpzNsL1muqukjplISSc6d46OkTbtmNirWFBKzZYL6mE+XGJrU/DaZMVqguQPVedP
WWgE/R5nhr+0fqmT6chsZA7DCHfuy24fdRyMDu1pqip2RyfO1VR+5mWG/4MOSZn4
cXCZ/rbV9peSNsUgDUtKgnNWlUUYD6WQEVpuqh0pMrP577KgFSXnwGlcsCziubeK
2WPzSqTY+1j8rKiiWkIgtUi01S2CgpJvQ4EkDq4jZYr332Gk7gRQFQx1RLUukbdN
EZYxtVn92nR+lhtdgChATKRIHM9LG61FZO1iXyjpKje1edH3CgBDgHAGVv3UoObe
1Ruo3Mr1N3aSH6Wph64VEZReIneISKVMU8a1LTY23g==
=TKEp
-----END PGP SIGNATURE-----
