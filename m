Date: Tue, 22 Jan 2002 14:05:08 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Lonnie Cumberland <lonnie@outstep.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: restricted guest domain accounts
In-Reply-To: <1129.192.168.1.12.1011589591.squirrel@mail.outstep.com>
Message-ID: <Pine.GSO.4.33.0201221329110.20295-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 21 Jan 2002, Lonnie Cumberland wrote:

> I will next be installing OpenOffice/StarOffice on my SELinux server
> but would like not to allow the guest domain users to run many of the
> existing applications that are in the "/bin /sbin /usr/bin ...."
> directories.
>
> Perhaps only allow them to run just a few that I will decide upon.

What do you hope to achieve by this restriction?  What do you gain in
security by preventing a user from running a program in /bin if he can run
OpenOffice/StarOffice?  Do you really care what programs can be run by the
user, or just what processes and files he can access, regardless of the
program that he happens to use?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
