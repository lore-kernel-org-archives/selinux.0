Date: Thu, 20 May 2004 21:51:32 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Joshua Brindle <jbrindle@snu.edu>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: se-samba
Message-ID: <20040520215132.GI18182@lkcl.net>
References: <40ACFC0C.9020101@snu.edu> <20040520211032.GG18182@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040520211032.GG18182@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, May 20, 2004 at 09:10:32PM +0000, Luke Kenneth Casson Leighton wrote:

>  by separating the SMB-processing from the file-accessing, you
>  effectively end up with an easy opportunity to emulate
>  multi-threading, and in the process a very very long-standing
>  and obscure bug will be fixed [which can be demonstrated by running
>  a multi-threaded benchmark test suite against a samba server].
> 
> 
>  now, you _might_ be able to get away with writing a VFS plugin,
>  or by subdiving the smbd source code so that the file-access bits
>  of smbd are called (eventually) by the SMB-parsing bits of smbd.
> 
>  in fact, if i was going to do the work, that's where i would start,
>  and once that was done, i would then add in a subdivision layer
>  over, oh, say, unix domain sockets or shared memory communication.
> 
>  the two separate tasks (making all file access go via the VFS layer
>  and then doing a daemon split at the same VFS interface) make very
>  clear and very straightforward milestones.

 it looks like, in samba 3.0.2a, that all file access already goes
 through the VFS layer.

 therefore the only task needed is to network / unix-socket / 
 shmem the file access via the VFS layer.

 and to ensure that each user context is separated out.

 the function vfs_connect will be responsible for initiating
 a new connection of a new user context;

 the function vfs_disconnect will be responsible for closing
 that connection.

 the rest of the work is getting each of those vfs functions,
 of which unfortunately there are about forty or more, over
 a network.

 ironically, i'd actually recommend doing something like use DCE/RPC
 to do that :) :)

 but that doesn't help because freedce requires, thanks to IBM,
 quite a lot of work to do security contexts, and also, being
 threaded, it would require the same reworking as samba, and you're
 back where you started.

 so _some_ sort of RPC system is required, with an IDL compiler,
 to simplify the task of turning the VFS api into a networked
 one.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
