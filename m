Message-ID: <42B94A03.8020508@tresys.com>
Date: Wed, 22 Jun 2005 07:22:43 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: alexander-barclay@utulsa.edu, Brandon Pollet <brandon@utulsa.edu>,
   SELinux@tycho.nsa.gov, John Hale <john-hale@utulsa.edu>
Subject: Re: XML Based Policy Configuration for SELinux
References: <7D1D591C-7CB7-4FAA-82DF-0CA87BE3372F@utulsa.edu> <20050621184940.GA8354@lkcl.net> <1119383982.42b871aef1898@cc.utulsa.edu> <20050621212059.GA9434@lkcl.net> <42B8A699.206@tresys.com> <20050622004114.GH9859@lkcl.net> <42B8DF16.3060108@tresys.com> <20050622053327.GB14480@lkcl.net>
In-Reply-To: <20050622053327.GB14480@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Luke Kenneth Casson Leighton wrote:

>On Tue, Jun 21, 2005 at 11:46:30PM -0400, Joshua Brindle wrote:
>
>  
>
>>>Wish List item 3)
>>>
>>>that the tools that do the converting to/from XML be
>>>written in python!!!
>>>
>>>
>>>      
>>>
>>The doctool to generate module.conf, tunables.conf and the html docs for 
>>the reference policy is in python :)
>>    
>>
> 
> wheeeee :)
>
>  
>
glad you approve :)

>>>XML is the sort of thing that allows people with very little
>>>understanding of e.g. selinux to write, write, using simple
>>>libraries, their Own Glorious parsing analysis and communication
>>>tools.
>>>
>>>
>>>
>>>      
>>>
>>I'm not sure what this means. How does XML help people that don't 
>>understand selinux do anything?
>>    
>>
>
> to illustrate: i did not need to understand anything about the ordering
> of the application of incoming NAT and incoming firewall rules which
> are different from the ordering of the application of outgoing NAT and
> outgoing firewall rules in order to write my fw_builder.py program,
> which simply takes the output of fwbuilder (an XML file) and spews
> forth a prettified HTML version of the firewall policy.
> 
> more later.
>  
>
This isn't right. The XML part of this equation is just the route those 
authors chose to get a free parser, the tool would work exactly the same 
from the user prespective if the file format was binary using 
alternating happy faces and frowny faces. It's just the tool and the 
developers that have to deal with the backend storage format. It might 
be nice in the firewall case to transform the config file into html but 
I can't think of a way this is helpful for SELinux policy.

The bottom line is that the tools would be great but the XML has nothing 
to do with that.

Joshua

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
