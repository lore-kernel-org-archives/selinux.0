Subject: Re: genhomedircon USERID and USERNAME patches
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <20160201093633.GB21978@meriadoc.perfinion.com>
 <1460131535-15688-1-git-send-email-jason@perfinion.com>
 <CAJfZ7=mZnyW8-+BH02VJX7fBONyJTOHjHmkqByidz8cWw37Lcg@mail.gmail.com>
 <570CF09E.10100@tycho.nsa.gov> <570D079B.40106@tresys.com>
 <570E74FA.8060600@gmail.com> <570E7B15.6090906@tycho.nsa.gov>
 <570E7D73.5060302@gmail.com> <570E7F5A.8060006@gmail.com>
 <570E8F36.3060609@gmail.com> <5713619B.3090604@gmail.com>
 <57137BA9.6010501@gmail.com> <5713E1BD.60702@gmail.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <57147D4B.6070108@gmail.com>
Date: Mon, 18 Apr 2016 08:23:07 +0200
MIME-Version: 1.0
In-Reply-To: <5713E1BD.60702@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 04/17/2016 09:19 PM, Dominick Grift wrote:
> On 04/17/2016 02:03 PM, Dominick Grift wrote:
>> On 04/17/2016 12:12 PM, Dominick Grift wrote:
>>> On 04/13/2016 08:25 PM, Dominick Grift wrote:
>>>> On 04/13/2016 07:18 PM, Dominick Grift wrote:
> 
>>>>>> Let me correct that:
> 
>>>>>> "Even CIL-based modules can be installed via semodule and
>>>>>>  managed via libsemanage, and libsemanage already
>>>>>> contains a C implementation of genhomedircon."
> 
> 
>>>>>> that is not my point though. My point is: since we need a
>>>>>>  working genhomedircon for monolithic policy, we might
>>>>>> cease the opportunity to also support text-based module
>>>>>> policy which can be installed via semodule and managed
>>>>>> via libsemanage, but does not strictly require that .
> 
> 
>>>>> Make that "seize" instead (i think)
> 
> 
>>>> I just realized that i do not have to bring CIL into the 
>>>> equation here. We can keep it nice, simple and to the point. 
>>>> Refpolicy genhomedircon needs to be updated (and needs just
>>>> a general review to make it work again on modern
>>>> distributions) as well to make this new functionality also
>>>> work with monolithic policy.
> 
>>>> Also since were on the discussion of genhomedircon, I might
>>>> be wrong here, but I believe genhomedircon cannot currently
>>>> deal with %group entries in seusers.
> 
> 
> 
>>> I think we should also generate file context specs for user
>>> mail spool (is currently not done AFAIK in common module
>>> policy).
> 
>>> But if genhomedircon would not hardcode keywords and 
>>> identifiers, then i could accept them through the command line 
>>> options and map it to some hardcoded initial identifiers
>>> where/if needed
> 
>>> then one could specify on the command line the keyword, and any
>>>  other identifiers. So that is a bit more flexible so that
>>> when in the future we get other instances where we need to
>>> generate contexts for some location we dont have to edit the
>>> script we can just pass it some additional new options. But yes
>>> then i suppose it would need to be a standalone script. Added
>>> value there is that we then no longer have to maintain to
>>> genhomedircon instances, one for libsemanage and one for
>>> monolitic policy and text-based module policy.
> 
> 
> 
>> strangely the generated homedir_template does include my 
>> "USER_SPOOL" entries, i cant find any reference to it in the
>> code (maybe its a fedora patch??)
> 
>> nonetheless genhomedircon doesnt generate any contexts for me. I 
>> think it might not be able to deal with the namespaced user 
>> identities(sys.id instead of system_u for example)
> 
>> And then there is the issue that even though the genhomedircon 
>> seems to indicate that it supports USER and ROLE keywords. cil 
>> filecon statements do not allow me to specify USER and ROLE in 
>> filecon it seems.
> 
>> I use RBACSEP (defaultrole source) so i need to be able to 
>> associate the appropriate roles with filecon for user file cons
> 
>> All-in-all semodule/libsemanage is not an option for me. Too 
>> limited and too much assumptions/hard coding
> 
> 
> 
> I managed to get something semi-acceptable with this spec:
> 
> https://github.com/DefenSec/selinux-rpm-spec/blob/master/dssp-mcs-norb
ac
>
> 
sep.spec
> 
> (its awesome how i dont need any fancy make files, just semodule
> and sed to tweak some tunables if needed)
> 
> rbacsep disabled. genhomedircon now generates contexts for
> __default__ and since it can't deal with %group it leaves wheel
> users home dir contexts as __default__. it does not replace the
> sys.id because it can't deal with that, but thats not a big deal
> since i dont enforce ubacsep. The mcs part also doesnt hurt.
> 
> what is a problem though is that genhomedircon can't generate
> contexts for user mail spool files. So useradd and userdel might
> not work since they may exit when they determine that they can't
> create user mail spool files.
> 
> It is cool to see though how every module can be exported and be 
> replaced. Theres no concept of base. Everything is tweakable, 
> exportable and replaceable.
> 
> But genhomedircon should really be revisited with an open mind.
> 
> 

BTW i think there is a bug in semodule man page:

# Write the HLL version of puppet and the CIL version of wireshark
# modules at priority 400 to the current working directory
$ semodule \-X 400 \-g wireshark \-\-cil \-g puppet \-\-hll


There is no -g, i think -E is meant here

- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXFH1GAAoJECV0jlU3+UdpNo8L/1GXBJF3of611my7gYh//feU
bcRf3Gt2tgBe1ld+IAapbHtfwXDvfGcUdklbJTJVZ8kkHN7eCZuTEmgxNssv68k5
uPrB+lC+4k5kHMtx3gQda2znai9+PmouBD14B5m1tqFJ8UEK/J+qA76Yogae+B/A
dBZWk5I3voo0j9W2hoVFUoVBVuywgaUe07BaSzju6VIYbbTkSJCp+GDeP1k41civ
yxe7C4I9lbha3UwTmNhI372RNOjY4jrf+q3h268GfMG/1YKzqXqR2KJDQQ/rwfYn
lQBylsnqoskJuO6sE36dbmhnSto3eKdUm47Ef97Ae1ZRi8P9lCscg/aUnLsKgN0c
andLdz15ewQEvIbBGJ8y8jpuif3fMUSIVugsIbkVYceHAIIDDRFaDDM23ekKFoSI
iemP7hVeFtxXZ+Km0D0Hm/W6ChR/GSRUf/3/XyeNq+bfFhxdTWwpt9bCbvL+iM2P
hrbAr6SElfnuCPhu+DFM/IUHc0B3+ZgtTvRPwLRK7Q==
=kDdm
-----END PGP SIGNATURE-----
