Message-ID: <43B82D88.9000805@cornell.edu>
Date: Sun, 01 Jan 2006 14:29:12 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Erich Schubert <erich@debian.org>
CC: SELinux@tycho.nsa.gov
Subject: Re: Documentation, anyone?
References: <1136147621.27906.74.camel@wintermute.xmldesign.de>
In-Reply-To: <1136147621.27906.74.camel@wintermute.xmldesign.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> The reason why I'd like to find out more on the seusers file is because
> the latest genhomedircon "depends" on this file. But I couldn't find one
> anywhere.
>   
The file is provided by the policy package. I'm not entirely sure which 
version started providing that file. It introduces mapping of Unix users 
to Selinux users, so we don't have to store role sets and other 
properties for each Unix user. It sounds like a dependency issue. There 
were also libselinux changes related to the introduction of a seusers 
file, that will map users appropriately upon login.

> Obviously, I don't have your <type>/modules/active directory either...
>   
Another feature of the policy package - at one point the package was 
made "managed" by libsemanage.
I think it was when the policy switched from targeted/strict to the new 
reference policy that uses modules and dependencies by Tresys.

> And none of this was included with the semanage source I have, nor is it
> explained in the manpages or a "doc" subdir in the source...
>   
The seusers file isn't really related to libsemanage. It's just one of 
the things that can be "managed" via that library. Alternatively you can 
just edit it yourself if your system isn't managed yet (which it sounds 
like it isn't). I can see why you'd be confused in that case, since no 
documentation is provided. The format would be clearer, however, if you 
could see the existing seusers file that's installed by policy - it's 
actually required, or bad things happen (as you've found out). Again, 
that sounds like a dependency issue between packages.
> Yes, I'm running a "plain old" strict policy...
>
> Oh, and in genhomedircon, the third component is not entirely optional:
> probably line 201, "if len(user) < 3:" should be < 2 then... ;-)
> (in the non-semanaged case)
>   
I guess it should be....libselinux was changed so it's optional, and 
genhomedircon should be changed to reflect that.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
