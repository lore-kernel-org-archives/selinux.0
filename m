From: Paul Moore <paul.moore@hp.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Socket and inode label consistency
Date: Wed, 27 Aug 2008 16:32:51 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Trent Jaeger <tjaeger@cse.psu.edu>,
        selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
References: <1D98C7BF-3D76-4A9C-B43C-31BE0C57227B@cse.psu.edu> <1219861005.5708.137.camel@moss-spartans.epoch.ncsc.mil> <48B5B3DF.4080404@schaufler-ca.com>
In-Reply-To: <48B5B3DF.4080404@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808271632.51193.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 27 August 2008 4:06:55 pm Casey Schaufler wrote:
> Yes, it would be weird to change the label on a TCP connection
> midstream, but not unheard of. If you need an example think of
> what you might want to do with a diskless boot, or some of the
> less sophisticated clustering schemes.

Speaking purely in regards to the current Linux implementation, the 
thing that concerns me about stream sockets is that it is difficult, if 
not impossible, to ensure that the relabel happens at a specific data 
boundary in the stream.  Retransmission is another issue but might work 
okay depending where in the kernel the queue/retransmission takes 
place, I would need to check that.  I suppose all of these things can 
be addressed but it would be take a little bit of work and until I see 
an application/user that needs this functionality I can't justify 
spending time on it (my todo list is already way too long).

If you look carefully at the new labeled networking bits for 2.6.28 you 
will see that while we add the ability to change labeling based on the 
destination address, we do not allow labeling to change on an existing 
connection (although you can disconnect and reconnect a socket to a 
different destination allowing you to change the network labeling).

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
