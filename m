Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1GN6XZ027388
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 11:23:06 -0500 (EST)
Received: from tcsfw2.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1GLiCC008856
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 16:21:45 GMT
Message-ID: <418662EE.5090001@trustedcs.com>
Date: Mon, 01 Nov 2004 10:23:10 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: Stephen Smalley <sds@epoch.ncsc.mil>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>, James Morris <jmorris@redhat.com>
Subject: Re: dynamic context transitions
References: <4182959B.4080503@trustedcs.com> <20041029211809.GJ8897@lkcl.net> <20041030090603.GK8897@lkcl.net> <1099315214.21386.13.camel@moss-spartans.epoch.ncsc.mil> <20041101141025.GZ8897@lkcl.net>
In-Reply-To: <20041101141025.GZ8897@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James,
     I am hoping that this response will also address your question of 
applicability outside of the MLS policy.

Luke Kenneth Casson Leighton wrote:
>  this proposal is a little bit like seteuid-for-selinux, only not
>  really, because seteuid has the ability to switch to any uid and then
>  to any uid after that, ad infinitum.
> 

That is correct.  We are looking at a well-defined (via the policy) set of 
available type transitions.  Note that you can also specify a one-way dynamic 
transition as well (type1_t can dynamically transition to type2_t, but type2_t 
has no dynamic transitions available).  This will allow a daemon process to 
initialize itself with one set of access rights (bind ports, read conf files, 
etc.), and then lock itself into a domain with less access rights for the 
duration of its execution.  This is similar, but *much* more powerful than, 
changing the uid, or even using the libcap interface to drop specific capabilities.

>  i wonder if it would help at all with samba's predicament?
> 
>  would it be possible to use this to have an smbd process
>  transition to a user-based-file-access-only-context and then
>  back-to-"root-like"-with-no-file-access-allowed?
> 
> ...
> 
>  and also would it be possible to use this proposal to track
>  what famd does, too?
> 

I have looked back on the threads involving smbd and famd and it does indeed 
seem that dynamic transitions may help to bring those applications to a 
"SELinux-aware" state.  For instance, famd would be able to transition from its 
"standard domain" to a domain which would have the same file access as the user. 
  Once in this domain, it would be able to leverage the kernel's access 
decisions because they will computed against the access rights of the user's 
type.  I am not really familiar with the architecture and the specific problems 
of the daemons, so I don't want to throw out any specific advice on using 
dynamic transitions to SELinuxify the programs.

-- 

Darrel Goeddel
Senior Secure Systems Engineer

Trusted Computer Solutions             E: dgoeddel@trustedcs.com
121 West Goose Alley                   V: 217.384.0028 x19
Urbana, IL  61801                      F: 217.384.0288

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
