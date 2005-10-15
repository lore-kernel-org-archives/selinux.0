Message-ID: <4350EA46.4000506@cornell.edu>
Date: Sat, 15 Oct 2005 07:38:46 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@tresys.com>,
   Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEMANAGE ] Add a few direct dbases to handle
References: <434FF612.8010708@cornell.edu> <4350131E.8060708@tresys.com> <435017B2.7040107@cornell.edu> <435018F7.6070706@cornell.edu> <4350177F.7010600@tresys.com> <43501C38.5040907@cornell.edu> <43501DD9.4010803@tresys.com> <435025EB.2060203@cornell.edu> <4350E962.5080606@cornell.edu>
In-Reply-To: <4350E962.5080606@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
> By "backend-independent record code" I mean, being able to add a user, 
> and not care where the user is stored.. being able to loop over the 
> seuser mappings, and not care whether the data is coming from LDAP or 
> the seusers file, because all I want to do is load it into policy.
Well, we wouldn't be loading the seusers into policy, but that's not 
important - the point is... backend separation.
An example that makes sense would be looping over the seusers to find 
the ones that would be affected, if, say, I revoked the staff_r role, or 
changed some other policy thing that would affect seusers.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
