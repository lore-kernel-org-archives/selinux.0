Message-ID: <43B5A71D.4060205@cornell.edu>
Date: Fri, 30 Dec 2005 16:31:09 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: logging in using sereference policy
References: <20051230170827.GA6593@sergelap.austin.ibm.com>
In-Reply-To: <20051230170827.GA6593@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Kind of obvious in retrospect :)  And I sort of knew that must be what
> was going on, but wasn't sure how to find the real problem if there was
> no audit msg about it.  In the future I may just have to start by adding
> a debug make target which removes all dontaudits.
>   
It used to be called "make enableaudit".  Not sure what it's called 
nowdays, since I haven't looked at policy sources in a while, but I see 
Dan Walsh shipping a policy base module that removes all dontaudits - if 
you can switch to it (with semodule), it will probably do what you want.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
