Message-ID: <20050615030006.93510.qmail@web31613.mail.mud.yahoo.com>
Date: Tue, 14 Jun 2005 20:00:06 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Question about integration of IPsec with SELinux?
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20050615012023.22041.qmail@web51509.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Park Lee <parklee_sel@yahoo.com> wrote:

> Tue, 14 Jun 2005 at 14:23, Casey Schaufler wrote:
> >> Do you mean that attributes of receiving process
> >> should be sent to the sending machine, which
> >> contains the sending process?
> >
> > You'd have to anticipate what attributes
> > of what objects would be needed before you
> > could send packets. Beyond current technology.
> > 
> >> and the access control
> >> are made on the sending machine to decide
> >> whether the sending process can do interprocess
> >> communication with its receiving process?
> >
> > Again, if you could get the attributes of all
> > the receivers onto the sender in a reliable way
> > that would be great.
> 
> Do you mean that now we can not achieve this with
> current technology?

I mean that the sender cannot know the attributes
that will be present on the receiver at the time
of delivery when the packet is sent. Golly, with
UDP, you don't even know (or care) if the receiver
exists. You can't make the access control decision
on the sender because you don't have enough 
information and the steps that would be required
to get the information and ensure that it didn't
change during the delivery process* would
introduce all sorts of performance and lock
contention issues.

> Here, The receiving socket will receive packets sent
> by sending process. So, I think that the receiving
> socket is initiative, and the packets are passive on
> receiving machine.

A socket is not an active entity. The process
associated with it is, but the process may
never read the information from the socket.
The packets have no volition of their own,
they are the spawn of the sending process.

> Then, Would you please tell me why the sending
> process
> is still the subject and the receiving socket is
> still
> the object?

The sending process puts information into the
receiving socket. The access control decision
is (on Unix MLS systems at least) made based on
the attributes of the socket and the attributes
of the sending process, as propogated to the
receiver via CIPSO or TSIG SAMP.

------
* RFC 1149 has been implemented, after all.



Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Discover Yahoo! 
Get on-the-go sports scores, stock quotes, news and more. Check it out! 
http://discover.yahoo.com/mobile.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
