Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u93HOdMm015119
 for <selinux@tycho.nsa.gov>; Mon, 3 Oct 2016 13:24:39 -0400
Received: by mail-pa0-f54.google.com with SMTP id qn7so62996992pac.3
 for <selinux@tycho.nsa.gov>; Mon, 03 Oct 2016 10:24:27 -0700 (PDT)
Date: Tue, 4 Oct 2016 01:24:23 +0800
From: Jason Zaman <jason@perfinion.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: Received a base module, expected a non-base module.
Message-ID: <20161003172423.GA31836@meriadoc>
References: <20161003163208.GA19093@meriadoc>
 <34e9545e-3056-db34-f04a-0861beae5981@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <34e9545e-3056-db34-f04a-0861beae5981@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Oct 03, 2016 at 01:11:40PM -0400, James Carter wrote:
> On 10/03/2016 12:32 PM, Jason Zaman wrote:
> > Hey,
> >
> > I cant load base.pp now on gentoo :(. this is with 2.6-rc1.
> >
> > meriadoc mcs # semodule -vvv -b base.pp -i $(ls *.pp | grep -v base.pp)
> > The --base option is deprecated. Use --install instead.
> > Attempting to install module 'base.pp':
> > libsemanage.parse_module_headers: Received a base module, expected a non-base module. (No such file or directory).
> > semodule:  Failed on base.pp!
> > meriadoc mcs # semodule -vvv -b base.pp
> > The --base option is deprecated. Use --install instead.
> > Attempting to install module 'base.pp':
> > libsemanage.parse_module_headers: Received a base module, expected a non-base module. (No such file or directory).
> > semodule:  Failed on base.pp!
> > meriadoc mcs # semodule -vvv -i base.pp
> > Attempting to install module 'base.pp':
> > libsemanage.parse_module_headers: Received a base module, expected a non-base module. (No such file or directory).
> > semodule:  Failed on base.pp!
> >
> > Anyone got any ideas?
> 
> It is due to the recent patch to use pp module name instead of the filename if 
> they are different. I will work on a fix.

ooh, I should have remembered that one. fwiw, all the other modules load
just fine its only base.pp that has issues. Would renaming it to
something else make a difference?

-- Jason

> Thanks,
> Jim
> 
> >
> > -- Jason
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> >
> 
> 
> -- 
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
