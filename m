Subject: Re: Received a base module, expected a non-base module.
To: Jason Zaman <jason@perfinion.com>, selinux@tycho.nsa.gov
References: <20161003163208.GA19093@meriadoc>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <34e9545e-3056-db34-f04a-0861beae5981@tycho.nsa.gov>
Date: Mon, 3 Oct 2016 13:11:40 -0400
MIME-Version: 1.0
In-Reply-To: <20161003163208.GA19093@meriadoc>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/03/2016 12:32 PM, Jason Zaman wrote:
> Hey,
>
> I cant load base.pp now on gentoo :(. this is with 2.6-rc1.
>
> meriadoc mcs # semodule -vvv -b base.pp -i $(ls *.pp | grep -v base.pp)
> The --base option is deprecated. Use --install instead.
> Attempting to install module 'base.pp':
> libsemanage.parse_module_headers: Received a base module, expected a non-base module. (No such file or directory).
> semodule:  Failed on base.pp!
> meriadoc mcs # semodule -vvv -b base.pp
> The --base option is deprecated. Use --install instead.
> Attempting to install module 'base.pp':
> libsemanage.parse_module_headers: Received a base module, expected a non-base module. (No such file or directory).
> semodule:  Failed on base.pp!
> meriadoc mcs # semodule -vvv -i base.pp
> Attempting to install module 'base.pp':
> libsemanage.parse_module_headers: Received a base module, expected a non-base module. (No such file or directory).
> semodule:  Failed on base.pp!
>
> Anyone got any ideas?

It is due to the recent patch to use pp module name instead of the filename if 
they are different. I will work on a fix.

Thanks,
Jim

>
> -- Jason
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
