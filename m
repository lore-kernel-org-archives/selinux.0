Message-ID: <537F4A07.70403@tycho.nsa.gov>
Date: Fri, 23 May 2014 09:15:51 -0400
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

I am having problems reproducing the problem.

In one file, I have:

(block bb
	(type t1)
	(type t2)
	(boolean b1 false)
	(tunable tun1 true)
	(macro m ((boolean b))
		(tunableif tun1
			(true
				(allow t1 t2 (policy.file (write))))
			(false
				(allow t1 t2 (policy.file (execute)))))
		(booleanif b
			(true
				(allow t1 t2 (policy.file (read))))))

	(call m (b1))
)

and in another, I have:

(in bb
	(tunableif bb.tun1
		(true
			(allow t2 t1 (policy.file (read write execute)))))
	(type t3))

The order that I send the files to secilc doesn't seem to matter.

Could you give me a little bit more information on what you are doing?

Thanks,
Jim

> If i move the systemd.cil up the stack then i can work around the
> ordering issue but it is a dead-end. Ordering issues suck (/me points to
> sidorder statement)
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
