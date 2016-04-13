Subject: Re: genhomedircon USERID and USERNAME patches
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <20160201093633.GB21978@meriadoc.perfinion.com>
 <1460131535-15688-1-git-send-email-jason@perfinion.com>
 <CAJfZ7=mZnyW8-+BH02VJX7fBONyJTOHjHmkqByidz8cWw37Lcg@mail.gmail.com>
 <570CF09E.10100@tycho.nsa.gov> <570D079B.40106@tresys.com>
 <570E74FA.8060600@gmail.com> <570E7B15.6090906@tycho.nsa.gov>
 <570E7D73.5060302@gmail.com> <570E7F5A.8060006@gmail.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <570E8F36.3060609@gmail.com>
Date: Wed, 13 Apr 2016 20:25:58 +0200
MIME-Version: 1.0
In-Reply-To: <570E7F5A.8060006@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 04/13/2016 07:18 PM, Dominick Grift wrote:

>> Let me correct that:
> 
>> "Even CIL-based modules can be installed via semodule and
>> managed via libsemanage, and libsemanage already contains a C 
>> implementation of genhomedircon."
> 
> 
>> that is not my point though. My point is: since we need a working
>>  genhomedircon for monolithic policy, we might cease the
>> opportunity to also support text-based module policy which can be
>> installed via semodule and managed via libsemanage, but does not
>> strictly require that .
> 
> 
> Make that "seize" instead (i think)
> 

I just realized that i do not have to bring CIL into the equation
here. We can keep it nice, simple and to the point. Refpolicy
genhomedircon needs to be updated (and needs just a general review to
make it work again on modern distributions) as well to make this new
functionality also work with monolithic policy.

Also since were on the discussion of genhomedircon, I might be wrong
here, but I believe genhomedircon cannot currently deal with %group
entries in seusers.

- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXDo8yAAoJECV0jlU3+Udp7MYL/RjPxkBJMaueFJPP9rl93b/v
Jna5u8DdZLBXOCXNxViu7RKVEWgQ/l0c/DjousjnxsZ3RHAVPQ+p54OJLioyJmxj
PUrfp/xpeNkp/w/J2pKv/ElFl1hikQg8jqJsSJYLowTdP24cjgwNnXSWLOdsQdBH
mRPramRrTx/34SWcl2WMRC4MbVSnTEFM9S3OvjQWKHzImEqmgfEVR8d6XU9qe+oy
4qasZOT6sFNq/p9/lpHv7HuyjlysuVfKRnp6N4m/xgZ7/zOkLfTy2ozsVWRcRUHl
vsNGq/RHkiqNgozNZ6QjUfyOwv18wZrO3gFc/g4DSjJs97Iteej4vJw4/TrI1h4L
EiC31l2JU57Hq2ySVxK6BPxyMfLvxkE8dsGwJ/H1ABMvkQfqVCSW0ih2EmvI1jvo
fH1DWPPxwc1bBBtaWGr5MovdRF6vtud4Md+zufMqW0j3lLZTWVqASy+DuLFeRsIy
ZHjLSCNa9QHuc97QwCxuVRZJAWWSe9FvpAStNH/tAQ==
=nbjE
-----END PGP SIGNATURE-----
