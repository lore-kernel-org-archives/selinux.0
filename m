Message-ID: <20050614181118.75027.qmail@web51506.mail.yahoo.com>
Date: Tue, 14 Jun 2005 11:11:17 -0700 (PDT)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: Question about integration of IPsec with SELinux?
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Valdis.Kletnieks@vt.edu, Stephen Smalley <sds@tycho.nsa.gov>,
   Trent Jaeger <jaegert@us.ibm.com>, SELinux <SELinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 12 Jun 2005 at 10:46, Casey Schaufler wrote:

> A system compares attributes of processes such
> as user IDs, group memberships, clearances, and
> domain affiliations with attributes of storage
> containers such as ownership, sensitivity, and
> access control lists to determine what accesses
> may be permitted. An interesting special case of
> this behavior is interprocess communication,
> in which the sending process treats the receiving
> process as a storage container. In the local
> system case, where both the sending process and
> the receiving process are on the same machine,
> the attributes relevent to an access decision are
> available, and the IPC mechanism can make the call
> without special accomodation. If the processes
> are on different machines the IPC mechanism must
> provide transport of the required attributes so
> that the decision can be made.


Now let's suppose that processes are on different
machines,
Do you mean that attributes of receiving process
should be sent to the sending machine, which
contains the sending process? and the access control
are made on the sending machine to decide
whether the sending process can do interprocess
communication with its receiving process?
Can we view the sending process as a subject,and view
the receiving process as an object in the interprocess
communication on different machines?

If it is, let's see another situation:
We use the attributes of the sending process to label
the packets which are sent by the sending
process. when the packets are received on receiving
machine, the receiving machine can use the
attributes of the receiving process and the attributes
of the packets to determine whether these packets can
be received. Here, the receiving process becomes
subject, and the packets which represent its sending
process become objects. 
Then, Does this situation become conflict with what
you wrote above?


Thanks a lot.



Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
Make Yahoo! your home page 
http://www.yahoo.com/r/hs

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
