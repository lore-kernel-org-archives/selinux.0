Subject: Re: adobe on FC 14
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bill Chimiak <wch1m1@gmail.com>
Cc: selinux-mailing-list <selinux@tycho.nsa.gov>
In-Reply-To: <201102241119.25067.w.chimiak@ieee.org>
References: <201102241119.25067.w.chimiak@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Feb 2011 12:45:41 -0500
Message-ID: <1298569541.31953.49.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-02-24 at 11:19 -0500, Bill Chimiak wrote:
> acroread wants to execute on a stack and it seems to be ugly.
> Any advice?
> Details:
> 
> /opt/Adobe/Reader9/Reader/intellinux/bin/acroread: error while loading shared 
> libraries: libcrypto.so.0.9.8: cannot enable executable stack as shared object 
> requires: Permission denied

I have no libcrypto.so.0.9.8 on F14.
Where is yours located?
$ locate libcrypto.so.0.9.8

Replace /path/to/libcrypto.so.0.9.8 with the actual path below.

What package owns it?
$ rpm -q -f /path/to/libcrypto.so.0.9.8

Is it marked as requiring an executable stack?
$ execstack -q /path/to/libcrypto.so.0.9.8

Try clearing the marking.
$ execstack -c /path/to/libcrypto.so.0.9.8

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
