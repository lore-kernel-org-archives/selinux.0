Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mB8JlbZC021697
	for <selinux@tycho.nsa.gov>; Mon, 8 Dec 2008 14:47:37 -0500
Message-ID: <493D79D3.8020002@tycho.nsa.gov>
Date: Mon, 08 Dec 2008 14:47:31 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [RFC] Add color translation support to mcstransd
References: <4927839F.4070805@tycho.nsa.gov> <4939C7D8.7020000@tycho.nsa.gov> <4939D171.5090705@tycho.nsa.gov> <200812061441.45294.russell@coker.com.au>
In-Reply-To: <200812061441.45294.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Saturday 06 December 2008 12:12, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
>   
>> A screen shot of a sample application that uses the color translations
>> can be seen at:
>> http://people.freedesktop.org/~ewalsh/mcscolor_screenshot.png
>>     
>
> That's interesting, the yellow/green colour scheme is a little difficult to 
> read though.
>
> Are there any plans for making sure that it's accessible?  I expect that even 
> if the default configuration has no colour combinations that are bad for 
> colour-blind people, the first thing that would happen is for people to 
> immediately start adding them if there is no clear documentation about what 
> not to do.
>   

Choosing appropriate color combinations is the responsibility of the
people making the color policy.


> Also what about blind people?  Can this extra data be displayed in such a way 
> that braille and speech-synthesis programs access it?
>   

This would be the responsibility of the accessibility engine in the
application, for example by inserting some status notification when the
text color changes.

I don't think this is a real issue though, because if a speech synthesis
or braille reader is outputting the security context text in the first
place, the user will know the classification.

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
