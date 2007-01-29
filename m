Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0TNNcJp004184
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 18:23:38 -0500
Received: from ultra1.univ-paris12.fr (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0TNObME001184
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 23:24:38 GMT
From: "Catalin DIMA" <dima@univ-paris12.fr>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Catalin DIMA <dima@univ-paris12.fr>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Problems installing current version of refpolicy with FC6
Date: Tue, 30 Jan 2007 00:24:27 +0100
Message-Id: <20070129225708.M77854@ssl.univ-paris12.fr>
In-Reply-To: <45BE68BF.3030607@mentalrootkit.com>
References: <45BE44FC.8080303@univ-paris12.fr> <45BE4FC6.4090502@mentalrootkit.com> <45BE6262.5080902@univ-paris12.fr> <45BE68BF.3030607@mentalrootkit.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 29 Jan 2007 16:35:59 -0500, Karl MacMillan wrote
> Could you elaborate on where it gets stuck. Does the labeling 
> happen? 

No, it crashes before labeling, just after starting udev and the 2nd service
(don't remember the name, I just left home...).

> You might try relabeling in permissive.

I suspect it's not the relabeling process, though I have to check it back
(tomorrow...)

> > Btw, forgot to mention the libsepol.sepol_genbools: error while reading 
> > /etc/selinx/refpolicy/booleans error...
> >
> 
> In permissive or enforcing?

Enforcing.

> > In permissive refpolicy mode, the only selinux message talks about 
> > NetworkManager.
> >
> 
> Just to clarify, things work fine in permissive mode and you are 
> only getting a single AVC message, correct? 

Yes, at least during the booting process. I think I also did a setfiles check
in permissive, and everything was ok (to be checked tomorrow again).

> Could you check 
> /var/log/messages and /var/log/audit/audit.log for avc messages 
> after a permissive boot. Also check the selinux messages in dmesg 
> for errors.

The machine on which I noticed the avc:denied message about the NetworkManager
does not have setools installed -- I then only looked at /var/log/messages.
Hope I did not forget what machine I was working on...

> >> The unknown boolean messages should be harmless I believe.
> >>
> >> You can extract the build.conf from the policy source rpm as well, 
> >> which is likely a good starting point.
> > 
> > The problem is the same with the rpm and the bz2...
> >
> 
> Not certain what you mean here - the source rpm or the binary rpm? I 
> was suggesting that you rebuild refpolicy using the configuration 
> from the source rpm - which means extracting the correct build.conf, 
> modules.conf, and booleans.conf, seusers, and users_extra files and 
> installing the in the source tree. You can read the spec file to see 
> how this is done during the build process.

I meant the source rpm. Tried to install both from source rpm and bz2 and both
lead to the same problem. It does not seem to be a problem with
missing/misplaced source files, no problem occurs at compile time.

I'll try to do a neat reinstallation of FC6 and then a reinstallation of
refpolicy sources, the machines are used for many other teaching purposes by
different people and God only knows what bazaar is inside... though nobody
else tried to install/do anything about/against selinux...

Btw, during setools installation on one of the machines, I also encountered a
problem : the need to enable text relocation for libqpol. Is this normal ? The
problem seems to recur every time I do a relabel to targeted (in order to put
back the system in a "stable state") -- that means, after relabeling,
launching apol issues again an avc:denied about text relocation.

Catalin.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
