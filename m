In-Reply-To: <440F2E61.4070905@cornell.edu>
References: <4404BA44.8000503@cornell.edu> <440F2E61.4070905@cornell.edu>
Mime-Version: 1.0 (Apple Message framework v749)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A98716CB-BC6B-4EFE-B480-2B31C8D6FACD@nall.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
From: Joe Nall <joe@nall.com>
Subject: Re: Desktop Integration Take 2
Date: Wed, 8 Mar 2006 13:59:58 -0600
To: Ivan Gyurdiev <ivg2@cornell.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mar 8, 2006, at 1:20 PM, Ivan Gyurdiev wrote:

>> - Have a file controlled by libsetrans which maps mls ranges to  
>> (unicode?) translated strings
>>     (setrans.conf)
>>
>> - Require the mappings above to be 1:1.
...

The work I'm doing on better MLS inverse bit handing (rel country1/ 
country2 ...) in libsetrans supports mapping label fragments  
(individual categories and category ranges) in addition to the  
current 1:1 mapping. With 256 bits, 1:1 MLS mappings are not  
practical because the number of potential combinations is so great. I  
hope to have a patch for review at by the end of next week.

In our CMW work, we have a GUI label builder that understands the MLS  
combination constraints and a 'last 40 labels built' menu. Individual  
users rarely go beyond the 40 labels. An initial manual label  
constructor that saves state in a preferences file would be an  
adequate start.

joe 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
