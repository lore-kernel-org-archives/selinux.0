Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2M0Tehl011222
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2007 20:29:40 -0400
Message-ID: <4601CDF3.7040905@tycho.nsa.gov>
Date: Wed, 21 Mar 2007 20:29:39 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] refpolicy: experimental X policy -v2
References: <45B938EE.8010303@tycho.nsa.gov>	 <cadfc0e40702131226y3cef4a81h626bcdb264c563ee@mail.gmail.com>	 <45D2498C.3090902@tycho.nsa.gov> <1172602429.11157.48.camel@sgc>	 <46005FD3.8020203@tycho.nsa.gov> <1174496088.30666.11.camel@sgc>	 <46018E64.2080704@tycho.nsa.gov> <1174510410.19924.23.camel@sgc.columbia.tresys.com>
In-Reply-To: <1174510410.19924.23.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Wed, 2007-03-21 at 15:58 -0400, Eamon Walsh wrote:
>> Look at the example of the /dev/mem access denial.  This issue was 
>> reported to me even though it's an X server issue, not an X application 
>> issue.  If I were in charge of managing X application policy on some 
>> installation, I wouldn't want the kernel policy for the X server jumbled 
>> in with it.
>>
>> Just like how we're separating userspace object manager Flask 
>> definitions from the kernel ones.  In fact, I had originally created an 
>> entire separate directory "userspace" to use instead of services/. 
>> Reconsidered that, but still like the idea of separate modules.
> 
> I'm not saying that all the X object class rules are supposed to go in
> xserver, just the common ones.  Consider dbus, it has a template that
> other modules use for being client to a dbus, but the rules for sending
> dbus messages to other domains follows the same refpolicy conventions as
> kernel object classes, and thus are put in the relevant interface, eg
> hal_dbus_send().  I think the distinction between server and
> applications here is clear, and also I think its an analogue to the X
> server (there is a system dbus and also user dbuses).

OK, this makes sense.

>> Maybe gdm should restart the X server after the user has logged in, or 
>> the xserver should change its own context.  Both programs already have 
>> SELinux patches, adding this functionality could be done.
> 
> Yes, though I don't know the pros and cons, other than the latter option
> would be a dyntransition.

The fast user switching support in rawhide runs multiple xservers on 
virtual consoles; having them all be xdm_xserver_t is problematic.

Other ideas: have the display manager always running on the first 
virtual console, and launch the user servers on other consoles.  Or 
maybe we should go back to a text-based login only running X through startx.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
