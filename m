Date: Wed, 14 Oct 2015 19:38:40 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: does load_policy default to loading the lowest polvers available?
Message-ID: <20151014173839.GB15883@x250>
References: <561E5EF4.9080606@tycho.nsa.gov> <20151014141101.GB5222@x250>
 <561E63E0.1080609@tycho.nsa.gov> <20151014142952.GC5222@x250>
 <561E7840.50903@tycho.nsa.gov> <20151014154828.GA2909@x250>
 <561E7D47.7090306@tycho.nsa.gov> <20151014164145.GA11363@x250>
 <561E8872.3090404@tycho.nsa.gov> <20151014173416.GA15883@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <20151014173416.GA15883@x250>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, Oct 14, 2015 at 07:34:16PM +0200, Dominick Grift wrote:

> Setools(4) doesnt work with my policy (it can't deal with cil namespaces
> seemingly, and returns non-sense)
> 

Besides. did you know that setools (4) does not use
/sys/fs/selinux/policy? It uses /etc/selinux/SELINUXTYPE/policy/policy.X
instead. This sounded to me like a bad idea. Mainly because you don't
know if the /etc/selinux/SELINUXTYPE/policy/policy.X is the policy that
is currently actually loaded into the system. 

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWHpMaAAoJENAR6kfG5xmcdgkL/i7Az5S0OfmesKBEYshpztyV
UIgQ4gSQDPAe5TkVfjSUzGyaZDIv01RbvCXcl5gWAYpdQuMW97FpAtWwSyz6cRrT
63oKBUJcuCJgIrx5kp6IWBemYVWoNy+/x3VDEOLp5gNbQUhmLRsrfIUK1Ui0DdSo
ya0Up4tLMbxtZQweDuOKiY2PBfSrf/MpmSpEk2um7QXiJbtePOUlVRRt4Cm9vvq3
IJlzalLaYtygp/HNaiYni3cSyDOElDluN3HalGI1U1NYUGzcHfmiyR/6BJVHg1DO
XkhMRzu6Jj1D00KIbjf6VFFp7vhmHR7X+OG8OVUHZqq2g1/9OgOBCUq+Pd48FnLw
/w/LFhNJxDrpDd8pvXJvqNw648IrgbrXiqTkunRkyM7n5l1pLO3DNqNSpOZRA17G
FKiD6vD+C1XAXzBVi6MDrpGyNPO5LJbnoxV3zFQA+Q8v+wlgpmeQUYvDCMx6gqP3
+3GDAEiIosP4VI72QUVbZKcksmVfzrRtTm2nlIQxFA==
=RdNr
-----END PGP SIGNATURE-----
