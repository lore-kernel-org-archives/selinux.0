Message-ID: <46CB783F.6080204@manicmethod.com>
Date: Tue, 21 Aug 2007 19:41:51 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinuxfs to globally disable dontaudit rules
References: <1186696737.20393.10.camel@localhost.localdomain>	 <Pine.LNX.4.64.0708091525410.30691@us.intercode.com.au>	 <46BBAE00.7050600@manicmethod.com>  <46BBBDDF.2000307@manicmethod.com>	 <1187285317.909.36.camel@moss-spartans.epoch.ncsc.mil>	 <46C48D2B.3010504@manicmethod.com>	 <1187286476.909.51.camel@moss-spartans.epoch.ncsc.mil>	 <46C48F01.40101@manicmethod.com> <1187287475.909.69.camel@moss-spartans.epoch.ncsc.mil> <46C4A4E7.8050902@manicmethod.com> <46CB4E14.3020809@redhat.com>
In-Reply-To: <46CB4E14.3020809@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> I would like to get these patches into policycoreutils.
>
>
> Submitted before, but here we go.
>
> Change run_tty and open_init_pty to 755 instead of 555.  Some audit 
> tools are reporting this as a problem.  And I see no real value of 
> 555. for these to.
>
> Simple bugfix for chcat
>
> Fixes to make sure fixfiles reports errors and handles strange regexes.
>
> Speed enhancement for genhomedircon to only compile regex's once.
>
The current plan is to change to a genhomedircon based on C in 
libsemanage. Have you looked at those patches to see if they suffer the 
same problem you are fixing here?

>
> I reverted sepolgen-ifgen from sbin to bin, but I doubt many/anyone 
> will run it as non root, but I guess you never no.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
