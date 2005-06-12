Message-ID: <20050612174607.58223.qmail@web31610.mail.mud.yahoo.com>
Date: Sun, 12 Jun 2005 10:46:07 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Question about integration of IPsec with SELinux?
To: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20050612170212.40575.qmail@web51506.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Park Lee <parklee_sel@yahoo.com> wrote:


> But, when we "Integrate IPSEC with network mandatory
> controls", we only label and protect _network_
> _packets_, How can we control _processes_ in network
> circumstance?

Hum. Allow me to make sure we've got fundimentals
covered before I try answering this.

A system compares attributes of processes such
as user IDs, group memberships, clearances, and
domain affiliations with attributes of storage
containers such as ownership, sensitivity, and
access control lists to determine what accesses
may be permitted. An interesting special case of
this behavior is interprocess communication,
in which the sending process treats the receiving
process as a storage container. In the local
system case, where both the sending process and
the receiving process are on the same machine,
the attributes relevent to an access decision are
available, and the IPC mechanism can make the call
without special accomodation. If the processes
are on different machines the IPC mechanism must
provide transport of the required attributes so
that the decision can be made.

> and, Can I view what you wrote as a application of
> "labeled networking"
> which is mentioned by James Morris in
> http://www.linuxjournal.com/article/7764 ?
> then, What is the purpose of a "labeled networking"?

Labeled networking is an implementation of
mechanism to provide sufficient attribute
information for the TCP/IP and UDP/IP IPC
mechanisms to be useful in an environment
that requires all IPC mechanisms provide access
control. This includes the LSPP specification
of the Common Criteria.

Labeled networking is not new. SGI and Cray
completed B1 evaluations in 1995 that used CIPSO.
The SGI system looked like a cluster where
Cray chose to treat their machine as a single
network component.



Casey Schaufler
casey@schaufler-ca.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
