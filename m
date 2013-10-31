Message-ID: <1383212707.7870.3.camel@d30>
Subject: Re: Update to CIL
From: Dominick Grift <dominick.grift@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        Steve Lawrence
 <slawrence@tresys.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Date: Thu, 31 Oct 2013 10:45:07 +0100
In-Reply-To: <52617C02.4060500@tycho.nsa.gov>
References: <52617C02.4060500@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2013-10-18 at 14:20 -0400, James Carter wrote:
> I pushed an update of CIL to bitbucket.

Here is another way to make secilc segfault:

> (typeattribute canrelabeltoshadow)
> 
> (typeattribute authunconfined)

> ; Never allow relabelto operation on shadow_t files unless the source
> ; is associated with canrelabeltoshadow or authunconfined
> 
> (typeattribute notcanrelabeltoshadoworauthunconfined)
> 
> (typeattributeset notcanrelabeltoshadoworauthunconfined
>             (not (or notcanrelabeltoshadoworauthunconfined authunconfined)))
> 
> (neverallow notcanrelabeltoshadoworauthunconfined shadow_t (file
>             (relabelto)))
> 

Its obviously a bug in the policy, but nonetheless it is like you said earlier: secilc should not segfault




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
