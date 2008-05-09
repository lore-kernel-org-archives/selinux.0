Subject: Re: I think this is a bug in the kernel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48245FFF.8050701@redhat.com>
References: <4824560E.8060500@redhat.com>  <48245CD6.2060206@redhat.com>
	 <1210343135.6434.211.camel@moss-spartans.epoch.ncsc.mil>
	 <48245FFF.8050701@redhat.com>
Content-Type: text/plain
Date: Fri, 09 May 2008 10:34:54 -0400
Message-Id: <1210343694.6434.215.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-05-09 at 10:30 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Stephen Smalley wrote:
> | On Fri, 2008-05-09 at 10:16 -0400, Daniel J Walsh wrote:
> |> -----BEGIN PGP SIGNED MESSAGE-----
> |> Hash: SHA1
> |>
> |> Daniel J Walsh wrote:
> |> | https://bugzilla.redhat.com/show_bug.cgi?id=445709
> |> |
> |> | libvirtd is clearly not ptracing the unconfined_t domain.  It is
> |> | problably looking under /proc for some information about the app
> that is
> |> | communicating with it.  It might be reading unconfined_t
> environment.  I
> |> | am not sure, but we generate a ptrace and stop the app from
> working.  My
> |> | only choice is to allow virtd to ptrace unconfined_t processes which is
> |> | not a good idea.  This has to be fixes in the kernel.
> |> |
> |> | Dan
> |>
> |> - --
> |> This message was distributed to subscribers of the selinux mailing list.
> |> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> |> with
> |> the words "unsubscribe selinux" without quotes as the message.
> |>
> |> Replying to my own email...
> |>
> |> Looks like the kernel has it on its todo list...
> |>
> |> ~ *  Finer-grained proc checking (so that we don't require full ptrace
> |> permission just to read process state),
> |>
> |> Well I think we need to jump the priority here.
> |>
> |> User apps seem to be doing things like looking at the remote end of the
> |> socket and checking the environment for special cookies in the case of
> |> consolehelper/policykit.  Or may looking to see where the kerberos
> |> tickets are located.  Whether this is a legitimate use or not, it is
> |> being done.
> |
> | That's decidedly racy and unsafe to do.  They shouldn't do that.
> |
> |>   So we need to handle it.  But I have a real concern about
> |> allowing virtd_t to ptrace unconfined_t process.
> |>
> |> Basically in order to allow virtd_t to verify the unconfined_t process
> |> that is trying to communicate with it, we need to allow it to read the
> |> memory of every unconfined_t process on the system.  Not good.
> |
> |
> I think this is policykit that is triggering it.  And with the advent of
> ~ /proc/$$/sessionid it will become less racy.
> 
> But for now it is what they do.
> 
> policykit is looking for a unique identifier to identify the "session"
> of the process that is trying to communicate with it.  It then uses
> consolekit to determine whether the "session" is on the console as
> opposed to logged in via ssh or some other remote application.

So they have two options:
- transfer the session id/cookie in the data of the request (i.e. it's a
capability), or
- extend the kernel the way we did to convey the peer or sender's
security context on a local IPC to the receiver (e.g. getpeercon(3)).

Reading /proc files for that purpose is not the way to go.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
