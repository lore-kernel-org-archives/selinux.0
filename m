Message-ID: <537622CB.4060504@tycho.nsa.gov>
Date: Fri, 16 May 2014 10:38:03 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: secilc: classmappings do not work
References: <1400242442.444.9.camel@x220.localdomain>
 <53761EB7.5060906@tycho.nsa.gov>
In-Reply-To: <53761EB7.5060906@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/16/2014 10:20 AM, James Carter wrote:

>
> Also note that currently classmaps cannot be used in nametypetransition,
> rangetransition, type_rule, roletransition, validatetrans, default_user,
> default_role, default_type, or default_range rules.
>

I forgot to mention that I am currently working on this and should release a fix 
soon.


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
