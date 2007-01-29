Message-ID: <45BE87E0.5090109@tycho.nsa.gov>
Date: Mon, 29 Jan 2007 18:48:48 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
MIME-Version: 1.0
To: Steve Grubb <sgrubb@redhat.com>
CC: Karl MacMillan <kmacmill@redhat.com>, linux-audit@redhat.com,
        Steve G <linux_4ever@yahoo.com>, selinux@tycho.nsa.gov
Subject: Re: missing avc message field names
References: <20070129185542.32977.qmail@web51502.mail.yahoo.com> <200701291556.37235.sgrubb@redhat.com> <45BE6410.9050604@redhat.com> <200701291749.21897.sgrubb@redhat.com>
In-Reply-To: <200701291749.21897.sgrubb@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>>>> Steve G wrote:
>>>>         
> I'd also like to make sure that all AVCs really are AVCs. I think there are 
> some error messages that come out as AVCs when they should be SE_ERR or 
> USER_SE_ERR.
>
>   
This is a separate issue, this results from the userspace AVC's logging 
callback not having a type field.  I'm aware of this problem and willing 
to fix it but I'd like to get a clear picture of what the final auditing 
format will be first, so I'm glad this discussion is taking place.
> You already have them split out...or did you totally skip AUDIT_USER_AVC? So, 
> you already have to solve the problem so why not generalize the solution? The 
> parsing API should be able to help with this. If you tell it to get all the 
> different types and they don't exist, you don't get a hit except the ones 
> that do exist.
>
>   
My point here was simply to warn in advance that userspace object 
managers will in general introduce widely varying fields to their AVC 
messages and that the auditing record format should be equipped to deal 
with that.  Who knows what types of objects will appear in these 
messages in the future: there might be SELinux-enhanced e-mail clients, 
office applications, file managers in the future.  Making the dictionary 
easily extensible now will likely pay off later and the prefix idea is a 
way to do that.

As far as binary records go, if that is the future direction then I 
don't see why the disk space argument is being made for not having a 
prefix.  Presumably in binary form the keywords will  be assigned 
numbers that are fixed size, so that the length of the string 
representation shouldn't matter.  And even in text form if the logs are 
compressed then the length issue will be mediated.
>>     
> I doubt there very many security related pieces of information that is not 
> already in the dictionary. There are a finite number of security objects and 
> their attributes.
>
>   
Again I think that the audit system should support future expansion if 
it's going to be the new way for handling AVC's and other security events.
>> And what about third-party tools that are security critical?
>>     
>
> They have the TRUSTED_APP message type and they can put anything in that they 
> want. I consider that one completely freestyle.
>
>   
How does this work with binary records?  How will these messages be 
searched?
> Nearly all names are unique (and the problem should be solved when I code up 
> seperm and seresults). Adding more letters to the name eats the diskspace. We 
> only do it when necessary. That is what drives the choice of "res" instead 
> of "results" for the audit system.
>   

I do think it should be selinux.perms, selinux.result and the other AVC 
stuff should be selinux.foo.  These are long names I concede but they 
are clearer and log size is already an issue anyway, moving to 
compressed or binary will solve the problem.
>   

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
