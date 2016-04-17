Subject: Re: genhomedircon USERID and USERNAME patches
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <20160201093633.GB21978@meriadoc.perfinion.com>
 <1460131535-15688-1-git-send-email-jason@perfinion.com>
 <CAJfZ7=mZnyW8-+BH02VJX7fBONyJTOHjHmkqByidz8cWw37Lcg@mail.gmail.com>
 <570CF09E.10100@tycho.nsa.gov> <570D079B.40106@tresys.com>
 <570E74FA.8060600@gmail.com> <570E7B15.6090906@tycho.nsa.gov>
 <570E7D73.5060302@gmail.com> <570E7F5A.8060006@gmail.com>
 <570E8F36.3060609@gmail.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <5713619B.3090604@gmail.com>
Date: Sun, 17 Apr 2016 12:12:43 +0200
MIME-Version: 1.0
In-Reply-To: <570E8F36.3060609@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 04/13/2016 08:25 PM, Dominick Grift wrote:
> On 04/13/2016 07:18 PM, Dominick Grift wrote:
> 
>>> Let me correct that:
> 
>>> "Even CIL-based modules can be installed via semodule and 
>>> managed via libsemanage, and libsemanage already contains a C 
>>> implementation of genhomedircon."
> 
> 
>>> that is not my point though. My point is: since we need a
>>> working genhomedircon for monolithic policy, we might cease
>>> the opportunity to also support text-based module policy which
>>> can be installed via semodule and managed via libsemanage, but
>>> does not strictly require that .
> 
> 
>> Make that "seize" instead (i think)
> 
> 
> I just realized that i do not have to bring CIL into the equation 
> here. We can keep it nice, simple and to the point. Refpolicy 
> genhomedircon needs to be updated (and needs just a general review
> to make it work again on modern distributions) as well to make this
> new functionality also work with monolithic policy.
> 
> Also since were on the discussion of genhomedircon, I might be
> wrong here, but I believe genhomedircon cannot currently deal with
> %group entries in seusers.
> 
> 

I think we should also generate file context specs for user mail spool
(is currently not done AFAIK in common module policy).

But if genhomedircon would not hardcode keywords and identifiers, then
i could accept them through the command line options and map it to
some hardcoded initial identifiers where/if needed

then one could specify on the command line the keyword, and any other
identifiers. So that is a bit more flexible so that when in the future
we get other instances where we need to generate contexts for some
location we dont have to edit the script we can just pass it some
additional new options. But yes then i suppose it would need to be a
standalone script. Added value there is that we then no longer have to
maintain to genhomedircon instances, one for libsemanage and one for
monolitic policy and text-based module policy.

- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXE2GXAAoJECV0jlU3+UdpHjML/0WTMGgEjjkgPuLduoOTxGjA
VBiiAOSIrrwh//TxXbbVxy1G46AHAD8SxBfC8TRCnAYMP01EVHpst7lLwXP4aDvH
a0Nhv7NV3nfdKCMuYKcXmGjPvkMD2u5v2JOpQjAM4s1AHxCm5irKq7rHZLeWfuVO
Ry4s0tQNRme8niHcr7I9jk50+ijxrUyKgh2CZQw0dmJ80nGCDXrbmGRYQYVY6Aw7
yNGhu7eoMbXd9yN5k9UAtT+kvLuD9gxahfokKECNqqLwWzf7ttP5idkDS8GQLYVM
OfogT6TKeQznqnU5y3ojTEVHy+2tjwjntVX4OSeBVietWH1Sulrv0SX0YhqjiYbQ
NE4GZi67JvExGXbGKSitMg6kSmivguUVIb7DAVviLW5FrHPWGZMybRFf/LtyZ3Ay
+GCgIFpeMn0933B4T6O6fZozcqpD66aFF9DWNvtQ2p9hIWzFNdxGwgg0B1gJJ0CO
eVReqMaR+15C1xiAoZz/C6Pa0r+qzTM8+0GorwEQ5A==
=ggrX
-----END PGP SIGNATURE-----
