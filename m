Date: Tue, 12 Jul 2005 15:34:10 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Joy Latten <latten@austin.ibm.com>
cc: SELinux@tycho.nsa.gov
Subject: Re: port and address caches
In-Reply-To: <200507121746.j6CHkePX004477@faith.austin.ibm.com>
Message-ID: <Xine.LNX.4.44.0507121533180.4276-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 12 Jul 2005, Joy Latten wrote:

> indicate some performance improvement. I am currently working 
> on a testcase that will somewhat exercise the use of ports and/or
> ipaddresses. Hopefully this will better indicate an improvement.

apachebench can give you a very quick and simple view of the network 
overhead.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
