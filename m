Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2QN11Ku031568
	for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2008 19:01:02 -0400
Received: from queueout02-winn.ispmail.ntl.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2QN0v21008746
	for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2008 23:00:57 GMT
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080326212216.XHBP1244.mtaout03-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>
          for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2008 21:22:16 +0000
Received: from [192.168.1.102] (really [82.18.189.14])
          by aamtaout04-winn.ispmail.ntl.com with ESMTP
          id <20080326211853.FOVE29112.aamtaout04-winn.ispmail.ntl.com@[192.168.1.102]>
          for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2008 21:18:53 +0000
Message-ID: <47EABDB2.8090305@martinorr.name>
Date: Wed, 26 Mar 2008 21:18:42 +0000
From: Martin Orr <martin@martinorr.name>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        =?ISO-8859-1?Q?V=E1?= =?ISO-8859-1?Q?clav_Ovs=EDk?= <vaclav.ovsik@i.cz>,
        SELinux List <selinux@tycho.nsa.gov>,
        selinux-devel@lists.alioth.debian.org
Subject: Re: [DSE-Dev] refpolicy: domains need access to the apt's pty	and
 fifos
References: <200803062346.58639.russell@coker.com.au>	<20080305152322.GA9988@bobek.pm.i.cz>	<1204734268.12784.124.camel@hepcat.vitavonni.de>	<200803062117.20441.russell@coker.com.au>	<1204805640.5885.4.camel@hepcat.vitavonni.de>	<20080305152322.GA9988@bobek.pm.i.cz>	<1204734268.12784.124.camel@hepcat.vitavonni.de>	<200803062117.20441.russell@coker.com.au>	<20080305152322.GA9988@bobek.pm.i.cz>	<1204734268.12784.124.camel@hepcat.vitavonni.de>	<20080321073158.GA12456@bobek.pm.i.cz> <1206547029.16113.272.camel@gorn>
In-Reply-To: <1206547029.16113.272.camel@gorn>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 26/03/08 15:57, Christopher J. PeBenito wrote:
> On Fri, 2008-03-21 at 08:31 +0100, Václav Ovsík wrote:
>> BTW: I found, that dpkg passes (and should not) to child processes
>> a file descriptor of apt pipe:
>> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=471488
>> The access to apts fifo should not be needed for dpkg scripts.

Ah, that explains a lot.

>> On Thu, Mar 06, 2008 at 11:46:54PM +1100, Russell Coker wrote:
>>> On Thursday 06 March 2008 23:13, Erich Schubert <erich@debian.org> wrote:
>>>>>> It would definitely help to have separate apt_t and apt_script_t
>>>>>> domains, though, to be able to differentiate access for installation
>>>>>> scripts and the package manager itself.
>>>>> What meaningful restrictions can be applied to one but not the other?
>>>> I agree with you that we would currently have to allow pretty much any
>>>> access by apt_script_t, unfortunately. Sorry for mixing up apt and dpkg
>>>> again in that post btw, yes, it sould be dpkg_t and dpkg_script_t,
>>>> obviously.
>>>> No, I can't really think of ways to restrict dpkg_script_t apart from
>>>> not messing with the dpkg_t state files. Maybe we could make some policy
>>> But given that dpkg_script_t can make all manner of other changes (including 
>>> loading a SE Linux policy) it seems rather minor to restrict access to dpkg 
>>> state files.
>>>
>>>> that /usr is to be modified by dpkg_t only whereas dynamically generated
>>>> files have to reside in /var, but I doubt this would currently hold.
>>> It's a standard practice to convert the data files under /var in an upgrade.
>>>
>>>> And after all, dpkg_script_t needs to be able to even add users
>>>> to /etc/passwd (although through the helper applications, not directly).
>>> Yes.
>>>
>>> In fact while we have unconfined_t, the benefit of having a separate dpkg_t 
>>> instead of using unconfined_t for installing packages doesn't seem 
>>> significant.
> 
>> Seems to me dpkg_script_t is not used now really.  Should be removed
>> dpkg_script_t from the refpolicy?  A part of rules should be moved from
>> the domain dpkg_script_t to the domain dpkg_t probably if such a removal
>> will take place.
> 
> As I recall it was a work in progress by either Erich or Manoj.  If it
> was never finished or abandoned, then it should probably be removed.

Because of
dpkg_domtrans_script(dpkg_t)
maintainer scripts written in shell (i.e. most) are run in dpkg_script_t,
but any written in something else (usually Perl) stay in dpkg_t.  So at the
moment a bunch of rules are needed for both domains, which is not very sensible.

-- 
Martin Orr

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
