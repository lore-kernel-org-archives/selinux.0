Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAOLVXRb010924
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2003 16:31:33 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAOLUxp5010638
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2003 21:31:00 GMT
Received: from smtp1.su.se (smtp1.su.se [130.237.162.112])
	by jazzswing.ncsc.mil  with ESMTP id hAOLUxt0010635
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2003 21:30:59 GMT
Message-Id: <3.0.32.20031124163129.00b01698@mail.dsv.su.se>
Date: Mon, 24 Nov 2003 16:31:30 -0500
To: Miguel Guirao <thinkfreemx@yahoo.com.mx>, SE Linux <selinux@tycho.nsa.gov>
From: Sead Muftic <sead@dsv.su.se>
Subject: Re: smart cards
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Miguel:

Thanks, but LinuxNet is in fact MUSCLE (so see my comments) and
GlobalPlatform is
just a set of specs (equivalent to OCF, GSC and others), so we decided on OCF
(support in banking community) and GSC (support by US Government).

Regards,

Sead Muftic
SETECS
Rockville, MD

----------------------------------------------------------------------------
----------

>I work with SC, try these two web sites:
>
>http://www.linuxnet.com/
>http://www.globalplatform.org/
>

----------------------------------------------------------------------------
----------

>Regards,
>
>Miguel Guirao
>
> --- Sead Muftic <sead@dsv.su.se> escribió: > Russell:
>> 
>> >Anyone working on smart-card support for SE Linux?
>> 
>> My answer to you is "Yes", but it needs some
>> clarifications.
>> 
>> The first problem with smart cards on Linux machines
>> are SC and reader
>> drivers. We tried to activate
>> M.U.S.C.L.E. drivers, we worked on this on-and-off
>> several months and we
>> didn't reach the point of 
>> smooth installation, then activation.
>> 
>> Just to mention that we have developed SC middleware
>> (compliant with OCF
>> and US Gov't GSC-IS, v 2.0), 
>> so "underneath" we can plug multiple drivers, only
>> if they work. This means
>> that some alternative
>> drivers, if you know of some, can be relatively
>> easily "plugged" under our
>> middleware.
>> 
>> Finally, we have in fact developed nice,
>> easy-to-use, GUI system to
>> administer all aspects
>> and entities of SELinux which performs SELinux admin
>> functions at the click
>> of the button.
>> The first version was "single machine" version, i.e.
>> it had to be located
>> on the same machine
>> as SELinux being administered. Now, we are in the
>> final phase of testing
>> the networked version.
>> 
>> This SELinux admin interface can use smart cards for
>> login and remote
>> commands security (based 
>> on SSL). However, due to problems with SC drivers it
>> runs only on Windows
>> (sorry !). 
>> 
>> 
>> >
>> >I think it's something we need for the future, but
>> at the moment I don't
>> know 
>> >anyone who is using such hardware and have no
>> access to it myself.  If 
>> >someone is using smart cards and can tell me what
>> needs to be done then I
>> can 
>> >start planning what we need for SE Linux policy to
>> support it.
>> >
>> 
>> 
>> As far as policy is concerned, we are following
>> Certification Policy,
>> compliant with Federal
>> Bridge CA, but it regulates only issuance of cards,
>> technical parameters
>> for those cards and rules
>> of handling certificates, not much related to
>> SELinux, for the time being.
>> 
>> Regards,
>> 
>> Sead Muftic
>> SETECS
>> Rockville, MD
>> 
>> 
>> 
>> --
>> This message was distributed to subscribers of the
>> selinux mailing list.
>> If you no longer wish to subscribe, send mail to
>> majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as
>> the message. 
>
>_________________________________________________________
>Do You Yahoo!?
>La mejor conexión a internet y 25MB extra a tu correo por $100 al mes.
http://net.yahoo.com.mx
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
