In-Reply-To: <1187099652.26008.171.camel@moss-spartans.epoch.ncsc.mil>
References: <D7B1D472-6E9E-407F-B9DE-E7D6B100F0CC@sf-net.com> <1187099652.26008.171.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9D2083D8-4914-4DFB-A062-B305926A5571@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: Re: [refpolicy] apt and rpm
Date: Wed, 15 Aug 2007 10:31:13 +0200
To: Stephen Smalley <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 14.08.2007, at 15:54, Stephen Smalley wrote:

> On Tue, 2007-08-14 at 08:14 +0200, Stefan Schulze Frielinghaus wrote:
>> Hello,
>>
>> I'm trying to fix the rules for apt and I have some questions
>> regarding how "rpm allow-rules" work.
>>
>> For example the last update was about the loadkeys package. In
>> permissive mode I get the following failures while updating:
>>
>> allow loadkeys_t apt_t:fd use;
>> allow loadkeys_t apt_t:fifo_file write;
>> allow loadkeys_t devpts_t:dir search;
>> allow loadkeys_t dpkg_t:fd use;
>> allow loadkeys_t dpkg_t:fifo_file { read write };
>> allow loadkeys_t newrole_t:fd use;
>> allow loadkeys_t sysadm_devpts_t:chr_file { read write };
>>
>> With other updates I get nearly the same errors. I beliefe that these
>> problems had rpm too. Because every package apt/rpm tries to  
>> exchange/
>> restart a file descriptor etc. will be needed. I could add for every
>> domain a apt_read_pipes(*) but I think this is _not_ the SELinux  
>> way ;-)
>>
>> How could I solve these ones? Is there an interface which regards
>> other programs more power while speaking with apt/rpm?
>
> Looks like rpm cheats ;)  I see rpm_use_fds() and rpm_read_pipes()  
> in an
> optional_policy block within the domain_type() definition in domain.if
> (underneath a comment about them being questionable).

I added these for apt and dpkg too.

>
> Also, I have to wonder how much benefit we derive from using separate
> domains for rpm vs. dpkg - abstractly they have the same purpose and
> require the same permissions, even if they exercise a slightly  
> different
> set and may be architected differently.  May be a tradeoff in least
> privilege vs. maintainable policy.   Domains are supposed to be
> equivalence classes.

Yeah, especially if you compare both dpkg.te and rpm.te. The main  
parts seem to be nearly the same. Only some little differences. It  
even looks like someone copied one of them and made only little  
changes. I think a merge is a nice idea. Makes handling/managing a  
little bit easier.

>
> On the other side, I have to wonder about putting both yum and rpm  
> into
> a single domain, as I could see them possibly being usefully
> differentiated.
>
> -- 
> Stephen Smalley
> National Security Agency
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
