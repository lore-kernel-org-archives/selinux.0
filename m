Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mB5MGrI3023149
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2008 17:16:53 -0500
Received: from an-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mB5MEiOS010763
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2008 22:14:45 GMT
Received: by an-out-0708.google.com with SMTP id d11so143833and.39
        for <selinux@tycho.nsa.gov>; Fri, 05 Dec 2008 14:16:53 -0800 (PST)
Message-ID: <cadfc0e40812051416v15070ddag132ff548d535052c@mail.gmail.com>
Date: Fri, 5 Dec 2008 16:16:52 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "Eamon Walsh" <ewalsh@tycho.nsa.gov>
Subject: Re: [RFC] Add color translation support to mcstransd
Cc: "Joe Nall" <joe@nall.com>, "SELinux List" <selinux@tycho.nsa.gov>,
        "James Carter" <jwcart2@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
In-Reply-To: <492AFFAD.5070805@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4927839F.4070805@tycho.nsa.gov>
	 <AD1BDA2B-D7CF-48AC-846E-54DC795B3C08@nall.com>
	 <492AFFAD.5070805@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 24, 2008 at 1:25 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
> Joe Nall wrote:
>> On Nov 21, 2008, at 9:59 PM, Eamon Walsh wrote:
>>
>>
>>> The proposal is to add 2 new functions to mcstransd:
>>> RAW_CONTEXT_TO_COLOR and TRANS_CONTEXT_TO_COLOR, and to add a new
>>> configuration file "secolor.conf", similar to setrans.conf, which
>>> contains mappings from security context components into colors.
>>>
>>> The purpose of this facility is to service SELinux-aware graphical
>>> applications which display security contexts.  Standard color schemes
>>> are often associated with security levels or categories.  The proposed
>>> color facility allows color policy to be expressed in the same
>>> manner as
>>> the existing human-readable translation strings in setrans.conf.
>>> Example uses include security labels in a window manager,
>>> headers/footers in documents or printouts, or downgrade dialogs in
>>> selection managers.
>>>
>>> The proposed color lookup operation supports up to 10 colors: a
>>> foreground/background pair for each component of the security context
>>> (user, role, type, level, and category).  If all five components are
>>> not
>>> specified in the configuration file, the matching engine will copy
>>> from
>>> other components to fill out the 10 colors according to fallback
>>> rules.
>>> For example, if colors are only specified for levels, the other four
>>> color pairs will be set to the value specified for the level.  This
>>> allows maximum flexibility while supporting the common case of only
>>> displaying a single foreground/background or even just a background
>>> color.
>>>
>>> Below is a sample secolor.conf file.  Comments appreciated.
>>>
>>
>> So you get 10 values back every time?
>>
>> What happens when there is no matching mapping?
>>
>> How are the fallback rules specified?
>>
>> This is way spiffier than what I was looking to do. I like it.
>>
>> joe
>>
>>
>
> Yes, under this proposal there are 10 colors returned for every lookup.
> The return value is a big string containing hex values separated by
> whitespace, such as:
> 000000  ffff00  000000  ffff00  000000  ffff00  000000  ffff00  000000
> ffff00
> I experimented with returning binary 32-bit integers on the wire, but
> all the mcstransd logic is set up to handle strings.  The client-side
> code (in libselinux) could parse the values.
>
> The fallback rules for borrowing colors from other parts of the context
> are hardcoded to the following:
>
> user falls back to:   role, type, level, category, black/white
> role falls back to:   user, type, level, category, black/white
> type falls back to:   user, role, level, category, black/white
> level falls back to:   category, user, role, type, black/white
> category falls back to: level, user, role type, black/white
>
> For example if there is no match found for the "role" component, then
> the role color will be set to the user color, if there was a match for
> the user in the secolor.conf file.  If not, then the role color will be
> set to the type color, if there was a match for the type.  And so on.
> If any one component matches then all five components will fall back to
> it, and the rules are set up so that TE/RBAC colors borrow from other
> TE/RBAC components first and MLS colors borrow from the other MLS
> components first.  The idea is that a simple application that is only
> capable of displaying one color (e.g. metacity) could always use the
> first one in the message (the "user" one).
>
> If there is no match for any part of the context then black-on-white is
> returned.  The secolor.conf file should have a wildcard rule for one of
> the components to prevent this.
>
> It was pointed out by Jim that some color policies might define separate
> colors for combinations of level/category the same way "SystemHigh" is
> defined as s15:c0.c255.  This could be solved by a new rule that treats
> category and level together when matching.  It seems like there are an
> infinite number of possibilities for color policy requirements.  This
> proposed scheme is somewhat flexible in that more colors could be added
> to the message later.
>
>
> --
> Eamon Walsh <ewalsh@tycho.nsa.gov>
> National Security Agency
>
>

Sorry to be pedantic but is there a reference implementation or will
the mcstrans developer (Joe) have to develop it?

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
