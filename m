Date: Mon, 18 Apr 2005 16:10:52 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Park Lee <parklee_sel@yahoo.com>
cc: SELinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Be labeled with SID or security context?
In-Reply-To: <20050418165241.9635.qmail@web51510.mail.yahoo.com>
Message-ID: <Xine.LNX.4.44.0504181610210.13604-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 18 Apr 2005, Park Lee wrote:

> Hi,
>   In SELinux, sockets inherit the SID of its creating
> process. 
>   Then, can we say that sockets are labeled with the
> SID of its creating process? (i.e. Can we say that
> SELinux uses the SID of a socket's creating process to
> label the socket?)
>   Or, can we also say that sockets are labeled with
> the security context of its creating process ? 
>   Which one is better? Thanks,

It's the same thing but a SID is something which is now internal to 
SELinux kernel code, so use security context instead.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
