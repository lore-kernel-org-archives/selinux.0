Subject: Re: SELinux Policy in OpenSUSE 11.2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Rouse <alan.rouse@ericsson.com>
Cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
References: 
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain
Date: Tue, 16 Feb 2010 14:10:11 -0500
Message-Id: <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-02-16 at 09:55 -0500, Alan Rouse wrote:
> I've been trying to get SELinux working in OpenSUSE 11.2.  So far I
> can get to runlevel 3 with enforcing=0.  Before I start tinkering with
> audit2allow, I thought I should get some advice.
>  
> The 11.2 repository gives me these policy rpms:
>  
> http://download.opensuse.org/repositories/openSUSE:/11.2/standard/noarch/selinux-policy-2.20081210-3.1.noarch.rpm
> http://download.opensuse.org/repositories/openSUSE:/11.2/standard/src/selinux-policy-2.20081210-3.1.src.rpm
>  
> But that version of policy has some issues in OpenSUSE:
>  
> 1) failure to allow the graphical desktop to load (even with
> enforcing=0) .   The following message appears in the console during
> boot:
>  
> ** (gdm:1073): WARNING **: Couldn't connect to system bus: A SELinux
> policy prevents this sender from sending this message to this
> recipient (rejected message had sender "(unset)" interface
> "org.freedesktop.DBus" member "Hello" erro name "(unset)" destination
> "org.freedesktop.DBus") startproc: exit status of parent
> of /usr/sbin/gdm: 1
>  
> Since enforcing is off, I'm surprised to see a message like that.
> SELinux shouldn't be preventing anything, so I don't see how modifying
> policy will solve that.  Ideas?
>  
> 2) Attempting to boot to runlevel 5 with kernel parms
> "security=selinux selinux=1 enforcing=0", I'm dropped off in runlevel
> 3 instead. I'm getting a couple of pages of AVC errors after boot (see
> below).
>  
> I've tried several other versions of the policy without luck: 
> - the version included in Fedora 12  (refpolicy-2.2009117
> - the latest release from Tresys
> - the latest from the repository at Tresys
>  
> They all give basically the same problems.  Any advice would be
> appreciated.

What does sestatus -v report?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
