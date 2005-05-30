Subject: Re: file_type_auto_trans is not sufficient
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1117422237.9452.15.camel@localhost.localdomain>
References: <1117249760.19257.18.camel@localhost.localdomain>
	 <1117252045.19698.16.camel@localhost.localdomain>
	 <42980072.6090701@redhat.com>
	 <1117336632.24194.8.camel@localhost.localdomain>
	 <42999EF1.3020205@redhat.com>
	 <1117388699.21505.4.camel@localhost.localdomain>
	 <1117422237.9452.15.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 30 May 2005 04:05:14 -0400
Message-Id: <1117440314.12101.18.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I'm really starting to think that this is too ugly, and not an
> acceptable solution, but I don't have another suggestion at this time.

The fontconfig patch is wrong - does not always restore context...

More significantly, however, how does this scheme work in multithreaded
context? It seems like it won't work - the switch-create-restore
sequence should not be interruptible if multiple threads share
the same creation context...

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
