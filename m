Subject: Re: [Fwd: policycoreutils patches]
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <461F7D36.2070602@redhat.com>
References: <461F7D36.2070602@redhat.com>
Content-Type: text/plain
Date: Fri, 13 Apr 2007 14:33:01 -0400
Message-Id: <1176489181.8230.38.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-04-13 at 08:53 -0400, Daniel J Walsh wrote:
> Moved audit2allow to sbin to match audit2why.
> 

I think I would rather move audit2why to bin. Both tools can run and are
useful without any privilege.

Karl




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
