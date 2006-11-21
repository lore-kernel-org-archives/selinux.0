Message-ID: <45636F88.3020608@mentalrootkit.com>
Date: Tue, 21 Nov 2006 16:28:40 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Manoj Srivastava <manoj.srivastava@stdc.com>, selinux@tycho.nsa.gov
Subject: Re: Compiling libsepol with -fPIC instead of -fpic
References: <87d57pqkca.fsf@glaurung.internal.golden-gryphon.com>	 <4561E044.6050006@mentalrootkit.com> <1164143156.13758.125.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1164143156.13758.125.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2006-11-20 at 12:05 -0500, Karl MacMillan wrote:
>> Manoj Srivastava wrote:

>> Acked-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
> 
> Is the problem truly limited to libsepol, or is it also an issue with
> libsemanage and/or libselinux?
> 
> Possibly we could define it as a variable in the Makefile (e.g. PIC ?=
> -fpic) with a default of -fpic and allow you to build them with make
> PIC=-fPIC on SPARC to avoid any effect on x86.
> 

The docs claim an effect only on m68k, PowerPC, and SPARC. So it should 
be safe to replace this globally for all of our code.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
