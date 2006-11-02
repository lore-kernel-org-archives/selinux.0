Message-ID: <454A654F.5020902@us.ibm.com>
Date: Thu, 02 Nov 2006 15:38:23 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH 3/4] newrole suid functionality (take 2)
References: <45351FC9.2080204@us.ibm.com>  <45352427.20705@us.ibm.com>	 <1161630359.3316.127.camel@moss-spartans.epoch.ncsc.mil>	 <454A2966.5050702@us.ibm.com>	 <1162492463.5519.23.camel@moss-spartans.epoch.ncsc.mil>	 <454A568C.3060201@us.ibm.com> <1162500860.5519.105.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1162500860.5519.105.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> The man page for setlocale() says:
> 	If locale is "", each part of the locale that should be modified is set
> according to the environment variables.
> 
> Which doesn't sound like it is sanitizing them.  Possibly it has
> different behavior in the libc_enable_secure case, which would be 1 for
> newrole (even the non-suid newrole, due to the domain transition), but I
> don't know offhand.  NLSPATH is on the unsecvars list, so it would be
> ignored.

I read through the glibc source, and glibc does checking for '/' in the 
values obtained from the environment.

>> There isn't any propsed change in this code, just a better understanding 
>> from the coder. If this is suggested code flow looks OK, I will clean up 
>> the rest of my code and send out the next round of patches.
> 
> I take it that su and friends don't do anything special here prior to
> calling the localization functions?

Right, the calls to setlocale, bindtextdomain and textdomain is 
basically the first thing that they do. They also seem to not worry 
about the environment until much later as well.

I'm find it hard to know where to stop worrying and trust the 
libraries... because understanding absolutely everything that's going on 
will not make for a timely patch. Although I would rather not trust 
anything.

Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
