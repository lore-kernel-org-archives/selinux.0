Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA213oXZ001982
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 20:03:50 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA213ofG018104
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 01:03:50 GMT
Message-ID: <4186DCE7.9030401@tresys.com>
Date: Mon, 01 Nov 2004 20:03:35 -0500
From: Karl MacMillan <kmacmillan@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Frank Mayer <mayerf@tresys.com>,
   "'Darrel Goeddel'" <dgoeddel@TrustedCS.com>, selinux@tycho.nsa.gov,
   "'Chad Hanson'" <chanson@TrustedCS.com>
Subject: Re: dynamic context transitions
References: <000501c4bf9b$a157d2e0$6701a8c0@columbia.tresys.com> <1099316236.21386.31.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1099316236.21386.31.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Sun, 2004-10-31 at 17:47, Frank Mayer wrote:
>  
>
>>Ah and here we have the beginning of the slippery slope.  This might be easy in
>>terms of lines of code, but the conceptual complexity of what you describe above
>>scares me.  I still wonder why we have to change TE to support a MLS convention.
>>I'd much rather you did not make these mechanisms dependent on each other.  
>>    
>>
>
>TE was originally developed to fill in the gaps of MLS, including
>privilege management for trusted subjects.  Using TE to control MLS
>privileges is a good thing.  Whether or not privilege bracketing is a
>good thing is more open to debate, although it is clearly entrenched in
>applications today, and not just MLS applications; the prior requests
>for such a feature have been to support traditional Unix applications
>that presently use seteuid/setfsuid.
>
>Devil's advocate: 
>

This is a clear start to a message that I should probably avoid replying 
to . . .

>Would you argue for removing the ability to reload
>policy at runtime from SELinux?  For removing the ability to relabel
>files at runtime from SELinux?  Or is it sufficient that these "unsafe"
>operations are controlled by the policy?  The dynamic context
>transitions can be controlled on a pairwise context basis, so you do get
>much finer control than a traditional setuid-like operation.
>
>  
>

I certainly see your general point: we are already on the slippery 
slope. That doesn't mean we have to keep going, though. I have a few 
questions (and answers) back:

Is it possible to build a reasonable system without any of these 
features? I don't see how SELinux could be made acceptable to the linux 
world without policy reloading and file relabeling,  but it seems clear 
that a reasonable system can be built without dynamic context 
transistions. Feel free to beat me up about what a "reasonable" system is.

All of these mechanism are present to allow integration of SELinux with 
existing linux, and prehaps solaris, concepts and practices. The 
question is, how far are we willing to go to preserve backwards 
compatibility and when is it valuable to force a certain model? I think 
it is valuable to force an exec model of domain transitions because it 
requires applications to conform to a sound security architecture. TCS 
and others with a large body of existing code probably have a different 
view.

Everyone seems to agree that dynamic context transitions are useful only 
to support legacy applications that should be rewritten to an exec 
model. Will dynamic context transitions therefore be removed at some 
point in the future? It seems that if this is accepted not only will it 
remain forever to support legacy, but new applications will be written 
that use this capability.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
