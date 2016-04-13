Subject: Re: genhomedircon USERID and USERNAME patches
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <20160201093633.GB21978@meriadoc.perfinion.com>
 <1460131535-15688-1-git-send-email-jason@perfinion.com>
 <CAJfZ7=mZnyW8-+BH02VJX7fBONyJTOHjHmkqByidz8cWw37Lcg@mail.gmail.com>
 <570CF09E.10100@tycho.nsa.gov> <570D079B.40106@tresys.com>
 <570E74FA.8060600@gmail.com> <570E7B15.6090906@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <570E7D73.5060302@gmail.com>
Date: Wed, 13 Apr 2016 19:10:11 +0200
MIME-Version: 1.0
In-Reply-To: <570E7B15.6090906@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 04/13/2016 07:00 PM, Stephen Smalley wrote:
> On 04/13/2016 12:34 PM, Dominick Grift wrote:
>> On 04/12/2016 04:35 PM, Christopher J. PeBenito wrote:
>> 
>>> Right, the script that refpolicy has is only used on
>>> monolithic builds.
>> 
>> 
>> As I recall, last time i tried it, it was not working on a 
>> redhat-based system. Probably bit-rot has set in. There is also
>> some hard-coding going on in there i believe.
>> 
>> Someone with c-skills should rewrite it in c, make it truly
>> portable. That way it can be used with both monolithic as well as
>> modular policy (i don't mean binary-based module policy here but
>> text-based module policy that otherwise does not require the
>> presence of semodule)
> 
> Even CIL-based modules are installed via semodule and managed via 
> libsemanage, and libsemanage already contains a C implementation
> of genhomedircon.
> 
> 

Let me correct that:

"Even CIL-based modules can be installed via semodule and managed via
libsemanage, and libsemanage already contains a C implementation of
genhomedircon."


that is not my point though. My point is: since we need a working
genhomedircon for monolithic policy, we might cease the opportunity to
also support text-based module policy which can be installed via
semodule and managed via libsemanage, but does not strictly require that
.


- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXDn1vAAoJECV0jlU3+UdpkP4MAIhmW/ghl9/pVBVSX+56lZEB
ns9znLpwUSv50kcYDh9e8lfWrIOlJGgXD86D2pnCU2AjJbxvBWaEQpPw0Z0c+Vmy
M8NvBTqm763mTZ2ANgGFjWpE0cAOAFIHBmfNhacl6fyUwVLfxZA/locUh9SJIsqd
AhSx+lt9t2uMxB7W2PoCf6Bwpz+fQDbnD+3vaU5ZIcu/sNYGYd4Pmf4jYl38QR1P
vxCIrj4OTJrT7w0A0/J98d7jBnLsvvb63Jjm+5HP3PP5mHn0DGu6/qEBKJcuYWPP
tyRIVzlvreRrrVoF6u9BtgDD7+/1XXco20yoQanXCr2fhox5OkW8/TerK9KEcbwE
a4MZyDPlTrpthprznvSSaCo5uK6xCoaIBR9GjBlU3L/CUzI6ZioEoVwX9wxMpskA
TGtYRJyCVlrxYCy7ec/qEBY3vTg61DsTwq2fL84F+11NoJofIBuY2AwqQ5WpJmwN
WRtkEVQWqtxE1cybXhiQX0UIlBt3uqcHO6+Xr5TYSQ==
=u/g3
-----END PGP SIGNATURE-----
