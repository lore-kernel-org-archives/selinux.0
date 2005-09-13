Message-ID: <43273782.7070600@redhat.com>
Date: Tue, 13 Sep 2005 16:33:06 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Karl MacMillan <kmacmillan@tresys.com>,
   Darrel Goeddel <dgoeddel@TrustedCS.com>, SELinux <SELinux@tycho.nsa.gov>,
   Nalin Dahyabhai <nalin@redhat.com>
Subject: Re: New ideas on implementation on libsetrans.
References: <43271BDA.3060403@redhat.com> <43272C09.3050105@trustedcs.com>	 <43272E92.4060400@redhat.com>	 <1126641222.29303.235.camel@moss-spartans.epoch.ncsc.mil>	 <432730B2.8090005@redhat.com> <1126641983.29303.249.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1126641983.29303.249.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Tue, 2005-09-13 at 16:04 -0400, Daniel J Walsh wrote:
>  
>
>>Most of the people I talk to in Red Hat don't like alternatives.    We 
>>can change to just use libsetrans and implement to communication in this 
>>library, but I don't see that as adding much value.
>>    
>>
>
>The advantage of putting the communication/caching code into a separate
>library (libsetrans) rather than into libselinux directly are:
>- it leaves open the option of omitting the code for the communications
>and caching altogether for systems that have no need for label
>translation,
>  
>
If no one is listening on  the socket or the socket does not exist you 
get the same behavior.

>- it leaves open the option of providing a libsetrans implementation
>that deals with flat files directly rather than communicating over a
>socket.
>
>The only disadvantage that I see is that users of the static libselinux
>don't get the translation by default; they have to explicitly link with
>libsetrans themselves and invoke the translation interfaces if they want
>translation.  But such users should be very few and manageable.  prelink
>doesn't truly need translation; it just needs getfilecon to always
>return a context that can be used in a subsequent setfilecon call, and
>James' kernel patch addresses that concern.
>
>  
>
I see packaging problems and requiring objects to link with -dl.  We are 
basically looking at a packaging problem
now, which is why we are bringing this up. 

I have added Nalin to the message to get his comments.

>Am I missing other disadvantages?
> 
>  
>


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
