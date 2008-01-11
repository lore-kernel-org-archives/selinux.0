Date: Fri, 11 Jan 2008 12:46:47 -0800
From: Glenn Faden <Glenn.Faden@sun.com>
Subject: Re: X avcs
In-reply-to: <47878130.5010000@gmail.com>
To: Ted X Toth <txtoth@gmail.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Message-id: <4787D5B7.9090606@sun.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
References: <cadfc0e40712261301l3765f85fyc813a6ccfb262e3b@mail.gmail.com>
 <cadfc0e40712280854i586aae43ya9e602fd56a984ab@mail.gmail.com>
 <47754FCB.1070307@tycho.nsa.gov>
 <cadfc0e40712281326k31e9238ci8604298596ade04d@mail.gmail.com>
 <cadfc0e40801020711w1e3a3a2dv422280f1f9d9595d@mail.gmail.com>
 <477BEFF1.2090507@sun.com> <47867FCA.50408@tycho.nsa.gov>
 <47878130.5010000@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ted X Toth wrote:
> I'll look at implementing a dixPropertyLookup function. Do any other 
> XACE hooks have value-return parameters, would it just be va_arg(ap, 
> PropertyPtr*)?
> What about the idea of an exception list of single-instance 
> root-window properties?
>
We have already implemented the equivalent of a dixPropertyLookup 
function called PolyProperty. The following URL is an OpenSolaris source 
browser query to find the implementation and uses of that function in Xorg.

http://src.opensolaris.org/source/search?q=&defs=&refs=PolyProperty&path=&hist=&project=%2Ffox

--Glenn

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
