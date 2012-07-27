MIME-Version: 1.0
In-Reply-To: <3138EE6F-F894-46F2-A233-E3F014B1257C@nall.com>
References: <CAO-4OdHA5cawkDUOqHWMKP9tSqtEKosGincjcycENUr47Qjt3A@mail.gmail.com>
	<3138EE6F-F894-46F2-A233-E3F014B1257C@nall.com>
Date: Thu, 26 Jul 2012 18:15:48 -0700
Message-ID: <CAFftDdqjHjjT2Ond9NHd7qkiYyFaEKYv3CZt2HxrPKsTQU-r8Q@mail.gmail.com>
Subject: Re: Questions about the MLS to "read down"
From: William Roberts <bill.c.roberts@gmail.com>
To: Joe Nall <joe@nall.com>
Cc: Haiqing Jiang <hqjiang1988@gmail.com>, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

How did you determine that c42 doesn't dominate c16?

Ive been looking at:
http://selinuxproject.org/page/NB_MLS

I understand that s is for sensitivity and c is for category so their
separate entities. But the level is determined by the "level"
statement and is combination of s, c and number to determing the
level.

in mls of sepolicy for Android their is:
# Generate level definitions for each sensitivity and category.
gen_levels(mls_num_sens,mls_num_cats)

How would one specify that one level can dom another?

On Thu, Jul 26, 2012 at 6:03 PM, Joe Nall <joe@nall.com> wrote:
>
> On Jul 26, 2012, at 5:49 PM, Haiqing Jiang <hqjiang1988@gmail.com> wrote:
>
>> Hi, all
>>
>> I have the following denials. But from my understanding, the reading-down rule is not violated according to the scontext and tcontext. Could you help to explain why? Thanks.
>>
>> <5>[15423.456451] type=1400 audit(1342836229.562:2241): avc:  denied  { read } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=127269 scontext=u:r:release_app:s0:c42 tcontext=u:r:shared_app:s0:c16 tclass=lnk_file
>
> s0:c42 and s0:c16 are incomparable. c42 doesn't dominate c16. There may be additional type issues as well.
>
> joe
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
