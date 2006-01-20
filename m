Message-ID: <43D0D8E2.2020304@cornell.edu>
Date: Fri, 20 Jan 2006 05:34:42 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SELinux List <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] Further bugfixes
References: <43D0383C.8010404@cornell.edu> <200601202321.07517.russell@coker.com.au>
In-Reply-To: <200601202321.07517.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I think that all of these should be changed similar to my revised man page 
> (which I posted under the subject "semanage patch" on the 14th of Jan).
>
> semanage fcontext -{a|d|m} [-hfrst] CONTEXT_EXPRESSION\n\
> semanage interface -{a|d|m} [-tr] INTERFACE_NAME\n\
> semanage login -{a|d|m} [-sr] LOGIN_NAME\n\
> semanage port -{a|d|m} [-tpr] PORT | PORT_RANGE\n\
>
> The convention is that anything within [] is optional, however it is not 
> optional to have one of 'a', 'd', or 'm', it is required to have exactly one 
> of them.
>   
Technically -p is required for ports, since it is part of the port key.
Also, there's required parameters on add that you must enter (but I 
guess this is better left out of the manpage).
> Also there should be a line such as the following to indicate the ways in 
> which the "-l" option can be used (it can't be used in conjunction with any 
> other option):
> semanage {login|user|port} -l
>
> Do "interface" and "fcontext" support the "-l" option?
>   
Sure.. try it..
> I would offer a patch for this, but I think we have enough unmerged patches 
> for the semanage utility floating around at the moment.  Once we get the 
> current patches sorted out I'll be happy to write a patch for this.
>   
I think most of them have been merged, but I'm not sure which ones 
you're referring to.
> Finally, when semanage development slows down a bit we will have to put in 
> some decent error checking for command-line parameters.  Currently you can 
> pass in parameters that are not used to a command without an error or warning 
> message.  For example the following command will work even though -R is not a 
> valid option to the login management interface.
>
> semanage login -a -s user_u -r s0 -R sysadm_r john
>   
-R doesn't actually work. It can't handle more than one role, and it 
handles that one role incorrectly.
I agree with what you're saying though...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
