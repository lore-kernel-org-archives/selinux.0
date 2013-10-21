Message-ID: <526578E8.1010908@tycho.nsa.gov>
Date: Mon, 21 Oct 2013 14:56:40 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>
CC: Dominick Grift <dominick.grift@gmail.com>,
        SELinux List <selinux@tycho.nsa.gov>,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: Update to CIL
References: <52617C02.4060500@tycho.nsa.gov> <1382126564.3041.13.camel@d30> <1382189566.3041.34.camel@d30> <52652B51.8050601@tresys.com>
In-Reply-To: <52652B51.8050601@tresys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/21/2013 09:25 AM, Steve Lawrence wrote:
> On 10/19/2013 09:32 AM, Dominick Grift wrote:

>>
>> Also i was not able to write TE AV rules with two target types. e.g.
>> where we previously used brace expansion: allow bla_t { foo_t
>> bar_t }:file read;
>
> Yes, the source/target parameters of the allow rule only allow a single type or
> typeattribute. CIL is not meant to be succinct. You'll find there's a great deal
> of repetition. The idea is that higher level languages would allow for
> succinctness.
>
>> I tried several things like: (allow (bla_t ( foo_t bar_t))
>> all_file_perms), but no go
>
> If you really don't want two allow rules, you can create a typeattribute:
>
>    (typeattribute foobar)
>    (typeattributeset foobar (foo_t bar_t))
>    (allow bla_t foobar all_file_perms)
>
> But unless the foobar attribute has some kind of meaning, it probably makes more
> sense to just have two allow rules.
>

We wanted to prevent writing rules such as "allow foo_t { file_type -bar_t 
}:file read;" which expand into a large number of rules. Dan and others have 
converted a large number rules like this into ones using attributes which has 
really reduced the size of the binary policy. CIL requires what we believe to be 
the best practice.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
