MIME-Version: 1.0
In-Reply-To: <1266951608.871.70.camel@moss-pluto.epoch.ncsc.mil>
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266932425.871.13.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F52E41FFA04@EUSAACMS0703.eamcs.ericsson.se>
	 <1266941425.871.18.camel@moss-pluto.epoch.ncsc.mil>
	 <4B84135E.8010402@gmail.com>
	 <1266948097.871.27.camel@moss-pluto.epoch.ncsc.mil>
	 <4B841EA8.6040908@gmail.com>
	 <1266950573.871.61.camel@moss-pluto.epoch.ncsc.mil>
	 <4B842560.4080708@gmail.com>
	 <1266951608.871.70.camel@moss-pluto.epoch.ncsc.mil>
Date: Tue, 23 Feb 2010 11:03:21 -0800
Message-ID: <dd18b0c31002231103o10155ec8t8069dec638e6ade8@mail.gmail.com>
Subject: Re: SELinux Policy in OpenSUSE 11.2
From: Justin Mattock <justinmattock@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Alan Rouse <alan.rouse@ericsson.com>, Dominick Grift <domg472@gmail.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Feb 23, 2010 at 11:00 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2010-02-23 at 10:58 -0800, Justin P. mattock wrote:
>> On 02/23/2010 10:42 AM, Stephen Smalley wrote:
>> > On Tue, 2010-02-23 at 10:30 -0800, Justin P. mattock wrote:
>> >> On 02/23/2010 10:01 AM, Stephen Smalley wrote:
>> >>> On Tue, 2010-02-23 at 09:41 -0800, Justin P. mattock wrote:
>> >>>> On 02/23/2010 08:10 AM, Stephen Smalley wrote:
>> >>>>> On Tue, 2010-02-23 at 10:56 -0500, Alan Rouse wrote:
>> >>>>>> Would the proper solution be to add a transition to put that script in the right context when run from a shell?
>> >>>>>
>> >>>>> No.  I think we just need to drop the transition to sysadm_t altogether
>> >>>>> (at least in the ifdef suse case) and have userspace explicitly arrange
>> >>>>> the transition for single-user mode (ala sulogin).
>> >>>>
>> >>>> out of curiosity during booting up I'm seeing
>> >>>> a mess load of *.sh files being called
>> >>>> before the policy is loaded.
>> >>>>
>> >>>> looking into this I'm seeing them in /lib/mkinitrd/scripts
>> >>>> before I go and mess around with initrd
>> >>>> what are the thoughts on this area?
>> >>>
>> >>> That's ok - I wouldn't worry about that.
>> >>>
>> >>> As I said, I think the solution here is just to disable the transition
>> >>> to sysadm_t, at least if DISTRO=suse.
>> >>>
>> >>
>> >>
>> >> alright.. in regards to sysadm_t
>> >> a quick google found something
>> >> similar to what might be happening:
>> >>
>> >> http://www.engardelinux.org/modules/index/list_archives.cgi?list=selinux&page=1000.html&month=2008-03
>> >
>> > That was the original discussion that led to the logic you see in
>> > init.te today.  In any event, I've taken this up as a separate issue on
>> > refpolicy list.
>> >
>>
>>
>> alright..
>> I'll look to file some bugs at suse
>> for pam.d, the config file with the
>> permissions being that cause libselinux to default
>> to targeted. and any other that I can think of.
>
> Might want to add it to:
> https://bugzilla.novell.com/show_bug.cgi?id=581505
>
> --
> Stephen Smalley
> National Security Agency
>
>

cool, already one there.

-- 
Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
