Message-ID: <537CF36C.2010204@tycho.nsa.gov>
Date: Wed, 21 May 2014 14:41:48 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: secilc: in statement ordering limitations
References: <1400689802.5957.5.camel@x220.localdomain>
In-Reply-To: <1400689802.5957.5.camel@x220.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/21/2014 12:30 PM, Dominick Grift wrote:
> I got a little carried away with block and in statements (to say the
> least)
>
> I hit a limitation were ordering of modules matters (e.g. ordering of
> entries in LISTING or entries fed into secilc)
>
> I order my modules in alphabetical order so for example
> policy/modules/systemd/systemd.cil comes after
> policy/modules/system/dbus for example.
>
> If i, in the dbus.cil file now want to insert some declarations in a
> systemd block i hit issues due to that ordering issue
>
> If i move the systemd.cil up the stack then i can work around the
> ordering issue but it is a dead-end. Ordering issues suck (/me points to
> sidorder statement)
>
>

Thanks for the report. All ordering issues are bugs.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
