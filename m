In-Reply-To: <20050621212059.GA9434@lkcl.net>
References: <7D1D591C-7CB7-4FAA-82DF-0CA87BE3372F@utulsa.edu> <20050621184940.GA8354@lkcl.net> <1119383982.42b871aef1898@cc.utulsa.edu> <20050621212059.GA9434@lkcl.net>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3993CA46-7D41-4587-8364-686113C92376@utulsa.edu>
Cc: Brandon Pollet <brandon@utulsa.edu>, SELinux@tycho.nsa.gov,
   John Hale <john-hale@utulsa.edu>
From: Alex Barclay <alexander-barclay@utulsa.edu>
Subject: Re: XML Based Policy Configuration for SELinux
Date: Tue, 21 Jun 2005 18:11:36 -0400
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jun 21, 2005, at 5:20 PM, Luke Kenneth Casson Leighton wrote:

>
>  3) is the only "sane" - read acceptable - answer.
>
>  not least because it requires that your code "understand"
>  the key concepts supported in python code by the program
>  genhomedircon, and the concept of users being associated [by
>  their unix username] with multiple roles (user_r, staff_r,
>  sysadm_r etc.)
>
>  which are actually quite difficult - if not impossible - to
>  "extract" from the policy.conf file, in isolation, with no
>  access to the "users" file.
>
>
>  basically, policy.conf and file_contexts do not provide the "full
>  picture" that would make the representation of selinux policy in XML
>  file format "useful" to developers and sysadmins.
>
>

I would agree for the most part, and as a result our new projects  
(which will be given to the list for pre-development feedback in the  
near future) are geared to work on top of the existing  layers in  
SELinux. The things that have been on the list from us the past week  
or so were are first salvo for SElinux, the second salvo is being  
worked on, and will be out for feedback soon, and we just are in the  
"what if" stage for round 3.

>  wish list item 1):
>
>  * the ability to read /etc/selinux/src/* (*.te, *.fc, users,
>    mls, rpac, net_contexts etc) + tunables into an XML formatted file
>

In regards to your wish list, that seems like a relatively reasonable  
thing to accomplish. I like the idea, and will see if what we can do  
about this this next semester. To be honest, it depends on how many   
or if we get new researchers and their abilities.

Once again, thanks for the discussion and anyone feel free to send us  
thoughts, suggestions, improvements etc.

Alex Barclay, Masters Student
Enterprise Security Group
University of Tulsa





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
