Message-ID: <437A0BED.1060102@cornell.edu>
Date: Tue, 15 Nov 2005 11:25:17 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   SELinux-dev@tresys.com, selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] Stub pserver backend
References: <437907D7.8090002@cornell.edu> <1132054159.5415.282.camel@moss-spartans.epoch.ncsc.mil> <1132055891.5415.305.camel@moss-spartans.epoch.ncsc.mil> <4379E4D1.2010900@redhat.com> <437A0749.5060407@cornell.edu> <437A05C5.4080505@tresys.com>
In-Reply-To: <437A05C5.4080505@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
> the swig wrappers don't currently have any write (transaction) 
> functionality, nor are the seuser keys and create functions wrapped, 
> these will need to be done.
Speaking of transactions, I see the "moving genhomedircon patch outside 
the active-lock section" patch has been merged. That's fine, but I also 
pointed out why genhomedircon should be using transactions in read-only 
mode as well - please see the relevant thread. Using transactions there 
eliminates an unnecessary policy rebuild, and a race condition (but on 
the other hand then you have another deadlock to deal with, because 
you're calling it with the transaction lock held).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
