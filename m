Subject: Re: did libselinux grow a new build dependency? (openssl-devel:
 openssl.h)
To: Richard Haines <richard_c_haines@btinternet.com>,
 Dominick Grift <dac.override@gmail.com>
References: <20151018140730.GB19335@x250>
 <1360366462.3121760.1445180447166.JavaMail.yahoo@mail.yahoo.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <562531F6.8010609@tycho.nsa.gov>
Date: Mon, 19 Oct 2015 14:09:58 -0400
MIME-Version: 1.0
In-Reply-To: <1360366462.3121760.1445180447166.JavaMail.yahoo@mail.yahoo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/18/2015 11:00 AM, Richard Haines wrote:
>
>
>> On Sunday, 18 October 2015, 15:07, Dominick Grift <dac.override@gmail.com> wrote:
>
>>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA512
>>
>> On Sun, Oct 18, 2015 at 12:48:12PM +0000, Richard Haines wrote:
>>>   I added openssl to libselinux to support the new selabel_digest(3)
>>>   function.
>>>
>>>   I'm not aware of any issues between openssl and gnutls, however as
>>>
>>>   selabel_digest was only added last week I guess not much testing.
>>>   Well apart from myself as I'm currently adding the selinux_restorecon
>>>   feature that makes use of it.
>>>
>>
>> Thanks for clarifying, I am not hitting any issues with it just
>> wondering if instead of openssl, gnutls could be used for this and if
>
>> so, if this should be somehow supported or not.
>
> I tried using gnutls after I read your initial email, however I
> could not find a way to generate the same digest as openssl
> (I changed the SHA1 function to gnutls_hmac_fast(3) with various
> algorithms and used the selabel_digest util to compare digests).
> It could be that I should use some other function but I could
>
> not find any useful info on this (including web searches).
> If anyone knows how to resolve this please let me know.
>
> I guess what is supported (openssl or gnutls) would be down to
> the maintainers.

Wondering if dependency on openssl might be a license issue for Debian 
or others.  Apparently openssl license is considered GPL-incompatible 
[1] [2], and obviously libselinux is linked by a variety of GPL-licensed 
programs.  Fedora seems to view this as falling under the system library 
exception [3] but not clear that other distributions would view it that 
way.  On the other hand, using gnutls would be subject to the reverse 
problem; it would make libselinux depend on a LGPL library, and that 
could create issues for non-GPL programs that statically link 
libselinux.  We might need to revert this change and revisit how to 
solve this in a manner that avoids such issues.

[1] http://www.gnu.org/licenses/license-list.en.html#OpenSSL

[2] https://people.gnome.org/~markmc/openssl-and-the-gpl.html

[3] 
https://fedoraproject.org/wiki/Licensing:FAQ?rd=Licensing/FAQ#What.27s_the_deal_with_the_OpenSSL_license.3F)
