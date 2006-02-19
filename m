Message-ID: <43F8A2AC.9070601@tresys.com>
Date: Sun, 19 Feb 2006 11:54:04 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Chris PeBenito <pebenito@gentoo.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: semanage non MLS breakage
References: <1140150258.13377.15.camel@gorn.pebenito.net>	 <43F561F3.4080200@cornell.edu> <43F5DC70.3070103@gentoo.org>	 <43F5E618.4010001@cornell.edu> <43F5E74C.7050904@gentoo.org>	 <43F5E97B.8060102@cornell.edu> <43F5EB83.30402@gentoo.org>	 <43F5EE32.5080101@cornell.edu>  <43F64063.4040601@cornell.edu> <1140288277.18548.28.camel@gorn.pebenito.net> <43F77E2B.3050108@cornell.edu> <43F86035.1010401@cornell.edu>
In-Reply-To: <43F86035.1010401@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>
>>
>> What I don't like about this is that libsemanage skips the MLS check 
>> now, but still proceeds to write any MLS range found to disk. It 
>> should invalidate an MLS range if it sees one. Will submit another 
>> patch on top of the previous one...
> Hmm, I don't know what to do about this...
> There's several options:
>
> 1) Treat this as fatal error. This is by far the simplest solution - 
> we already know when it happens, just make it fatal. Commit is 
> aborted, and there's no problem. It seems a bit.... ugly, however, to 
> abort a commit for which we clearly have all the data, and the user 
> simply has extra data like MLS attached. Nevertheless, considering the 
> options below, I think this is probably the best solution.
>
It's an invalid context, I don't think there is anything you *can* do 
except fatally error. Consider what would happen if there was a proper 
MLS context with multiple levels on an MCS policy...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
